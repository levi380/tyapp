

import 'package:flutter_ty_app/app/modules/match_detail/states/league_points_state.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_vs_info_new_info_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_analyze_vs_info_entity.dart';
import '../../../../../../../../generated/locales.g.dart';

import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import '../../../../../../widgets/loading.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../controllers/league_points_controller.dart';
import '../../../../models/request_status.dart';
import 'league_points_football_footer.dart';
import 'league_points_football_item.dart';

/**
 * 联赛积分列表体组件
 */
class LeaguePointsFootballBody extends StatelessWidget {
  final LeaguePointsController controller;

  const LeaguePointsFootballBody({
    super.key,
    required this.controller,
  });

  /// 构建联赛积分列表体UI
  /// 根据版本类型构建不同版本的列表
  @override
  Widget build(BuildContext context) {
    if (controller.state.version == LeaguePointVersion.version2) {
      return _buildVersion2(context);
    } else {
      return _buildVersion3(context);
    }
  }

  /// 构建版本2的列表体
  /// 后端数据接口有两种：传统联赛数组结构和杯赛数组结构，杯赛有分组，联赛没有
  Widget _buildVersion2(BuildContext context) {
    if (controller.state.currentCupBasketBallEventDataEvents.isEmpty) {
      return NoData(
        top: 40.h,
        content: LocaleKeys.common_no_data.tr,
      );
    }
    List<AnalyzeVsInfoNewInfoTeamRankings> currentPageTeamRankings = (controller
            .state
            .currentCupBasketBallEventDataEvents[
                controller.state.currentCupBasketBallEventPageIndex]
            .teamRankings)
        .map((e) => e)
        .toList(growable: true);
    return ListView.builder(
      shrinkWrap: true,
      padding:
          EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w, bottom: 120.w),
      itemCount: currentPageTeamRankings.length,
      itemBuilder: (context, index) {
        AnalyzeVsInfoNewInfoTeamRankings eventItem =
            currentPageTeamRankings[index];
        return LeaguePointsFootballItem(
          analyzeVSInfoEntity: currentPageTeamRankings[index],
          index: index,
          selectIndex: controller.getTeamNameType(eventItem.teamName),
          controller: controller,
          boldText: controller.getTeamNameColorIndex(eventItem.teamCnName) != 0,
          listColor: getLeaguePointsItemColor(
              context,
              controller.getTeamNameColorIndex(
                  currentPageTeamRankings[index].teamCnName)),
        );
      },
    );
  }

  /**
   * 构建版本3的列表体
   */
  Widget _buildVersion3(BuildContext context) {
    List<MatchAnalyzeVsInfoEntity> currentPageTeamRankings =
        (controller.state.version3MatchAnalyzeVsInfoDataList)
            .map((e) => e)
            .toList(growable: true);
    int length = currentPageTeamRankings.length;
    if (controller.state.requestStatus == RequestStatus.loading) {
      return Loading();
    }
    if (currentPageTeamRankings.isEmpty) {
      return NoData(
        top: 100.h,
        content: LocaleKeys.common_no_data.tr,
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(bottom: 100.w),
      itemCount: length + 1,
      //列表项构造器
      itemBuilder: (BuildContext context, int index) {
        if (index == length) {
          return LeaguePointsFootballFooter(
            controller: controller,
            needBottomPadding: true,
          );
        }

        return Container(
          child: LeaguePointsFootballItem(
            analyzeVSInfoEntity: AnalyzeVsInfoNewInfoTeamRankings.fromJson(
                currentPageTeamRankings[index].toJson()),
            index: index,
            selectIndex: controller.getTeamNameType(
                controller.state.version3MatchAnalyzeVsInfoDataList[index]
                        .teamName ),
            controller: controller,
            boldText: controller.getTeamNameColorIndex(
                    currentPageTeamRankings[index].teamCnName) !=
                0,
            listColor: getLeaguePointsItemColor(
                context,
                controller.getTeamNameColorIndex(
                    currentPageTeamRankings[index].teamCnName)),
          ),
        );
      },
    );
  }
}

