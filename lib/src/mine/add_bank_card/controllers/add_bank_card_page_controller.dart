import 'dart:convert';

import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/security/Bank_list_model.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/src/security/widgets/bottom_safe_verify.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/bank_card_real_name.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddBankCardPageController extends GetXBaseController {
  final SecurityService _securityService = Get.find<SecurityService>();

  String realName = "";
  final phoneNumber = "".obs;

  // TextEditingController walletNameController = TextEditingController();
  TextEditingController addBankCardController = TextEditingController();
  TextEditingController inputNameController = TextEditingController();
  TextEditingController inputPhoneController = TextEditingController();
  TextEditingController inputSmsCodeController = TextEditingController();

  // TextEditingController paymentPasswordController = TextEditingController();

  // late final FocusNode walletNameFocusNode = FocusNode();
  late final FocusNode addBankCardFocusNode = FocusNode();
  late final FocusNode inputNameFocusNode = FocusNode();
  late final FocusNode inputPhoneFocusNode = FocusNode();
  late final FocusNode inputSmsCodeFocusNode = FocusNode();

  // late final FocusNode paymentPasswordFocusNode = FocusNode();

  Rx<BankListModel?> selBankCard = Rx<BankListModel?>(null);

  // final Rx<String> walletNameText = ''.obs;
  final Rx<String> addBankCardText = ''.obs;
  final Rx<String> inputNameText = ''.obs;
  final Rx<String> inputPhoneText = ''.obs;
  final Rx<String> smsCodeText = ''.obs;
  final Rx<String> selAreaCodeText = '+86'.obs;

  // final Rx<String> paymentPasswordText = ''.obs;

  final Rx<String> selAddressText = ''.obs;

  /// 提交中（请求期间为 true，按钮不可点击）
  final isSubmitting = false.obs;
  final Rx<String> province = ''.obs;
  final Rx<String> cityName = ''.obs;
  final Rx<String> areaName = ''.obs;

  final RxList<BankListModel> bankList = <BankListModel>[].obs;
  final RxList<String> countryCodeList = <String>[].obs;

  final countdownSeconds = 0.obs;
  final checkBankCardInfo = false.obs;

  /// 用于区号弹窗定位：手机号输入行 Container 的 key，在 View 中挂到对应 widget 上
  final GlobalKey phoneContainerKey = GlobalKey();

  String sid = '';

  bool getCheckBankCardInfo() {
    checkBankCardInfo.value = selBankCard.value != null &&
        // paymentPasswordText.value.isNotEmpty &&
        addBankCardText.value.isNotEmpty &&
        !isAddBankCardInputError;
    return checkBankCardInfo.value;
  }

  bool get isAddBankCardInputError {
    if (addBankCardText.value.isEmpty) {
      return false;
    }
    if (addBankCardText.value.length < 13 ||
        addBankCardText.value.length > 19) {
      return true;
    } else {
      return !RegExp(r'^\d+$').hasMatch(addBankCardText.value);
    }
  }

  bool isRealName = false;

  @override
  void onInit() {
    super.onInit();
    realName = UserService.to.state.userInfo.realName ?? "";
    convertAreaAndPhone();
    inputNameController.addListener(() {
      inputNameText.value = inputNameController.text;
      getCheckBankCardInfo();
    });

    addBankCardController.addListener(() {
      addBankCardText.value = addBankCardController.text;
      getCheckBankCardInfo();
    });
    inputPhoneController.addListener(() {
      inputPhoneText.value = inputPhoneController.text;
      getCheckBankCardInfo();
    });
    inputSmsCodeController.addListener(() {
      smsCodeText.value = inputSmsCodeController.text;
      getCheckBankCardInfo();
    });
  }

  @override
  void onReady() {
    super.onReady();
    getBankList();
  }

  @override
  void dispose() {
    super.dispose();
    clearInput();
  }

  void onDispose() {
    // walletNameFocusNode.unfocus();
    addBankCardFocusNode.unfocus();
    inputNameFocusNode.unfocus();
    inputPhoneFocusNode.unfocus();
    inputSmsCodeFocusNode.unfocus();
    // paymentPasswordFocusNode.unfocus();
  }

  clearInput() {
    // walletNameController.text = "";
    addBankCardController.text = "";
    inputNameController.text = "";
    inputPhoneController.text = "";
    inputSmsCodeController.text = "";
    // paymentPasswordController.text = "";
  }

  void getBankList() async {
    await fetchHandler(
      _securityService.getBankList(),
      onSuccess: (model) {
        bankList.value = model;
      },
      onError: toastError,
      loading: true,
    );
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
      if (inputPhoneController.text.isEmpty) {
        AppUtils.showToast('请输入手机号');
        return;
      }
      phoneVerify(inputPhoneController.text);
    }
  }

  Future<void> sendSms() async {
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

  //添加银行卡
  addBank() async {
    if (!validateParams()) {
      return;
    }
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    try {
      Map params = getParams();
      params['code'] = inputSmsCodeController.text.trim();
      params['phone'] = phoneNumber.isNotEmpty
          ? "${selAreaCodeText.value}-$phoneNumber"
          : "${selAreaCodeText.value}-${inputPhoneText.value}";
      var result = await ApiRequest.accountBindStep3(params);
      if (result != true) {
        return;
      }
      print("发起请求:$params");
      final response = await ApiRequest.accountBindStep4(getParams());
      if (response == true) {
        //添加成功
        AppUtils.showToast('添加成功');
        UserService.to.getUserInfos();
        Get.back(result: true);
      }
    } catch (e) {
      e.printError();
    } finally {
      isSubmitting.value = false;
    }
  }

  Map getParams() {
    var addressParams = {
      "account_name": inputNameText.value,
      "account_no": addBankCardText.value,
      "bank_code": selBankCard.value?.id ?? "",
      "province": province.value,
      "city": cityName.value,
      "area": areaName.value,
      "phone": phoneNumber.isNotEmpty
          ? "${selAreaCodeText.value}-$phoneNumber"
          : "${selAreaCodeText.value}-${inputPhoneText.value}",
      "img": selBankCard.value?.img ?? "",
      "name": selBankCard.value?.name ?? "",
      "id": selBankCard.value?.id ?? "",
    };
    return {
      'sid': sid,
      // "name": walletNameController.text,
      "payment_type": 6,
      "address": jsonEncode(addressParams),
      // "withdrawal_password": paymentPasswordText.value,
    };
  }

  bool validateParams() {
    // if (walletNameText.value.isEmpty) {
    //   AppUtils.showToast('请输入钱包名称');
    //   return false;
    // }

    // 校验姓名（如果之前没填）
    if (realName.isEmpty) {
      final name = inputNameText.value.trim();
      if (name.isEmpty) {
        AppUtils.showToast('请输入持卡人姓名');
        return false;
      }
      final nameErr = BankCardRealNameRules.validate(name);
      if (nameErr != null) {
        AppUtils.showToast(nameErr);
        return false;
      }
    }

    // 校验手机号（如果之前没填）
    if (phoneNumber.value.isEmpty && inputPhoneText.value.isEmpty) {
      AppUtils.showToast('请输入手机号');
      return false;
    }

    if (smsCodeText.isEmpty) {
      AppUtils.showToast('请输入验证码');
      return false;
    }
    if (addBankCardText.isEmpty) {
      AppUtils.showToast('请输入银行卡号');
      return false;
    }

    if (selBankCard.value == null) {
      AppUtils.showToast('请选择开户银行');
      return false;
    }

    // if (selAddressProvinces.value == null) {
    //   AppUtils.showToast('请选择省');
    //   return false;
    // }

    // if (paymentPasswordText.value.isEmpty) {
    //   AppUtils.showToast('input_pay_pwd'.tr);
    //   return false;
    // }

    return true;
  }

  Future<Result?> showCityPicker(BuildContext context) async {
    Result? result = await CityPickers.showCityPicker(
      context: context,
      height: 316.h,
      itemExtent: 32.h,
      borderRadius: 18.r,
      cancelWidget: Text(
        "cancel".tr,
        style: TextStyle(color: appnewColors.text1),
      ),
      confirmWidget: Text(
        "完成".tr,
        style: TextStyle(color: appnewColors.text1),
      ),
    );
    if (result != null) {
      province.value = result.provinceName ?? "";
      cityName.value = result.cityName ?? "";
      areaName.value = result.areaName ?? "";
      selAddressText.value =
          "${result.provinceName}${result.cityName}${result.areaName}";
      getCheckBankCardInfo();
    }
    return result;
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
