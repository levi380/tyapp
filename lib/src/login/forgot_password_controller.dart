import 'package:filbet/constants/constants.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/login/auth_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/credential_validate_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ForgotPasswordStep {
  fillUsername, // 填写用户名
  identityVerify, // 身份验证
  setPassword, // 设置密码
  success, // 成功
}

enum RecoveryMethod {
  phone, // 手机找回
  email, // 邮箱找回
}

class ForgotPasswordController extends GetXBaseController {
  // 当前步骤
  final Rx<ForgotPasswordStep> currentStep = ForgotPasswordStep.fillUsername.obs;

  // 找回方式
  final Rx<RecoveryMethod> recoveryMethod = RecoveryMethod.phone.obs;

  // 输入框控制器
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController verificationCodeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // 验证码倒计时
  final RxInt countdownSeconds = 0.obs;

  // 手机号/邮箱（用于显示）
  String? displayPhone;
  String? displayEmail;

  // 找回密码会话ID（从第一步验证账号接口返回）
  String? sid;

  // 按钮是否可用
  final RxBool canNext = false.obs;

  // AuthService
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    // 监听输入框变化
    usernameController.addListener(_checkCanNext);
    phoneController.addListener(_checkCanNext);
    emailController.addListener(_checkCanNext);
    verificationCodeController.addListener(_checkCanNext);
    newPasswordController.addListener(_checkCanNext);
    confirmPasswordController.addListener(_checkCanNext);
  }

  void _checkCanNext() {
    switch (currentStep.value) {
      case ForgotPasswordStep.fillUsername:
        if (recoveryMethod.value == RecoveryMethod.phone) {
          canNext.value = usernameController.text.isNotEmpty && phoneController.text.isNotEmpty;
        } else {
          canNext.value = usernameController.text.isNotEmpty && emailController.text.isNotEmpty;
        }
        break;
      case ForgotPasswordStep.identityVerify:
        canNext.value = verificationCodeController.text.isNotEmpty;
        break;
      case ForgotPasswordStep.setPassword:
        canNext.value = isNewPasswordValid && isConfirmPasswordValid;
        break;
      default:
        canNext.value = false;
    }
  }

  // 密码验证规则（参考注册页面）
  bool get isNewPasswordValid {
    return passwordStringValidate03(newPasswordController.text).every((element) => element.item2);
  }

  bool get isConfirmPasswordValid {
    if (newPasswordController.text.isNotEmpty) {
      return newPasswordController.text.trim() == confirmPasswordController.text.trim() && isNewPasswordValid;
    } else {
      return passwordStringValidate03(confirmPasswordController.text).every((element) => element.item2);
    }
  }

  bool get isConfirmPasswordInputError {
    if (newPasswordController.text.isNotEmpty) {
      return newPasswordController.text.trim() != confirmPasswordController.text.trim();
    } else {
      return passwordStringValidate03(confirmPasswordController.text).any((element) => !element.item2);
    }
  }

  // 切换找回方式
  void switchRecoveryMethod(RecoveryMethod method) {
    recoveryMethod.value = method;
    phoneController.clear();
    emailController.clear();
    _checkCanNext();
  }

  // 下一步
  void nextStep() {
    switch (currentStep.value) {
      case ForgotPasswordStep.fillUsername:
        // 验证用户名和手机/邮箱
        _verifyAccount();
        break;

      case ForgotPasswordStep.identityVerify:
        // 验证验证码
        _verifyCode();
        break;

      case ForgotPasswordStep.setPassword:
        // 重置密码
        _resetPassword();
        break;

      default:
        break;
    }
  }

  // 验证账号（第一步）
  Future<void> _verifyAccount() async {
    String account;
    if (recoveryMethod.value == RecoveryMethod.phone) {
      if (usernameController.text.isEmpty || phoneController.text.isEmpty) {
        return;
      }
      account = phoneController.text;
    } else {
      if (usernameController.text.isEmpty || emailController.text.isEmpty) {
        return;
      }
      account = emailController.text;
    }

    await fetchHandler(
      _authService.recoveryStep1(
        username: usernameController.text,
        account: account,
      ),
      loading: true,
      onSuccess: (String sidValue) {
        // 保存返回的 sid
        sid = sidValue;

        // 保存手机号/邮箱用于显示
        if (recoveryMethod.value == RecoveryMethod.phone) {
          displayPhone = phoneController.text;
          // 部分隐藏手机号
          if (displayPhone!.length > 7) {
            displayPhone = '${displayPhone!.substring(0, 3)}****${displayPhone!.substring(displayPhone!.length - 4)}';
          }
        } else {
          displayEmail = emailController.text;
          // 部分隐藏邮箱
          final parts = displayEmail!.split('@');
          if (parts[0].length > 2) {
            displayEmail = '${parts[0].substring(0, 2)}******@${parts[1]}';
          }
        }

        // 进入下一步
        currentStep.value = ForgotPasswordStep.identityVerify;
      },
      onError: toastError,
    );
  }

  // 验证验证码（第三步）
  Future<void> _verifyCode() async {
    if (verificationCodeController.text.isEmpty) {
      AppUtils.showToast('请输入验证码'.tr);
      return;
    }

    // 检查是否有 sid
    if (sid == null || sid!.isEmpty) {
      AppUtils.showToast('会话已过期，请重试'.tr);
      return;
    }

    await fetchHandler(
      _authService.recoveryStep3(
        sid: sid!,
        code: verificationCodeController.text,
      ),
      loading: true,
      onSuccess: (bool success) {
        if (success) {
          // 验证成功，进入下一步
          currentStep.value = ForgotPasswordStep.setPassword;
        }
      },
      onError: toastError,
    );
  }

  // 发送验证码（手动点击触发）
  Future<void> sendVerificationCode() async {
    // 检查是否有 sid（必须先完成第一步）
    if (sid == null || sid!.isEmpty) {
      AppUtils.showToast('请先完成账号验证'.tr);
      return;
    }

    await fetchHandler(
      _authService.recoveryStep2(sid: sid!),
      loading: true,
      onSuccess: (bool success) {
        if (success) {
          // 发送成功，启动倒计时
          countdownSeconds.value = countdownTime;
          _startCountdown();
        }
      },
      onError: toastError,
    );
  }

  // 重置密码（第四步）
  Future<void> _resetPassword() async {
    // 验证密码是否符合规则
    if (!isNewPasswordValid) {
      final errors = passwordStringValidate03(newPasswordController.text)
          .where((element) => !element.item2)
          .map((element) => element.item1.description)
          .toList();
      if (errors.isNotEmpty) {
        AppUtils.showToast(errors.first);
      }
      return;
    }

    // 验证确认密码
    if (!isConfirmPasswordValid) {
      if (newPasswordController.text.trim() != confirmPasswordController.text.trim()) {
        AppUtils.showToast('两次输入的密码不一致'.tr);
      } else {
        AppUtils.showToast('确认密码不符合规则'.tr);
      }
      return;
    }

    // 检查是否有 sid
    if (sid == null || sid!.isEmpty) {
      AppUtils.showToast('会话已过期，请重新开始'.tr);
      return;
    }

    await fetchHandler(
      _authService.recoveryStep4(
        sid: sid!,
        pwd: newPasswordController.text.trim(),
      ),
      loading: true,
      onSuccess: (bool success) {
        if (success) {
          // 重置成功，进入成功页面
          currentStep.value = ForgotPasswordStep.success;
        }
      },
      onError: toastError,
    );
  }

  // 启动倒计时
  void _startCountdown() {
    if (countdownSeconds.value > 0) {
      Future.delayed(Duration(seconds: 1), () {
        if (countdownSeconds.value > 0) {
          countdownSeconds.value--;
          _startCountdown();
        }
      });
    }
  }

  // 返回上一步
  void goBack() {
    switch (currentStep.value) {
      case ForgotPasswordStep.identityVerify:
        currentStep.value = ForgotPasswordStep.fillUsername;
        verificationCodeController.clear();
        countdownSeconds.value = 0;
        break;
      case ForgotPasswordStep.setPassword:
        currentStep.value = ForgotPasswordStep.identityVerify;
        newPasswordController.clear();
        confirmPasswordController.clear();
        break;
      default:
        Get.back();
    }
  }

  // 立即登录
  void loginNow() {
    Get.back();
  }

  // 返回首页
  void goHome() {
    AppNavigator.gotohome();
  }

  @override
  void onClose() {
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    verificationCodeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
