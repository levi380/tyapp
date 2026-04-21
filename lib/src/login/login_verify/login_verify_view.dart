import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/login/login_and_register_controller.dart';
import 'package:filbet/src/login/login_register_commit_button.dart';
import 'package:filbet/src/login/login_and_register_text_field.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/dialog/safe_verify_login_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginVerifyView extends GetView<LoginAndRegisterController> {
  const LoginVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '因本次登录不是常用IP,故需要安全验证',
          style: TextStyle(
            color: Color(0xFF9FA5B5),
            fontSize: 12.sp,
          ),
        ),
        Container(
          height: 48.r,
          margin: EdgeInsets.only(top: 20.r),
          child: Obx(
            () => LoginAndRegisterTextField(
              focusNode: controller.verifyFocusNode,
              hasFocus: controller.verifyIsFocus.value,
              prefix: Image.asset(
                Assets.loginIconVerify,
                width: 20.r,
                height: 20.r,
                color: Colors.white,
              ),
              controller: controller.verifyController,
              onChanged: (text) {
                controller.verifyCode.value = text;
              },
              hintText: 'input_verify_code'.tr,
              inputTextColor: appnewColors.text2,
              hintColor: appnewColors.text3,
              suffix: Obx(() {
              return Container(
                width: 100.r,
                alignment: Alignment.center,
                child: CountDownTimer(
                  content: 'get_code'.tr,
                  textColor: Color(0xFF2084D8),
                  countdownSeconds: controller.countdownSeconds.value,
                  callback: () {
                    Get.dialog(
                      SafeVerifyLoginDialog(
                        phoneNum: controller.loginInfo?.maskedPhone ?? '',
                        sid: controller.loginInfo?.sid ?? '',
                        safeVerifyConfirm: (result, inputContent, isFirst) {
                          if (result == true) {
                            controller.sendCode();
                          } else {
                            if (!isFirst) {
                              controller.loginByVerifyPhoneAgain(inputContent);
                            }
                          }
                        },
                      ),
                    );
                    // controller.countdownSeconds.value = 60;
                  },
                ),
              );
            }),
            ),
          ),
        ),
        SizedBox(height: 32.r),
        Obx(
          () => LoginRegisterCommitButton(
            canTap: controller.verifyCode.value.trim().isNotEmpty,
            onPressed: () => controller.verifySmsCode(),
            label: 'login'.tr,
          ),
        ),
        changeAccountButton(),
      ],
    );
  }

  Widget changeAccountButton() {
    return Container(
      margin: EdgeInsets.only(top: 20.r),
      width: double.infinity,
      height: 48.r,
      child: GestureDetector(
        onTap: () {
          controller.verifyController.clear();
          controller.countdownSeconds.value = 0;
          controller.toggleLoginAndRegisterType(LoginAndRegisterType.login);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            color: Color(0x0FFFFFFF),
          ),
          child: Text(
            '切换账号'.tr,
            style: TextStyle(
              color: appnewColors.textWhite,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
