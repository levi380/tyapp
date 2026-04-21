import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/exception_user_message.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/services/web_socket_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/login/auth_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/credential_validate_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PwdModifyController extends GetXBaseController {
  UserService get userService => Get.find<UserService>();

  AuthService get authService => Get.find<AuthService>();
  TextEditingController oldPwdController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  final oldPwdObscureText = true.obs;
  final newPwdObscureText = true.obs;
  final confirmPwdObscureText = true.obs;

  /// 各输入框是否有内容（用于控制 rightView 显隐）
  final oldPwdHasText = false.obs;
  final newPwdHasText = false.obs;
  final confirmPwdHasText = false.obs;

  final RxString newPwdStr = "".obs;
  final RxString confirmPassword = "".obs;

  final isEnable = false.obs;
  String? mSid;

  @override
  void onInit() {
    super.onInit();
    mSid = Get.arguments?['sid'];
    // 为三个 TextEditingController 添加监听器
    oldPwdController.addListener(_checkEnable);
    newController.addListener(_checkEnable);
    confirmController.addListener(_checkEnable);
  }

  @override
  void onClose() {
    oldPwdController.removeListener(_checkEnable);
    newController.removeListener(_checkEnable);
    confirmController.removeListener(_checkEnable);
    oldPwdController.dispose();
    newController.dispose();
    confirmController.dispose();
    super.onClose();
  }

  /// 检查是否启用提交按钮
  void _checkEnable() {
    final oldPwd = oldPwdController.text.trim();
    final newPwd = newController.text.trim();
    final confirmPwd = confirmController.text.trim();

    oldPwdHasText.value = oldPwdController.text.isNotEmpty;
    newPwdHasText.value = newController.text.isNotEmpty;
    confirmPwdHasText.value = confirmController.text.isNotEmpty;

    newPwdStr.value = newPwd;
    confirmPassword.value = confirmPwd;

    // 判断条件：
    // 1. 原密码不为空
    // 2. 新密码符合格式（8-12位字母+数字的组合）
    // 3. 确认密码与新密码一致
    final isOldPwdValid = oldPwd.isNotEmpty;
    final isNewPwdValid = _isPasswordValid(newPwd);
    final isConfirmPwdValid = newPwd.isNotEmpty && confirmPwd == newPwd;
    isEnable.value = isOldPwdValid && isNewPwdValid && isConfirmPwdValid;
  }

  /// 验证密码格式：8-12位字母+数字的组合
  bool _isPasswordValid(String password) {
    if (password.isEmpty) {
      return false;
    }
    // 使用 passwordStringValidate 验证：8-12位，包含大小写字母和数字
    return passwordStringValidate03(password).every((element) => element.item2);
  }

  void submit() async {
    var resp = await ApiRequest.updateLoginPwd4(
        sid: mSid, oldPwd: oldPwdController.text.trim(), newPwd: newController.text.trim());
    if (resp == true) {
      AppUtils.showToast("修改成功");
      logOut();
    }
  }

  ///退出登录
  void logOut() async {
    try {
      await authService.logout();
      await userService.logout();
      WebSocketService c = Get.put(WebSocketService());
      c.closeConnect();
      AppNavigator.startMain();
    } catch (e) {
      Get.snackbar('error'.tr, exceptionMessageForUser(e));
    }
  }

  bool get isPresentLoginPasswordInputError {
    if (newController.text.trim().isEmpty) {
      return false;
    }
    return passwordStringValidate03(newController.text.trim()).any((element) => !element.item2);
  }

  bool get isConfirmPasswordInputError {
    if (newController.text.isNotEmpty) {
      return newController.text.trim() != confirmController.text.trim();
    } else {
      return passwordStringValidate03(confirmController.text.trim()).any((element) => !element.item2);
    }
  }
}
