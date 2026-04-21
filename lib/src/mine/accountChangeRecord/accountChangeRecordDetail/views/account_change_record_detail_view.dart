import 'package:filbet/generated/assets.dart';
import 'package:filbet/mixin/copy_mixin.dart';
import 'package:filbet/src/mine/accountChangeRecord/accountChangeRecordDetail/controllers/account_change_record_detail_controller.dart';
import 'package:filbet/src/mine/accountChangeRecord/account_change_record_model.dart';
import 'package:filbet/src/mine/accountChangeRecord/controllers/account_change_record_controller.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_decoration.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class AccountChangeRecordDetailView
    extends GetView<AccountChangeRecordDetailController> with CopyMixin {
  const AccountChangeRecordDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        title: 'order_detail'.tr,
        bgColor: appnewColors.bg1,
      ),
      body: _buildPageWidget(),
    );
  }

  Widget _buildPageWidget() {
    return Container(
      margin: EdgeInsets.only(left: 22.w, right: 22.w),
      child: SingleChildScrollView(
        child: _buildRecordInfoWidget(),
      ),
    );
  }

  /// 交易详情信息
  Widget _buildRecordInfoWidget() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.h),
              child: Text(
                  textAlign: TextAlign.center,
                  controller.detail.accountChangeType ==
                          AccountChangeType.deposit
                      ? 'deposit'.tr
                      : 'withdraw_amount'.tr,
                  style: TextStyle(
                      color: appnewColors.text1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600)),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h, bottom: 40.h),
              child: Text(
                textAlign: TextAlign.center,
                controller.detail.topAmountWithSymbol,
                style: TextStyle(
                    color: appnewColors.text1,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            _buildRecordInfoItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordInfoItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        children: [
          _buildContextInfoItem(
              title: 'order_num'.tr,
              context: controller.detail.orderId,
              isShowCopy: true),
          _buildContextInfoItem(
              title: controller.detail.accountChangeType ==
                      AccountChangeType.deposit
                  ? 'deposit_time'.tr
                  : 'withdrawal_time'.tr,
              context: controller.detail.createdAtFormatted),
          _buildContextInfoItem(
            title: 'status'.tr,
            context: controller.detail.orderStatus.name,
            textStyle: controller.detail.orderStatus ==
                    AccountChangeOrderStatus.success
                ? TextStyle(
                    color: appnewColors.tip2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500)
                : controller.detail.orderStatus ==
                        AccountChangeOrderStatus.failed
                    ? TextStyle(
                        color: appnewColors.tip1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500)
                    : TextStyle(
                        color: appnewColors.tip3,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
          ),
          if (controller.detail.accountChangeType == AccountChangeType.deposit)
            _buildContextInfoItem(
                title: 'deposit_amount'.tr,
                context: controller.detail.order_amounWithUSDTSymbol),
          if (controller.detail.accountChangeType == AccountChangeType.withdraw)
            _buildContextInfoItem(
                title: 'withdraw_amount'.tr,
                context: controller.detail.topAmountWithSymbol),
          if (controller.detail.accountChangeType ==
                  AccountChangeType.deposit &&
              controller.detail.orderStatus == AccountChangeOrderStatus.success)
            _buildContextInfoItem(
                title: 'actualPaymentAmount'.tr,
                context: controller.detail.topAmountWithSymbol),
                // context: controller.detail.amounWithUSDTSymbol),
          // _buildContextInfoItem(
          //     title: 'fee'.tr, context: controller.detail.fee),
          actualview(),
          if (controller.detail.item.paymentType != 6 &&
              controller.detail.item.paymentType != 7)
            _buildContextInfoItem(
                title: 'exchange_rate'.tr,
                context: controller.detail.rateString),
          _buildContextInfoItem(
              title: 'remark'.tr,
              context: controller.detail.remark.isNotEmpty
                  ? controller.detail.remark
                  : '- - -'),
        ],
      ),
    );
  }

  Widget actualview() {
    String text = 'actual_amt_colon'.tr;
    if (controller.detail.accountChangeType == AccountChangeType.deposit) {
      if (controller.detail.orderStatus == AccountChangeOrderStatus.success) {
        text = 'actual_amt_colon'.tr;
      } else {
        text = "est_receive_amt".tr;
      }
    } else {
      if (controller.detail.orderStatus == AccountChangeOrderStatus.success) {
        text = 'actual_amt_colon'.tr;
      } else {
        text = "est_receive_amt".tr;
      }
    }

    return _buildContextInfoItem(
        title: text, context: controller.detail.amountWithSymbol);
  }

  ///文本左右排版信息
  Widget _buildContextInfoItem({
    required String title,
    String? context,
    TextStyle? textStyle,
    double? bottom,
    bool isShowCopy = false,
  }) {
    return Container(
      padding: EdgeInsets.only(bottom: bottom ?? 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: appnewColors.text1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 12.w),
          isShowCopy
              ? Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          context ?? '',
                          style: textStyle ??
                              TextStyle(
                                  color: appnewColors.text2,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      InkWell(
                        onTap: () {
                          copyText(context ?? "");
                        },
                        child: Image.asset(
                          Assets.mineCopyOrder,
                          width: 14.w,
                          height: 17.w,
                        ),
                      )
                    ],
                  ),
                )
              : Flexible(
                  child: Text(
                    context ?? '',
                    style: textStyle ??
                        TextStyle(
                            color: appnewColors.text2,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                  ),
                ),
        ],
      ),
    );
  }

  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    AppUtils.showToast("copy_success".tr);
  }
}
