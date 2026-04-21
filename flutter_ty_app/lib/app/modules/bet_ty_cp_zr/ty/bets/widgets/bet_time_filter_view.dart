import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../main.dart';
import '../../../../../extension/color_extension.dart';
import '../../../../unsettled_bets/utils/betsUtils.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-未结算日期选择Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示投注时间过滤选项，允许用户选择不同的时间类型 全部-今日-昨日-一周-自定义。
    - **type**: 当前选中的时间类型（整数）。
    - **onChanged**: 当选项改变时的回调函数。
    - **startTime**: 自定义时间段的开始时间。
    - **endTime**: 自定义时间段的结束时间。
    - **openSelectTypeTime**: 是否打开自定义时间选择，默认为 `false`。
    - 构建组件的 UI，包括一个行，展示多个时间过滤选项。
    - `singleType`: 当前选项的类型（整数）。
    - `title`: 显示的标题。
    - **功能**: 返回一个可点击的选项，调用 `onChanged` 回调。
    - `singleType`: 当前选项的类型（整数）。
    - `title`: 显示的标题。
    - **功能**: 根据选项类型和状态返回不同的 UI：
    - 如果是自定义时间且未打开自定义选择，则显示开始和结束时间。
    - 否则，仅显示标题。
    - 通过 `Get.isDarkMode` 判断当前主题，动态设置颜色。
    - 文本样式包括字体、大小和粗细等属性，适配中文和英文显示。
    - 使用 `Flexible` 适配不同语言的布局。
    - 选项的点击事件通过 `InkWell` 处理，提供反馈效果。

    】】】
 *
 */
class BetTimeFilteringView extends StatelessWidget {
  BetTimeFilteringView({
    required this.type,
    required this.onChanged,
    required this.startTime,
    required this.endTime,
    this.openSelectTypeTime = false,
    Key? key,
  }) : super(key: key);

  final int type;
  final bool openSelectTypeTime;
  final ValueChanged<int> onChanged;
  final String startTime, endTime;

  bool get _isEnglish => ['en'].contains(Get.locale?.languageCode);

  bool get _isZh => ['zh', 'hk'].contains(Get.locale?.languageCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.w,
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.1)
                : const Color(0xFFE4E6ED),
          ),
        ),
      ),
      child: Row(
        children: [
          _single(
            0,
            LocaleKeys.app_h5_match_all.tr,
          ),
          _single(
            1,
            LocaleKeys.app_bet_date_list_0.tr,
          ),
          _single(
            2,
            LocaleKeys.app_bet_date_list_1.tr,
          ),
          _single(
            3,
            LocaleKeys.app_bet_date_list_2.tr,
          ),
          _single(
            5,
            LocaleKeys.app_custom.tr,
          ),
        ],
      ),
    );
  }

  /**
   * 适配中英文
   */
  int fitWidth(int singleType) {
    if (_isEnglish) {
      if (singleType == 2) {
        return 7;
      } else if (singleType == 5) {
        return 6;
      } else if (singleType == 0) {
        return 4;
      }
    } else if (_isZh && (singleType == 3 || singleType == 5)) {
      return 6;
    }
    return 5;
  }

  Widget _single(int singleType, String title) {
    return Flexible(
      ///适配英文
      flex: fitWidth(singleType),
      child: InkWell(
        onTap: () => {
          onChanged(singleType),
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: singleType == 5 && type == 5 ? 0.w : 1.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _showStatus(singleType, title),
            ],
          ),
        ),
      ),
    );
  }

/*
*日期选择
 */
  Widget _showStatus(int singleType, String title) {
    Widget widget = Container();
    ///自定义时间（并且被选中）
    if (singleType == 5 && type == 5 && !openSelectTypeTime) {
      widget = Container(
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              startTime,
              maxLines: 1,
              style: TextStyle(
                color: BetsUtils.getColor(Get.isDarkMode),
                fontSize: 7.5.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ).paddingOnly(
              bottom: 2.w,
            ),
            Text(
              endTime,
              maxLines: 1,
              style: TextStyle(
                color: BetsUtils.getColor(Get.isDarkMode),
                fontSize: 7.5.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    } else {
      //////常规
      widget = Container(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isFootballBasketballTemplate  ? singleType == type ? HexColor(footballBasketballTemplateThemeColor) : Color(0xFF949AB6) : Get.isDarkMode
                ? singleType == type
                    ?  const Color(0xFF127DCC)
                    : Colors.white.withValues(alpha: 0.5)
                : Color(
                    singleType == type ?  0xff179CFF : 0xFF949AB6,
                  ),
            fontSize: (_isZh ? 14.sp : 12.sp),
            fontFamily: 'PingFang SC',
            fontWeight: singleType == type ? FontWeight.w600 : FontWeight.w400,
            height: 1.0.h,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    return widget;
  }
}
