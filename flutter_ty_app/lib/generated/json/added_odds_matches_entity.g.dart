import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/added_odds_matches_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


AddedOddsMatchesEntity $AddedOddsMatchesEntityFromJson(
    Map<String, dynamic> json) {
  final AddedOddsMatchesEntity addedOddsMatchesEntity = AddedOddsMatchesEntity();
  final List<MatchEntity>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MatchEntity>(e) as MatchEntity).toList();
  if (data != null) {
    addedOddsMatchesEntity.data = data;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    addedOddsMatchesEntity.count = count;
  }
  return addedOddsMatchesEntity;
}

Map<String, dynamic> $AddedOddsMatchesEntityToJson(
    AddedOddsMatchesEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['count'] = entity.count;
  return data;
}

extension AddedOddsMatchesEntityExtension on AddedOddsMatchesEntity {
  AddedOddsMatchesEntity copyWith({
    List<MatchEntity>? data,
    int? count,
  }) {
    return AddedOddsMatchesEntity()
      ..data = data ?? this.data
      ..count = count ?? this.count;
  }
}