import 'package:filbet/constants/constants.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/services/user/user_state.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/security_util.dart';
import 'package:filbet/utils/string_utils.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BindEmailViewController extends GetXBaseController {
  final SecurityService _securityService = Get.find<SecurityService>();

  UserService get _userService => Get.find<UserService>();

  UserServiceState get userState => _userService.state;

  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  bool isDisableInput = false;

  bool isDepositEnabled = true;

  final countdownSeconds = 0.obs;

  final count = 0.obs;
  RxString codeText = "".obs;

  bool get isValidEmail =>
      StringUtils.isValidEmail(emailController.text.trim());

  @override
  void onInit() {
    codeController.addListener(() {
      codeText.value = codeController.text;
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void sendSmsCode() {
    if (emailController.value.text.isEmpty) {
      AppUtils.showToast('input_email'.tr);
      return;
    }
    if (!isEmailValid(emailController.value.text)) {
      AppUtils.showToast('邮箱格式不正确');
      return;
    }
    getEmailVerifyCode();
  }

  Future<void> getEmailVerifyCode() async {
    final isSuccess = await fetchHandler<bool>(
      _securityService.sendEmailBindingVerifyCode(emailController.value.text),
      onError: toastError,
      loading: true,
    );
    if (isSuccess == true) {
      //发送成功
      countdownSeconds.value = countdownTime;
      countdownSeconds.refresh();
    }
  }

  Future<bool> bindEmailAddress({String? secCode}) async {
    if (emailController.value.text.isEmpty) {
      AppUtils.showToast('input_email'.tr);
    } else if (!isEmailValid(emailController.value.text)) {
      AppUtils.showToast('邮箱格式不正确');
    } else if (codeController.value.text.isEmpty) {
      AppUtils.showToast('input_email_code'.tr);
    } else {
      final tuple = await _securityService.bindEmail(
        emailController.text,
        codeController.text,
        secCode: secCode,
      );
      if (tuple == true) {
        AppUtils.showToast('bind_success'.tr);
        Get.back();
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
