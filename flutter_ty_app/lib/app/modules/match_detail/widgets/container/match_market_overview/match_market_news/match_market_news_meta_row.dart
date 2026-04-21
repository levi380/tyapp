import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_market_news_state.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';

/// 盘面-赛事文章元信息行
///
/// 显示头像占位、分类名、发布时间、阅读数。
class MatchMarketNewsMetaRow extends StatelessWidget {
  const MatchMarketNewsMetaRow({
    super.key,
    required this.categoryName,
    required this.showTime,
    required this.readCounts,
  });

  /// 分类名称（如赛事、资讯）
  final String categoryName;
  /// 发布时间文案
  final String showTime;
  /// 阅读次数，与「阅读」文案一起展示
  final int readCounts;

  /// 构建一行 [Row]：灰色圆角头像占位 + 间距 + 分类名 + 时间 + 阅读数（含 [LocaleKeys.ouzhou_detail_read]），
  /// 高度与字号来自 [MatchMarketNewsState]，颜色 [secondFontColor]。
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MatchMarketNewsState.messageBodyHeight.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: MatchMarketNewsState.iconContainerWidth.w,
                height: MatchMarketNewsState.iconContainerHeight.w,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(MatchMarketNewsState.iconContainerBorderRadius.w),
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.person,
                  size: MatchMarketNewsState.iconSize.w,
                ),
              ),
              SizedBox(width: MatchMarketNewsState.iconSpacing.w),
              Text(
                "$categoryName     ",
                style: TextStyle(
                  fontSize: isIPad
                      ? MatchMarketNewsState.messageBodyFontSizeIPad.sp
                      : MatchMarketNewsState.messageBodyFontSize.sp,
                  color: Get.theme.secondFontColor,
                ),
              ),
              Text(
                showTime,
                style: TextStyle(
                  fontSize: isIPad
                      ? MatchMarketNewsState.messageBodyFontSizeIPad.sp
                      : MatchMarketNewsState.messageBodyFontSize.sp,
                  color: Get.theme.secondFontColor,
                ),
              ),
              Text(
                "       $readCounts${LocaleKeys.ouzhou_detail_read.tr}",
                style: TextStyle(
                  fontSize: isIPad
                      ? MatchMarketNewsState.messageBodyFontSizeIPad.sp
                      : MatchMarketNewsState.messageBodyFontSize.sp,
                  color: Get.theme.secondFontColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
