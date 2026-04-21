import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/transactionRecord/transactionRecordDetail/controllers/transaction_record_detail_controller.dart';
import 'package:filbet/widgets/contact_service_view.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:flutter/services.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/themes/app_newcolor.dart';

class TransactionRecordDetailView
    extends GetView<TransactionRecordDetailController> {
  const TransactionRecordDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        title: 'trade_detail'.tr,
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
      margin: EdgeInsets.only(bottom: 10.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10.h,
                bottom: 20.h,
              ),
              child: Text(
                textAlign: TextAlign.center,
                controller.replaceStr(
                    (double.tryParse(controller.item?.amount ?? 0.toString()) ??
                            0)
                        .toStringAsFixed(2)),
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
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          _buildContextInfoItem(
            title: '交易类型'.tr,
            context: controller.tradeDict?.name ?? '',
          ),
          _buildContextInfoItem(
            title: '交易方式'.tr,
            context: controller.item?.subTypeName ?? '',
          ),
          _buildContextInfoItem(
            title: '状态'.tr,
            context: controller.item?.statusName ?? '',
            contentColor: convertColor(controller.item?.status),
          ),
          _buildContextInfoItem(
            title: 'trade_time'.tr,
            context: formatTimestampToTime02(
                controller.item?.createdAt?.toInt() ?? 0),
          ),
          _buildContextInfoItem(
              title: 'trade_order_number'.tr,
              context: controller.item?.id,
              isShowCopy: true),
          cancelView(),
        ],
      ),
    );
  }

  ///文本左右排版信息
  Widget _buildContextInfoItem({
    required String title,
    String? context,
    TextStyle? textStyle,
    Color? contentColor,
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
                color: appnewColors.textMain,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                context ?? '',
                style: textStyle ??
                    TextStyle(
                        color: contentColor ?? appnewColors.text2,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
              ),
              if (isShowCopy)
                SizedBox(
                  width: 6.w,
                ),
              if (isShowCopy)
                InkWell(
                  onTap: () {
                    copyText(context ?? "");
                  },
                  child: Image.asset(
                    Assets.recordBetCopy,
                    width: 12.w,
                    height: 12.w,
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }

  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    AppUtils.showToast("copy_success".tr);
  }

  Color convertColor(num? status) {
    Color textColor = appnewColors.textSecond;
    if (controller.tradeDict?.type == 2) {
      if (status == 2) {
        textColor = appnewColors.text14;
      } else if (status == 3) {
        textColor = appnewColors.textRed;
      }
    } else if (controller.tradeDict?.type == 4) {
      if (status == 2) {
        textColor = appnewColors.text14;
      } else if (status == 3) {
        textColor = appnewColors.textRed;
      }
    } else if (controller.tradeDict?.type == 5) {
      if (status == 1) {
        textColor = appnewColors.text14;
      } else if (status == 2) {
        textColor = appnewColors.textRed;
      }
    } else if (controller.tradeDict?.type == 6) {
      if (status == 6) {
        textColor = appnewColors.text14;
      } else if (status == 5) {
        textColor = appnewColors.textRed;
      }
    } else if (controller.tradeDict?.type == 7) {
      if (status == 6) {
        textColor = appnewColors.text14;
      } else if (status == 5) {
        textColor = appnewColors.textRed;
      }
    } else if (controller.tradeDict?.type == 8) {
      if (status == 2) {
        textColor = appnewColors.text14;
      } else if (status == 3) {
        textColor = appnewColors.textRed;
      }
    }
    return textColor;
  }

  Widget cancelView() {
    if (controller.item?.status == 1 && controller.tradeDict?.type == 2) {
      return Container(
        margin: EdgeInsets.only(top: 20.r),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                controller.showCancelDialog();
              },
              child: Text(
                '申请取消',
                style: TextStyle(
                  color: Color(0xFFFF0000),
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 16.r),
            ContactServiceView(),
          ],
        ),
      );
    }
    return SizedBox();
  }
}
