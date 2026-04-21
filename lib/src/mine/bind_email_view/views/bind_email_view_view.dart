import 'package:filbet/src/mine/verity_identity/widget/verity_input.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_title.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/base_util.dart';
import 'package:filbet/utils/security_util.dart';
import 'package:filbet/utils/string_utils.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/bind_email_view_controller.dart';

class BindEmailViewView extends GetView<BindEmailViewController> {
  const BindEmailViewView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        bgColor: appnewColors.bg1,
        title: "电子邮箱".tr,
      ),
      body: Obx(() {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.w),
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Column(
                children: [
                  VerityTitleView(
                    title: "邮箱账号".tr,
                  ),

                  ///邮箱输入框
                  Padding(
                    padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
                    child: VerityInput(
                      hintStr: "请输入邮箱账号".tr,
                      controller: controller.emailController,
                      isDisableInput: controller.isDisableInput,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9._@-]')),
                        _EmailInputFormatter(),
                      ],
                    ),
                  ),
                  VerityTitleView(
                    title: "邮箱验证码",
                  ),

                  ///验证码输入框
                  Padding(
                    padding: EdgeInsets.only(top: 10.w),
                    child: VerityInput(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: controller.codeController,
                      hintStr: "请输入邮箱验证码",
                      rightView: CountDownTimer(
                        content: 'get_code'.tr,
                        countdownSeconds: controller.countdownSeconds.value,
                        callback: () {
                          controller.sendSmsCode();
                        },
                      ),
                    ),
                  ),

                  ///下一步
                  Padding(
                    padding: EdgeInsets.only(top: 30.w),
                    child: nextBtn(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.w),
                    child: Text(
                      "为了您的隐私安全信息在确认后将无法修改".tr,
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: appnewColors.text23),
                    ),
                  ),
                  VerityKfView()
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget nextBtn() {
    return Obx(() {
      return CommonActionButton(
        content: Text(
          '完成绑定'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        height: 44.h,
        isActive: controller.codeText.trim().isNotEmpty && controller.codeText.trim().length > 5&& controller.isValidEmail,
        onPressed: () {
          controller.bindEmailAddress();
        },
        borderRadius: BorderRadius.circular(12.r),
      );
    });
  }
}

/// 邮箱输入格式化器，用于实时校验邮箱格式
class _EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 允许空值
    if (newValue.text.isEmpty) {
      return newValue;
    }
    
    final text = newValue.text;
    
    // 检查是否包含 @
    final atIndex = text.indexOf('@');
    
    if (atIndex == -1) {
      // 还没有 @，只允许本地部分的字符
      // 本地部分：a-z A-Z 0-9 . _ -，长度 1-32
      if (text.length > 32) {
        return oldValue;
      }
      // 不能以 . 开头
      if (text.startsWith('.')) {
        return oldValue;
      }
      // 不能连续出现 ..
      if (text.contains('..')) {
        return oldValue;
      }
      return newValue;
    } else {
      // 已经有 @，分割本地部分和域名部分
      final localPart = text.substring(0, atIndex);
      final domainPart = text.substring(atIndex + 1);
      
      // 本地部分校验
      if (localPart.isEmpty || localPart.length > 32) {
        return oldValue;
      }
      if (localPart.startsWith('.') || localPart.endsWith('.')) {
        return oldValue;
      }
      if (localPart.contains('..')) {
        return oldValue;
      }
      
      // 域名部分校验
      if (domainPart.length > 63) {
        return oldValue;
      }
      // 不能以 . 或 - 开头
      if (domainPart.isNotEmpty && (domainPart.startsWith('.') || domainPart.startsWith('-'))) {
        return oldValue;
      }
      
      return newValue;
    }
  }
}
