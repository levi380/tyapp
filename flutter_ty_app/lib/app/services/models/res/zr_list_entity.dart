import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/zr_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/zr_list_entity.g.dart';

@JsonSerializable()
class ZrListEntity {
  late String bootNo;
  ZrListBootReport? bootReport;
  late String countdownEndTime;
  late String dealerCountry = "";
  late String dealerEntertainPic = "";
  late String dealerId;
  late String dealerName = "";
  late String dealerPic = "";
  late String dealerPicInstant = '';
  late String dealerPicTable;
  late int gameCasinoId;
  late int gameStatus;
  late String gameTypeId;
  late String gameTypeName;
  List<ZrListGoodRoadPoints>? goodRoadPoints;
  late String goodRoads;
  late String phonePicTable;
  late String physicsTableNo;
  ZrListRoadPaper? roadPaper;
  late String roundId;
  dynamic roundNo;
  late String serverTime;
  late String tableAnchorHeadPictureUrl;
  dynamic tableAnchorId;
  late String tableAnchorName;
  late String tableId;
  late String tableLimitMax;
  late String tableLimitMin;
  dynamic tableLimits;
  late ZrListTableNameLanguageMap tableNameLanguageMap;
  late ZrListTableOnline tableOnline;
  late bool tableOpen;
  late String totalBetCountDown;
  late String videoUrl;

  ZrListEntity();

  factory ZrListEntity.fromJson(Map<String, dynamic> json) => $ZrListEntityFromJson(json);

  Map<String, dynamic> toJson() => $ZrListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZrListBootReport {
  late List<ZrListBootReportItems> items;
  late int totalCount;

  ZrListBootReport();

  factory ZrListBootReport.fromJson(Map<String, dynamic> json) => $ZrListBootReportFromJson(json);

  Map<String, dynamic> toJson() => $ZrListBootReportToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZrListBootReportItems {
  late int betPointId;
  late String betPointName;
  late int winCount;

  ZrListBootReportItems();

  factory ZrListBootReportItems.fromJson(Map<String, dynamic> json) => $ZrListBootReportItemsFromJson(json);

  Map<String, dynamic> toJson() => $ZrListBootReportItemsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZrListGoodRoadPoints {
  late bool betPoint;
  late bool goodRoadFlag;
  late int goodRoadType;
  int? num;
  late bool putPoint;
  late int sort;

  ZrListGoodRoadPoints();

  factory ZrListGoodRoadPoints.fromJson(Map<String, dynamic> json) => $ZrListGoodRoadPointsFromJson(json);

  Map<String, dynamic> toJson() => $ZrListGoodRoadPointsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZrListRoadPaper {
  late String beatPlateRoad;
  late String bigEyeBoy;
  late String bigPairRoad;
  late String bigRoad;
  late String bigSmallPlateRoad;
  late String cockroachPig;
  late String dragonBonusPlateRoad;
  late String newBigPairRoad;
  late String smallRoad;
  late String winPointPlateRoad;

  ZrListRoadPaper();

  factory ZrListRoadPaper.fromJson(Map<String, dynamic> json) => $ZrListRoadPaperFromJson(json);

  Map<String, dynamic> toJson() => $ZrListRoadPaperToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZrListTableNameLanguageMap {
  late ZrListTableNameLanguageMapVi vi;
  late ZrListTableNameLanguageMapTh th;
  late ZrListTableNameLanguageMapKr kr;
  late ZrListTableNameLanguageMapEn en;
  late ZrListTableNameLanguageMapCn cn;
  late ZrListTableNameLanguageMapTc tc;

  ZrListTableNameLanguageMap();

  factory ZrListTableNameLanguageMap.fromJson(Map<String, dynamic> json) => $ZrListTableNameLanguageMapFromJson(json);

  Map<String, dynamic> toJson() => $ZrListTableNameLanguageMapToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZrListTableNameLanguageMapVi {
  late String languageCode;
  late String content;

  ZrListTableNameLanguageMapVi();

  factory ZrListTableNameLanguageMapVi.fromJson(Map<String, dynamic> json) =>
      $ZrListTableNameLanguageMapViFromJson(json);

  Map<String, dynamic> toJson() => $ZrListTableNameLanguageMapViToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZrListTableNameLanguageMapTh {
  late String languageCode;
  late String content;

  ZrListTableNameLanguageMapTh();

  factory ZrListTableNameLanguageMapTh.fromJson(Map<String, dynamic> json) =>
      $ZrListTableNameLanguageMapThFromJson(json);

  Map<String, dynamic> toJson() => $ZrListTableNameLanguageMapThToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZrListTableNameLanguageMapKr {
  late String languageCode;
  late String content;

  ZrListTableNameLanguageMapKr();

  factory ZrListTableNameLanguageMapKr.fromJson(Map<String, dynamic> json) =>
      $ZrListTableNameLanguageMapKrFromJson(json);

  Map<String, dynamic> toJson() => $ZrListTableNameLanguageMapKrToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZrListTableNameLanguageMapEn {
  late String languageCode;
  late String content;

  ZrListTableNameLanguageMapEn();

  factory ZrListTableNameLanguageMapEn.fromJson(Map<String, dynamic> json) =>
      $ZrListTableNameLanguageMapEnFromJson(json);

  Map<String, dynamic> toJson() => $ZrListTableNameLanguageMapEnToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZrListTableNameLanguageMapCn {
  late String languageCode;
  late String content;

  ZrListTableNameLanguageMapCn();

  factory ZrListTableNameLanguageMapCn.fromJson(Map<String, dynamic> json) =>
      $ZrListTableNameLanguageMapCnFromJson(json);

  Map<String, dynamic> toJson() => $ZrListTableNameLanguageMapCnToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZrListTableNameLanguageMapTc {
  late String languageCode;
  late String content;

  ZrListTableNameLanguageMapTc();

  factory ZrListTableNameLanguageMapTc.fromJson(Map<String, dynamic> json) =>
      $ZrListTableNameLanguageMapTcFromJson(json);

  Map<String, dynamic> toJson() => $ZrListTableNameLanguageMapTcToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZrListTableOnline {
  late String onlineNumber;
  late String totalAmount;

  ZrListTableOnline();

  factory ZrListTableOnline.fromJson(Map<String, dynamic> json) => $ZrListTableOnlineFromJson(json);

  Map<String, dynamic> toJson() => $ZrListTableOnlineToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
