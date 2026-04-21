import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/deposit/waiting_payment_controller.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/content_shadow_wrapper.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WaitingPaymentView extends GetView<WaitingPaymentController> {
  const WaitingPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appnewColors.bg4,
      appBar: CustomAppbar.normalTitle(
        title: 'waiting_payment'.tr,
        bgColor: Colors.transparent,
        leftBackColor: appnewColors.text6,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 10.w, left: 10.w, bottom: 10.h),
            child: Column(
              children: [
                _buildPaymentInfo(),
                SizedBox(height: 60.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CommonActionButton(
                    content: Text(
                      'payment_done'.tr,
                      style: TextStyle(
                        color: appColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    isActive: true,
                    onPressed: controller.goToAccountChangeRecordDeposit,
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPaymentInfo() {
    final content = Padding(
      padding: EdgeInsets.only(top: 0.h, bottom: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          timeDownView(),
          amountView(),
          orderView(),
          payInfoView(),
          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'important_notice'.tr,
              style: TextStyle(
                color: appnewColors.text1,
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
                height: 1.40,
              ),
            ),
          ),
          _buildRemarkInfo(),
        ],
      ),
    );

    return buildContentShadowWrapper(content: content);
  }

  Widget timeDownView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'remain_pay_time'.tr,
              style: TextStyle(
                color: appnewColors.text1,
                fontSize: 14.sp,
                fontFamily: "PingFang SC",
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              controller.formattedCountDown,
              style: TextStyle(
                color: appnewColors.bg,
                fontFamily: "PingFang SC",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h), // 文字和横线之间的间距
        Container(
          height: 1,
          color: appnewColors.lineColor,
        ),
      ],
    );
  }

  Widget amountView() {
    return Container(
      margin: EdgeInsets.only(top: 20.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            controller.isAlipayOrBank()
                ? Assets.currencyRmb
                : Assets.currencyUsdt,
            height: 24.h,
            width: 24.w,
          ),
          SizedBox(width: 10.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                controller.amount.value.toInt().toString(),
                style: TextStyle(
                  color: appnewColors.text1,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 5.w),
              if (!controller.isAlipayOrBank())
                Text(
                  'USDT',
                  style: TextStyle(
                    color: appnewColors.text1,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget orderView() {
    return Container(
      margin: EdgeInsets.only(top: 16.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'order'.tr,
            style: TextStyle(
              color: appnewColors.text3,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "PingFang SC",
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            controller.depositModel.value.orderId,
            style: TextStyle(
              color: appnewColors.text3,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "PingFang SC",
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: controller.copyOrderId,
            child: Image.asset(
              Assets.imagesCopy,
              height: 14.h,
              width: 14.w,
              color: appnewColors.bg, // 修改图片颜色
            ),
          )
        ],
      ),
    );
  }

  Widget payInfoView() {
    return Obx(() {
      if (controller.depositModel.value.paymentType == 6) {
        return bankInfoView();
      } else if (controller.depositModel.value.paymentType == 7) {
        return alipayInfoView();
      }
      return usdtInfoView();
    });
  }

  Widget usdtInfoView() {
    return Container(
      margin: EdgeInsets.only(top: 16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                // 'protocol'.tr,
                'USDT-',
                style: TextStyle(
                  color: appnewColors.text1,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                controller.protocol.value,
                style: TextStyle(
                  color: appnewColors.text1,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Container(
            decoration: BoxDecoration(
              color: appnewColors.bg4,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(0.r), // 二维码和背景的间距
              child: QrImageView(
                data: controller.depositModel.value.toAddress,
                version: QrVersions.auto,
                size: 120.w,
                gapless: false,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: appnewColors.bg4,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 地址文本
                Expanded(
                  child: Text(
                    controller.depositModel.value.toAddress,
                    style: TextStyle(
                      color: appnewColors.text1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
                SizedBox(width: 2.w),
                // 复制按钮
                GestureDetector(
                  onTap: controller.copyPaymentAddress,
                  child: Image.asset(
                    Assets.imagesCopy,
                    height: 14.h,
                    width: 14.w,
                    color: appnewColors.bg,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bankInfoView() {
    return Container(
      margin: EdgeInsets.only(top: 20.r),
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
      decoration: BoxDecoration(
        color: appnewColors.bg4,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          infoItemView(
              'account_name'.tr, controller.addressInfo.value.accountName ?? '',
              () {
            controller.copyInfo(controller.addressInfo.value.accountName ?? '');
          }),
          infoItemView(
              'bank_no'.tr, controller.addressInfo.value.accountNo ?? '', () {
            controller.copyInfo(controller.addressInfo.value.accountNo ?? '');
          }),
          infoItemView('bank'.tr, controller.addressInfo.value.bankName ?? '',
              () {
            controller.copyInfo(controller.addressInfo.value.bankName ?? '');
          }),
        ],
      ),
    );
  }

  Widget alipayInfoView() {
    return Container(
      margin: EdgeInsets.only(top: 20.r),
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
      decoration: BoxDecoration(
        color: appnewColors.bg4,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          infoItemView(
              'name'.tr, controller.addressInfo.value.accountName ?? '', () {
            controller.copyInfo(controller.addressInfo.value.accountName ?? '');
          }),
          infoItemView(
              'alipay_account'.tr, controller.addressInfo.value.accountNo ?? '',
              () {
            controller.copyInfo(controller.addressInfo.value.accountNo ?? '');
          }),
        ],
      ),
    );
  }

  Widget infoItemView(String title, String content, GestureTapCallback? onTap) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.r),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: appnewColors.text2,
              fontSize: 14.sp,
              fontFamily: "PingFang SC",
            ),
          ),
          Spacer(),
          Text(
            content,
            style: TextStyle(
              color: appnewColors.text1,
              fontSize: 14.sp,
              fontFamily: "PingFang SC",
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onTap,
            child: Image.asset(
              Assets.imagesCopy,
              height: 14.r,
              width: 14.r,
              color: appnewColors.bg, // 修改图片颜色
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRemarkInfo() {
    final content = Container(
      width: double.infinity,
      child: Text(
        'waiting_payment_remark'.tr,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: appColors.textSecond2Color,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

    return buildContentShadowWrapper(content: content);
  }
}
