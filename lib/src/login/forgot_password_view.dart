import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/src/login/forgot_password_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/sk_common_text_field.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg26,
      appBar: CustomAppbar.normalTitle(
        bgColor: appnewColors.textWhite,
        title: '密码找回'.tr,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProgressIndicator(),
                SizedBox(height: 16.h),
                Obx(() => _buildContent()),
                Obx(() => _buildBottomButton()),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 构建进度指示器
  Widget _buildProgressIndicator() {
    return Container(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
        color: appnewColors.textWhite,
        child: Obx(() {
          final step = controller.currentStep.value;
          return Row(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  Container(
                      height: 60.h,
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15.h),
                          height: 2.h,
                          color: appnewColors.textBlue,
                        ),
                      )),
                  Positioned(
                    right: 5.w,
                    bottom: 0.h,
                    child: _buildStepItem(
                      stepNumber: 1,
                      title: '填写用户名'.tr,
                      isCompleted: true,
                    ),
                  )
                ],
              )),
              Expanded(
                  child: Stack(
                children: [
                  Container(
                      height: 60.h,
                      child: Center(
                        child: Container(
                            margin: EdgeInsets.only(bottom: 15.h),
                            height: 2.h,
                            color: (step == ForgotPasswordStep.setPassword || step == ForgotPasswordStep.success)
                                ? appnewColors.textBlue
                                : appnewColors.bg27),
                      )),
                  Positioned(
                    right: 5.w,
                    bottom: 0.h,
                    child: _buildStepItem(
                      stepNumber: 2,
                      title: '身份验证'.tr,
                      isCompleted: step == ForgotPasswordStep.setPassword || step == ForgotPasswordStep.success,
                    ),
                  )
                ],
              )),
              Expanded(
                  child: Stack(
                children: [
                  Container(
                      height: 60.h,
                      child: Center(
                        child: Container(
                            margin: EdgeInsets.only(bottom: 15.h),
                            height: 2.h,
                            color: (step == ForgotPasswordStep.success) ? appnewColors.textBlue : appnewColors.bg27),
                      )),
                  Positioned(
                      right: 5.w,
                      bottom: 0.h,
                      child: _buildStepItem(
                        stepNumber: 3,
                        title: '设置密码'.tr,
                        isCompleted: step == ForgotPasswordStep.success,
                      )),
                ],
              )),
              Container(
                  height: 60.h,
                  child: Center(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 15.h),
                          width: 50,
                          height: 2.h,
                          color: (step == ForgotPasswordStep.success) ? appnewColors.textBlue : appnewColors.bg27))),
            ],
          );
        }));
  }

  // 构建步骤项
  Widget _buildStepItem({
    required int stepNumber,
    required String title,
    required bool isCompleted,
  }) {
    return Column(
      children: [
        Container(
          width: 28.r,
          height: 28.r,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.loginLoginRec),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(isCompleted ? appnewColors.textBlue : appnewColors.bg27, BlendMode.srcIn),
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$stepNumber',
              style: TextStyle(
                fontSize: 12.sp,
                color: isCompleted ? appnewColors.textWhite : Color(0xFF7B7F8B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: isCompleted ? appnewColors.textBlue : Color(0xFF7B7F8B),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // 构建内容区域
  Widget _buildContent() {
    switch (controller.currentStep.value) {
      case ForgotPasswordStep.fillUsername:
        return _buildFillUsernameStep();
      case ForgotPasswordStep.identityVerify:
        return _buildIdentityVerifyStep();
      case ForgotPasswordStep.setPassword:
        return _buildSetPasswordStep();
      case ForgotPasswordStep.success:
        return _buildSuccessStep();
    }
  }

  Widget _buildBottomButton() {
    switch (controller.currentStep.value) {
      case ForgotPasswordStep.fillUsername:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(color: appnewColors.bg26),
          child: Column(
            children: [
              SizedBox(height: 26.h),
              // 下一步按钮
              Obx(() => _buildNextButton()),
              SizedBox(height: 20.h),
              // 提示文字
              _buildHintText(),
            ],
          ),
        );
      case ForgotPasswordStep.identityVerify:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(color: appnewColors.bg26),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              // 下一步按钮
              Obx(() => _buildNextButton()),
              SizedBox(height: 20.h),
              // 提示文字
              _buildHintText(),
            ],
          ),
        );
      case ForgotPasswordStep.setPassword:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(color: appnewColors.bg26),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              // 密码提示
              Text(
                '请避免使用与其他网站相同或易于被他人猜测到的密码'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: appnewColors.text2,
                ),
              ),
              SizedBox(height: 20.h),
              // 完成按钮
              Obx(() => _buildCompleteButton()),
            ],
          ),
        );
      case ForgotPasswordStep.success:
        return Container();
    }
  }

  // 第一步：填写用户名
  Widget _buildFillUsernameStep() {
    return Container(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
        decoration: BoxDecoration(
          color: appnewColors.textWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 找回方式切换
            _buildRecoveryMethodTabs(),
            SizedBox(height: 10.h),
            // 用户名输入
            Text(
              '用户名'.tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: appnewColors.text1,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12.h),
            SkCommonTextField(
              fillColor: appnewColors.bgGray3,
              radius: BorderRadius.circular(8),
              controller: controller.usernameController,
              hintText: '请输入用户名'.tr,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: appnewColors.text31,
              ),
            ),
            SizedBox(height: 20.h),
            // 手机号/邮箱输入
            Obx(() {
              if (controller.recoveryMethod.value == RecoveryMethod.phone) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '手机号'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: appnewColors.text1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Container(
                          width: 60.w,
                          height: 44.h,
                          decoration: BoxDecoration(
                            color: appnewColors.bgGray3,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '+86',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: appnewColors.text1,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.w),
                                child: Image.asset(
                                  Assets.mineVerityDown,
                                  height: 5.w,
                                  width: 10.w,
                                ),
                              ),
                            ],
                          )),
                        ),
                        Expanded(
                          child: SkCommonTextField(
                            controller: controller.phoneController,
                            fillColor: appnewColors.bgGray3,
                            radius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                            hintText: '请输入手机号'.tr,
                            keyboardType: TextInputType.phone,
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: appnewColors.text31,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '邮箱'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: appnewColors.text1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SkCommonTextField(
                      fillColor: appnewColors.bgGray3,
                      radius: BorderRadius.circular(8),
                      controller: controller.emailController,
                      hintText: '请输入绑定邮箱'.tr,
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: appnewColors.text31,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                );
              }
            }),
          ],
        ));
  }

  // 构建找回方式切换标签
  Widget _buildRecoveryMethodTabs() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appnewColors.colorLine,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => GestureDetector(
                  onTap: () => controller.switchRecoveryMethod(RecoveryMethod.phone),
                  child: Container(
                      height: 40.h,
                      padding: EdgeInsets.symmetric(vertical: 0.h),
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              '手机找回'.tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: controller.recoveryMethod.value == RecoveryMethod.phone
                                    ? appnewColors.text1
                                    : appnewColors.text2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 90.w,
                            color: controller.recoveryMethod.value == RecoveryMethod.phone
                                ? appnewColors.textBlue
                                : Colors.transparent,
                            height: 4.h,
                          ),
                        ],
                      )),
                )),
          ),
          Expanded(
            child: Obx(() => GestureDetector(
                  onTap: () => controller.switchRecoveryMethod(RecoveryMethod.email),
                  child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              '邮箱找回'.tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: controller.recoveryMethod.value == RecoveryMethod.email
                                    ? appnewColors.text1
                                    : appnewColors.text2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 90.w,
                            color: controller.recoveryMethod.value == RecoveryMethod.email
                                ? appnewColors.textBlue
                                : Colors.transparent,
                            height: 4.h,
                          ),
                        ],
                      )),
                )),
          ),
        ],
      ),
    );
  }

  // 第二步：身份验证
  Widget _buildIdentityVerifyStep() {
    return Container(
        padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 20.h, bottom: 20.h),
        decoration: BoxDecoration(
          color: appnewColors.textWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 显示手机号/邮箱
            Obx(() {
              if (controller.recoveryMethod.value == RecoveryMethod.phone) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '手机号码'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: appnewColors.text1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: appnewColors.bgGray3,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        controller.displayPhone ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: appnewColors.text1,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '邮箱地址'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: appnewColors.text1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: appnewColors.bg4,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        controller.displayEmail ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: appnewColors.text1,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
            SizedBox(height: 20.h),
            // 验证码输入
            Text(
              '获取验证码'.tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: appnewColors.text1,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12.h),
            SkCommonTextField(
              controller: controller.verificationCodeController,
              fillColor: appnewColors.bgGray3,
              radius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: appnewColors.text31,
              ),
              hintText: controller.recoveryMethod.value == RecoveryMethod.phone ? '请输入手机验证码'.tr : '请输入邮箱验证码'.tr,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              suffix: Obx(() => Container(
                    margin: EdgeInsets.only(right: 12.w),
                    child: CountDownTimer(
                      content: '获取验证码'.tr,
                      countdownSeconds: controller.countdownSeconds.value,
                      callback: () {
                        controller.sendVerificationCode();
                      },
                    ),
                  )),
            ),
          ],
        ));
  }

  // 第三步：设置密码
  Widget _buildSetPasswordStep() {
    return Container(
        padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 20.h, bottom: 20.h),
        decoration: BoxDecoration(
          color: appnewColors.textWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 登录密码
            Text(
              '登录密码'.tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: appnewColors.text1,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12.h),
            SkCommonTextField(
              fillColor: appnewColors.bgGray3,
              radius: BorderRadius.circular(8),
              controller: controller.newPasswordController,
              hintText: "请输入8-12位字母+数字的组合".tr,
              isObscure: true,
            ),
            SizedBox(height: 20.h),
            // 确认密码
            Text(
              '确认密码'.tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: appnewColors.text1,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12.h),
            SkCommonTextField(
              fillColor: appnewColors.bgGray3,
              radius: BorderRadius.circular(8),
              controller: controller.confirmPasswordController,
              hintText: '请再次输入密码'.tr,
              isObscure: true,
            ),
          ],
        ));
  }

  // 成功页面
  Widget _buildSuccessStep() {
    return Column(
      children: [
        SizedBox(height: 35.h),

        Container(
          width: 120.r,
          height: 120.r,
          decoration: BoxDecoration(
            color: Color(0xFF08C605),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            size: 70.r,
            color: appnewColors.textWhite,
          ),
        ),

        SizedBox(height: 55.h),
        // 成功文字
        Text(
          '恭喜您,您的密码已经修改成功'.tr,
          style: TextStyle(
            fontSize: 12.sp,
            color: appnewColors.text31,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          width: double.infinity,
          height: 44.h,
          child: GestureDetector(
            onTap: controller.loginNow,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appnewColors.textBlue,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text('立即登录'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: appnewColors.textWhite,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        // 返回首页按钮
        SizedBox(
          width: double.infinity,
          height: 44.h,
          child: GestureDetector(
            onTap: controller.goHome,
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: appnewColors.textBlue),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '返回首页'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: appnewColors.textBlue,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ),
        ),
      ],
    );
  }

  // 构建下一步按钮
  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: GestureDetector(
        onTap: controller.canNext.value ? controller.nextStep : null,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: controller.canNext.value ? appnewColors.textBlue : appnewColors.textBlue.withOpacity(.4),
            ),
            child: Text(
              '下一步'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: appnewColors.textWhite,
                fontWeight: FontWeight.w500,
              ),
            )),
      ),
    );
  }

  // 构建完成按钮
  Widget _buildCompleteButton() {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: GestureDetector(
        onTap: controller.canNext.value ? controller.nextStep : null,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: controller.canNext.value ? appnewColors.textBlue : appnewColors.textBlue.withOpacity(.4),
            ),
            child: Text(
              '完成'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: appnewColors.textWhite,
                fontWeight: FontWeight.w500,
              ),
            )),
      ),
    );
  }

  // 构建提示文字
  Widget _buildHintText() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: appnewColors.text2,
          ),
          children: [
            TextSpan(text: '如用户名没有绑定手机号或邮箱,请联系'.tr),
            TextSpan(
              text: '客服'.tr,
              style: TextStyle(color: appnewColors.textBlue, fontWeight: FontWeight.w500),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  AppNavigator.gotoseveice();
                },
            ),
            TextSpan(text: '找回密码。'.tr),
          ],
        ),
      ),
    );
  }
}
