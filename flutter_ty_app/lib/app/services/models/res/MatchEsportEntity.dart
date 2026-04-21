
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

class MatchEsportEntity {
    List<MatchEntity>? esportMatchs;
    List<MatchEntity>? matchs;

    MatchEsportEntity({
        this.esportMatchs,
        this.matchs,
    });

    factory MatchEsportEntity.fromJson(Map<String, dynamic> json) => MatchEsportEntity(
        esportMatchs: json["esportMatchs"] == null ? [] : List<MatchEntity>.from(json["esportMatchs"]!.map((x) => MatchEntity.fromJson(x))),
        matchs: json["matchs"] == null ? [] : List<MatchEntity>.from(json["matchs"]!.map((x) => MatchEntity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "esportMatchs": esportMatchs == null ? [] : List<dynamic>.from(esportMatchs!.map((x) => x.toJson())),
        "matchs": matchs == null ? [] : List<dynamic>.from(matchs!.map((x) => x.toJson())),
    };
}
