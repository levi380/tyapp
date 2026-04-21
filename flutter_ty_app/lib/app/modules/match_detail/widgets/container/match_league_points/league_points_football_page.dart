import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/league_points_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/widget/box_shadow_container.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_league_points/widgets/analyze_new_combined_history_child_header.dart';
import '../../../../../../../generated/locales.g.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import '../../../../../widgets/loading.dart';
import '../../../../login/login_head_import.dart';
import '../../../controllers/league_points_controller.dart';
import '../../../models/request_status.dart';
import 'widgets/league_points_football_body.dart';
import 'widgets/league_points_football_select_btn.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 历史回放主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -小组塞-联赛积分
    】】】
 */
// 小组塞-联赛积分-足球
class LeaguePointsFootballPage extends StatefulWidget {
  final String tag;

  LeaguePointsFootballPage({super.key, required this.tag});

  @override
  State<LeaguePointsFootballPage> createState() =>
      _LeaguePointsBasketballPageState();
}

class _LeaguePointsBasketballPageState extends State<LeaguePointsFootballPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaguePointsController>(
      tag: widget.tag,
      init: LeaguePointsController(tag: widget.tag),
      builder: (controller) {
        if (controller.state.requestStatus == RequestStatus.loading) {
          return Loading();
        }
        if (((controller.state.version==LeaguePointVersion.version2))&&controller.state.currentCupBasketBallEventDataEvents.isEmpty) {
          return NoData(
            top: LeaguePointsState.noDataTopSpacing.h,
            content: LocaleKeys.common_no_data.tr,
          );
        }
        if (((controller.state.version==LeaguePointVersion.version3))&&controller.state.version3MatchAnalyzeVsInfoDataList.isEmpty) {
          return NoData(
            top: LeaguePointsState.noDataTopSpacing.h,
            content: LocaleKeys.common_no_data.tr,
          );
        }

        return BoxShadowContainer(
          alignment: Alignment.topCenter,
          color: Get.theme.oddsButtonBackgroundColor,
          margin: EdgeInsets.symmetric(
            horizontal: LeaguePointsState.pageHorizontalMargin.w,
            vertical: LeaguePointsState.pageVerticalMargin.w,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: LeaguePointsState.pageHorizontalPadding.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(controller.state.version==LeaguePointVersion.version2)
              LeaguePointsFootballSelectBtn(controller: controller),
              AnalyzeNewCombinedHistoryChildHeader(),
              Expanded(child: LeaguePointsFootballBody(controller: controller)),
            ],
          ),
        );
      },
    );
  }
}
