import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/welfareCenter/redemption_detail/redemption_detail_controller.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:flutter/services.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/themes/app_newcolor.dart';

class RedemptionDetailView extends GetView<RedemptionDetailController> {
  const RedemptionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        title: '订单详情'.tr,
        bgColor: appnewColors.bg1,
      ),
      body: _buildPageWidget(),
    );
  }

  Widget _buildPageWidget() {
    return Container(
      margin: EdgeInsets.only(left: 25.r, right: 25.r),
      child: _buildRecordInfoWidget(),
    );
  }

  /// 交易详情信息
  Widget _buildRecordInfoWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30.h),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '¥',
                    style: TextStyle(
                        color: appnewColors.textMain,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 3.r,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    controller.model?.prizeAmount ?? '',
                    style: TextStyle(
                        color: appnewColors.textMain,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Text(
                textAlign: TextAlign.center,
                '礼金金额',
                style: TextStyle(
                    color: appnewColors.textMain,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        _buildRecordInfoItem(),
      ],
    );
  }

  Widget _buildRecordInfoItem() {
    var item = controller.model;
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          _buildContextInfoItem(
              title: '订单编号'.tr, context: item?.id, isShowCopy: true),
          _buildContextInfoItem(
            title: '状态'.tr,
            context: controller.convertTypeName(item?.status?.toInt() ?? 0),
          ),
          _buildContextInfoItem(
            title: '申请时间'.tr,
            context: formatDateTimeToString(
              DateTime.fromMillisecondsSinceEpoch(
                  item?.claimedAt?.toInt() ?? 0),
            ),
          ),
          _buildContextInfoItem(
            title: '活动名称'.tr,
            context: item?.activityName,
          ),
          _buildContextInfoItem(
            title: '奖品类型'.tr,
            context: item?.prizeType,
          ),
          _buildContextInfoItem(
            title: '流水要求'.tr,
            context: item?.waterMultiple,
          ),
          _buildContextInfoItem(
            title: '发放钱包'.tr,
            context: item?.walletType == 2 ? '场馆钱包'.tr : '中心钱包'.tr,
          ),
        ],
      ),
    );
  }

  ///文本左右排版信息
  Widget _buildContextInfoItem({
    required String title,
    String? context,
    TextStyle? textStyle,
    bool isShowCopy = false,
  }) {
    return Container(
      height: 48.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: appnewColors.colorLine, width: 1),
        ),
      ),
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
          isShowCopy
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      context ?? '',
                      style: textStyle ??
                          TextStyle(
                              color: appnewColors.text2,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
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
                )
              : Text(
                  context ?? '',
                  style: textStyle ??
                      TextStyle(
                          color: appnewColors.text2,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
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
