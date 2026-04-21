import 'dart:convert';

import 'package:city_pickers/city_pickers.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/security/Address_provinces_model.dart';
import 'package:filbet/src/security/Bank_list_model.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/src/security/widgets/bottom_safe_verify.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/bank_card_real_name.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/http/http_client.dart';

class RealNameAuthenticationController extends GetXBaseController {
  TextEditingController inputNameController = TextEditingController();
  TextEditingController inputPhoneController = TextEditingController();
  TextEditingController inputSmsCodeController = TextEditingController();

  late final FocusNode inputNameFocusNode = FocusNode();
  late final FocusNode inputPhoneFocusNode = FocusNode();
  late final FocusNode inputSmsCodeFocusNode = FocusNode();

  final Rx<String> selAreaCodeText = '+86'.obs;
  final countdownSeconds = 0.obs;

  final Rx<String> inputNameText = ''.obs;
  final Rx<String> inputPhoneText = ''.obs;
  final Rx<String> smsCodeText = ''.obs;
  final bindConfirmEnable = false.obs;
  final GlobalKey phoneContainerKey = GlobalKey();

  String sid = "";

  bool checkBindConfirmEnable() {
    bindConfirmEnable.value = inputNameText.value.isNotEmpty &&
        inputPhoneText.value.isNotEmpty &&
        smsCodeText.value.isNotEmpty;
    return bindConfirmEnable.value;
  }

  String realName = "";
  final phoneNumber = "".obs;

  @override
  void onInit() {
    super.onInit();
    realName = UserService.to.state.userInfo.realName ?? '';
    inputNameText.value = realName;
    inputNameController.text = realName;
    convertAreaAndPhone();
    inputNameController.addListener(() {
      inputNameText.value = inputNameController.text;
      checkBindConfirmEnable();
    });
    inputPhoneController.addListener(() {
      inputPhoneText.value = inputPhoneController.text;
      checkBindConfirmEnable();
    });
    inputPhoneController.text = phoneNumber.value;
    inputPhoneText.value = phoneNumber.value;
    inputSmsCodeController.addListener(() {
      smsCodeText.value = inputSmsCodeController.text;
      checkBindConfirmEnable();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getSendBindCode() async {
    if (phoneNumber.value.isNotEmpty) {
      Get.bottomSheet(
        SKBottomSheet(
          top: 24.h,
          left: 16.w,
          title: 'safe_verify'.tr,
          content: BottomSafeVerify(
            phoneNum: phoneNumber.value,
            onConfirm: (value) {
              if (Get.isBottomSheetOpen ?? false) {
                Get.back();
              }
              phoneVerify(value);
            },
          ),
        ),
        isScrollControlled: true,
      );
    } else {
      var inputPhone = inputPhoneController.text.trim();
      if (inputPhone.isEmpty) {
        AppUtils.showToast("请输入手机号");
        return;
      }
      postPhoneVerify(inputPhone);
    }
  }

  Future<void> sendSms() async {
    countdownSeconds.value = 0;
    var result = await ApiRequest.accountBindStep2(sid);
    if (result == true) {
      AppUtils.showToast('验证码发送成功');
      countdownSeconds.value = countdownTime;
    }
  }

  Future<void> phoneVerify(value) async {
    var resp = await ApiRequest.accountBindStep1(value);
    if (resp != null) {
      sid = resp;
      sendSms();
    }
  }

  Future<void> postPhoneVerify(String phone) async {
    var resp =
        await ApiRequest.accountBindStep1('${selAreaCodeText.value}-$phone');
    if (resp != null) {
      sid = resp;
      sendSms();
    }
  }

  Future<bool> accountBindStep3() async {
    if (realName.isEmpty) {
      final name = inputNameText.value.trim();
      final nameErr = BankCardRealNameRules.validate(name);
      if (nameErr != null) {
        AppUtils.showToast(nameErr);
        return false;
      }
    }
    // if (sid.isEmpty) {
    //   AppUtils.showToast('请先获取验证码');
    //   return false;
    // }
    Map params = {
      "sid": sid,
      "name": "",
      "real_name": inputNameText.value, //真实姓名
      "address": "",
      "is_agent": 0,
      "phone": "${selAreaCodeText.value}-${inputPhoneController.text}",
    };

    params['code'] = inputSmsCodeController.text.trim();
    final response = await HttpClient.post(Api.accountBindStep3, data: params);
    if (!response.status) {
      AppUtils.showToastForResponse(
        response.message, ifEmpty: "验证失败");
    }
    return response.status;
  }

  //添加银行卡
  void addBank() async {
    try {
      Map params = {
        "sid": sid,
        "name": "",
        "real_name": inputNameText.value,
        "address": "",
        "is_agent": 0
      };
      final response =
          await HttpClient.post(Api.accountBindStep4, data: params);
      if (response.status) {
        AppUtils.showToast('认证成功');
        UserService.to.getUserInfos();
        Get.back(result: true);
      } else {
        AppUtils.showToastForResponse(
        response.message, ifEmpty: "认证失败");
      }
    } catch (e) {}
  }

  void convertAreaAndPhone() {
    String phoneWithArea = UserService.to.state.userInfo.phone ?? "";
    var arr = phoneWithArea.split('-');
    if (arr.length > 1) {
      selAreaCodeText.value = arr[0].isNotEmpty ? arr[0] : '+86';
      phoneNumber.value = arr[1];
    } else {
      phoneNumber.value = arr[0];
    }
  }
}
