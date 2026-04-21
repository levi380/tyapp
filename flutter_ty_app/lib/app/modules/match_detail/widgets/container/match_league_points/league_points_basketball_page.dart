
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import '../../../../../../../generated/locales.g.dart';

import '../../../../../services/models/res/match_analyze_vs_info_entity.dart';
import '../../../../../widgets/loading.dart';
import '../../../../login/login_head_import.dart';
import '../../../controllers/league_points_controller.dart';
import '../../../controllers/match_detail_controller.dart';
import '../../../controllers/match_tools_methods.dart';
import '../../../models/request_status.dart';
import '../../../states/league_points_state.dart';
import 'widgets/basket_ball_combined_history_header.dart';
import 'widgets/basket_ball_point_item.dart';
import 'widgets/basket_ball_footer.dart';
import 'widgets/league_points_basketball_header.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛积分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 小组塞-联赛积分-篮球
    】】】
 *
 */
class LeaguePointsBasketballPage extends StatefulWidget {
  final String tag;

  LeaguePointsBasketballPage({super.key, required this.tag});

  @override
  State<LeaguePointsBasketballPage> createState() =>
      _LeaguePointsBasketballPageState();
}

class _LeaguePointsBasketballPageState
    extends State<LeaguePointsBasketballPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaguePointsController>(
      init: LeaguePointsController(tag: widget.tag),
      tag: widget.tag,
      builder: (controller) {
        MatchDetailController matchDetailController =
            Get.find<MatchDetailController>(tag: widget.tag);
        List<MatchAnalyzeVsInfoEntity> currentPageTeamRankings =
            (controller.state.dataList).map((e) => e).toList(growable: true);
        if (controller.state.expand == false) {
          List<MatchAnalyzeVsInfoEntity> tempPageTeamRankings = [];
          bool reset = false;
          for (MatchAnalyzeVsInfoEntity item in currentPageTeamRankings) {
            if (item.teamName ==
                    getTeamName(
                        type: 1,
                        match: matchDetailController.detailState.match) ||
                item.teamName ==
                    getTeamName(
                        type: 2,
                        match: matchDetailController.detailState.match)) {
              reset = true;
              break;
            }
          }

          // 如果含有主客队 就重置顺序
          if (reset) {
            currentPageTeamRankings = (controller.state.dataList);

            for (MatchAnalyzeVsInfoEntity item in currentPageTeamRankings) {
              if (item.teamName ==
                      getTeamName(
                          type: 1,
                          match: matchDetailController.detailState.match) ||
                  item.teamName ==
                      getTeamName(
                          type: 2,
                          match: matchDetailController.detailState.match)) {
                tempPageTeamRankings.add(item);
              }
            }
            if (tempPageTeamRankings.isNotEmpty) {
              currentPageTeamRankings = tempPageTeamRankings;
            }
          }
        }

        int length = currentPageTeamRankings.length;

        if (controller.state.requestStatus == RequestStatus.loading) {
          return Loading();
        }
        if (currentPageTeamRankings.isEmpty) {
          return NoData(
            top: LeaguePointsState.noDataTopSpacing.h,
            content: LocaleKeys.common_no_data.tr,
          );
        }

        return Container(
          margin: EdgeInsets.only(
            top: LeaguePointsState.basketballPageTopMargin.h,
            left: LeaguePointsState.basketballPageTopMargin.w,
            right: LeaguePointsState.basketballPageTopMargin.w,
          ),
          decoration: BoxDecoration(
            color: Get.theme.oddsButtonBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, LeaguePointsState.basketballShadowOpacity),
                blurRadius: LeaguePointsState.basketballShadowBlurRadius,
                offset: Offset(0, LeaguePointsState.basketballShadowOffsetY.w),
                spreadRadius: 0,
                blurStyle: BlurStyle.normal,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(LeaguePointsState.basketballPageBorderRadius.w),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: LeaguePointsState.pageHorizontalPadding.w,
            vertical: LeaguePointsState.basketballPageVerticalPadding.w,
          ),
          // height: controller.state.expand == false ? 200.w : 1.sh,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LeaguePointsBasketballHeader(tag: widget.tag),
              BasketBallCombinedHistoryHeader(),
              Flexible(
                child: ListView.builder(
                  itemCount: length + 1,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  //列表项构造器
                  itemBuilder: (BuildContext context, int index) {
                    if (index == length) {
                      return BasketBallFooter(
                        controller: controller,
                        needBottomPadding: true,
                      );
                    }
                    return Container(
                      child: BasketBallPointItem(
                        analyzeVSInfoEntity: currentPageTeamRankings[index],
                        index: index,
                        controller: controller,
                        listColor: getColor(
                            context,
                            controller.getTeamNameColorIndex(
                                currentPageTeamRankings[index].teamName)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Color> getColor(BuildContext context, int index) {
    List<Color> list = [Colors.transparent, Colors.transparent];

    if (context.isDarkMode) {
      if ((index == 1)) {
        list = [
          LeaguePointsState.basketballTeam1BackgroundColorDark,
          LeaguePointsState.basketballTeam1BackgroundColorDark
        ];
      } else if (index == 2) {
        list = [
          LeaguePointsState.basketballTeam2BackgroundColorDark,
          LeaguePointsState.basketballTeam2BackgroundColorDark
        ];
      }
    } else {
      if ((index == 1)) {
        list = [
          LeaguePointsState.basketballTeam1BackgroundColorLight,
          LeaguePointsState.basketballTeam1BackgroundColorLight
        ];
      } else if (index == 2) {
        list = [
          LeaguePointsState.basketballTeam2BackgroundColorLight,
          LeaguePointsState.basketballTeam2BackgroundColorLight
        ];
      }
    }
    return list;
  }
}
