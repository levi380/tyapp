import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_tools_methods.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
/// 本赛季统计队伍辅助类
/// 负责处理与队伍相关的辅助方法
class SeasonStatisticTeamHelper {
  /// 初始化队伍信息
  /// [tag] 比赛ID
  /// [basketBallTeamNameList] 队伍名称列表，将被填充
  /// 返回是否需要请求VS信息（篮球比赛返回true）
  static bool initTeams(
    String tag,
    List<String> basketBallTeamNameList,
  ) {
    basketBallTeamNameList.clear();

    MatchDetailController detailController =
        Get.find<MatchDetailController>(tag: tag);
    MatchEntity? match = detailController.detailState.match;
    
    // 1主队 2客队
    String team1 = getTeamName(type: 1, match: match);
    String team2 = getTeamName(type: 2, match: match);
    basketBallTeamNameList.add(team1);
    basketBallTeamNameList.add(team2);
    
    // 如果是篮球比赛（csid == "2"），返回true表示需要请求VS信息
    return match?.csid == "2";
  }

  /// 获取队伍图片URL
  /// [awayTeamName] 客队名称
  /// [tag] 比赛ID
  /// 返回队伍图片URL
  static String getPlayImage(String awayTeamName, String tag) {
    MatchEntity matchEntity =
        DataStoreController.to.getMatchById(tag) ?? MatchEntity();
    // 1主队 2客队
    String team1 = getTeamName(type: 1, match: matchEntity);
    String url = "";

    MatchDetailController detailController =
        Get.find<MatchDetailController>(tag: tag);
    
    if (awayTeamName == team1) {
      // 主队
      url = detailController.detailState.match?.mhlu[0] ?? "";
    } else {
      // 客队
      url = detailController.detailState.match?.malu[0] ?? "";
    }

    return url;
  }
}
