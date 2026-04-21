
import 'match_entity.dart';

class MatchAllEntity {
  List<MatchEntity>? eSports;
  List<MatchEntity>? general;
  List<MatchEntity>? electronic;

  MatchAllEntity({
    this.eSports,
    this.general,
    this.electronic,
  });

  factory MatchAllEntity.fromJson(Map<String, dynamic> json) => MatchAllEntity(
    eSports: json["eSports"] == null ? [] : List<MatchEntity>.from(json["eSports"]!.map((x) => MatchEntity.fromJson(x))),
    general: json["general"] == null ? [] : List<MatchEntity>.from(json["general"]!.map((x) => MatchEntity.fromJson(x))),
    electronic: json["electronic"] == null ? [] : List<MatchEntity>.from(json["electronic"]!.map((x) => MatchEntity.fromJson(x))),
  );
}