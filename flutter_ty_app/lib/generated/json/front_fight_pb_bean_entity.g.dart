import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/front_fight_pb_bean_entity.dart';

FrontFightPbBeanEntity $FrontFightPbBeanEntityFromJson(
    Map<String, dynamic> json) {
  final FrontFightPbBeanEntity frontFightPbBeanEntity = FrontFightPbBeanEntity();
  final double? averageGoal = jsonConvert.convert<double>(json['averageGoal']);
  if (averageGoal != null) {
    frontFightPbBeanEntity.averageGoal = averageGoal;
  }
  final double? averageGoalPercent = jsonConvert.convert<double>(
      json['averageGoalPercent']);
  if (averageGoalPercent != null) {
    frontFightPbBeanEntity.averageGoalPercent = averageGoalPercent;
  }
  final double? bothGoalPercent = jsonConvert.convert<double>(
      json['bothGoalPercent']);
  if (bothGoalPercent != null) {
    frontFightPbBeanEntity.bothGoalPercent = bothGoalPercent;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    frontFightPbBeanEntity.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    frontFightPbBeanEntity.dataSourceCode = dataSourceCode;
  }
  final int? expressingType = jsonConvert.convert<int>(json['expressingType']);
  if (expressingType != null) {
    frontFightPbBeanEntity.expressingType = expressingType;
  }
  final String? expressionRanking = jsonConvert.convert<String>(
      json['expressionRanking']);
  if (expressionRanking != null) {
    frontFightPbBeanEntity.expressionRanking = expressionRanking;
  }
  final int? fifthStatus = jsonConvert.convert<int>(json['fifthStatus']);
  if (fifthStatus != null) {
    frontFightPbBeanEntity.fifthStatus = fifthStatus;
  }
  final double? firstGoalPercent = jsonConvert.convert<double>(
      json['firstGoalPercent']);
  if (firstGoalPercent != null) {
    frontFightPbBeanEntity.firstGoalPercent = firstGoalPercent;
  }
  final int? firstStatus = jsonConvert.convert<int>(json['firstStatus']);
  if (firstStatus != null) {
    frontFightPbBeanEntity.firstStatus = firstStatus;
  }
  final int? fourthStatus = jsonConvert.convert<int>(json['fourthStatus']);
  if (fourthStatus != null) {
    frontFightPbBeanEntity.fourthStatus = fourthStatus;
  }
  final double? goalPercent = jsonConvert.convert<double>(json['goalPercent']);
  if (goalPercent != null) {
    frontFightPbBeanEntity.goalPercent = goalPercent;
  }
  final double? goalXg = jsonConvert.convert<double>(json['goalXg']);
  if (goalXg != null) {
    frontFightPbBeanEntity.goalXg = goalXg;
  }
  final double? goalXga = jsonConvert.convert<double>(json['goalXga']);
  if (goalXga != null) {
    frontFightPbBeanEntity.goalXga = goalXga;
  }
  final int? goalsForTotal = jsonConvert.convert<int>(json['goalsForTotal']);
  if (goalsForTotal != null) {
    frontFightPbBeanEntity.goalsForTotal = goalsForTotal;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontFightPbBeanEntity.id = id;
  }
  final double? lostGoalPercent = jsonConvert.convert<double>(
      json['lostGoalPercent']);
  if (lostGoalPercent != null) {
    frontFightPbBeanEntity.lostGoalPercent = lostGoalPercent;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    frontFightPbBeanEntity.modifyTime = modifyTime;
  }
  final double? notLostPercent = jsonConvert.convert<double>(
      json['notLostPercent']);
  if (notLostPercent != null) {
    frontFightPbBeanEntity.notLostPercent = notLostPercent;
  }
  final int? secondStatus = jsonConvert.convert<int>(json['secondStatus']);
  if (secondStatus != null) {
    frontFightPbBeanEntity.secondStatus = secondStatus;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    frontFightPbBeanEntity.sportId = sportId;
  }
  final String? standardTeamId = jsonConvert.convert<String>(
      json['standardTeamId']);
  if (standardTeamId != null) {
    frontFightPbBeanEntity.standardTeamId = standardTeamId;
  }
  final String? teamCnName = jsonConvert.convert<String>(json['teamCnName']);
  if (teamCnName != null) {
    frontFightPbBeanEntity.teamCnName = teamCnName;
  }
  final String? teamEnName = jsonConvert.convert<String>(json['teamEnName']);
  if (teamEnName != null) {
    frontFightPbBeanEntity.teamEnName = teamEnName;
  }
  final int? thirdStatus = jsonConvert.convert<int>(json['thirdStatus']);
  if (thirdStatus != null) {
    frontFightPbBeanEntity.thirdStatus = thirdStatus;
  }
  final String? thirdTeamSourceId = jsonConvert.convert<String>(
      json['thirdTeamSourceId']);
  if (thirdTeamSourceId != null) {
    frontFightPbBeanEntity.thirdTeamSourceId = thirdTeamSourceId;
  }
  final String? thirdTournamentSourceId = jsonConvert.convert<String>(
      json['thirdTournamentSourceId']);
  if (thirdTournamentSourceId != null) {
    frontFightPbBeanEntity.thirdTournamentSourceId = thirdTournamentSourceId;
  }
  final double? winPercent = jsonConvert.convert<double>(json['winPercent']);
  if (winPercent != null) {
    frontFightPbBeanEntity.winPercent = winPercent;
  }
  return frontFightPbBeanEntity;
}

Map<String, dynamic> $FrontFightPbBeanEntityToJson(
    FrontFightPbBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['averageGoal'] = entity.averageGoal;
  data['averageGoalPercent'] = entity.averageGoalPercent;
  data['bothGoalPercent'] = entity.bothGoalPercent;
  data['createTime'] = entity.createTime;
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

extension FrontFightPbBeanEntityExtension on FrontFightPbBeanEntity {
  FrontFightPbBeanEntity copyWith({
    double? averageGoal,
    double? averageGoalPercent,
    double? bothGoalPercent,
    String? createTime,
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
    return FrontFightPbBeanEntity()
      ..averageGoal = averageGoal ?? this.averageGoal
      ..averageGoalPercent = averageGoalPercent ?? this.averageGoalPercent
      ..bothGoalPercent = bothGoalPercent ?? this.bothGoalPercent
      ..createTime = createTime ?? this.createTime
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