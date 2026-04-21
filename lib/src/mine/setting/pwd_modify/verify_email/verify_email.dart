import 'package:filbet/src/mine/setting/pwd_modify/verify_email/verify_email_controller.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_input.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_title.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/dialog/safe_verify_email_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerifyEmail extends GetView<VerifyEmailController> {
  VerifyEmail({super.key, required this.verityType, this.deleteId});

  bool isDisableInput = true;

  ValidationType verityType;
  String? deleteId;

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyEmailController());
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        children: [
          VerityTitleView(
            title: "邮箱号码",
          ),

          ///邮箱输入框
          Padding(
            padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
            child: VerityInput(
              controller: controller.emailController,
              isDisableInput: isDisableInput,
            ),
          ),
          VerityTitleView(
            title: "邮箱验证码",
          ),

          ///验证码输入框
          Padding(
            padding: EdgeInsets.only(top: 10.w),
            child: VerityInput(
              controller: controller.codeController,
              hintStr: "请输入邮箱验证码",
              rightView: sendSmsCode(),
            ),
          ),

          ///下一步
          Padding(
            padding: EdgeInsets.only(top: 30.w),
            child: nextBtn(),
          ),
          VerityKfView()
        ],
      ),
    );
  }

  Widget sendSmsCode() {
    return Obx(() {
      return CountDownTimer(
          content: '获取验证码',
          countdownSeconds: controller.countdownSeconds.value,
          callback: () {
            Get.dialog(
              SafeVerifyEmailDialog(
                  subEmail: controller.convertEmail(),
                  verifyType: verityType,
                  deleteId: deleteId,
                  safeVerifyConfirm: (value) {
                    controller.safeVerifyConfirm(verityType, value);
                  }),
              barrierDismissible: false,
            );
            // controller.getSendBindCode();
          });
    });
  }

  Widget nextBtn() {
    return Obx(() {
      return CommonActionButton(
        content: Text(
          '下一步'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        height: 44.h,
        isActive: controller.isEnabled.value,
        onPressed: () async {
          controller.nextStep(verityType);
        },
        borderRadius: BorderRadius.circular(12.r),
      );
    });
  }
}
