import 'package:filbet/generated/assets.dart';
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

import '../controllers/modify_withdraw_pwd_controller.dart';

//修改支付密码页面
class ModifyWithdrawPwdView extends GetView<ModifyWithdrawPwdController> {
  const ModifyWithdrawPwdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var hasPayPwd = controller.securityData.value?.hasPayPwd ?? false;
      return CustomScffold(
        showBgTexture: false,
        backgroundColor: appnewColors.bg1,
        appBar: CustomAppbar.normalTitle(
          bgColor: appnewColors.bg1,
          title: hasPayPwd ? '修改取款密码'.tr : "设置取款密码",
        ),
        body: Column(
          children: [
            /// 顶部提示
            if (!hasPayPwd)
              Container(
                padding: EdgeInsets.symmetric(vertical: 7.w, horizontal: 15.w),
                decoration: BoxDecoration(
                  color: appnewColors.bg5,
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.orange, size: 12.w),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        '请设置6位数字取款密码,用于提现验证',
                        style: TextStyle(fontSize: 12.sp, color: appnewColors.text28, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),

            Padding(
              padding: EdgeInsets.only(left: 12.w, top: 12.w, right: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.securityData.value?.hasPayPwd ?? false)
                    VerityTitleView(
                      title: "原密码",
                    ),

                  ///原始密码
                  if (controller.securityData.value?.hasPayPwd ?? false)
                    Padding(
                      padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
                      child: VerityInput(
                        keyboardType: TextInputType.number,
                        controller: controller.oldPwdController,
                        focusNode: controller.oldPwdFocusNode,
                        hasFocus: controller.oldPwdIsFocus.value,
                        obscureText: true,
                        // leftView: countryCode(),
                        hintStr: "请输入原始密码",
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        onChanged: (text) {
                          controller.oldPwdText.value = text;
                        },
                      ),
                    ),
                  VerityTitleView(
                    title: hasPayPwd ? "new_pwd".tr : "取款密码".tr,
                  ),

                  ///新密码（6位纯数字）
                  Padding(
                    padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
                    child: VerityInput(
                      focusNode: controller.newPwdFocusNode,
                      hasFocus: controller.newPwdIsFocus.value,
                      controller: controller.newController,
                      obscureText: true,
                      hintStr: "请输入6位数纯数字密码".tr,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      onChanged: (text) {
                        controller.newPwdText.value = text;
                      },
                      // rightView: sendSmsCode(),
                    ),
                  ),

                  VerityTitleView(
                    title: hasPayPwd ? '确认新密码' : '确认密码'.tr,
                  ),

                  ///确认新密码
                  Padding(
                    padding: EdgeInsets.only(top: 10.w),
                    child: VerityInput(
                      focusNode: controller.confirmPwdFocusNode,
                      hasFocus: controller.confirmPwdIsFocus.value,
                      controller: controller.confirmController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      hintStr: "请再次输入密码",
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      onChanged: (text) {
                        controller.confirmPwdText.value = text;
                      },
                      // rightView: sendSmsCode(),
                    ),
                  ),

                  SizedBox(height: 6.h),

                  if (!(controller.securityData.value?.hasPayPwd ?? false))
                    Text(
                      '仅支持数字组合,请勿使用连续或重复数字,防止泄露',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: appnewColors.text18,
                      ),
                    ),

                  ///下一步
                  Padding(
                    padding: EdgeInsets.only(top: 20.w),
                    child: nextBtn(),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget countryCode() {
    return Row(
      children: [
        Text(
          "+86",
          style: TextStyle(color: Color(0xff7B7F8B), fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          child: Image.asset(
            Assets.mineVerityDown,
            height: 5.w,
            width: 10.w,
          ),
        ),
      ],
    );
  }

  Widget sendSmsCode() {
    return Container(
      child: Text(
        "获取验证码",
        style: TextStyle(color: Color(0xff4C96FF), fontSize: 14.sp, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget nextBtn() {
    var hasPayPwd = controller.securityData.value?.hasPayPwd ?? false;
    return Obx(() {
      return CommonActionButton(
        content: Text(
          '完成设置'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        height: 44.h,
        isActive: hasPayPwd ? controller.getChangePaymentPassword() : controller.getSetNewPaymentPassword(),
        onPressed: () {
          controller.setPaymentPassword();
        },
        borderRadius: BorderRadius.circular(12.r),
      );
    });
  }
}
