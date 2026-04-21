import 'package:filbet/src/mine/verity_identity/widget/verity_input.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_title.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/forget_withdrawal_pwd_controller.dart';

/// 找回取款密码 重置密码页面
class ForgetWithdrawalPwdView extends GetView<ForgetWithdrawalPwdController> {
  const ForgetWithdrawalPwdView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        bgColor: appnewColors.bg1,
        title: "取款密码",
      ),
      body: Obx(() {
        var oldPwdText = controller.newPwdText.value;

        return Padding(
          padding: EdgeInsets.only(left: 12.w, top: 12.w, right: 12.w),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            VerityTitleView(
              title: "取款密码",
            ),

            ///新密码（6位纯数字）
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
              child: VerityInput(
                controller: controller.newController,
                hintStr: "请输入6位纯数字密码",
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                // rightView: sendSmsCode(),
              ),
            ),

            VerityTitleView(
              title: "确认密码",
            ),

            ///确认新密码
            Padding(
              padding: EdgeInsets.only(top: 10.w),
              child: VerityInput(
                controller: controller.confirmController,
                keyboardType: TextInputType.number,
                hintStr: "请再次输入密码",
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                // rightView: sendSmsCode(),
              ),
            ),

            ///下一步
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: nextBtn(),
            ),
          ]),
        );
      }),
    );
  }

  Widget nextBtn() {
    return CommonActionButton(
      content: Text(
        '提交'.tr,
        style: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'PingFang SC',
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      height: 44.h,
      isActive: controller.setNewPaymentPassword,
      onPressed: () async {
        var isSuccess = await controller.getResetStep3();
        if (isSuccess) {
          Get.back();
        }
      },
      borderRadius: BorderRadius.circular(12.r),
    );
  }
}
