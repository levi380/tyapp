import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/widget/box_shadow_container.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/network/request_interceptor.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../../controllers/match_market_news_controller.dart';
import '../../../../states/match_market_news_state.dart';
import 'match_market_news_article_title.dart';
import 'match_market_news_meta_row.dart';
import 'match_market_news_article_body.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘面】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球盘面新闻控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛事文章
    】】】
 *
 */
/// 盘面-赛事文章页
///
/// 根据 [tag] 绑定 [MatchMarketNewsController]，无数据或非中文时显示 [NoData]，否则展示标题、元信息、正文。
class MatchMarketNewsPage extends StatelessWidget {
  MatchMarketNewsPage({super.key, required this.tag});

  /// 控制器 tag，用于 GetX 定位与初始化
  final String tag;

  /// 构建整页：通过 [GetBuilder] 监听 [MatchMarketNewsController]，
  /// 无数据或语言非 zh 时返回 [NoData]；否则返回带内边距的 [SingleChildScrollView]，
  /// 内部为 [BoxShadowContainer] 包裹标题 [MatchMarketNewsArticleTitle]、元信息行 [MatchMarketNewsMetaRow]、正文 [MatchMarketNewsArticleBody]。
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchMarketNewsController>(
        init: MatchMarketNewsController(tag: tag),
        tag: tag,
        builder: (controller) {
          final state = controller.state;

          if (state.noData || (!(["zh"].contains(getLang())))) {
            return NoData(
              content: LocaleKeys.analysis_football_matches_no_data.tr,
              top: MatchMarketNewsState.noDataTopSpacing.h,
            );
          }

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: MatchMarketNewsState.pageHorizontalPadding.w,
              vertical: MatchMarketNewsState.pageVerticalPadding.h,
            ),
            width: 1.sw,
            height: 1.sh,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  BoxShadowContainer(
                    padding: EdgeInsets.symmetric(
                      vertical: MatchMarketNewsState.contentVerticalPadding.h,
                      horizontal: MatchMarketNewsState.contentHorizontalPadding.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MatchMarketNewsArticleTitle(
                          title: controller.state.analyzeNewsEntity.value.articleTittle ?? "",
                        ),
                        SizedBox(height: MatchMarketNewsState.titleBottomSpacing.w),
                        MatchMarketNewsMetaRow(
                          categoryName: controller.state.analyzeNewsEntity.value.categoryName ?? "",
                          showTime: controller.state.analyzeNewsEntity.value.showTime ?? "",
                          readCounts: int.tryParse(controller.state.analyzeNewsEntity.value.readCounts??"0") ?? 0,
                        ),
                        SizedBox(height: MatchMarketNewsState.subtitleBottomSpacing.w),
                        MatchMarketNewsArticleBody(
                          summary: controller.state.analyzeNewsEntity.value.summary ?? "",
                          articleContent: controller.state.analyzeNewsEntity.value.articleContent ?? "",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
