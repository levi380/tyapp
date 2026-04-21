import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_input.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_title.dart';
import 'package:filbet/src/security/widgets/bottom_safe_verify.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/retrieve_withdrawal_pwd_controller.dart';

//找回取款密码 输入新密码页面
class RetrieveWithdrawalPwdView extends GetView<RetrieveWithdrawalPwdController> {
  const RetrieveWithdrawalPwdView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: Colors.white,
      appBar: CustomAppbar.normalTitle(
        bgColor: Colors.white,
        title: '手机号码'.tr,
      ),
      body: Obx(() {
        return Column(children: [
         // topInfo(),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                VerityTitleView(
                  title: "手机号码",
                ),

                ///手机号输入框
                Padding(
                  padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
                  child: VerityInput(
                    controller: controller.phoneController,
                    isDisableInput: controller.userService.state.userInfo.phone?.isNotEmpty == true,
                    leftView: countryCode(),
                  ),
                ),
                VerityTitleView(
                  title: "手机验证码",
                ),

                ///验证码输入框
                Padding(
                  padding: EdgeInsets.only(top: 10.w),
                  child: VerityInput(
                    controller: controller.codeController,
                    hintStr: "请输入手机验证码",
                    rightView: Obx(() => CountDownTimer(
                          content: 'get_code'.tr,
                          countdownSeconds: controller.countdownSeconds.value,
                          callback: () async {
                            String phone = UserService.to.state.userInfo.phone ?? '';
                            if (phone.isNotEmpty) {
                              Get.bottomSheet(
                                SKBottomSheet(
                                  top: 24.h,
                                  left: 16.w,
                                  title: 'safe_verify'.tr,
                                  content: BottomSafeVerify(
                                    phoneNum: phone,
                                    onConfirm: (value) async {
                                      if (Get.isBottomSheetOpen ?? false) {
                                        Get.back();
                                      }
                                      var isSuccess = await controller.postPhoneVerify(value);
                                      if (isSuccess) {
                                        String replacePhone = phone.replaceAll("****", value);
                                        controller.countdownSeconds.value = 0;
                                        controller.getSendBindCode(replacePhone);
                                      }
                                    },
                                  ),
                                ),
                                isScrollControlled: true,
                              );
                            } else {
                              if (controller.phoneController.text.isEmpty) {
                                AppUtils.showToast('请输入手机号');
                                return;
                              }
                              var isSuccess = await controller.postPhoneVerify(controller.phoneController.text.trim());
                              if (isSuccess) {
                                controller.countdownSeconds.value = 0;
                                controller.getSendBindCode("");
                              }
                            }
                          },
                        )),
                  ),
                ),

                ///下一步
                Padding(
                  padding: EdgeInsets.only(top: 30.w),
                  child: nextBtn(),
                ),
              ],
            ),
          ),
        ]);
      }),
    );
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

  Widget nextBtn() {
    return CommonActionButton(
      content: Text(
        'submit'.tr,
        style: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'PingFang SC',
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      height: 44.h,
      isActive: controller.codeText.isNotEmpty,
      onPressed: () async {
        if (controller.codeController.text.isEmpty) {
          AppUtils.showToast('请输入验证码');
          return;
        }
        var isSuccess = await controller.getResetStep3();
        if (isSuccess) {
          Get.back();
          Get.toNamed(Routes.FORGET_WITHDRAWAL_PWD, arguments: {"sid": controller.sid.value ?? ""});
        }
      },
      borderRadius: BorderRadius.circular(12.r),
    );
  }

  Widget topInfo() {
    return Container(
      height: 32.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.w),
      color: Color(0xffF8F8FF),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            Assets.mineVerityAttention,
            width: 12.w,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            "为了您的账户安全，请确保填写真实信息",
            style: TextStyle(color: Color(0xff8888A1), fontSize: 12.sp, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
