import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_cup_point_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_cup_point_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_cup_point/widget/eliminate_match_history_type1_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/knockout_info_bean_entity.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../widgets/empty/no_data.dart';
import '../../../../../login/login_head_import.dart';
import 'eliminate_match_history_type2_widget.dart';
import 'knockout_round_tab_bar.dart';
import 'knockout_round_basketball_item.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 杯赛积分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 足球小组赛-淘汰赛
    】】】
 *
 */
/// 杯赛积分-淘汰赛视图
///
/// 根据 [MatchCupPointController] 与 [MatchDetailController] 展示轮次 Tab 与当前轮对阵列表（足球用 [EliminateMatchHistoryType1/2]，篮球用 [KnockoutRoundBasketballItem]）。
class KnockoutRound extends StatelessWidget {
  KnockoutRound({required this.tag});

  /// 控制器 tag，用于 GetX 绑定与 [MatchDetailController] 查找（判断 csid 是否篮球）
  final String tag;

  /// 构建淘汰赛页：无数据时 [NoData]；否则 [SingleChildScrollView] 内嵌 [buildPanmian]（轮次 Tab + 当前轮列表）。
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchCupPointController>(
        id: "buildPanmian",
        tag: tag,
        builder: (controller) {
          MatchDetailController detailController =
              Get.find<MatchDetailController>(tag: tag);
          return (controller.getLength() == 0)
              ? NoData(
                  content: LocaleKeys.analysis_football_matches_no_data.tr,
                  top: 30.h,
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        color: Get.theme.tabPanelBackgroundColor,
                        alignment: Alignment.centerLeft,
                        child: buildPanmian(controller,
                            showBasketBall:
                                detailController.detailState.match?.csid ==
                                    "2"),
                      ),
                    ],
                  ),
                );
        });
  }

  /// 构建淘汰赛主体：轮次 [KnockoutRoundTabBar] + 当前轮对阵列表。
  /// [showBasketBall] 为 true 时每条为 [KnockoutRoundBasketballItem]；为 false 时根据 [currentIndex] 用 [EliminateMatchHistoryType1WidgetWidget] 或 [EliminateMatchHistoryType2WidgetWidget]。
  buildPanmian(MatchCupPointController controller,
      {bool showBasketBall = false}) {
    final state = controller.state;
    return controller.getLength() == 0
        ? NoData(
            content: LocaleKeys.analysis_football_matches_no_data.tr,
            top: 30.h,
          )
        : Column(
            children: [
              Container(
                child: KnockoutRoundTabBar(controller: controller),
              ),
              Column(
                children: state.currentList
                    .map(
                      (e) => showBasketBall
                          ? KnockoutRoundBasketballItem(entity: e)
                          : (controller.state.currentIndex == 4
                              ? EliminateMatchHistoryType2WidgetWidget(e)
                              : EliminateMatchHistoryType1WidgetWidget(
                                  e,
                                  tag: tag,
                                )),
                    )
                    .toList(),
              ),
            ],
          );
  }
}
