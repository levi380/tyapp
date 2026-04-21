import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_market_news_state.dart';
import 'package:flutter_ty_app/main.dart';

/// 盘面-赛事文章标题
///
/// 显示 [articleTittle]，使用 [MatchMarketNewsState] 的标题字号（含 iPad 适配）。
class MatchMarketNewsArticleTitle extends StatelessWidget {
  const MatchMarketNewsArticleTitle({super.key, required this.title});

  /// 文章标题文案
  final String title;

  /// 构建单行标题 [Text]：颜色 [oddsButtonValueFontColor]，字重 w600，字号 [titleFontSize] / [titleFontSizeIPad]。
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Get.theme.oddsButtonValueFontColor,
        fontWeight: FontWeight.w600,
        fontSize: isIPad
            ? MatchMarketNewsState.titleFontSizeIPad.sp
            : MatchMarketNewsState.titleFontSize.sp,
      ),
    );
  }
}
