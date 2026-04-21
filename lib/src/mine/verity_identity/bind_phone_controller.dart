import 'package:filbet/api/api.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:filbet/http/http_client.dart';

class BindPhoneController extends GetXBaseController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  UserService get to => Get.find();
  RxString sid = "".obs;

  final SecurityService _securityService = Get.find<SecurityService>();
  final UserService userService = Get.find<UserService>();

  final countdownSeconds = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> sendSms(phone, code) async {
    await fetchHandler(
      _securityService.getSendBindCode(phone, code),
      onSuccess: (model) {
        if (model) {
          //发送成功
          countdownSeconds.value = countdownTime;
          countdownSeconds.refresh();
        }
      },
      onError: toastError,
      loading: true,
    );
  }

  Future<bool> postPhoneBind() async {
    if (phoneController.text.trim().isEmpty) {
      AppUtils.showToast('请输入手机号'.tr);
      return false;
    }
    if (codeController.text.trim().isEmpty) {
      AppUtils.showToast('input_verify_code'.tr);
      return false;
    }
    final response = await HttpClient.post(Api.phoneBindStep2, data: {
      'sid': sid.value,
      'code': codeController.text.trim(),
    });
    if (!response.status) {
      AppUtils.showToastForResponse(response.message, ifEmpty: '失败');
      throw response.error!;
    }
    return response.status;
  }

  Future<void> getSendBindCode() async {
    sendSms(phoneController.text, "+86");
  }

  Future<bool> phoneBindStep1(String phone) async {
    try {
      final response = await HttpClient.post(Api.phoneBindStep1, data: {
        'phone': phone,
      });
      if (!response.status) {
        AppUtils.showToastForResponse(
        response.message, ifEmpty: '手机号校验失败！');
        return false;
      }
      //发送成功
      countdownSeconds.value = countdownTime;
      countdownSeconds.refresh();
      sid.value = response.data;
      return response.status;
    } catch (e) {
      countdownSeconds.value = 0;
      sid.value = "";
      return false;
    }
  }
}
