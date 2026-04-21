import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/setting/pwd_modify/pwd_modify_controller.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_input.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_title.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///修改登录密码
class PwdModifyPage extends GetView<PwdModifyController> {
  const PwdModifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        bgColor: appnewColors.bg1,
        title: '修改密码',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20.w, top: 20.w, right: 20.w),
          child: Column(
            children: [
              VerityTitleView(
                title: "原密码",
              ),

              ///原始密码
              Padding(
                padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
                child: Obx(() {
                  return VerityInput(
                    controller: controller.oldPwdController,
                    hintStr: "请输入原始密码",
                    obscureText: controller.oldPwdObscureText.value,
                    rightView: controller.oldPwdHasText.value
                        ? InkWell(
                            onTap: () {
                              controller.oldPwdObscureText.value = !controller.oldPwdObscureText.value;
                            },
                            child: eyeView(controller.oldPwdObscureText.value),
                          )
                        : null,
                  );
                }),
              ),
              VerityTitleView(
                title: "新密码",
              ),

              Padding(
                padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
                child: Obx(() {
                  var newPwdStr = controller.newPwdStr.value;
                  return Column(
                    children: [
                      VerityInput(
                        controller: controller.newController,
                        hintStr: "login_pwd_rule".tr,
                        obscureText: controller.newPwdObscureText.value,
                        rightView: controller.newPwdHasText.value
                            ? Row(
                                children: [
                                  GestureDetector(
                                    child: Image.asset(
                                      Assets.mineIconClearInputContent,
                                      width: 16.r,
                                      height: 16.r,
                                    ),
                                    onTap: () {
                                      controller.newController.clear();
                                    },
                                  ),
                                  SizedBox(width: 8.w),
                                  InkWell(
                                    onTap: () {
                                      controller.newPwdObscureText.value = !controller.newPwdObscureText.value;
                                    },
                                    child: eyeView(controller.newPwdObscureText.value),
                                  )
                                ],
                              )
                            : null,
                      ),
                      if (controller.isPresentLoginPasswordInputError)
                        Container(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            'login_pwd_rule'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              color: appnewColors.tip1,
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ),

              VerityTitleView(
                title: "确认新密码",
              ),

              ///确认新密码
              Padding(
                padding: EdgeInsets.only(top: 10.w),
                child: Obx(() {
                  var newPwdStr = controller.confirmPassword.value;
                  return Column(
                    children: [
                      VerityInput(
                        controller: controller.confirmController,
                        hintStr: "请再次输入密码",
                        obscureText: controller.confirmPwdObscureText.value,
                        rightView: controller.confirmPwdHasText.value
                            ? Row(
                                children: [
                                  GestureDetector(
                                    child: Image.asset(
                                      Assets.mineIconClearInputContent,
                                      width: 16.r,
                                      height: 16.r,
                                    ),
                                    onTap: () {
                                      controller.confirmController.clear();
                                    },
                                  ),
                                  SizedBox(width: 8.w),
                                  InkWell(
                                    onTap: () {
                                      controller.confirmPwdObscureText.value = !controller.confirmPwdObscureText.value;
                                    },
                                    child: eyeView(controller.confirmPwdObscureText.value),
                                  )
                                ],
                              )
                            : null,
                      ),
                      if (controller.isConfirmPasswordInputError && controller.confirmPassword.value.isNotEmpty)
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            'pwd_mismatch'.tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              color: appnewColors.tip1,
                            ),
                          ),
                        )
                    ],
                  );
                }),
              ),

              ///下一步
              Padding(
                padding: EdgeInsets.only(top: 20.w),
                child: nextBtn(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget eyeView(bool isObscureText) {
    return SizedBox(
      width: 16.r,
      height: 16.r,
      child: Image.asset(
        isObscureText ? Assets.homeNoeye : Assets.homeEye,
      ),
    );
  }

  Widget nextBtn() {
    return Obx(() {
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
        isActive: controller.isEnable.value,
        onPressed: () {
          controller.submit();
        },
        borderRadius: BorderRadius.circular(12.r),
      );
    });
  }
}
