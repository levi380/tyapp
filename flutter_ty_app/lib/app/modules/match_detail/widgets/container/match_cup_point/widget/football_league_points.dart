
import 'package:flutter_ty_app/app/modules/match_detail/states/match_cup_point_state.dart';

import '../../../../../../services/models/res/analyze_vs_info_new_info_entity.dart';
import '../../../../../../widgets/empty/no_data.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../controllers/match_cup_point_controller.dart';
import 'eliminate_match_history_board_header.dart';
import 'football_league_points_group_selector.dart';
import 'football_league_points_item.dart';
import 'football_league_points_footer.dart';

/// 足球杯赛积分页
///
/// 包含：分组选择器、表头、积分列表、底部展开与图例。
/// 数据与展开状态由 [MatchCupPointController] 管理，通过 [tag] 绑定。
class FootballLeaguePoints extends StatelessWidget {
  const FootballLeaguePoints({super.key, required this.tag});
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FootballLeaguePointsGroupSelector(tag: tag),
        SizedBox(height: 12.w),
        EliminateMatchHistoryBoardHeader(),
        buildList(),
      ],
    );
  }

  /// 根据当前分组与展开状态构建积分列表；无数据时显示 [NoData]
  Widget buildList() {
    return GetBuilder<MatchCupPointController>(
        id: "analyzeMatchResultLiveEvent",
        tag: tag,
        builder: (controller) {
          final state = controller.state;
          if (state.currentCupBasketBallEventDataEvents.isEmpty) {
            return NoData(top: 0);
          }

          List<AnalyzeVsInfoNewInfoTeamRankings> currentPageTeamRankings =
              (state
                      .currentCupBasketBallEventDataEvents[
                          state.currentCupBasketBallEventPageIndex]
                      .teamRankings)
                  .map((e) => e)
                  .toList(growable: true);
          bool showExpand = false;
          if (currentPageTeamRankings.length > MatchCupPointState.MAX_LENGTH) {
            showExpand = true;
          }
          if (showExpand && state.currentCupBasketBallEventPageIndex == 0) {
            currentPageTeamRankings = (state.isExpandImport == true)
                ? currentPageTeamRankings
                : currentPageTeamRankings.sublist(0, MatchCupPointState.MAX_LENGTH);
          }


          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 12.w, bottom: 80.w),
              itemCount: currentPageTeamRankings.length + 1,
              itemBuilder: (context, index) {
                if (currentPageTeamRankings.length == index) {
                  return FootballLeaguePointsFooter(tag: tag);
                }
                final eventItem = currentPageTeamRankings[index];
                return FootballLeaguePointsItem(
                  entity: eventItem,
                  union: state.union,
                  currentCupBasketBallEventPageIndex:
                      state.currentCupBasketBallEventPageIndex,
                  color: getColor(
                    controller.getTeamNameColorIndex(eventItem.teamCnName),
                  ),
                );
              },
            ),
          );
        });
  }

  /// 根据主客队高亮索引返回行背景渐变色（深色/浅色主题）
  List<Color> getColor(int index) {
    List<Color> list = [Colors.transparent, Colors.transparent];

    if (Get.isDarkMode) {
      if ((index == 1)) {
        list = [
          MatchCupPointState.team1BackgroundColorDark,
          MatchCupPointState.team1BackgroundColorDark
        ];
      } else if (index == 2) {
        list = [
          MatchCupPointState.team2BackgroundColorDark,
          MatchCupPointState.team2BackgroundColorDark
        ];
      }
    } else {
      if ((index == 1)) {
        list = [
          MatchCupPointState.team1BackgroundColorLight,
          MatchCupPointState.team1BackgroundColorLight
        ];
      } else if (index == 2) {
        list = [
          MatchCupPointState.team2BackgroundColorLight,
          MatchCupPointState.team2BackgroundColorLight
        ];
      }
    }
    return list;
  }
}
