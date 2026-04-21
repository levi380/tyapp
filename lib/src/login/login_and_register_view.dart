import 'dart:math';

import 'package:filbet/common/language.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/activity/controllers/activity_controller.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/home/home_view_controller.dart';
import 'package:filbet/src/login/check_view.dart';
import 'package:filbet/src/login/login_and_register_controller.dart';
import 'package:filbet/src/login/login_and_register_text_field.dart';
import 'package:filbet/src/login/login_register_commit_button.dart';
import 'package:filbet/src/login/login_verify/login_verify_view.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/select_bottom_sheet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginAndRegisterView extends GetView<LoginAndRegisterController> {
  const LoginAndRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.loginLoginLoginBg,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Obx(() {
            return Column(
              children: [
                SizedBox(height: 78.r),
                Obx(
                  () => _AnimatedLoginLogoHeader(
                    visible: !controller.anyFieldFocused.value,
                    gapBelowLogo: 48.r,
                    logo: Image.asset(
                      Assets.loginLoginLogo,
                      width: 90.r,
                      height: 71.r,
                    ),
                  ),
                ),
                _officialSponsorBuild(),
                SizedBox(height: 20.r),
                if (controller.type.value == LoginAndRegisterType.login)
                  _buildLoginView()
                else if (controller.type.value == LoginAndRegisterType.register)
                  _buildRegisterView()
                else
                  _buildLoginVerify(),
                SizedBox(height: 20.h),
                _buildFunctionalsBottom(),
                // if (controller.type.value == LoginAndRegisterType.login) _tgLogin()
              ],
            );
          }),
        ),
      ),
    );
  }

  Future<T?> _selectLanguage<T>() async {
    final items = Language.values.map((lang) {
      return BottomSelectModel(
        title: lang.name,
        imgUrl: lang.imagePath,
        keyValue: lang.toString(),
      );
    }).toList();
    final selectedItem = BottomSelectModel(
      title: controller.language.value.name,
      imgUrl: controller.language.value.imagePath,
      keyValue: controller.language.value.toString(),
    );
    return Get.bottomSheet<T>(SelectBottomSheet(
      itemList: items,
      stypeType: 1,
      onValueChanged: (model) {
        final languageValue = Language.values.firstWhere(
          (lang) => lang.toString() == model.keyValue,
        );
        controller.language.value = languageValue;
        GlobalService.to.platformListNew();
        if (Get.isRegistered<ActivityController>()) {
          Get.find<ActivityController>().getPromoTypeData();
        }
        if (Get.isRegistered<HomeViewController>()) {
          HomeViewController.to.homeRefresh();
        }
      },
      selectedItem: selectedItem,
      title: 'choose_lang'.tr,
    )).then((value) {
      controller.accountFocusNode.unfocus();
      controller.passwordFocusNode.unfocus();
      controller.confirmPasswordFocusNode.unfocus();
      controller.verifyFocusNode.unfocus();
      // controller.invitationCodeFocusNode.unfocus();
    });
  }

  Widget _buildLanguageButton() {
    return GetBuilder<LoginAndRegisterController>(
      builder: (controller) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _selectLanguage,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            height: 30.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(20.r),
              color: appnewColors.bg2,
              gradient: LinearGradient(
                colors: [
                  Color(0xffFFFFFF),
                  Color(0xffE5EDFF),
                  Color(0xffFFFFFF)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff3B65B3).withAlpha(8),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Color(0xffF0F3FD),
                  offset: Offset(0, 2),
                  blurRadius: 0,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  controller.language.value.imagePath,
                  width: 20.r,
                  height: 20.r,
                ),
                SizedBox(width: 6.r),
                Text(
                  controller.language.value.name,
                  style: TextStyle(
                    color: appnewColors.text1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 6.r),
                Image.asset(
                  Assets.loginArrowDown,
                  width: 16.r,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _officialSponsorBuild() {
    final titleStyle = TextStyle(
      fontSize: 12.sp,
      fontFamily: 'PingFang SC',
      fontWeight: FontWeight.w500,
      color: appnewColors.textWhite,
    );
    final subtitleStyle = TextStyle(
      fontSize: 10.sp,
      fontFamily: 'PingFang SC',
      fontWeight: FontWeight.w400,
      color: Color(0xFFB1C1DB),
    );
    final sponsorSubtitle = '官方区域合作伙伴';

    return Row(
      spacing: 15.r,
      children: [
        for (final s in controller.officialSponsors)
          Expanded(
            child: Container(
              width: 100.r,
              height: 104.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                gradient: RadialGradient(
                  colors: [
                    Color(0x808A9DBD),
                    Color(0x8042577E),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    s.asset,
                    width: 40.r,
                    height: 40.r,
                  ),
                  SizedBox(height: 6.r),
                  Text(
                    s.titleKey.tr,
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    sponsorSubtitle,
                    style: subtitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLoginView() {
    return Column(
      children: [
        _buildAccountAndPassword(register: false),
        _buildRememberPasswordAndForgotPassword(),
        SizedBox(height: 32.r),
        _buildLoginButton(),
      ],
    );
  }

  Widget _buildRegisterView() {
    return Column(
      children: [
        _buildAccountAndPassword(register: true),
        _buildRegisterButton(),
      ],
    );
  }

  Widget _buildLoginVerify() {
    return LoginVerifyView();
  }

  static TextStyle _fieldTipStyle(double fontSize) => TextStyle(
        fontSize: fontSize,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w500,
        color: Color(0xFFEA5B5B),
      );

  /// 聚焦且无校验错误时，输入框下方规则说明使用与聚焦描边一致的蓝色。
  static TextStyle _fieldTipStyleBlue(double fontSize) => TextStyle(
        fontSize: fontSize,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w500,
        color: LoginAndRegisterTextField.focusBorderColor,
      );

  Widget _buildAccountAndPassword({required bool register}) {
    return Obx(() {
      final double icon = 20.r;
      final accountTip = 'char_4_11_letter_digit'.tr;

      Widget accountErrorBlock() =>
          Text(accountTip, style: _fieldTipStyle(12.sp));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 46.r,
            key: controller.accountFieldKey,
            child: LoginAndRegisterTextField(
              prefix: Image.asset(Assets.loginLoginAccountIcon,
                  width: icon, height: icon),
              controller: controller.accountController,
              focusNode: controller.accountFocusNode,
              hintText: '用户名',
              hasFocus: controller.accountIsFocus.value,
              isError: controller.isPresentLoginAccountInputError,
              textInputAction: TextInputAction.next,
              onChanged: (text) => controller.account.value = text,
            ),
          ),
          if (controller.isPresentLoginAccountInputError)
            Container(
              padding: EdgeInsets.fromLTRB(18.w, 6.h, 8.w, 14.r),
              child: accountErrorBlock(),
            )
          else if (controller.accountIsFocus.value)
            Container(
              padding: EdgeInsets.fromLTRB(18.w, 6.h, 8.w, 14.r),
              child: Text(accountTip, style: _fieldTipStyleBlue(12.sp)),
            )
          else
            SizedBox(height: 14.r),
          Container(
            height: 46.r,
            key: controller.passwordFieldKey,
            child: LoginAndRegisterTextField(
              obscureText: true,
              showClearButton: false,
              prefix: Image.asset(Assets.loginLoginPasswordIcon,
                  width: icon, height: icon),
              maxLength: 12,
              controller: controller.passwordController,
              focusNode: controller.passwordFocusNode,
              hintText: '密码',
              isError: controller.isPresentLoginPasswordInputError,
              hasFocus: controller.passwordIsFocus.value,
              textInputAction:
                  register ? TextInputAction.next : TextInputAction.done,
              onSubmitted: register
                  ? null
                  : () {
                      if (controller.isLoginButtonEnable) {
                        controller.loginByVerifyPhone();
                      }
                    },
              onChanged: (text) => controller.password.value = text,
            ),
          ),
          if (controller.isPresentLoginPasswordInputError)
            Container(
              padding: EdgeInsets.fromLTRB(18.w, 6.h, 8.w, 14.r),
              child: Text('login_pwd_rule'.tr, style: _fieldTipStyle(12.sp)),
            )
          else if (controller.passwordIsFocus.value)
            Container(
              padding: EdgeInsets.fromLTRB(18.w, 6.h, 8.w, 14.r),
              child:
                  Text('login_pwd_rule'.tr, style: _fieldTipStyleBlue(12.sp)),
            )
          else
            SizedBox(height: 14.r),
          if (register) ...[
            Container(
              height: 46.r,
              key: controller.confirmPasswordFieldKey,
              child: LoginAndRegisterTextField(
                obscureText: true,
                showClearButton: false,
                prefix: Image.asset(Assets.loginLoginPasswordIcon,
                    width: icon, height: icon),
                maxLength: 12,
                controller: controller.confirmPasswordController,
                focusNode: controller.confirmPasswordFocusNode,
                hintText: 'confirm_pwd'.tr,
                hasFocus: controller.confirmPasswordIsFocus.value,
                isError: controller.isConfirmPasswordInputError &&
                    controller.confirmPassword.value.isNotEmpty,
                textInputAction: TextInputAction.done,
                onSubmitted: () {
                  if (controller.isRegisterButtonEnable) {
                    controller.register();
                  }
                },
                onChanged: (text) => controller.confirmPassword.value = text,
              ),
            ),
            if (controller.isConfirmPasswordInputError &&
                controller.confirmPassword.value.isNotEmpty)
              Container(
                padding: EdgeInsets.fromLTRB(18.w, 6.h, 8.w, 14.r),
                child: Text('pwd_mismatch'.tr, style: _fieldTipStyle(12.sp)),
              )
            else
              SizedBox(height: 14.r),
            _checkProtocol(),
            SizedBox(height: 32.r),
          ],
        ],
      );
    });
  }

  Widget _buildRememberPasswordAndForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: controller.toggleRememberPassword,
          child: Row(
            children: [
              Obx(() {
                return CheckView(value: controller.isRememberPassword.value);
              }),
              SizedBox(width: 5.r),
              Text(
                'remember_pwd'.tr,
                style: TextStyle(
                  color: Color(0xff9FA5B5),
                  fontFamily: 'PingFang SC',
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        GestureDetector(
          onTap: _forgotPasswordDialog,
          child: Text(
            'forgot_pwd'.tr,
            style: TextStyle(
                color: Color(0xff9FA5B5),
                fontFamily: 'PingFang SC',
                fontSize: 12.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Obx(() {
      final canTap =
          controller.isLoginButtonEnable && !controller.isLoginSubmitting.value;
      return LoginRegisterCommitButton(
        canTap: canTap,
        onPressed: () => controller.loginByVerifyPhone(),
        label: 'login'.tr,
      );
    });
  }

  Widget _buildRegisterButton() {
    return Obx(() {
      final canTap = controller.isRegisterButtonEnable &&
          !controller.isRegisterSubmitting.value;
      return LoginRegisterCommitButton(
        canTap: canTap,
        onPressed: () {
          if (!controller.isProtocolCheck.value) {
            AppUtils.showToast("请勾选协议!");
            return;
          }
          controller.register();
        },
        label: 'register'.tr,
      );
    });
  }

  Widget _buildFunctionalElement(
    Image image,
    String text, {
    Function()? onTap,
    EdgeInsetsGeometry? margin,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100.w,
          height: 60.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Color(0x0FFFFFFF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image,
              SizedBox(height: 5.r),
              Text(
                text,
                style: TextStyle(
                  color: Color(0xFFB4B3B8),
                  fontSize: 12.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Image _functionalBottomTabIcon(String asset, {Color? color}) => Image.asset(
        asset,
        fit: BoxFit.cover,
        height: 20.w,
        width: 20.w,
        color: color,
      );

  Widget _buildGotoRegisterButton() => _buildFunctionalElement(
        _functionalBottomTabIcon(Assets.loginLoginRegister),
        'register_now'.tr,
        onTap: () {
          controller.clearAllFields();
          controller.verifyController.clear();
          controller.countdownSeconds.value = 0;
          controller.toggleLoginAndRegisterType(LoginAndRegisterType.register);
        },
        margin: EdgeInsets.zero,
      );

  Widget _buildGotoLoginButton() => _buildFunctionalElement(
        _functionalBottomTabIcon(Assets.loginLoginRegister,
            color: appnewColors.text2),
        'login_in_now'.tr,
        onTap: () {
          controller.clearAllFields();
          controller.toggleLoginAndRegisterType(LoginAndRegisterType.login);
        },
      );

  Future _showCustomerServiceDialog(String contentText) async {
    return Get.dialog(
      SkBaseDialog(
        title: 'contact_support'.tr,
        leftBtnTitle: 'cancel'.tr,
        rightBtnTitle: 'confirm'.tr,
        showFooterBtn: true,
        showDeleteBtn: false,
        child: Container(
          padding: EdgeInsets.all(20.r),
          child: Text(
            contentText,
            style: TextStyle(
              fontSize: 16.sp,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        callback: () {
          if (Get.isDialogOpen ?? false) Get.back();
          Future.delayed(Duration(milliseconds: 100), () {
            AppNavigator.gotoseveice();
          });
        },
      ),
    );
  }

  Future _customerServiceDialog() async {
    return _showCustomerServiceDialog('ask_support_confirm'.tr);
  }

  void _forgotPasswordDialog() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  Widget _buildFunctionalsBottom() {
    final type = controller.type.value;
    return Row(
      spacing: 9.r,
      children: [
        type == LoginAndRegisterType.register
            ? _buildGotoLoginButton()
            : _buildGotoRegisterButton(),
        _buildFunctionalElement(
          _functionalBottomTabIcon(Assets.loginLoginEnter),
          'enter_now'.tr,
          onTap: Get.back,
          margin: EdgeInsets.zero,
        ),
        _buildFunctionalElement(
          _functionalBottomTabIcon(Assets.loginLoginCustomerService),
          'online_support'.tr,
          onTap: _customerServiceDialog,
          margin: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _tgLogin() {
    if (controller.type.value == LoginAndRegisterType.login) {
      return Column(
        children: [
          SizedBox(height: 32.h),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: appnewColors.text5,
                  thickness: 2.h,
                  indent: 6,
                ),
              ),
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: appnewColors.text5,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 9.w),
              Text(
                "quick_login".tr,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "PingFang SC",
                  color: appnewColors.text1,
                ),
              ),
              SizedBox(width: 9.w),
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: appnewColors.text5,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Divider(
                  color: appnewColors.text5,
                  thickness: 2.h,
                  endIndent: 6,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.LOGIN_TELEGRAM);
            },
            child: Image.asset(
              Assets.loginTgLogin,
              width: 40.w,
              height: 40.w,
            ),
          ),
          SizedBox(height: 68.h),
        ],
      );
    }
    return Container();
    // } else {
    //   return SizedBox(
    //     height: 0,
    //   );
    // }
  }

  Widget _checkProtocol() {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          controller.isProtocolCheck.value = !controller.isProtocolCheck.value;
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return CheckView(
                value: controller.isProtocolCheck.value,
              );
            }),
            SizedBox(width: 3.w),
            RichText(
              text: TextSpan(
                text: '我已阅读并同意'.tr,
                style: TextStyle(
                    color: Color(0xFF9FA5B5),
                    fontSize: 12.sp,
                    fontFamily: "PingFang SC",
                    fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text: ' ',
                  ),
                  TextSpan(
                    text: '相关条款'.tr,
                    style: TextStyle(
                        color: Color(0xFF3B93D8),
                        fontSize: 12.sp,
                        fontFamily: "PingFang SC",
                        fontWeight: FontWeight.w400),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(text: 'draw'.tr),
                  TextSpan(
                    text: ' ',
                  ),
                  TextSpan(
                    text: '隐私政策'.tr,
                    style: TextStyle(
                        color: Color(0xFF3B93D8),
                        fontSize: 12.sp,
                        fontFamily: "PingFang SC",
                        fontWeight: FontWeight.w400),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('点击了隐私政策');
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Logo 仅淡入淡出；logo 下方间距用高度收合，带动下方内容上/下移动。
class _AnimatedLoginLogoHeader extends StatefulWidget {
  const _AnimatedLoginLogoHeader({
    required this.visible,
    required this.gapBelowLogo,
    required this.logo,
  });

  final bool visible;
  final double gapBelowLogo;
  final Widget logo;

  @override
  State<_AnimatedLoginLogoHeader> createState() =>
      _AnimatedLoginLogoHeaderState();
}

class _AnimatedLoginLogoHeaderState extends State<_AnimatedLoginLogoHeader>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 280);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _duration,
  );
  late final Animation<double> _curved = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutCubic,
  );

  @override
  void initState() {
    super.initState();
    if (widget.visible) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(covariant _AnimatedLoginLogoHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != oldWidget.visible) {
      if (widget.visible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curved,
      builder: (context, child) {
        final t = _curved.value.clamp(0.0, 1.0);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _curved,
              child: widget.logo,
            ),
            ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: t,
                child: SizedBox(
                  width: double.infinity,
                  height: widget.gapBelowLogo,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ValidationResult {
  final bool isValid;
  final String message;

  const ValidationResult({
    required this.isValid,
    required this.message,
  });
}

extension LanguageExtension on Language {
  String get imagePath {
    switch (this) {
      case Language.zh_cn:
        return Assets.languageChinese;
      // case Language.en:
      //   return Assets.languageEnglish;
      // case Language.viet:
      //   return Assets.languageVietnamese;
      case Language.zh_tw:
        return Assets.languageChinese;
    }
  }
}
