import 'package:flutter_ty_app/app/services/api/analyze_detail_api.dart';


/// 本赛季统计API服务类
/// 负责处理所有与赛季统计数据相关的API请求
class SeasonStatisticApiService {
  /// 请求获取本赛季统计数据
  /// [mid] 比赛ID
  /// [flag] 标志位，默认为"0"
  /// 返回Future，包含赛季统计数据
  static Future<dynamic> requestGetSeasonStats({
    required String mid,
    String flag = "0",
  }) async {
    return await AnalyzeDetailApi.instance().getSeasonStatsPB(
      mid: mid,
      flag: flag,
    );
  }

  /// 请求VS信息
  /// [mid] 比赛ID
  /// [flag] 标志位
  /// 返回Future，包含VS信息列表
  static Future<dynamic> requestVSInfo({
    required String mid,
    String? flag,
  }) async {
    return await AnalyzeDetailApi.instance().vsInfo(mid, flag);
  }

  /// 请求团队与其他团队的交手记录
  /// [mid] 比赛ID
  /// [flag] 标志位，默认为"0"
  /// [day] 天数，默认为"999"
  /// 返回Future，包含团队与其他团队的交手记录
  static Future<dynamic> requestOtherTeamsVSInfo({
    required String mid,
    String flag = "0",
    String day = "999",
  }) async {
    return await AnalyzeDetailApi.instance().teamVsOtherTeam(mid, flag, day);
  }

  /// 请求团队VS历史记录
  /// [mid] 比赛ID
  /// [flag] 标志位，默认为"0"
  /// [day] 天数，默认为"5"
  /// 返回Future，包含团队VS历史记录列表
  static Future<dynamic> requestTeamsVSInfo({
    required String mid,
    String flag = "0",
    String day = "5",
  }) async {
    return await AnalyzeDetailApi.instance().teamVSHistory(mid, flag, day);
  }
}
