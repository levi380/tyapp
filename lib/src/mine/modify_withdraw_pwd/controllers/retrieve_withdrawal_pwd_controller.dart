import 'package:filbet/api/api.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/security/security_data_model.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:filbet/http/http_client.dart';

class RetrieveWithdrawalPwdController extends GetXBaseController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  final UserService userService = Get.find<UserService>();

  RxString codeText = "".obs;
  RxString sid = "".obs;
  RxInt countdownSeconds = 0.obs;

  final SecurityService securityService = Get.find<SecurityService>();
  final Rx<SecurityDataModel?> securityData = Rx<SecurityDataModel?>(null);

  @override
  void onInit() {
    loadSecurityData();
    super.onInit();
    phoneController.text = userService.state.userInfo.phone ?? "";
    codeController.addListener(() {
      codeText.value = codeController.text;
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

  Future<void> loadSecurityData() async {
    await fetchHandler<SecurityDataModel>(
      securityService.loadSecurityData(),
      onSuccess: (model) {
        securityData.value = model;
      },
      onError: toastError,
      loading: true,
    );
  }

  Future<void> getSendBindCode(String phone) async {
    sendSms(phone.trim().isNotEmpty ? phone : phoneController.text, "+86");
  }

  Future<void> sendSms(phone, code) async {
    await fetchHandler(
      userService.getResetStep2(sid.value),
      onSuccess: (model) {
        if (model) {
          //发送成功
          AppUtils.showToast("验证码已发送");
          countdownSeconds.value = countdownTime;
          countdownSeconds.refresh();
        }
      },
      onError: toastError,
      loading: true,
    );
  }

  Future<bool> postPhoneVerify(String phone) async {
    try {
      final response = await HttpClient.post(Api.resetStep1, data: {
        'phone': phone,
      });
      if (!response.status) {
        AppUtils.showToastForResponse(
        response.message, ifEmpty: '手机号校验失败！');
      }
      sid.value = response.data;
      return response.status;
    } catch (e) {
      return false;
    }
  }

  Future<bool> phoneCodeVerify() async {
    try {
      final response = await HttpClient.post(Api.phoneCodeVerify, data: {
        'active_method': 1,
        'code': codeController.text,
        'type': 4,
      });

      if (!response.status) {
        AppUtils.showToastForResponse(
        response.message, ifEmpty: '验证码校验失败！');
      }
      return response.status;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getResetStep3() async {
    final response = await HttpClient.post(Api.resetStep3, data: {
      'sid': sid.value,
      'code': codeController.text.trim(),
    });
    if (!response.status) {
      AppUtils.showToastForResponse(
        response.message, ifEmpty: "验证失败");
      throw response.error!;
    }
    return response.status;
  }
}
