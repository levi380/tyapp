import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_market_news_state.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

/// 盘面-赛事文章正文
///
/// 使用 [HtmlWidget] 渲染 [summary] + [articleContent]，占位符替换为图片域名。
class MatchMarketNewsArticleBody extends StatelessWidget {
  const MatchMarketNewsArticleBody({
    super.key,
    required this.summary,
    required this.articleContent,
  });

  /// 摘要 HTML 片段，拼接在正文前
  final String summary;
  /// 正文 HTML，其中 [_imagePlaceholder] 会被替换为 [_imageDomain]
  final String articleContent;

  /// 正文中的图片域名占位符，需替换为实际 CDN 地址
  static const String _imagePlaceholder = 'IMAGE_DOMAIN_YUNYING_PLACEHOLDER';
  /// 替换后的图片域名
  static const String _imageDomain = 'https://image.moof87.com//';

  /// 构建正文：将 [articleContent] 中的 [_imagePlaceholder] 全部替换为 [_imageDomain] 后与 [summary] 拼接，
  /// 用 [HtmlWidget] 渲染，行高与字间距来自 [MatchMarketNewsState]。
  @override
  Widget build(BuildContext context) {
    final String html = '$summary${articleContent.replaceAll(_imagePlaceholder, _imageDomain)}';
    return Container(
      width: 1.sw,
      child: HtmlWidget(
        html,
        textStyle: TextStyle(
          height: MatchMarketNewsState.htmlTextLineHeight,
          wordSpacing: MatchMarketNewsState.htmlTextWordSpacing.w,
        ),
      ),
    );
  }
}
