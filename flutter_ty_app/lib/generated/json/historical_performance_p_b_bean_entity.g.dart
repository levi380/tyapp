import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/historical_performance_p_b_bean_entity.dart';

HistoricalPerformancePBBeanEntity $HistoricalPerformancePBBeanEntityFromJson(
    Map<String, dynamic> json) {
  final HistoricalPerformancePBBeanEntity historicalPerformancePBBeanEntity = HistoricalPerformancePBBeanEntity();
  final double? averageGoal = jsonConvert.convert<double>(json['averageGoal']);
  if (averageGoal != null) {
    historicalPerformancePBBeanEntity.averageGoal = averageGoal;
  }
  final double? averageGoalPercent = jsonConvert.convert<double>(
      json['averageGoalPercent']);
  if (averageGoalPercent != null) {
    historicalPerformancePBBeanEntity.averageGoalPercent = averageGoalPercent;
  }
  final double? bothGoalPercent = jsonConvert.convert<double>(
      json['bothGoalPercent']);
  if (bothGoalPercent != null) {
    historicalPerformancePBBeanEntity.bothGoalPercent = bothGoalPercent;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    historicalPerformancePBBeanEntity.createTime = createTime;
  }
  final String? teamLogo = jsonConvert.convert<String>(json['teamLogo']);
  if (teamLogo != null) {
    historicalPerformancePBBeanEntity.teamLogo = teamLogo;
  }
  final List<int>? name2 = (json['name2'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (name2 != null) {
    historicalPerformancePBBeanEntity.name2 = name2;
  }
  final String? name4 = jsonConvert.convert<String>(json['name4']);
  if (name4 != null) {
    historicalPerformancePBBeanEntity.name4 = name4;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    historicalPerformancePBBeanEntity.dataSourceCode = dataSourceCode;
  }
  final int? expressingType = jsonConvert.convert<int>(json['expressingType']);
  if (expressingType != null) {
    historicalPerformancePBBeanEntity.expressingType = expressingType;
  }
  final String? expressionRanking = jsonConvert.convert<String>(
      json['expressionRanking']);
  if (expressionRanking != null) {
    historicalPerformancePBBeanEntity.expressionRanking = expressionRanking;
  }
  final int? fifthStatus = jsonConvert.convert<int>(json['fifthStatus']);
  if (fifthStatus != null) {
    historicalPerformancePBBeanEntity.fifthStatus = fifthStatus;
  }
  final double? firstGoalPercent = jsonConvert.convert<double>(
      json['firstGoalPercent']);
  if (firstGoalPercent != null) {
    historicalPerformancePBBeanEntity.firstGoalPercent = firstGoalPercent;
  }
  final int? firstStatus = jsonConvert.convert<int>(json['firstStatus']);
  if (firstStatus != null) {
    historicalPerformancePBBeanEntity.firstStatus = firstStatus;
  }
  final int? fourthStatus = jsonConvert.convert<int>(json['fourthStatus']);
  if (fourthStatus != null) {
    historicalPerformancePBBeanEntity.fourthStatus = fourthStatus;
  }
  final double? goalPercent = jsonConvert.convert<double>(json['goalPercent']);
  if (goalPercent != null) {
    historicalPerformancePBBeanEntity.goalPercent = goalPercent;
  }
  final double? goalXg = jsonConvert.convert<double>(json['goalXg']);
  if (goalXg != null) {
    historicalPerformancePBBeanEntity.goalXg = goalXg;
  }
  final double? goalXga = jsonConvert.convert<double>(json['goalXga']);
  if (goalXga != null) {
    historicalPerformancePBBeanEntity.goalXga = goalXga;
  }
  final int? goalsForTotal = jsonConvert.convert<int>(json['goalsForTotal']);
  if (goalsForTotal != null) {
    historicalPerformancePBBeanEntity.goalsForTotal = goalsForTotal;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    historicalPerformancePBBeanEntity.id = id;
  }
  final double? lostGoalPercent = jsonConvert.convert<double>(
      json['lostGoalPercent']);
  if (lostGoalPercent != null) {
    historicalPerformancePBBeanEntity.lostGoalPercent = lostGoalPercent;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    historicalPerformancePBBeanEntity.modifyTime = modifyTime;
  }
  final double? notLostPercent = jsonConvert.convert<double>(
      json['notLostPercent']);
  if (notLostPercent != null) {
    historicalPerformancePBBeanEntity.notLostPercent = notLostPercent;
  }
  final int? secondStatus = jsonConvert.convert<int>(json['secondStatus']);
  if (secondStatus != null) {
    historicalPerformancePBBeanEntity.secondStatus = secondStatus;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    historicalPerformancePBBeanEntity.sportId = sportId;
  }
  final String? standardTeamId = jsonConvert.convert<String>(
      json['standardTeamId']);
  if (standardTeamId != null) {
    historicalPerformancePBBeanEntity.standardTeamId = standardTeamId;
  }
  final String? teamCnName = jsonConvert.convert<String>(json['teamCnName']);
  if (teamCnName != null) {
    historicalPerformancePBBeanEntity.teamCnName = teamCnName;
  }
  final String? teamEnName = jsonConvert.convert<String>(json['teamEnName']);
  if (teamEnName != null) {
    historicalPerformancePBBeanEntity.teamEnName = teamEnName;
  }
  final int? thirdStatus = jsonConvert.convert<int>(json['thirdStatus']);
  if (thirdStatus != null) {
    historicalPerformancePBBeanEntity.thirdStatus = thirdStatus;
  }
  final String? thirdTeamSourceId = jsonConvert.convert<String>(
      json['thirdTeamSourceId']);
  if (thirdTeamSourceId != null) {
    historicalPerformancePBBeanEntity.thirdTeamSourceId = thirdTeamSourceId;
  }
  final String? thirdTournamentSourceId = jsonConvert.convert<String>(
      json['thirdTournamentSourceId']);
  if (thirdTournamentSourceId != null) {
    historicalPerformancePBBeanEntity.thirdTournamentSourceId =
        thirdTournamentSourceId;
  }
  final double? winPercent = jsonConvert.convert<double>(json['winPercent']);
  if (winPercent != null) {
    historicalPerformancePBBeanEntity.winPercent = winPercent;
  }
  return historicalPerformancePBBeanEntity;
}

Map<String, dynamic> $HistoricalPerformancePBBeanEntityToJson(
    HistoricalPerformancePBBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['averageGoal'] = entity.averageGoal;
  data['averageGoalPercent'] = entity.averageGoalPercent;
  data['bothGoalPercent'] = entity.bothGoalPercent;
  data['createTime'] = entity.createTime;
  data['teamLogo'] = entity.teamLogo;
  data['name2'] = entity.name2;
  data['name4'] = entity.name4;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['expressingType'] = entity.expressingType;
  data['expressionRanking'] = entity.expressionRanking;
  data['fifthStatus'] = entity.fifthStatus;
  data['firstGoalPercent'] = entity.firstGoalPercent;
  data['firstStatus'] = entity.firstStatus;
  data['fourthStatus'] = entity.fourthStatus;
  data['goalPercent'] = entity.goalPercent;
  data['goalXg'] = entity.goalXg;
  data['goalXga'] = entity.goalXga;
  data['goalsForTotal'] = entity.goalsForTotal;
  data['id'] = entity.id;
  data['lostGoalPercent'] = entity.lostGoalPercent;
  data['modifyTime'] = entity.modifyTime;
  data['notLostPercent'] = entity.notLostPercent;
  data['secondStatus'] = entity.secondStatus;
  data['sportId'] = entity.sportId;
  data['standardTeamId'] = entity.standardTeamId;
  data['teamCnName'] = entity.teamCnName;
  data['teamEnName'] = entity.teamEnName;
  data['thirdStatus'] = entity.thirdStatus;
  data['thirdTeamSourceId'] = entity.thirdTeamSourceId;
  data['thirdTournamentSourceId'] = entity.thirdTournamentSourceId;
  data['winPercent'] = entity.winPercent;
  return data;
}

extension HistoricalPerformancePBBeanEntityExtension on HistoricalPerformancePBBeanEntity {
  HistoricalPerformancePBBeanEntity copyWith({
    double? averageGoal,
    double? averageGoalPercent,
    double? bothGoalPercent,
    String? createTime,
    String? teamLogo,
    List<int>? name2,
    String? name4,
    String? dataSourceCode,
    int? expressingType,
    String? expressionRanking,
    int? fifthStatus,
    double? firstGoalPercent,
    int? firstStatus,
    int? fourthStatus,
    double? goalPercent,
    double? goalXg,
    double? goalXga,
    int? goalsForTotal,
    String? id,
    double? lostGoalPercent,
    String? modifyTime,
    double? notLostPercent,
    int? secondStatus,
    String? sportId,
    String? standardTeamId,
    String? teamCnName,
    String? teamEnName,
    int? thirdStatus,
    String? thirdTeamSourceId,
    String? thirdTournamentSourceId,
    double? winPercent,
  }) {
    return HistoricalPerformancePBBeanEntity()
      ..averageGoal = averageGoal ?? this.averageGoal
      ..averageGoalPercent = averageGoalPercent ?? this.averageGoalPercent
      ..bothGoalPercent = bothGoalPercent ?? this.bothGoalPercent
      ..createTime = createTime ?? this.createTime
      ..teamLogo = teamLogo ?? this.teamLogo
      ..name2 = name2 ?? this.name2
      ..name4 = name4 ?? this.name4
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..expressingType = expressingType ?? this.expressingType
      ..expressionRanking = expressionRanking ?? this.expressionRanking
      ..fifthStatus = fifthStatus ?? this.fifthStatus
      ..firstGoalPercent = firstGoalPercent ?? this.firstGoalPercent
      ..firstStatus = firstStatus ?? this.firstStatus
      ..fourthStatus = fourthStatus ?? this.fourthStatus
      ..goalPercent = goalPercent ?? this.goalPercent
      ..goalXg = goalXg ?? this.goalXg
      ..goalXga = goalXga ?? this.goalXga
      ..goalsForTotal = goalsForTotal ?? this.goalsForTotal
      ..id = id ?? this.id
      ..lostGoalPercent = lostGoalPercent ?? this.lostGoalPercent
      ..modifyTime = modifyTime ?? this.modifyTime
      ..notLostPercent = notLostPercent ?? this.notLostPercent
      ..secondStatus = secondStatus ?? this.secondStatus
      ..sportId = sportId ?? this.sportId
      ..standardTeamId = standardTeamId ?? this.standardTeamId
      ..teamCnName = teamCnName ?? this.teamCnName
      ..teamEnName = teamEnName ?? this.teamEnName
      ..thirdStatus = thirdStatus ?? this.thirdStatus
      ..thirdTeamSourceId = thirdTeamSourceId ?? this.thirdTeamSourceId
      ..thirdTournamentSourceId = thirdTournamentSourceId ??
          this.thirdTournamentSourceId
      ..winPercent = winPercent ?? this.winPercent;
  }
}