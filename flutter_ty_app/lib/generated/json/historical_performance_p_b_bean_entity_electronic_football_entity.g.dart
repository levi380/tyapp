import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/historical_performance_p_b_bean_entity_electronic_football_entity.dart';

HistoricalPerformancePBBeanEntityElectronicFootballEntity $HistoricalPerformancePBBeanEntityElectronicFootballEntityFromJson(
    Map<String, dynamic> json) {
  final HistoricalPerformancePBBeanEntityElectronicFootballEntity historicalPerformancePBBeanEntityElectronicFootballEntity = HistoricalPerformancePBBeanEntityElectronicFootballEntity();
  final List<int>? summary = (json['summary'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (summary != null) {
    historicalPerformancePBBeanEntityElectronicFootballEntity.summary = summary;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    historicalPerformancePBBeanEntityElectronicFootballEntity.awayName =
        awayName;
  }
  final List<int>? away = (json['away'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (away != null) {
    historicalPerformancePBBeanEntityElectronicFootballEntity.away = away;
  }
  final double? homeAvg = jsonConvert.convert<double>(json['homeAvg']);
  if (homeAvg != null) {
    historicalPerformancePBBeanEntityElectronicFootballEntity.homeAvg = homeAvg;
  }
  final String? flag = jsonConvert.convert<String>(json['flag']);
  if (flag != null) {
    historicalPerformancePBBeanEntityElectronicFootballEntity.flag = flag;
  }
  final String? mhlu = jsonConvert.convert<String>(json['mhlu']);
  if (mhlu != null) {
    historicalPerformancePBBeanEntityElectronicFootballEntity.mhlu = mhlu;
  }
  final double? awayAvg = jsonConvert.convert<double>(json['awayAvg']);
  if (awayAvg != null) {
    historicalPerformancePBBeanEntityElectronicFootballEntity.awayAvg = awayAvg;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    historicalPerformancePBBeanEntityElectronicFootballEntity.homeName =
        homeName;
  }
  final String? team = jsonConvert.convert<String>(json['team']);
  if (team != null) {
    historicalPerformancePBBeanEntityElectronicFootballEntity.team = team;
  }
  final double? summaryAvg = jsonConvert.convert<double>(json['summaryAvg']);
  if (summaryAvg != null) {
    historicalPerformancePBBeanEntityElectronicFootballEntity.summaryAvg =
        summaryAvg;
  }
  final String? malu = jsonConvert.convert<String>(json['malu']);
  if (malu != null) {
    historicalPerformancePBBeanEntityElectronicFootballEntity.malu = malu;
  }
  final List<int>? home = (json['home'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (home != null) {
    historicalPerformancePBBeanEntityElectronicFootballEntity.home = home;
  }
  return historicalPerformancePBBeanEntityElectronicFootballEntity;
}

Map<String,
    dynamic> $HistoricalPerformancePBBeanEntityElectronicFootballEntityToJson(
    HistoricalPerformancePBBeanEntityElectronicFootballEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['summary'] = entity.summary;
  data['awayName'] = entity.awayName;
  data['away'] = entity.away;
  data['homeAvg'] = entity.homeAvg;
  data['flag'] = entity.flag;
  data['mhlu'] = entity.mhlu;
  data['awayAvg'] = entity.awayAvg;
  data['homeName'] = entity.homeName;
  data['team'] = entity.team;
  data['summaryAvg'] = entity.summaryAvg;
  data['malu'] = entity.malu;
  data['home'] = entity.home;
  return data;
}

extension HistoricalPerformancePBBeanEntityElectronicFootballEntityExtension on HistoricalPerformancePBBeanEntityElectronicFootballEntity {
  HistoricalPerformancePBBeanEntityElectronicFootballEntity copyWith({
    List<int>? summary,
    String? awayName,
    List<int>? away,
    double? homeAvg,
    String? flag,
    String? mhlu,
    double? awayAvg,
    String? homeName,
    String? team,
    double? summaryAvg,
    String? malu,
    List<int>? home,
  }) {
    return HistoricalPerformancePBBeanEntityElectronicFootballEntity()
      ..summary = summary ?? this.summary
      ..awayName = awayName ?? this.awayName
      ..away = away ?? this.away
      ..homeAvg = homeAvg ?? this.homeAvg
      ..flag = flag ?? this.flag
      ..mhlu = mhlu ?? this.mhlu
      ..awayAvg = awayAvg ?? this.awayAvg
      ..homeName = homeName ?? this.homeName
      ..team = team ?? this.team
      ..summaryAvg = summaryAvg ?? this.summaryAvg
      ..malu = malu ?? this.malu
      ..home = home ?? this.home;
  }
}