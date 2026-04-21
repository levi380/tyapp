import 'package:city_pickers/city_pickers.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/src/security/widgets/bottom_area_code.dart';
import 'package:filbet/src/security/widgets/bottom_bank_card_list.dart';
import 'package:filbet/src/security/widgets/bottom_bank_tip.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/bank_card_real_name.dart';
import 'package:filbet/widgets/area_code_selector.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/common_textfield.dart';
import 'package:filbet/widgets/content_shadow_wrapper.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/dialog/dialog_area_code.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/real_name_authentication_controller.dart';

class RealNameAuthenticationView
    extends GetView<RealNameAuthenticationController> {
  const RealNameAuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar.normalTitle(
        bgColor: Colors.white,
        title: '实名认证'.tr,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
            color: appnewColors.bg5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: Icon(Icons.error_outlined,
                      color: appnewColors.text25, size: 14.w),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    '为了您的资金能快速到账，请确保填写的姓名与手机号实名及银行卡的开户名一致'.tr,
                    style: TextStyle(
                        color: appnewColors.text28,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  Column(
                    children: [
                      _buildTitle("real_name".tr, required: true),
                      SizedBox(height: 7.h),
                      SizedBox(
                        height: 40.h,
                        child: CommonTextfield(
                          controller: controller.inputNameController,
                          focusNode: controller.inputNameFocusNode,
                          fillColor: appnewColors.bg5,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12.w),
                          hintText: '请输入真实姓名'.tr,
                          isObscure: false,
                          cornerRadius: 8.r,
                          style: TextStyle(
                            color: appnewColors.text1,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          hintStyle: TextStyle(
                            color: appnewColors.textFourth,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          inputFormatters: [
                            BankCardRealNameInputFormatter(),
                          ],
                        ),
                      )
                    ],
                  ),
                  buildBottomSheetInputPhoneWrapper(),
                  buildBottomSheetInputCodeWrapper(),
                  Spacer(),
                  Obx(() {
                    return CommonActionButton.confirm(
                      controller.checkBindConfirmEnable(),
                      content: '完成绑定',
                      borderRadius: BorderRadius.circular(8.r),
                      onPressed: () async {
                        var isSuccess = await controller.accountBindStep3();
                        if (isSuccess) {
                          controller.addBank();
                        }
                      },
                    );
                  }),
                  SizedBox(height: 10.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: '如需帮助？',
                        style: TextStyle(
                          color: appnewColors.text2,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          const TextSpan(
                            text: ' 请 ',
                          ),
                          TextSpan(
                              text: '联系客服',
                              style: TextStyle(
                                color: appnewColors.text7,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  AppNavigator.gotoseveiceForMain();
                                }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 42.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String text, {bool required = false}) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 14.sp,
                color: appnewColors.text1,
                fontWeight: FontWeight.w600),
          ),
          Text(
            required ? "必填".tr : "非必填".tr,
            style: TextStyle(
                fontSize: 14.sp,
                color: required ? appnewColors.text25 : appnewColors.textFourth,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget buildBottomSheetUserInfoContentWrapper({
    required String title,
    required String content,
    Color? bgColor,
    bool isShowTitle = true,
    bool isShowArrowDown = true,
    EdgeInsetsGeometry? titlePadding,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle) _buildTitle(title, required: false),
        Container(
          width: double.infinity,
          height: 40.h,
          margin: EdgeInsets.only(top: 7.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
              color: bgColor ?? appnewColors.bg2,
              borderRadius: BorderRadius.circular(8.r)),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      content,
                      style: TextStyle(
                          color: appnewColors.text19,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  if (isShowArrowDown)
                    Icon(Icons.keyboard_arrow_down,
                        color: appnewColors.bg11, size: 14.w),
                ],
              )),
        ),
      ],
    );
  }

  Widget buildBottomSheetInputCodeWrapper() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildTitle("手机验证码".tr, required: true),
      Container(
        width: double.infinity,
        height: 40.h,
        margin: EdgeInsets.only(top: 10.h),
        child: IgnoreContentContainerBackgroundWidget(
          child: CommonTextfield(
            fillColor: appnewColors.bg5,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
            isError: false,
            controller: controller.inputSmsCodeController,
            focusNode: controller.inputSmsCodeFocusNode,
            hintText: '请输入验证码'.tr,
            isObscure: false,
            maxLength: 50,
            cornerRadius: 8.r,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // 只能输入数字
            ],
            style: TextStyle(
              color: appnewColors.text1,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            hintStyle: TextStyle(
              color: appnewColors.textFourth,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            suffix: Obx(() => CountDownTimer(
                  content: 'get_code'.tr,
                  countdownSeconds: controller.countdownSeconds.value,
                  callback: () async {
                    controller.getSendBindCode();
                  },
                )),
          ),
        ),
      ),
    ]);
  }

  /// 根据区号返回手机号最大长度：+86 为 11 位，+852 为 8 位
  int _phoneMaxLengthForAreaCode(String areaCode) {
    return areaCode == '+852' ? 8 : 11;
  }

  Widget buildBottomSheetInputPhoneWrapper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle("手机号码".tr, required: true),
        Container(
          key: controller.phoneContainerKey,
          width: double.infinity,
          height: 40.h,
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
              color: appnewColors.bg5,
              borderRadius: BorderRadius.circular(8.r)),
          child: Row(
            children: [
              AreaCodeSelector(
                areaCodeLabel: Obx(() {
                  return Text(
                    controller.selAreaCodeText.value,
                    style: TextStyle(
                      color: appnewColors.text1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }),
                onTap: _showAreaCodeDialogBelowPhone,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Obx(() {
                  final maxLen = _phoneMaxLengthForAreaCode(
                      controller.selAreaCodeText.value);
                  return TextField(
                    controller: controller.inputPhoneController,
                    focusNode: controller.inputPhoneFocusNode,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "请输入手机号",
                      hintStyle: TextStyle(
                        color: appnewColors.textFourth,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                      color: appnewColors.text1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(maxLen),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAreaCodeDialogBelowPhone() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = controller.phoneContainerKey.currentContext;
      final box = context?.findRenderObject() as RenderBox?;
      double? left, top, width;
      if (box != null && box.hasSize) {
        final offset = box.localToGlobal(Offset.zero);
        left = offset.dx;
        top = offset.dy + 4.h;
        width = box.size.width;
      }

      DialogAreaCode.show(
        onSelect: (model) {
          final code = model.code ?? '';
          controller.selAreaCodeText.value = code;
          final maxLen = code == '+852' ? 8 : 11;
          final text = controller.inputPhoneController.text;
          if (text.length > maxLen) {
            controller.inputPhoneController.text = text.substring(0, maxLen);
          }
        },
        areaCode: controller.selAreaCodeText.value,
        left: left,
        top: top,
        width: width,
      );
    });
  }
}
