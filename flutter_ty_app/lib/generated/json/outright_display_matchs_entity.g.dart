import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/outright_display_matchs_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


OutrightDisplayMatchsEntity $OutrightDisplayMatchsEntityFromJson(
    Map<String, dynamic> json) {
  final OutrightDisplayMatchsEntity outrightDisplayMatchsEntity = OutrightDisplayMatchsEntity();
  final List<
      OutrightDisplayMatchsHandicaplist>? handicaplist = (json['handicaplist'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<OutrightDisplayMatchsHandicaplist>(
          e) as OutrightDisplayMatchsHandicaplist).toList();
  if (handicaplist != null) {
    outrightDisplayMatchsEntity.handicaplist = handicaplist;
  }
  final List<MatchEntity>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MatchEntity>(e) as MatchEntity).toList();
  if (data != null) {
    outrightDisplayMatchsEntity.data = data;
  }
  return outrightDisplayMatchsEntity;
}

Map<String, dynamic> $OutrightDisplayMatchsEntityToJson(
    OutrightDisplayMatchsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['handicaplist'] = entity.handicaplist.map((v) => v.toJson()).toList();
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

extension OutrightDisplayMatchsEntityExtension on OutrightDisplayMatchsEntity {
  OutrightDisplayMatchsEntity copyWith({
    List<OutrightDisplayMatchsHandicaplist>? handicaplist,
    List<MatchEntity>? data,
  }) {
    return OutrightDisplayMatchsEntity()
      ..handicaplist = handicaplist ?? this.handicaplist
      ..data = data ?? this.data;
  }
}

OutrightDisplayMatchsHandicaplist $OutrightDisplayMatchsHandicaplistFromJson(
    Map<String, dynamic> json) {
  final OutrightDisplayMatchsHandicaplist outrightDisplayMatchsHandicaplist = OutrightDisplayMatchsHandicaplist();
  final String? linkId = jsonConvert.convert<String>(json['linkId']);
  if (linkId != null) {
    outrightDisplayMatchsHandicaplist.linkId = linkId;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    outrightDisplayMatchsHandicaplist.matchId = matchId;
  }
  final int? relationStatus = jsonConvert.convert<int>(json['relationStatus']);
  if (relationStatus != null) {
    outrightDisplayMatchsHandicaplist.relationStatus = relationStatus;
  }
  final String? standardMarketId = jsonConvert.convert<String>(
      json['standardMarketId']);
  if (standardMarketId != null) {
    outrightDisplayMatchsHandicaplist.standardMarketId = standardMarketId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    outrightDisplayMatchsHandicaplist.tournamentId = tournamentId;
  }
  return outrightDisplayMatchsHandicaplist;
}

Map<String, dynamic> $OutrightDisplayMatchsHandicaplistToJson(
    OutrightDisplayMatchsHandicaplist entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['linkId'] = entity.linkId;
  data['matchId'] = entity.matchId;
  data['relationStatus'] = entity.relationStatus;
  data['standardMarketId'] = entity.standardMarketId;
  data['tournamentId'] = entity.tournamentId;
  return data;
}

extension OutrightDisplayMatchsHandicaplistExtension on OutrightDisplayMatchsHandicaplist {
  OutrightDisplayMatchsHandicaplist copyWith({
    String? linkId,
    String? matchId,
    int? relationStatus,
    String? standardMarketId,
    String? tournamentId,
  }) {
    return OutrightDisplayMatchsHandicaplist()
      ..linkId = linkId ?? this.linkId
      ..matchId = matchId ?? this.matchId
      ..relationStatus = relationStatus ?? this.relationStatus
      ..standardMarketId = standardMarketId ?? this.standardMarketId
      ..tournamentId = tournamentId ?? this.tournamentId;
  }
}