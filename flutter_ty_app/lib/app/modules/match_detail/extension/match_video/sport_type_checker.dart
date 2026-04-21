import '../../../../global/config_static.dart';

/// 球种类型检查器
class SportTypeChecker {
  /// 电竞球种ID列表
  static final List<String> esportIds = [
    (SportConfig.lol.sportId - 2000).toString(),
    (SportConfig.dota2.sportId - 2000).toString(),
    (SportConfig.cs2.sportId - 2000).toString(),
    (SportConfig.honorOfKings.sportId - 2000).toString(),
    (SportConfig.valorant.sportId - 2000).toString()
  ];

  /// 是否支持动画3.0的球种ID列表
  static const List<String> animation3SupportedIds = ["1", "2", "3", "5"];

  /// 判断是否为电竞比赛
  static bool isEsport(String? csid) {
    return csid != null && esportIds.contains(csid);
  }

  /// 判断是否支持动画3.0
  static bool isAnimation3Supported(String? csid) {
    return csid != null && animation3SupportedIds.contains(csid);
  }
}