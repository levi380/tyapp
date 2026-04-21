
import 'package:flutter_ty_app/app/modules/match_detail/states/match_cup_point_state.dart';

import '../../../../../../../generated/locales.g.dart';

import '../../../../../../services/models/res/analyze_vs_info_new_info_entity.dart';

import '../../../../../../widgets/empty/no_data.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../controllers/match_cup_point_controller.dart';
import '../../../../controllers/match_detail_controller.dart';
import '../../../../controllers/match_tools_methods.dart';
import 'basket_ball_league_points_header.dart';
import 'basket_ball_league_points_item.dart';
import 'basket_ball_league_points_footer.dart';
import 'basket_ball_league_points_match_head.dart';
import 'basket_ball_league_points_select_btn.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 杯赛积分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 篮球小组赛-杯赛积分
    】】】
 *
 */
class BasketballLeaguePoints extends StatefulWidget {
  const BasketballLeaguePoints({super.key, required this.tag});

  final String tag;

  @override
  State<BasketballLeaguePoints> createState() => _BasketballLeaguePointsState();
}

class _BasketballLeaguePointsState extends State<BasketballLeaguePoints> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchCupPointController>(
      tag: widget.tag,
      builder: (controller) {
        return Column(
          children: [
            BasketBallLeaguePointsSelectBtn(controller: controller),
            BasketBallLeaguePointsMatchHead(tag: widget.tag),
            SizedBox(height: 12.w),
            const BasketBallLeaguePointsHeader(),
            Expanded(child: buildBasketBallBody(controller)),
          ],
        );
      },
    );
  }

  /// 篮球杯赛积分列表主体：无数据时显示 NoData，否则按当前分组展示排名列表，含主客队高亮与展开
  Widget buildBasketBallBody(MatchCupPointController controller) {
    final state = controller.state;

    if (state.currentCupBasketBallEventDataEvents.isEmpty) {
      return NoData(
        top: 40.h,
        content: LocaleKeys.common_no_data.tr,
      );
    }

    MatchDetailController matchDetailController =
        Get.find<MatchDetailController>(tag: widget.tag);
    List<AnalyzeVsInfoNewInfoTeamRankings> currentPageTeamRankings = (state
            .currentCupBasketBallEventDataEvents[
                state.currentCupBasketBallEventPageIndex]
            .teamRankings)
        .map((e) => e)
        .toList(growable: true);
    bool showExpand = false;
    if (currentPageTeamRankings.length > MatchCupPointState.MAX_LENGTH) {
      showExpand = true;
    }
    if (showExpand) {
      currentPageTeamRankings = (state.isExpandImport == true)
          ? currentPageTeamRankings
          : currentPageTeamRankings.sublist(0, MatchCupPointState.MAX_LENGTH);
    }
    if (state.isExpandImport == false) {
      List<AnalyzeVsInfoNewInfoTeamRankings> tempPageTeamRankings = [];
      bool reset = false;
      for (AnalyzeVsInfoNewInfoTeamRankings item in currentPageTeamRankings) {
        if (item.teamCnName ==
                getTeamName(
                    type: 1, match: matchDetailController.detailState.match) ||
            item.teamCnName ==
                getTeamName(
                    type: 2, match: matchDetailController.detailState.match)) {
          reset = true;
          break;
        }
      }
      // 如果含有主客队 就重置顺序
      if (reset) {
        currentPageTeamRankings = state
            .currentCupBasketBallEventDataEvents[
                state.currentCupBasketBallEventPageIndex]
            .teamRankings;

        for (AnalyzeVsInfoNewInfoTeamRankings item in currentPageTeamRankings) {
          if (item.teamCnName ==
                  getTeamName(
                      type: 1,
                      match: matchDetailController.detailState.match) ||
              item.teamCnName ==
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
    return ListView.builder(
      shrinkWrap: true,
      padding:
          EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w, bottom: 120.w),
      itemCount: showExpand
          ? (currentPageTeamRankings.length + 1)
          : currentPageTeamRankings.length,
      itemBuilder: (context, index) {
        if (currentPageTeamRankings.length == index) {
          return BasketBallLeaguePointsFooter(controller: controller);
        }
        AnalyzeVsInfoNewInfoTeamRankings eventItem =
            currentPageTeamRankings[index];
        return BasketBallLeaguePointsItem(
          eventItem: eventItem,
          color: getColor(
              controller.getTeamNameColorIndex(eventItem.teamCnName)),
          controller: controller,
        );
      },
    );
  }

  List<Color> getColor(int index) {
    List<Color> list = [Colors.transparent, Colors.transparent];

    if (Get.isDarkMode) {
      if ((index == 1)) {
        list = [Color(0xFF24374A), Color(0xFF24374A)];
      } else if (index == 2) {
        list = [Color(0xFF41392A), Color(0xFF41392A)];
      }
    } else {
      if ((index == 1)) {
        list = [Color(0xFFD1ECFF), Color(0xFFD1ECFF)];
      } else if (index == 2) {
        list = [Color(0xFFFEEECC), Color(0xFFFEEECC)];
      }
    }
    return list;
  }
}

