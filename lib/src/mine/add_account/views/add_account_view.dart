import 'package:filbet/common/encrypto_protocal.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/resp_widthdraw_method.dart';
import 'package:filbet/src/security/widgets/bottom_safe_verify.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/bank_card_real_name.dart';
import 'package:filbet/widgets/area_code_selector.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/contact_service_view.dart';
import 'package:filbet/widgets/content_shadow_wrapper.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/dialog/dialog_area_code.dart';
import 'package:filbet/widgets/picture_selestor.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:filbet/widgets/sk_common_text_field.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:filbet/widgets/wallet_component_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/add_account_controller.dart';

class AddAccountView extends GetView<AddAccountController> {
  const AddAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      num paymentType = controller.selectedMethod.value?.paymentType ?? 1;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar.normalTitle(
          bgColor: Colors.white,
          title: controller.getWalletString(),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                aliasView(),
                buildSelAddress(context),
                if (paymentType != BlockChain.alipay.code &&
                    paymentType != BlockChain.weChat_pay.code)
                  inputUSDTAddress(),
                if (paymentType == BlockChain.alipay.code ||
                    paymentType == BlockChain.weChat_pay.code)
                  accountView(),
                if (paymentType == BlockChain.alipay.code ||
                    paymentType == BlockChain.weChat_pay.code)
                  nameView(),
                if (paymentType == BlockChain.alipay.code ||
                    paymentType == BlockChain.weChat_pay.code)
                  _alipayQRCode(context),
                phoneView(),
                // phoneTipsView(),
                verifyCodeView(),
                // payPwdView(),
                confirmView(),
                serverView(),
                SizedBox(height: 60.r),
              ],
            ),
            // Obx(() {
            //   return;
            // }),
          ),
        ),
      );
    });
  }

  Widget _alipayQRCode(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '收款二维码',
          style: TextStyle(
            fontSize: 16.sp,
            color: appnewColors.text22,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        PictureSelector(
          controller: controller.pictureController,
          placeholderBuilder: () {
            return Center(
              child:
                  Image.asset(Assets.mineIconQrCode, height: 86, width: 86.w),
            );
          },
          maxCount: 1,
          columnCount: 1,
          multiple: false,
          uiStyle: true,
          onChanged: () {
            controller.updateImageCount();
          },
        ),
        SizedBox(height: 6.h),
        Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                  color: appnewColors.tip1,
                  fontSize: 12..sp,
                  fontFamily: "PingFang SC",
                  fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                  text: '*'.tr,
                ),
                TextSpan(
                  text: '文件格式为PNG, JPG, JPEG,且大小不超过5MB',
                  style: TextStyle(
                      color: appnewColors.text5,
                      fontSize: 12.sp,
                      fontFamily: "PingFang SC",
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget aliasView() {
    return buildTitleAndInputView(
      'alias'.tr,
      '至少2位英文或数字，便于区分不同地址'.tr,
      controller.aliasController,
      isError: controller.isAliasError.value,
      errorText: controller.aliasErrorText.value,
      inputFormatters: [],
    );
  }

  Widget nameView() {
    return Column(
      children: [
        buildTitleAndInputView(
          'arrive_name'.tr,
          'arrive_name_hint'.tr,
          controller.nameController,
          // enable: controller.realName.isEmpty,
          isError: controller.isNameError.value,
          errorText: controller.nameErrorText.value,
          inputFormatters: [
            BankCardRealNameInputFormatter(),
          ],
        ),
        Row(
          children: [
            Icon(Icons.error_outlined, color: appnewColors.text25, size: 12.w),
            SizedBox(width: 7.w),
            Text(
              "账户与收款人需一致且准确，填写错误 损失自负",
              style: TextStyle(
                fontSize: 12.sp,
                color: appnewColors.text28,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget accountView() {
    return buildTitleAndInputView(
      controller.selectedMethod.value?.paymentType == BlockChain.alipay.code
          ? 'alipay_account'.tr
          : "微信账号",
      controller.selectedMethod.value?.paymentType == BlockChain.alipay.code
          ? '请输入支付宝账户'.tr
          : '请输入微信账户',
      controller.accountController,
      isError: controller.isAccountError.value,
      errorText: controller.accountErrorText.value,
    );
  }

  Widget phoneView() {
    return buildTitleAndInputView(
      key: controller.phoneContainerKey,
      'phone_num'.tr,
      'phone_num_hint'.tr,
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
    );
  }

  Widget phoneTipsView() {
    return Container(
      margin: EdgeInsets.only(top: 10.r),
      child: Text(
        'phone_tips'.tr,
        style: TextStyle(
          color: appnewColors.text3,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget verifyCodeView() {
    return buildTitleAndInputView(
      '手机验证码'.tr,
      '请输入手机验证码'.tr,
      controller.verifyController,
      isError: controller.isVerifyError.value,
      errorText: controller.verifyErrorText.value,
      suffix: Obx(
        () => CountDownTimer(
          content: 'get_code'.tr,
          countdownSeconds: controller.countdownSeconds.value,
          callback: () {
            controller.countdownSeconds.value = 0;
            getSendBindCode();
          },
        ),
      ),
    );
  }

  // Widget payPwdView() {
  //   return buildTitleAndInputView(
  //     'pay_pwd'.tr,
  //     'input_pay_pwd'.tr,
  //     controller.payPwdController,
  //     isObscure: true,
  //     isError: controller.isPayPwdError.value,
  //     errorText: controller.payPwdErrorText.value,
  //   );
  // }

  Widget serverView() {
    return Container(
      margin: EdgeInsets.only(top: 10.r),
      child: const ContactServiceView(),
    );
  }

  Widget confirmView() {
    return Container(
      margin: EdgeInsets.only(top: 15.r),
      child: CommonActionButton.confirm(
        borderRadius: BorderRadius.circular(8.r),
        true,
        onPressed: () {
          controller.validateAndSubmit();
        },
      ),
    );
  }

  Widget buildTitleAndInputView(
      String title, String hitText, TextEditingController textController,
      {Widget? prefix,
      Widget? suffix,
      bool isError = false,
      bool isObscure = false,
      List<TextInputFormatter>? inputFormatters,
      String? errorText,
      EdgeInsetsGeometry? contentPadding,
      Key? key,
      bool? enable}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: appnewColors.text22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            key: key,
            width: double.infinity,
            margin: EdgeInsets.only(top: 10.r),
            child: SkCommonTextField(
              controller: textController,
              fillColor:
                  isError ? appnewColors.tip1.withAlpha(10) : appnewColors.bg5,
              contentPadding: contentPadding ??
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
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getSendBindCode() async {
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
              var isSuccess = await controller.accountBindStep1(value);
              if (isSuccess) {
                controller.accountBindStep2(controller.sid.value);
              }
            },
          ),
        ),
        isScrollControlled: true,
      );
    } else {
      if (controller.phoneController.text.isEmpty) {
        AppUtils.showToast('${'input_hint'.tr}${'phone_num'.tr}');
        return;
      }
      var isSuccess = await controller
          .accountBindStep1(controller.phoneController.text.trim());
      if (isSuccess) {
        controller.accountBindStep2(controller.sid.value);
      }
    }
  }

  Widget buildSelAddress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '选择方式',
          style: TextStyle(
            fontFamily: 'PingFang SC',
            fontSize: 16.sp,
            color: appnewColors.text22,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Obx(() {
          return MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            removeTop: true,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.r,
                mainAxisSpacing: 10.r,
                childAspectRatio: 108 / 40, // 宽高比 (宽 / 高)
              ),
              itemCount: controller.methodList.length,
              itemBuilder: (context, index) {
                return _itemSelAddress(controller.methodList[index], index);
              },
            ),
          );
        }),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _itemSelAddress(MethodModel model, int index) {
    final selectedMethod = controller.selectedMethod.value;
    final isSelected = selectedMethod != null && selectedMethod == model;
    return InkWell(
      onTap: () {
        controller.selectedMethod.value = model;
        controller.accountController.clear();
        controller.isAccountError.value = false;
        controller.accountErrorText.value = '';
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
                model.name ?? '',
                style: TextStyle(
                  color: isSelected ? appnewColors.text1 : appnewColors.text2,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              Positioned(
                right: 0,
                bottom: 0,
                child: Image.asset(
                  Assets.mineIconSelectAddress,
                  width: 19.w,
                  height: 19.w,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget inputUSDTAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${controller.selectedMethod.value?.name ?? ''}地址',
          style: TextStyle(
            fontFamily: 'PingFang SC',
            color: appnewColors.text1,
            fontWeight: FontWeight.w500,
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
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
                // 最大长度
              ],
              hintStyle: TextStyle(
                color: appnewColors.text8,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              controller: controller.usdtAddressController,
              fillColor: controller.isAddressError.value
                  ? appnewColors.tip1.withAlpha(10)
                  : appnewColors.bg5,
              isError: controller.isAddressError.value,
            ),
          ),
        ),
        if (controller.isAddressError.value)
          Text(
            '请输入地址',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
              color: appnewColors.tip1,
            ),
          ),
        SizedBox(height: 10.h),
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
        onSelect: (model) =>
            controller.selAreaCodeText.value = model.code ?? '',
        areaCode: controller.selAreaCodeText.value,
        left: left,
        top: top,
        width: width,
      );
    });
  }
}
