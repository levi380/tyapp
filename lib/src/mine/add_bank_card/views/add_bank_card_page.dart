import 'package:filbet/src/mine/add_bank_card/controllers/add_bank_card_page_controller.dart';
import 'package:filbet/src/security/widgets/bottom_bank_card_list.dart';
import 'package:filbet/src/security/widgets/bottom_bank_tip.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/bank_card_real_name.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/common_textfield.dart';
import 'package:filbet/widgets/contact_service_view.dart';
import 'package:filbet/widgets/content_shadow_wrapper.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/area_code_selector.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class AddBankCardPage extends GetView<AddBankCardPageController> {
  const AddBankCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar.normalTitle(
        bgColor: Colors.white,
        title: 'add_bank_card'.tr,
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.realName.isNotEmpty)
                    buildBottomSheetUserInfoContentWrapper(
                      title: "real_name".tr,
                      content: controller.realName,
                      isShowArrowDown: false,
                      titlePadding: EdgeInsets.only(top: 16.h),
                    ),
                  if (controller.realName.isEmpty)
                    Column(
                      children: [
                        Container(
                          width: Get.width,
                          padding: EdgeInsets.only(top: 16.h),
                          child: Text(
                            "real_name".tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: appnewColors.text1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
                            maxLength: 60,
                            cornerRadius: 8.r,
                            style: TextStyle(
                              color: appnewColors.text21,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            hintStyle: TextStyle(
                              color: appnewColors.textFourth,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            inputFormatters: [
                              BankCardRealNameInputFormatter(),
                            ],
                          ),
                        )
                      ],
                    ),
                  SizedBox(height: 14.h),
                  Text(
                    "为了您的资金能够迅速到账，请确保填写的姓名与手机号实名及银行卡的开户名一致".tr,
                    style: TextStyle(
                        color: appnewColors.text28,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Obx(() {
                    if (controller.phoneNumber.value.isEmpty) {
                      return buildBottomSheetInputPhoneWrapper();
                    } else {
                      return buildBottomSheetUserInfoContentWrapper(
                        title: "手机号码".tr,
                        content: controller.phoneNumber.value,
                        isShowArrowDown: false,
                        isAreaCode: true,
                        titlePadding: EdgeInsets.only(top: 14.h),
                      );
                    }
                  }),
                  buildBottomSheetInputCodeWrapper(),
                  buildBottomSheetInputBankNumberContentWrapper(),
                  Obx(() {
                    return InkWell(
                      child: buildBottomSheetUserInfoContentWrapper(
                          title: "开户银行".tr,
                          content: controller.selBankCard.value?.name == null
                              ? "请选择银行"
                              : controller.selBankCard.value?.name ?? "",
                          bgColor: appnewColors.bg5),
                      onTap: () {
                        controller.onDispose();
                        Get.bottomSheet(
                          SKBottomSheet(
                            top: 24.h,
                            left: 16.w,
                            title: '开户银行'.tr,
                            content: BottomBankCardList(
                                bankList: controller.bankList,
                                onSelect: (value) {
                                  if (value.riskState == 1) {
                                    Get.bottomSheet(
                                      SKBottomSheet(
                                        top: 24.h,
                                        left: 16.w,
                                        title: 'tips'.tr,
                                        content: BottomBankTip(onSelect: (a) {
                                          if (!a) {
                                            Get.back();
                                            controller.selBankCard.value =
                                                value;
                                            controller.getCheckBankCardInfo();
                                          }
                                        }),
                                      ),
                                      isScrollControlled: true,
                                    );
                                  } else {
                                    Get.back();
                                    controller.selBankCard.value = value;
                                    controller.getCheckBankCardInfo();
                                  }
                                }),
                          ),
                          isScrollControlled: true,
                        );
                      },
                    );
                  }),
                  Obx(() {
                    return InkWell(
                        child: buildBottomSheetUserInfoContentWrapper(
                            title: "开户行地址".tr,
                            content: controller.selAddressText.value.isEmpty
                                ? "请选择开户行地址".tr
                                : controller.selAddressText.value ?? "",
                            bgColor: appnewColors.bg5,
                            isShowTitle: true),
                        onTap: () {
                          controller.showCityPicker(context);
                        });
                  }),
                  SizedBox(height: 6.h),
                  // Container(
                  //   width: Get.width,
                  //   padding: EdgeInsets.only(top: 14.h),
                  //   child: Text(
                  //     "pay_pwd".tr,
                  //     style: TextStyle(
                  //       fontSize: 14.sp,
                  //       color: appnewColors.text19,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 10.h),
                  // SizedBox(
                  //   height: 40.h,
                  //   child: CommonTextfield(
                  //     controller: controller.paymentPasswordController,
                  //     focusNode: controller.paymentPasswordFocusNode,
                  //     fillColor: appnewColors.bg4,
                  //     contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                  //     hintText: 'input_pay_pwd'.tr,
                  //     isObscure: true,
                  //     cornerRadius: 8.r,
                  //     maxLength: 6,
                  //     keyboardType: TextInputType.number,
                  //     style: TextStyle(
                  //       color: appnewColors.text21,
                  //       fontSize: 14.sp,
                  //       fontWeight: FontWeight.w400,
                  //     ),
                  //     hintStyle: TextStyle(
                  //       color: appnewColors.text21,
                  //       fontSize: 14.sp,
                  //       fontWeight: FontWeight.w400,
                  //     ),
                  //     inputFormatters: [
                  //       FilteringTextInputFormatter.digitsOnly,
                  //     ],
                  //   ),
                  // ),
                  // if (!controller.isOriginalPaymentPasswordValid)
                  //   Text(
                  //     'char_6_digit'.tr,
                  //     style: TextStyle(
                  //       color: appColors.textRedErrorColor,
                  //       fontSize: 12.sp,
                  //     ),
                  //   ),
                  // SizedBox(height: 10.h),
                  Text(
                    "请认真校准开户行及开户行地址,如有错误,请手动修改".tr,
                    style: TextStyle(
                        color: appnewColors.textFourth,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20.h),

                  Text(
                    "注意：手机号与银行卡的归属人姓名必须与真实姓名一致，否则会影响到您的存提款".tr,
                    style: TextStyle(
                        color: appnewColors.text25,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 12.h),
                  Obx(() {
                    final canSubmit = controller.checkBankCardInfo.value &&
                        !controller.isSubmitting.value;
                    return CommonActionButton.confirm(
                      canSubmit,
                      content: "submit".tr,
                      borderRadius: BorderRadius.circular(8.r),
                      onPressed: () {
                        controller.addBank();
                      },
                    );
                  }),
                  SizedBox(height: 10.h),
                  const ContactServiceView(),
                  SizedBox(height: 42.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomSheetUserInfoContentWrapper({
    required String title,
    required String content,
    Color? bgColor,
    bool isShowTitle = true,
    bool isShowArrowDown = true,
    bool isAreaCode = false,
    EdgeInsetsGeometry? titlePadding,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle)
          Padding(
            padding: titlePadding ?? EdgeInsets.only(top: 16.h),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: appnewColors.text1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        Container(
          width: double.infinity,
          height: 40.h,
          margin: EdgeInsets.only(top: 7.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
              color: bgColor ?? appnewColors.bg5,
              borderRadius: BorderRadius.circular(8.r)),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  if (isAreaCode)
                    Text(
                      controller.selAreaCodeText.value ?? "+86",
                      style: TextStyle(
                          color: appnewColors.text1,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  if (isAreaCode) SizedBox(width: 6.w),
                  if (isAreaCode)
                    Align(
                      child: Icon(Icons.keyboard_arrow_down,
                          color: appnewColors.text1, size: 14.w),
                    ),
                  Expanded(
                    child: Text(
                      content,
                      style: TextStyle(
                          color: appnewColors.textFourth,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  if (isShowArrowDown)
                    Icon(Icons.arrow_forward_ios_outlined,
                        color: appnewColors.bg24, size: 14.w),
                ],
              )),
        ),
      ],
    );
  }

  Widget buildBottomSheetInputBankNumberContentWrapper() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Text(
              "银行卡号".tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: appnewColors.text1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 40.h,
            margin: EdgeInsets.only(top: 7.h),
            child: IgnoreContentContainerBackgroundWidget(
              child: CommonTextfield(
                controller: controller.addBankCardController,
                focusNode: controller.addBankCardFocusNode,
                fillColor: appnewColors.bg5,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                isError: controller.isAddBankCardInputError,
                hintText: '请输入银行卡号'.tr,
                isObscure: false,
                maxLength: 20,
                cornerRadius: 8.r,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // 只能输入数字
                ],
                style: TextStyle(
                  color: appnewColors.text21,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: TextStyle(
                  color: appnewColors.textFourth,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          if (controller
              .isAddBankCardInputError) //bankCardNumberStringValidate()
            Container(
              padding: EdgeInsets.only(top: 6.h),
              // height: 40.h,
              child: Text(
                controller.addBankCardText.value.length <= 13
                    ? '银行卡号长度不正确请重新输入'.tr
                    : "含非法字符,银行卡号只能输入数字".tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                  color: appnewColors.tip1,
                ),
              ),
            )
        ],
      );
    });
  }

  Widget buildBottomSheetInputCodeWrapper() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: Text(
          '手机验证码'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            color: appnewColors.text1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: 40.h,
        margin: EdgeInsets.only(top: 7.h),
        child: IgnoreContentContainerBackgroundWidget(
          child: CommonTextfield(
            fillColor: appnewColors.bg5,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
            isError: false,
            controller: controller.inputSmsCodeController,
            focusNode: controller.inputSmsCodeFocusNode,
            hintText: '请输入手机验证码'.tr,
            isObscure: false,
            maxLength: 50,
            cornerRadius: 8.r,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // 只能输入数字
            ],
            style: TextStyle(
              color: appnewColors.text21,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            suffix: Obx(() => CountDownTimer(
                  content: 'get_code'.tr,
                  countdownSeconds: controller.countdownSeconds.value,
                  callback: () {
                    controller.getSendBindCode();
                  },
                )),
            hintStyle: TextStyle(
              color: appnewColors.textFourth,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ]);
  }

  Widget buildBottomSheetInputPhoneWrapper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: Text(
            "手机号码".tr,
            style: TextStyle(
              fontSize: 14.sp,
              color: appnewColors.text1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          key: controller.phoneContainerKey,
          width: double.infinity,
          height: 40.h,
          margin: EdgeInsets.only(top: 7.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: appnewColors.bg5,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              AreaCodeSelector(
                areaCodeLabel: Obx(() {
                  return Text(
                    controller.selAreaCodeText.value ?? "+86",
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
                child: TextField(
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
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAreaCodeDialogBelowPhone() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final context = controller.phoneContainerKey.currentContext;
    //   final box = context?.findRenderObject() as RenderBox?;
    //   double? left, top, width;
    //   if (box != null && box.hasSize) {
    //     final offset = box.localToGlobal(Offset.zero);
    //     left = offset.dx;
    //     top = offset.dy + 4.h;
    //     width = box.size.width;
    //   }
    //
    //   DialogAreaCode.show(
    //     onSelect: (model) =>
    //         controller.selAreaCodeText.value = model.code ?? '',
    //     areaCode: controller.selAreaCodeText.value,
    //     left: left,
    //     top: top,
    //     width: width,
    //   );
    // });
  }
}
