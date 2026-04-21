import 'dart:async';

import 'package:filbet/src/security/security_component.dart';
import 'package:filbet/src/security/security_controller.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/common_textfield.dart';
import 'package:filbet/widgets/pop_up_view.dart';
import 'package:filbet/widgets/sk_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

typedef SecurityVeriyCodeCallback = void Function(String?);
mixin SecurityVerificationMixin {
  SecurityController get securityController;

  void performSecurityVerification(
    SecuritySecondaryVerifyType type, {
    SecurityVeriyCodeCallback? onSuccess,
    VoidCallback? onCancel,
  }) {
    switch (type) {
      case SecuritySecondaryVerifyType.email:
        _performEmailVerification(onSuccess, onCancel);
      case SecuritySecondaryVerifyType.google:
        _performGoogleVerification(onSuccess, onCancel);
      case SecuritySecondaryVerifyType.none:
        onSuccess?.call(null);
    }
  }

  void _performEmailVerification(
    SecurityVeriyCodeCallback? onSuccess,
    VoidCallback? onCancel,
  ) async {
    securityController.emailSecurityVerificationCodeController.clear();
    securityController.emailSecurityVerificationCode.value = '';

    securityController.startPeriodicSync();

    final popUp = Obx(() => PopUpView.withCancelActionButton(
          title: 'email_verify'.tr,
          showClose: false,
          canConfirmAction:
              securityController.emailSecurityVerificationCode.value.length ==
                  6,
          onCofirm: () async {
            securityController.stopPeriodicSync();

            securityController.forceSyncEmailSecurityCode();

            final code = securityController.emailSecurityVerificationCode.value;

            if (code.length == 6) {
              onSuccess?.call(code);
              if (Get.isDialogOpen ?? false) {
                Get.back();
              }
            } else {
              AppUtils.showToast('input_6_digit_code'.tr);
            }
          },
          content: buildEmailVerificationContent(securityController.email),
          onCancel: () {
            securityController.stopPeriodicSync();
            onCancel?.call();
          },
        ));

    // Use bottom sheet so it moves with keyboard
    Get.bottomSheet(
      popUp,
      isScrollControlled: true,
    );
  }

  Future<bool> _performGoogleVerification(
    SecurityVeriyCodeCallback? onSuccess,
    VoidCallback? onCancel,
  ) async {
    final completer = Completer<bool>();

    securityController.startPeriodicSync();

    final popUp = PopUpView.withActionButton(
      title: 'google_auth'.tr,
      content: buildGoogleAuthVerificationContent(),
      actionButton: Obx(() {
        return CommonActionButton.confirm(
          securityController.googleAuthCode.value.length == 6,
          onPressed: () async {
            securityController.stopPeriodicSync();
            final code = securityController.googleAuthCode.value;

            if (code.length == 6) {
              if (Get.isDialogOpen ?? false) {
                Get.back();
              }
              if (!completer.isCompleted) completer.complete(true);
              onSuccess?.call(code);
            } else {
              AppUtils.showToast('input_6_digit_code'.tr);
              // 不关闭弹窗
            }
          },
        );
      }),
      onClose: () {
        securityController.stopPeriodicSync();
        onCancel?.call();
        if (!completer.isCompleted) completer.complete(false);
      },
    );

    // Use bottom sheet so it moves with keyboard
    Get.bottomSheet(
      popUp,
      isScrollControlled: true,
    );
    return completer.future;
  }

  Widget buildEmailVerificationContent(String email) {
    return Column(
      children: [
        Text(
          "email_verification".trParams({'email': email}),
          style: TextStyle(
            fontSize: 14.sp,
            color: appColors.textMainColor,
          ),
        ),
        SizedBox(height: 20.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'email_code'.tr,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: appColors.textMainColor,
              ),
            ),
            SizedBox(height: 8.h),
            CommonTextfield(
              hintText: 'input_verify_code_received'.tr,
              isObscure: false,
              maxLength: 6,
              controller:
                  securityController.emailSecurityVerificationCodeController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              suffix: GestureDetector(
                onTap:
                    securityController.isEmailVerificationCodeCountDownRunning
                        ? null
                        : () {
                            securityController.sendSecurityCodeToEmail();
                          },
                child: Obx(() => Text(
                      securityController.isEmailVerificationCodeCountDownRunning
                          ? '${securityController.emailVerficationCodeCountDown.value}s'
                          : 'get_code'.tr,
                      style: TextStyle(
                        color: appColors.textMain2Color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildGoogleAuthVerificationContent() {
    return Column(
      children: [
        Text(
          'open_auth_input_code'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            color: appColors.textMainColor,
          ),
        ),
        SizedBox(height: 20.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'authenticator'.tr,
              style: TextStyle(
                fontSize: 12.sp,
                color: appColors.textSecondColor,
              ),
            ),
            SizedBox(height: 8.h),
            CommonTextfield(
              hintText: 'input_verify_code'.tr,
              isObscure: false,
              maxLength: 6,
              controller: securityController.googleAuthController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ],
        ),
      ],
    );
  }

  bool needSecurityVerification() {
    return securityController.hasSecAuth;
  }

  SecuritySecondaryVerifyType getCurrentSecurityVerificationType() {
    return securityController.verifyType.value;
  }

  void executeWithSecurityVerification(
    SecurityVeriyCodeCallback action, {
    VoidCallback? onCancel,
    bool requireVerification = true,
  }) async {
    securityController.earseSecondaryVerifyCode();
    if (!requireVerification || !needSecurityVerification()) {
      action(null);
      return;
    }

    performSecurityVerification(
      getCurrentSecurityVerificationType(),
      onSuccess: action,
      onCancel: onCancel,
    );
  }

  Future<void> setPaymentPasswordProcedure() async {
    setPaymentPasswordFirst(
      onSuccess: (isSuccess) {
        if (isSuccess && (Get.isDialogOpen ?? false)) Get.back(); //dismiss提示框
      },
      onCancel: () {
        securityController.earseTextControllers();
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      },
    );
  }

  void setPaymentPasswordFirst({
    void Function(bool)? onSuccess,
    VoidCallback? onCancel,
  }) {
    final popUp = Obx(() {
      final _ = [
        securityController.newPaymentPassword.value,
        securityController.confirmPaymentPassword.value,
      ];
      return PopUpView.withCancelActionButton(
        title: 'set_pay_pwd'.tr,
        content: buildSetPaymentPassword(),
        onCancel: onCancel,
        showClose: false,
        canConfirmAction: securityController.canSetPaymentPassword,
        onCofirm: () async {
          final pwd = securityController.newPaymentPasswordController.text;
          securityController.earseTextControllers();
          if (securityController.hasSecAuth) {
            executeWithSecurityVerification((secCode) async {
              final isSuccess =
                  await securityController.setPayPwd(pwd, secCode: secCode);
              if (onSuccess != null) onSuccess(isSuccess);
            });
            return;
          }
          final isSuccess = await securityController.setPayPwd(pwd);
          if (onSuccess != null) onSuccess(isSuccess);
        },
      );
    });

    Get.dialog(popUp);
  }

  Widget buildSetPaymentPassword() {
    return Column(
      children: [
        buildSecurityPasswordTextFieldContentWithTitle(
          'pay_pwd'.tr,
          hintText: 'input_pay_pwd'.tr,
          controller: securityController.newPaymentPasswordController,
          onChanged: (val) => securityController.newPaymentPassword.value = val,
          maxLength: 6,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20.h),
        buildSecurityPasswordTextFieldContentWithTitle(
          'confirm_pwd'.tr,
          hintText: 'reenter_pay_pwd'.tr,
          controller: securityController.confirmPaymentPasswordController,
          onChanged: (val) =>
              securityController.confirmPaymentPassword.value = val,
          maxLength: 6,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
