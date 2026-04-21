import 'package:filbet/common/encrypto_protocal.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/security/widgets/bottom_area_code.dart';
import 'package:filbet/src/security/widgets/bottom_safe_verify.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/area_code_selector.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/common_textfield.dart';
import 'package:filbet/widgets/contact_service_view.dart';
import 'package:filbet/widgets/content_shadow_wrapper.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/dialog/dialog_area_code.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:filbet/widgets/sk_common_text_field.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:filbet/widgets/wallet_component_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/add_usdt_controller.dart';

class AddUsdtView extends GetView<AddUsdtController> {
  const AddUsdtView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar.normalTitle(
        bgColor: Colors.white,
        title: '添加虚拟币地址'.tr,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                _buildWalletName(),
                SizedBox(height: 15.h),
                _buildSelAddress(),
                SizedBox(height: 15.h),
                _buildWalletAddress(),
                SizedBox(height: 15.h),
                phoneView(),
                verifyCodeView(),
                // _buildPaymentPassword(),
                confirmView(),
                serverView(),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSelAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '选择地址'.tr,
          style: TextStyle(
            fontFamily: 'PingFang SC',
            color: appnewColors.text1,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 40.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _itemSelAddress(
                  controller.encryptoProtocalList[index], index);
            },
            itemCount: controller.encryptoProtocalList.length,
          ),
        ),
      ],
    );
  }

  Widget _itemSelAddress(BlockChain chain, int index) {
    final selectedProtocol = controller.selectedProtocol.value;
    var protocol = controller.encryptoProtocalList[index];
    final isSelected = selectedProtocol != null && selectedProtocol == protocol;
    return InkWell(
      onTap: () {
        controller.selectedProtocol.value = protocol;
      },
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: appnewColors.bg5,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? appnewColors.bg : appnewColors.bg4, // ✅ 边框切换
            width: 1,
          ),
        ),
        height: 40.h,
        width: 108.w,
        child: Stack(
          children: [
            Center(
              child: Text(
                protocol.name,
                style: TextStyle(
                  color: isSelected ? appnewColors.text1 : appnewColors.text2,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // if (isSelected)
            //   Positioned(
            //     right: 0,
            //     bottom: 0,
            //     child: ClipRRect(
            //       clipBehavior: Clip.antiAlias,
            //       borderRadius: BorderRadius.only(
            //         bottomRight: Radius.circular(6.r),
            //       ),
            //       child: Image.asset(
            //         Assets.mineIconUsdtCheck,
            //         width: 15.w,
            //         height: 11.h,
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletName() {
    var tempName = controller.name.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'alias'.tr,
          style: TextStyle(
            fontFamily: 'PingFang SC',
            color: appnewColors.text1,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        IgnoreContentContainerBackgroundWidget(
          child: SizedBox(
            height: 40.h,
            child: CommonTextfield(
              controller: controller.accountNameController,
              hintText: '至少2位英文或数字，便于区分不同地址'.tr,
              fillColor: appnewColors.bg14,
              cornerRadius: 8.r,
              maxLength: 12,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              style: TextStyle(
                color: appnewColors.text1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              hintStyle: TextStyle(
                color: appnewColors.text8,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWalletAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'USDT地址'.tr,
          style: TextStyle(
            fontFamily: 'PingFang SC',
            color: appnewColors.text1,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 10.h),
        IgnoreContentContainerBackgroundWidget(
          child: SizedBox(
            height: 40.h,
            child: WaleltUSDTAddressTextField(
              borderRadius: BorderRadius.circular(8.r),
              showIcon: true,
              suffixIcon: Text(""),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              inputFormatters: [
                LengthLimitingTextInputFormatter(controller.getInputLength()),
                // 最大长度
              ],
              hintStyle: TextStyle(
                color: appnewColors.text8,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              controller: controller.usdtAddressController,
              fillColor: controller.isAddressInputError
                  ? appnewColors.tip1.withAlpha(10)
                  : appnewColors.bg5,
              isError: controller.isAddressInputError,
              hintText: "请输入USDT地址",
            ),
          ),
        ),
        if (controller.isAddressInputError)
          Text(
            '地址格式错误'.tr.replaceAll('{{a}}', controller.getWalletName()),
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
              color: appnewColors.tip1,
            ),
          )
      ],
    );
  }

  // Widget _buildPaymentPassword() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'pay_pwd'.tr,
  //         style: TextStyle(
  //           color: appnewColors.text1,
  //           fontWeight: FontWeight.w500,
  //           fontSize: 14.sp,
  //           fontFamily: 'PingFang SC',
  //         ),
  //       ),
  //       SizedBox(height: 10.h),
  //       IgnoreContentContainerBackgroundWidget(
  //         child: SizedBox(
  //           height: 40.h,
  //           child: WalletPasswordTextField(
  //             controller: controller.payPwdController,
  //             hintText: 'input_pay_pwd'.tr,
  //             maxLength: 6,
  //             keyboardType: TextInputType.number,
  //             fillColor: appnewColors.bg5,
  //             borderRadius: BorderRadius.circular(8.r),
  //             contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
  //             style: TextStyle(
  //               color: appnewColors.text1,
  //               fontSize: 14.sp,
  //             ),
  //             hintStyle: TextStyle(
  //               color: appnewColors.text8,
  //               fontSize: 14.sp,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget serverView() {
    return Container(
      margin: EdgeInsets.only(top: 10.r),
      child: ContactServiceView(),
    );
  }

  Widget confirmView() {
    return Container(
      margin: EdgeInsets.only(top: 15.r),
      child: CommonActionButton.confirm(
        content: "提交".tr,
        borderRadius: BorderRadius.circular(8.r),
        controller.inSubmit,
        onPressed: () {
          controller.validateAndSubmit();
        },
      ),
    );
  }

  /// 根据区号返回手机号最大长度：+86 为 11 位，+852 为 8 位
  int _phoneMaxLengthForAreaCode(String? areaCode) {
    return (areaCode ?? '+86') == '+852' ? 8 : 11;
  }

  Widget phoneView() {
    return Obx(() {
      final maxLen =
          _phoneMaxLengthForAreaCode(controller.selAreaCodeText.value);
      return buildTitleAndInputView(
          key: controller.phoneContainerKey,
          '手机号码'.tr,
          controller.usdtNeedPhone.value == 1 ? "可选填" : '请输入手机号码'.tr,
          controller.phoneController,
          isError: controller.isPhoneError.value,
          errorText: controller.phoneErrorText.value,
          enable: controller.phoneNumber.value.isEmpty,
          prefix: AreaCodeSelector(
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
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(maxLen),
          ]);
    });
  }

  Widget verifyCodeView() {
    return buildTitleAndInputView(
        '手机验证码'.tr,
        controller.usdtNeedPhone.value == 1 ? "可选填" : '请输入手机验证码'.tr,
        controller.verifyController,
        isError: controller.isVerifyError.value,
        errorText: controller.verifyErrorText.value,
        suffix: CountDownTimer(
            content: 'get_code'.tr,
            countdownSeconds: controller.countdownSeconds.value,
            callback: () async {
              if (controller.phoneNumber.value.isNotEmpty) {
                Get.bottomSheet(
                  SKBottomSheet(
                    top: 24.h,
                    left: 16.w,
                    title: 'safe_verify'.tr,
                    content: BottomSafeVerify(
                      phoneNum: controller.phoneNumber.value,
                      onConfirm: (value) async {
                        if (Get.isBottomSheetOpen ?? false) {
                          Get.back();
                        }
                        var isSuccess = await controller.postPhoneVerify(value);
                        if (isSuccess) {
                          controller.countdownSeconds.value = 0;
                          controller.accountBindStep2(controller.sid.value);
                        }
                      },
                    ),
                  ),
                  isScrollControlled: true,
                );
              } else {
                var inputPhone = controller.phoneController.text.trim();
                if (controller.phoneController.text.trim().isEmpty) {
                  AppUtils.showToast('${'input_hint'.tr}${'phone_num'.tr}');
                  return;
                }

                var isSuccess = await controller.postPhoneVerify(inputPhone);
                if (isSuccess) {
                  controller.countdownSeconds.value = 0;
                  controller.accountBindStep2(controller.sid.value);
                }
              }
            }),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // 只允许数字
        ]);
  }

  Widget buildTitleAndInputView(
      String title, String hitText, TextEditingController textController,
      {Widget? prefix,
      Widget? suffix,
      bool isError = false,
      bool isObscure = false,
      List<TextInputFormatter>? inputFormatters,
      String? errorText,
      Key? key,
      bool? enable}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: appnewColors.text1,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          key: key,
          width: double.infinity,
          margin: EdgeInsets.only(top: 8.r),
          child: SkCommonTextField(
            controller: textController,
            fillColor: appnewColors.bg14,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.r),
            isError: isError,
            hintText: hitText,
            isObscure: isObscure,
            maxLength: 50,
            enable: enable,
            inputFormatters: inputFormatters,
            errorText: errorText,
            hintStyle: TextStyle(
              color: appnewColors.text21,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            style: TextStyle(
              color: appnewColors.text1,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            prefix: prefix,
            suffix: suffix,
            keyboardType: TextInputType.number,
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
          final maxLen = (code == '+852') ? 8 : 11;
          final text = controller.phoneController.text;
          if (text.length > maxLen) {
            controller.phoneController.text = text.substring(0, maxLen);
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
