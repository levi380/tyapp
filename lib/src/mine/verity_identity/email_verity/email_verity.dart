import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/src/mine/verity_identity/email_verity/email_verity_controller.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_input.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_title.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmailVerity extends GetView<EmailVerityController> {
  EmailVerity({super.key, this.verityType, this.accountId});

  bool isDisableInput = true;

  ValidationType? verityType;
  String? accountId;

  @override
  Widget build(BuildContext context) {
    Get.put(EmailVerityController());
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
            controller.getSendBindCode();
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
          if (controller.codeController.text.trim().isEmpty) {
            return AppUtils.showToast('请输入验证码！');
          }
          var isSuccess = await controller.phoneCodeVerify(2, controller.codeController.text.trim(), 2);
          if (isSuccess) {
            if (ValidationType.changeLoginPwd.name == verityType?.name) {
              //修改密码
              Get.offAndToNamed(Routes.PWD_MODIFY);
            } else if (ValidationType.checkData.name == verityType?.name) {
              Get.back(result: true);
            } else if (ValidationType.deleteData.name == verityType?.name) {
              Get.back(result: true);
            } else if (ValidationType.changePayPwd.name == verityType?.name) {
              ///测试修改取款密码成功
              Get.back(result: true);
              // Get.toNamed(Routes.MODIFY_WITHDRAW_PWD_SUCCESS);
            } else {
              Get.toNamed(Routes.GETPWD_BYPHONE, arguments: {"type": 2});
            }
          }
        },
        borderRadius: BorderRadius.circular(12.r),
      );
    });
  }
}
