import 'package:filbet/src/security/add_bank_card_controller.dart';
import 'package:filbet/src/security/widgets/bottom_address_area.dart';
import 'package:filbet/src/security/widgets/bottom_address_cities.dart';
import 'package:filbet/src/security/widgets/bottom_address_provinces.dart';
import 'package:filbet/src/security/widgets/bottom_area_code.dart';
import 'package:filbet/src/security/widgets/bottom_bank_card_list.dart';
import 'package:filbet/src/security/widgets/bottom_bank_tip.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/common_textfield.dart';
import 'package:filbet/widgets/content_shadow_wrapper.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddBankCardDialog extends StatefulWidget {
  String realName = "";
  String phone = "";

  AddBankCardDialog({super.key, this.realName = "", this.phone = ""});

  @override
  State<StatefulWidget> createState() {
    return AddBankCardDialogState();
  }
}

class AddBankCardDialogState extends State<AddBankCardDialog> {
  final AddBankCardController _controller = Get.put(AddBankCardController());

  @override
  void initState() {
    super.initState();
    _controller.realName = widget.realName;
    _controller.phone = widget.phone;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.clearInput();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        constraints: BoxConstraints(
          maxHeight: 600.h,
        ),
        margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: Icon(Icons.error_outlined,
                        color: Colors.red, size: 14.w),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      '为了您的资金能快速到账，请确保填写的姓名与手机号实名及银行卡的开户名一致'.tr,
                      style: TextStyle(
                          color: appnewColors.text1,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.only(top: 14.h),
                    child: Text(
                      "wallet_name".tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: appnewColors.text19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 40.h,
                    child: CommonTextfield(
                      controller: _controller.walletNameController,
                      fillColor: appnewColors.bg4,
                      focusNode: _controller.walletNameFocusNode,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                      hintText: 'alias_hint'.tr,
                      isObscure: false,
                      maxLength: 20,
                      cornerRadius: 8.r,
                      style: TextStyle(
                        color: appnewColors.text21,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: appnewColors.text21,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9]')), // 只允许英文字母和数字
                      ],
                    ),
                  )
                ],
              ),
              if (widget.realName.isNotEmpty)
                buildBottomSheetUserInfoContentWrapper(
                  title: "持卡人姓名".tr,
                  content: widget.realName,
                  isShowArrowDown: false,
                  titlePadding: EdgeInsets.only(top: 14.h),
                ),
              if (widget.realName.isEmpty)
                Column(
                  children: [
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.only(top: 14.h),
                      child: Text(
                        "持卡人姓名".tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: appnewColors.text19,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 40.h,
                      child: CommonTextfield(
                        controller: _controller.inputNameController,
                        focusNode: _controller.inputNameFocusNode,
                        fillColor: appnewColors.bg4,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                        hintText: '请输入持卡人姓名'.tr,
                        isObscure: false,
                        maxLength: 20,
                        cornerRadius: 8.r,
                        style: TextStyle(
                          color: appnewColors.text21,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: TextStyle(
                          color: appnewColors.text21,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        inputFormatters: [
                          // ✅ 只允许中文、英文、符号（禁止数字）
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\u4e00-\u9fa5\p{P}\p{S}\s]'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              SizedBox(height: 14.h),
              Text(
                "为了您的资金能够迅速到账，请确保填写的姓名与手机号实名及银行卡的开户名一致".tr,
                style: TextStyle(
                    color: appnewColors.text3,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              if (widget.phone.isNotEmpty)
                buildBottomSheetUserInfoContentWrapper(
                  title: "手机号码".tr,
                  content: widget.phone,
                  isShowArrowDown: false,
                  titlePadding: EdgeInsets.only(top: 14.h),
                ),
              if (widget.phone.isEmpty) buildBottomSheetInputPhoneWrapper(),
              buildBottomSheetInputCodeWrapper(),
              buildBottomSheetInputBankNumberContentWrapper(),
              InkWell(
                child: buildBottomSheetUserInfoContentWrapper(
                    title: "开户银行".tr,
                    content: _controller.selBankCard.value?.name == null
                        ? "请输入开户银行"
                        : _controller.selBankCard.value?.name ?? "",
                    bgColor: appnewColors.bg4),
                onTap: () {
                  _controller.onDispose();
                  Get.bottomSheet(
                    SKBottomSheet(
                      top: 24.h,
                      left: 16.w,
                      title: '选择银行'.tr,
                      content: BottomBankCardList(
                          bankList: _controller.bankList,
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
                                      _controller.selBankCard.value = value;
                                    }
                                  }),
                                ),
                                isScrollControlled: true,
                              );
                            } else {
                              Get.back();
                              _controller.selBankCard.value = value;
                            }
                          }),
                    ),
                    isScrollControlled: true,
                  );
                },
              ),
              InkWell(
                  child: buildBottomSheetUserInfoContentWrapper(
                      title: "开户地址".tr,
                      content: _controller.selAddressProvinces.value?.name ==
                              null
                          ? "请选择省".tr
                          : _controller.selAddressProvinces.value?.name ?? "",
                      bgColor: appnewColors.bg4,
                      isShowTitle: true),
                  onTap: () {
                    _controller.onDispose();
                    Get.bottomSheet(
                      SKBottomSheet(
                        top: 24.h,
                        left: 16.w,
                        title: '请选择省'.tr,
                        content: BottomAddressProvinces(
                            addressProvinces: _controller.addressProvinces,
                            onSelect: (value) {
                              _controller.selAddressProvinces.value = value;
                              _controller.getCities(value.code ?? "");
                              _controller.selAddressCities.value = null;
                              _controller.selAddressAreas.value = null;
                              Get.back();
                            }),
                      ),
                      isScrollControlled: true,
                    );
                  }),
              InkWell(
                child: buildBottomSheetUserInfoContentWrapper(
                    title: "".tr,
                    content: _controller.selAddressCities.value?.name == null
                        ? "请选择市".tr
                        : _controller.selAddressCities.value?.name ?? "",
                    bgColor: appnewColors.bg4,
                    isShowTitle: false),
                onTap: () {
                  _controller.onDispose();
                  Get.bottomSheet(
                    SKBottomSheet(
                      top: 24.h,
                      left: 16.w,
                      title: '请选择市'.tr,
                      content: BottomAddressCities(
                          cities: _controller.addressCities,
                          onSelect: (value) {
                            _controller.getAreas(value.code ?? "");
                            _controller.selAddressCities.value = value;
                            Get.back();
                          }),
                    ),
                    isScrollControlled: true,
                  );
                },
              ),
              InkWell(
                child: buildBottomSheetUserInfoContentWrapper(
                    title: "".tr,
                    content: _controller.selAddressAreas.value?.name == null
                        ? "请选择区".tr
                        : _controller.selAddressAreas.value?.name ?? "",
                    bgColor: appnewColors.bg4,
                    isShowTitle: false),
                onTap: () {
                  _controller.onDispose();
                  Get.bottomSheet(
                    SKBottomSheet(
                      top: 24.h,
                      left: 16.w,
                      title: '请选择区'.tr,
                      content: SelectAreaDialog(
                          list: _controller.addressAreas,
                          onSelect: (value) {
                            _controller.selAddressAreas.value = value;
                            Get.back();
                          }),
                    ),
                    isScrollControlled: true,
                  );
                },
              ),
              SizedBox(height: 10.h),
              Container(
                width: Get.width,
                padding: EdgeInsets.only(top: 14.h),
                child: Text(
                  "pay_pwd".tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: appnewColors.text19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 40.h,
                child: CommonTextfield(
                  controller: _controller.paymentPasswordController,
                  focusNode: _controller.paymentPasswordFocusNode,
                  fillColor: appnewColors.bg4,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                  hintText: 'input_pay_pwd'.tr,
                  isObscure: true,
                  cornerRadius: 8.r,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: appnewColors.text21,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: TextStyle(
                    color: appnewColors.text21,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              if (!_controller.isOriginalPaymentPasswordValid)
                Text(
                  'char_6_digit'.tr,
                  style: TextStyle(
                    color: appColors.textRedErrorColor,
                    fontSize: 12.sp,
                  ),
                ),
              SizedBox(height: 10.h),
              Text(
                " 注意：手机号与银行卡的归属人姓名必须与真实姓名一致，否则会影响到您的存提款".tr,
                style: TextStyle(
                    color: appnewColors.text20,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outlined,
                      color: appnewColors.bg, size: 14.w),
                  const SizedBox(width: 6),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: appnewColors.text1,
                          fontSize: 14.sp,
                          fontFamily: "PingFang SC",
                          fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                          text: '有任何疑问请联系'.tr,
                        ),
                        TextSpan(
                          text: ' ',
                        ),
                        TextSpan(
                          text: 'online_support'.tr,
                          style: TextStyle(
                              color: appnewColors.bg,
                              fontSize: 14.sp,
                              fontFamily: "PingFang SC",
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 23.h),
              CommonActionButton.confirm(
                _controller.checkBankCardInfo,
                onPressed: () {
                  _controller.addBank();
                },
              ),
            ],
          ),
        ),
      );
    });
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
        if (isShowTitle)
          Padding(
            padding: titlePadding ?? EdgeInsets.only(top: 24.h),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: appnewColors.text19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        Container(
          width: double.infinity,
          height: 40.h,
          margin: EdgeInsets.only(top: 10.h),
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

  Widget buildBottomSheetInputBankNumberContentWrapper() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: Text(
              "银行卡号".tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: appnewColors.text19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 40.h,
            margin: EdgeInsets.only(top: 10.h),
            child: IgnoreContentContainerBackgroundWidget(
              child: CommonTextfield(
                controller: _controller.addBankCardController,
                focusNode: _controller.addBankCardFocusNode,
                fillColor: appnewColors.bg4,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                isError: _controller.isAddBankCardInputError,
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
                  color: appnewColors.text21,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          if (_controller
              .isAddBankCardInputError) //bankCardNumberStringValidate()
            Container(
              padding: EdgeInsets.only(top: 6.h),
              // height: 40.h,
              child: Text(
                _controller.addBankCardText.value.length <= 13
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
        padding: EdgeInsets.only(top: 24.h),
        child: Text(
          '验证码'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            color: appnewColors.text19,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: 40.h,
        margin: EdgeInsets.only(top: 10.h),
        child: IgnoreContentContainerBackgroundWidget(
          child: CommonTextfield(
            fillColor: appnewColors.bg4,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
            isError: false,
            controller: _controller.inputSmsCodeController,
            focusNode: _controller.inputSmsCodeFocusNode,
            hintText: '请输入验证码'.tr,
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
                  countdownSeconds: _controller.countdownSeconds.value,
                  callback: () {
                    _controller.getSendBindCode();
                  },
                )),
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
          padding: EdgeInsets.only(top: 24.h),
          child: Text(
            "手机号码".tr,
            style: TextStyle(
              fontSize: 14.sp,
              color: appnewColors.text19,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 40.h,
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
              color: appnewColors.bg4,
              borderRadius: BorderRadius.circular(8.r)),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  _controller.onDispose();
                  Get.bottomSheet(
                    SKBottomSheet(
                      top: 24.h,
                      left: 16.w,
                      title: '选择区号'.tr,
                      content: BottomAreaCode(
                        onSelect: (value) {
                          _controller.selAreaCodeText.value = value.code ?? '';
                          Get.back();
                        },
                      ),
                    ),
                    isScrollControlled: true,
                  );
                },
                child: Align(
                  child: Text(
                    _controller.selAreaCodeText.value ?? "",
                    style: TextStyle(
                        color: appnewColors.text1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Align(
                child: Icon(Icons.keyboard_arrow_down,
                    color: appnewColors.text1, size: 14.w),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextField(
                  controller: _controller.inputPhoneController,
                  focusNode: _controller.inputPhoneFocusNode,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "请输入手机号",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: appnewColors.text21,
                      fontSize: 14.sp,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11), // ✅ 限制长度为11位（可选）
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
