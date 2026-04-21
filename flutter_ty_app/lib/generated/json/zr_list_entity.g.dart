import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_list_entity.dart';

ZrListEntity $ZrListEntityFromJson(Map<String, dynamic> json) {
  final ZrListEntity zrListEntity = ZrListEntity();
  final String? bootNo = jsonConvert.convert<String>(json['bootNo']);
  if (bootNo != null) {
    zrListEntity.bootNo = bootNo;
  }
  final ZrListBootReport? bootReport = jsonConvert.convert<ZrListBootReport>(
      json['bootReport']);
  if (bootReport != null) {
    zrListEntity.bootReport = bootReport;
  }
  final String? countdownEndTime = jsonConvert.convert<String>(
      json['countdownEndTime']);
  if (countdownEndTime != null) {
    zrListEntity.countdownEndTime = countdownEndTime;
  }
  final String? dealerCountry = jsonConvert.convert<String>(
      json['dealerCountry']);
  if (dealerCountry != null) {
    zrListEntity.dealerCountry = dealerCountry;
  }
  final String? dealerEntertainPic = jsonConvert.convert<String>(
      json['dealerEntertainPic']);
  if (dealerEntertainPic != null) {
    zrListEntity.dealerEntertainPic = dealerEntertainPic;
  }
  final String? dealerId = jsonConvert.convert<String>(json['dealerId']);
  if (dealerId != null) {
    zrListEntity.dealerId = dealerId;
  }
  final String? dealerName = jsonConvert.convert<String>(json['dealerName']);
  if (dealerName != null) {
    zrListEntity.dealerName = dealerName;
  }
  final String? dealerPic = jsonConvert.convert<String>(json['dealerPic']);
  if (dealerPic != null) {
    zrListEntity.dealerPic = dealerPic;
  }
  final String? dealerPicInstant = jsonConvert.convert<String>(
      json['dealerPicInstant']);
  if (dealerPicInstant != null) {
    zrListEntity.dealerPicInstant = dealerPicInstant;
  }
  final String? dealerPicTable = jsonConvert.convert<String>(
      json['dealerPicTable']);
  if (dealerPicTable != null) {
    zrListEntity.dealerPicTable = dealerPicTable;
  }
  final int? gameCasinoId = jsonConvert.convert<int>(json['gameCasinoId']);
  if (gameCasinoId != null) {
    zrListEntity.gameCasinoId = gameCasinoId;
  }
  final int? gameStatus = jsonConvert.convert<int>(json['gameStatus']);
  if (gameStatus != null) {
    zrListEntity.gameStatus = gameStatus;
  }
  final String? gameTypeId = jsonConvert.convert<String>(json['gameTypeId']);
  if (gameTypeId != null) {
    zrListEntity.gameTypeId = gameTypeId;
  }
  final String? gameTypeName = jsonConvert.convert<String>(
      json['gameTypeName']);
  if (gameTypeName != null) {
    zrListEntity.gameTypeName = gameTypeName;
  }
  final List<
      ZrListGoodRoadPoints>? goodRoadPoints = (json['goodRoadPoints'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ZrListGoodRoadPoints>(e) as ZrListGoodRoadPoints)
      .toList();
  if (goodRoadPoints != null) {
    zrListEntity.goodRoadPoints = goodRoadPoints;
  }
  final String? goodRoads = jsonConvert.convert<String>(json['goodRoads']);
  if (goodRoads != null) {
    zrListEntity.goodRoads = goodRoads;
  }
  final String? phonePicTable = jsonConvert.convert<String>(
      json['phonePicTable']);
  if (phonePicTable != null) {
    zrListEntity.phonePicTable = phonePicTable;
  }
  final String? physicsTableNo = jsonConvert.convert<String>(
      json['physicsTableNo']);
  if (physicsTableNo != null) {
    zrListEntity.physicsTableNo = physicsTableNo;
  }
  final ZrListRoadPaper? roadPaper = jsonConvert.convert<ZrListRoadPaper>(
      json['roadPaper']);
  if (roadPaper != null) {
    zrListEntity.roadPaper = roadPaper;
  }
  final String? roundId = jsonConvert.convert<String>(json['roundId']);
  if (roundId != null) {
    zrListEntity.roundId = roundId;
  }
  final dynamic roundNo = json['roundNo'];
  if (roundNo != null) {
    zrListEntity.roundNo = roundNo;
  }
  final String? serverTime = jsonConvert.convert<String>(json['serverTime']);
  if (serverTime != null) {
    zrListEntity.serverTime = serverTime;
  }
  final String? tableAnchorHeadPictureUrl = jsonConvert.convert<String>(
      json['tableAnchorHeadPictureUrl']);
  if (tableAnchorHeadPictureUrl != null) {
    zrListEntity.tableAnchorHeadPictureUrl = tableAnchorHeadPictureUrl;
  }
  final dynamic tableAnchorId = json['tableAnchorId'];
  if (tableAnchorId != null) {
    zrListEntity.tableAnchorId = tableAnchorId;
  }
  final String? tableAnchorName = jsonConvert.convert<String>(
      json['tableAnchorName']);
  if (tableAnchorName != null) {
    zrListEntity.tableAnchorName = tableAnchorName;
  }
  final String? tableId = jsonConvert.convert<String>(json['tableId']);
  if (tableId != null) {
    zrListEntity.tableId = tableId;
  }
  final String? tableLimitMax = jsonConvert.convert<String>(
      json['tableLimitMax']);
  if (tableLimitMax != null) {
    zrListEntity.tableLimitMax = tableLimitMax;
  }
  final String? tableLimitMin = jsonConvert.convert<String>(
      json['tableLimitMin']);
  if (tableLimitMin != null) {
    zrListEntity.tableLimitMin = tableLimitMin;
  }
  final dynamic tableLimits = json['tableLimits'];
  if (tableLimits != null) {
    zrListEntity.tableLimits = tableLimits;
  }
  final ZrListTableNameLanguageMap? tableNameLanguageMap = jsonConvert.convert<
      ZrListTableNameLanguageMap>(json['tableNameLanguageMap']);
  if (tableNameLanguageMap != null) {
    zrListEntity.tableNameLanguageMap = tableNameLanguageMap;
  }
  final ZrListTableOnline? tableOnline = jsonConvert.convert<ZrListTableOnline>(
      json['tableOnline']);
  if (tableOnline != null) {
    zrListEntity.tableOnline = tableOnline;
  }
  final bool? tableOpen = jsonConvert.convert<bool>(json['tableOpen']);
  if (tableOpen != null) {
    zrListEntity.tableOpen = tableOpen;
  }
  final String? totalBetCountDown = jsonConvert.convert<String>(
      json['totalBetCountDown']);
  if (totalBetCountDown != null) {
    zrListEntity.totalBetCountDown = totalBetCountDown;
  }
  final String? videoUrl = jsonConvert.convert<String>(json['videoUrl']);
  if (videoUrl != null) {
    zrListEntity.videoUrl = videoUrl;
  }
  return zrListEntity;
}

Map<String, dynamic> $ZrListEntityToJson(ZrListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['bootNo'] = entity.bootNo;
  data['bootReport'] = entity.bootReport?.toJson();
  data['countdownEndTime'] = entity.countdownEndTime;
  data['dealerCountry'] = entity.dealerCountry;
  data['dealerEntertainPic'] = entity.dealerEntertainPic;
  data['dealerId'] = entity.dealerId;
  data['dealerName'] = entity.dealerName;
  data['dealerPic'] = entity.dealerPic;
  data['dealerPicInstant'] = entity.dealerPicInstant;
  data['dealerPicTable'] = entity.dealerPicTable;
  data['gameCasinoId'] = entity.gameCasinoId;
  data['gameStatus'] = entity.gameStatus;
  data['gameTypeId'] = entity.gameTypeId;
  data['gameTypeName'] = entity.gameTypeName;
  data['goodRoadPoints'] =
      entity.goodRoadPoints?.map((v) => v.toJson()).toList();
  data['goodRoads'] = entity.goodRoads;
  data['phonePicTable'] = entity.phonePicTable;
  data['physicsTableNo'] = entity.physicsTableNo;
  data['roadPaper'] = entity.roadPaper?.toJson();
  data['roundId'] = entity.roundId;
  data['roundNo'] = entity.roundNo;
  data['serverTime'] = entity.serverTime;
  data['tableAnchorHeadPictureUrl'] = entity.tableAnchorHeadPictureUrl;
  data['tableAnchorId'] = entity.tableAnchorId;
  data['tableAnchorName'] = entity.tableAnchorName;
  data['tableId'] = entity.tableId;
  data['tableLimitMax'] = entity.tableLimitMax;
  data['tableLimitMin'] = entity.tableLimitMin;
  data['tableLimits'] = entity.tableLimits;
  data['tableNameLanguageMap'] = entity.tableNameLanguageMap.toJson();
  data['tableOnline'] = entity.tableOnline.toJson();
  data['tableOpen'] = entity.tableOpen;
  data['totalBetCountDown'] = entity.totalBetCountDown;
  data['videoUrl'] = entity.videoUrl;
  return data;
}

extension ZrListEntityExtension on ZrListEntity {
  ZrListEntity copyWith({
    String? bootNo,
    ZrListBootReport? bootReport,
    String? countdownEndTime,
    String? dealerCountry,
    String? dealerEntertainPic,
    String? dealerId,
    String? dealerName,
    String? dealerPic,
    String? dealerPicInstant,
    String? dealerPicTable,
    int? gameCasinoId,
    int? gameStatus,
    String? gameTypeId,
    String? gameTypeName,
    List<ZrListGoodRoadPoints>? goodRoadPoints,
    String? goodRoads,
    String? phonePicTable,
    String? physicsTableNo,
    ZrListRoadPaper? roadPaper,
    String? roundId,
    dynamic roundNo,
    String? serverTime,
    String? tableAnchorHeadPictureUrl,
    dynamic tableAnchorId,
    String? tableAnchorName,
    String? tableId,
    String? tableLimitMax,
    String? tableLimitMin,
    dynamic tableLimits,
    ZrListTableNameLanguageMap? tableNameLanguageMap,
    ZrListTableOnline? tableOnline,
    bool? tableOpen,
    String? totalBetCountDown,
    String? videoUrl,
  }) {
    return ZrListEntity()
      ..bootNo = bootNo ?? this.bootNo
      ..bootReport = bootReport ?? this.bootReport
      ..countdownEndTime = countdownEndTime ?? this.countdownEndTime
      ..dealerCountry = dealerCountry ?? this.dealerCountry
      ..dealerEntertainPic = dealerEntertainPic ?? this.dealerEntertainPic
      ..dealerId = dealerId ?? this.dealerId
      ..dealerName = dealerName ?? this.dealerName
      ..dealerPic = dealerPic ?? this.dealerPic
      ..dealerPicInstant = dealerPicInstant ?? this.dealerPicInstant
      ..dealerPicTable = dealerPicTable ?? this.dealerPicTable
      ..gameCasinoId = gameCasinoId ?? this.gameCasinoId
      ..gameStatus = gameStatus ?? this.gameStatus
      ..gameTypeId = gameTypeId ?? this.gameTypeId
      ..gameTypeName = gameTypeName ?? this.gameTypeName
      ..goodRoadPoints = goodRoadPoints ?? this.goodRoadPoints
      ..goodRoads = goodRoads ?? this.goodRoads
      ..phonePicTable = phonePicTable ?? this.phonePicTable
      ..physicsTableNo = physicsTableNo ?? this.physicsTableNo
      ..roadPaper = roadPaper ?? this.roadPaper
      ..roundId = roundId ?? this.roundId
      ..roundNo = roundNo ?? this.roundNo
      ..serverTime = serverTime ?? this.serverTime
      ..tableAnchorHeadPictureUrl = tableAnchorHeadPictureUrl ??
          this.tableAnchorHeadPictureUrl
      ..tableAnchorId = tableAnchorId ?? this.tableAnchorId
      ..tableAnchorName = tableAnchorName ?? this.tableAnchorName
      ..tableId = tableId ?? this.tableId
      ..tableLimitMax = tableLimitMax ?? this.tableLimitMax
      ..tableLimitMin = tableLimitMin ?? this.tableLimitMin
      ..tableLimits = tableLimits ?? this.tableLimits
      ..tableNameLanguageMap = tableNameLanguageMap ?? this.tableNameLanguageMap
      ..tableOnline = tableOnline ?? this.tableOnline
      ..tableOpen = tableOpen ?? this.tableOpen
      ..totalBetCountDown = totalBetCountDown ?? this.totalBetCountDown
      ..videoUrl = videoUrl ?? this.videoUrl;
  }
}

ZrListBootReport $ZrListBootReportFromJson(Map<String, dynamic> json) {
  final ZrListBootReport zrListBootReport = ZrListBootReport();
  final List<ZrListBootReportItems>? items = (json['items'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ZrListBootReportItems>(e) as ZrListBootReportItems)
      .toList();
  if (items != null) {
    zrListBootReport.items = items;
  }
  final int? totalCount = jsonConvert.convert<int>(json['totalCount']);
  if (totalCount != null) {
    zrListBootReport.totalCount = totalCount;
  }
  return zrListBootReport;
}

Map<String, dynamic> $ZrListBootReportToJson(ZrListBootReport entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['items'] = entity.items.map((v) => v.toJson()).toList();
  data['totalCount'] = entity.totalCount;
  return data;
}

extension ZrListBootReportExtension on ZrListBootReport {
  ZrListBootReport copyWith({
    List<ZrListBootReportItems>? items,
    int? totalCount,
  }) {
    return ZrListBootReport()
      ..items = items ?? this.items
      ..totalCount = totalCount ?? this.totalCount;
  }
}

ZrListBootReportItems $ZrListBootReportItemsFromJson(
    Map<String, dynamic> json) {
  final ZrListBootReportItems zrListBootReportItems = ZrListBootReportItems();
  final int? betPointId = jsonConvert.convert<int>(json['betPointId']);
  if (betPointId != null) {
    zrListBootReportItems.betPointId = betPointId;
  }
  final String? betPointName = jsonConvert.convert<String>(
      json['betPointName']);
  if (betPointName != null) {
    zrListBootReportItems.betPointName = betPointName;
  }
  final int? winCount = jsonConvert.convert<int>(json['winCount']);
  if (winCount != null) {
    zrListBootReportItems.winCount = winCount;
  }
  return zrListBootReportItems;
}

Map<String, dynamic> $ZrListBootReportItemsToJson(
    ZrListBootReportItems entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betPointId'] = entity.betPointId;
  data['betPointName'] = entity.betPointName;
  data['winCount'] = entity.winCount;
  return data;
}

extension ZrListBootReportItemsExtension on ZrListBootReportItems {
  ZrListBootReportItems copyWith({
    int? betPointId,
    String? betPointName,
    int? winCount,
  }) {
    return ZrListBootReportItems()
      ..betPointId = betPointId ?? this.betPointId
      ..betPointName = betPointName ?? this.betPointName
      ..winCount = winCount ?? this.winCount;
  }
}

ZrListGoodRoadPoints $ZrListGoodRoadPointsFromJson(Map<String, dynamic> json) {
  final ZrListGoodRoadPoints zrListGoodRoadPoints = ZrListGoodRoadPoints();
  final bool? betPoint = jsonConvert.convert<bool>(json['betPoint']);
  if (betPoint != null) {
    zrListGoodRoadPoints.betPoint = betPoint;
  }
  final bool? goodRoadFlag = jsonConvert.convert<bool>(json['goodRoadFlag']);
  if (goodRoadFlag != null) {
    zrListGoodRoadPoints.goodRoadFlag = goodRoadFlag;
  }
  final int? goodRoadType = jsonConvert.convert<int>(json['goodRoadType']);
  if (goodRoadType != null) {
    zrListGoodRoadPoints.goodRoadType = goodRoadType;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    zrListGoodRoadPoints.num = num;
  }
  final bool? putPoint = jsonConvert.convert<bool>(json['putPoint']);
  if (putPoint != null) {
    zrListGoodRoadPoints.putPoint = putPoint;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    zrListGoodRoadPoints.sort = sort;
  }
  return zrListGoodRoadPoints;
}

Map<String, dynamic> $ZrListGoodRoadPointsToJson(ZrListGoodRoadPoints entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betPoint'] = entity.betPoint;
  data['goodRoadFlag'] = entity.goodRoadFlag;
  data['goodRoadType'] = entity.goodRoadType;
  data['num'] = entity.num;
  data['putPoint'] = entity.putPoint;
  data['sort'] = entity.sort;
  return data;
}

extension ZrListGoodRoadPointsExtension on ZrListGoodRoadPoints {
  ZrListGoodRoadPoints copyWith({
    bool? betPoint,
    bool? goodRoadFlag,
    int? goodRoadType,
    int? num,
    bool? putPoint,
    int? sort,
  }) {
    return ZrListGoodRoadPoints()
      ..betPoint = betPoint ?? this.betPoint
      ..goodRoadFlag = goodRoadFlag ?? this.goodRoadFlag
      ..goodRoadType = goodRoadType ?? this.goodRoadType
      ..num = num ?? this.num
      ..putPoint = putPoint ?? this.putPoint
      ..sort = sort ?? this.sort;
  }
}

ZrListRoadPaper $ZrListRoadPaperFromJson(Map<String, dynamic> json) {
  final ZrListRoadPaper zrListRoadPaper = ZrListRoadPaper();
  final String? beatPlateRoad = jsonConvert.convert<String>(
      json['beatPlateRoad']);
  if (beatPlateRoad != null) {
    zrListRoadPaper.beatPlateRoad = beatPlateRoad;
  }
  final String? bigEyeBoy = jsonConvert.convert<String>(json['bigEyeBoy']);
  if (bigEyeBoy != null) {
    zrListRoadPaper.bigEyeBoy = bigEyeBoy;
  }
  final String? bigPairRoad = jsonConvert.convert<String>(json['bigPairRoad']);
  if (bigPairRoad != null) {
    zrListRoadPaper.bigPairRoad = bigPairRoad;
  }
  final String? bigRoad = jsonConvert.convert<String>(json['bigRoad']);
  if (bigRoad != null) {
    zrListRoadPaper.bigRoad = bigRoad;
  }
  final String? bigSmallPlateRoad = jsonConvert.convert<String>(
      json['bigSmallPlateRoad']);
  if (bigSmallPlateRoad != null) {
    zrListRoadPaper.bigSmallPlateRoad = bigSmallPlateRoad;
  }
  final String? cockroachPig = jsonConvert.convert<String>(
      json['cockroachPig']);
  if (cockroachPig != null) {
    zrListRoadPaper.cockroachPig = cockroachPig;
  }
  final String? dragonBonusPlateRoad = jsonConvert.convert<String>(
      json['dragonBonusPlateRoad']);
  if (dragonBonusPlateRoad != null) {
    zrListRoadPaper.dragonBonusPlateRoad = dragonBonusPlateRoad;
  }
  final String? newBigPairRoad = jsonConvert.convert<String>(
      json['newBigPairRoad']);
  if (newBigPairRoad != null) {
    zrListRoadPaper.newBigPairRoad = newBigPairRoad;
  }
  final String? smallRoad = jsonConvert.convert<String>(json['smallRoad']);
  if (smallRoad != null) {
    zrListRoadPaper.smallRoad = smallRoad;
  }
  final String? winPointPlateRoad = jsonConvert.convert<String>(
      json['winPointPlateRoad']);
  if (winPointPlateRoad != null) {
    zrListRoadPaper.winPointPlateRoad = winPointPlateRoad;
  }
  return zrListRoadPaper;
}

Map<String, dynamic> $ZrListRoadPaperToJson(ZrListRoadPaper entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['beatPlateRoad'] = entity.beatPlateRoad;
  data['bigEyeBoy'] = entity.bigEyeBoy;
  data['bigPairRoad'] = entity.bigPairRoad;
  data['bigRoad'] = entity.bigRoad;
  data['bigSmallPlateRoad'] = entity.bigSmallPlateRoad;
  data['cockroachPig'] = entity.cockroachPig;
  data['dragonBonusPlateRoad'] = entity.dragonBonusPlateRoad;
  data['newBigPairRoad'] = entity.newBigPairRoad;
  data['smallRoad'] = entity.smallRoad;
  data['winPointPlateRoad'] = entity.winPointPlateRoad;
  return data;
}

extension ZrListRoadPaperExtension on ZrListRoadPaper {
  ZrListRoadPaper copyWith({
    String? beatPlateRoad,
    String? bigEyeBoy,
    String? bigPairRoad,
    String? bigRoad,
    String? bigSmallPlateRoad,
    String? cockroachPig,
    String? dragonBonusPlateRoad,
    String? newBigPairRoad,
    String? smallRoad,
    String? winPointPlateRoad,
  }) {
    return ZrListRoadPaper()
      ..beatPlateRoad = beatPlateRoad ?? this.beatPlateRoad
      ..bigEyeBoy = bigEyeBoy ?? this.bigEyeBoy
      ..bigPairRoad = bigPairRoad ?? this.bigPairRoad
      ..bigRoad = bigRoad ?? this.bigRoad
      ..bigSmallPlateRoad = bigSmallPlateRoad ?? this.bigSmallPlateRoad
      ..cockroachPig = cockroachPig ?? this.cockroachPig
      ..dragonBonusPlateRoad = dragonBonusPlateRoad ?? this.dragonBonusPlateRoad
      ..newBigPairRoad = newBigPairRoad ?? this.newBigPairRoad
      ..smallRoad = smallRoad ?? this.smallRoad
      ..winPointPlateRoad = winPointPlateRoad ?? this.winPointPlateRoad;
  }
}

ZrListTableNameLanguageMap $ZrListTableNameLanguageMapFromJson(
    Map<String, dynamic> json) {
  final ZrListTableNameLanguageMap zrListTableNameLanguageMap = ZrListTableNameLanguageMap();
  final ZrListTableNameLanguageMapVi? vi = jsonConvert.convert<
      ZrListTableNameLanguageMapVi>(json['vi']);
  if (vi != null) {
    zrListTableNameLanguageMap.vi = vi;
  }
  final ZrListTableNameLanguageMapTh? th = jsonConvert.convert<
      ZrListTableNameLanguageMapTh>(json['th']);
  if (th != null) {
    zrListTableNameLanguageMap.th = th;
  }
  final ZrListTableNameLanguageMapKr? kr = jsonConvert.convert<
      ZrListTableNameLanguageMapKr>(json['kr']);
  if (kr != null) {
    zrListTableNameLanguageMap.kr = kr;
  }
  final ZrListTableNameLanguageMapEn? en = jsonConvert.convert<
      ZrListTableNameLanguageMapEn>(json['en']);
  if (en != null) {
    zrListTableNameLanguageMap.en = en;
  }
  final ZrListTableNameLanguageMapCn? cn = jsonConvert.convert<
      ZrListTableNameLanguageMapCn>(json['cn']);
  if (cn != null) {
    zrListTableNameLanguageMap.cn = cn;
  }
  final ZrListTableNameLanguageMapTc? tc = jsonConvert.convert<
      ZrListTableNameLanguageMapTc>(json['tc']);
  if (tc != null) {
    zrListTableNameLanguageMap.tc = tc;
  }
  return zrListTableNameLanguageMap;
}

Map<String, dynamic> $ZrListTableNameLanguageMapToJson(
    ZrListTableNameLanguageMap entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['vi'] = entity.vi.toJson();
  data['th'] = entity.th.toJson();
  data['kr'] = entity.kr.toJson();
  data['en'] = entity.en.toJson();
  data['cn'] = entity.cn.toJson();
  data['tc'] = entity.tc.toJson();
  return data;
}

extension ZrListTableNameLanguageMapExtension on ZrListTableNameLanguageMap {
  ZrListTableNameLanguageMap copyWith({
    ZrListTableNameLanguageMapVi? vi,
    ZrListTableNameLanguageMapTh? th,
    ZrListTableNameLanguageMapKr? kr,
    ZrListTableNameLanguageMapEn? en,
    ZrListTableNameLanguageMapCn? cn,
    ZrListTableNameLanguageMapTc? tc,
  }) {
    return ZrListTableNameLanguageMap()
      ..vi = vi ?? this.vi
      ..th = th ?? this.th
      ..kr = kr ?? this.kr
      ..en = en ?? this.en
      ..cn = cn ?? this.cn
      ..tc = tc ?? this.tc;
  }
}

ZrListTableNameLanguageMapVi $ZrListTableNameLanguageMapViFromJson(
    Map<String, dynamic> json) {
  final ZrListTableNameLanguageMapVi zrListTableNameLanguageMapVi = ZrListTableNameLanguageMapVi();
  final String? languageCode = jsonConvert.convert<String>(
      json['languageCode']);
  if (languageCode != null) {
    zrListTableNameLanguageMapVi.languageCode = languageCode;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    zrListTableNameLanguageMapVi.content = content;
  }
  return zrListTableNameLanguageMapVi;
}

Map<String, dynamic> $ZrListTableNameLanguageMapViToJson(
    ZrListTableNameLanguageMapVi entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['languageCode'] = entity.languageCode;
  data['content'] = entity.content;
  return data;
}

extension ZrListTableNameLanguageMapViExtension on ZrListTableNameLanguageMapVi {
  ZrListTableNameLanguageMapVi copyWith({
    String? languageCode,
    String? content,
  }) {
    return ZrListTableNameLanguageMapVi()
      ..languageCode = languageCode ?? this.languageCode
      ..content = content ?? this.content;
  }
}

ZrListTableNameLanguageMapTh $ZrListTableNameLanguageMapThFromJson(
    Map<String, dynamic> json) {
  final ZrListTableNameLanguageMapTh zrListTableNameLanguageMapTh = ZrListTableNameLanguageMapTh();
  final String? languageCode = jsonConvert.convert<String>(
      json['languageCode']);
  if (languageCode != null) {
    zrListTableNameLanguageMapTh.languageCode = languageCode;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    zrListTableNameLanguageMapTh.content = content;
  }
  return zrListTableNameLanguageMapTh;
}

Map<String, dynamic> $ZrListTableNameLanguageMapThToJson(
    ZrListTableNameLanguageMapTh entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['languageCode'] = entity.languageCode;
  data['content'] = entity.content;
  return data;
}

extension ZrListTableNameLanguageMapThExtension on ZrListTableNameLanguageMapTh {
  ZrListTableNameLanguageMapTh copyWith({
    String? languageCode,
    String? content,
  }) {
    return ZrListTableNameLanguageMapTh()
      ..languageCode = languageCode ?? this.languageCode
      ..content = content ?? this.content;
  }
}

ZrListTableNameLanguageMapKr $ZrListTableNameLanguageMapKrFromJson(
    Map<String, dynamic> json) {
  final ZrListTableNameLanguageMapKr zrListTableNameLanguageMapKr = ZrListTableNameLanguageMapKr();
  final String? languageCode = jsonConvert.convert<String>(
      json['languageCode']);
  if (languageCode != null) {
    zrListTableNameLanguageMapKr.languageCode = languageCode;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    zrListTableNameLanguageMapKr.content = content;
  }
  return zrListTableNameLanguageMapKr;
}

Map<String, dynamic> $ZrListTableNameLanguageMapKrToJson(
    ZrListTableNameLanguageMapKr entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['languageCode'] = entity.languageCode;
  data['content'] = entity.content;
  return data;
}

extension ZrListTableNameLanguageMapKrExtension on ZrListTableNameLanguageMapKr {
  ZrListTableNameLanguageMapKr copyWith({
    String? languageCode,
    String? content,
  }) {
    return ZrListTableNameLanguageMapKr()
      ..languageCode = languageCode ?? this.languageCode
      ..content = content ?? this.content;
  }
}

ZrListTableNameLanguageMapEn $ZrListTableNameLanguageMapEnFromJson(
    Map<String, dynamic> json) {
  final ZrListTableNameLanguageMapEn zrListTableNameLanguageMapEn = ZrListTableNameLanguageMapEn();
  final String? languageCode = jsonConvert.convert<String>(
      json['languageCode']);
  if (languageCode != null) {
    zrListTableNameLanguageMapEn.languageCode = languageCode;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    zrListTableNameLanguageMapEn.content = content;
  }
  return zrListTableNameLanguageMapEn;
}

Map<String, dynamic> $ZrListTableNameLanguageMapEnToJson(
    ZrListTableNameLanguageMapEn entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['languageCode'] = entity.languageCode;
  data['content'] = entity.content;
  return data;
}

extension ZrListTableNameLanguageMapEnExtension on ZrListTableNameLanguageMapEn {
  ZrListTableNameLanguageMapEn copyWith({
    String? languageCode,
    String? content,
  }) {
    return ZrListTableNameLanguageMapEn()
      ..languageCode = languageCode ?? this.languageCode
      ..content = content ?? this.content;
  }
}

ZrListTableNameLanguageMapCn $ZrListTableNameLanguageMapCnFromJson(
    Map<String, dynamic> json) {
  final ZrListTableNameLanguageMapCn zrListTableNameLanguageMapCn = ZrListTableNameLanguageMapCn();
  final String? languageCode = jsonConvert.convert<String>(
      json['languageCode']);
  if (languageCode != null) {
    zrListTableNameLanguageMapCn.languageCode = languageCode;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    zrListTableNameLanguageMapCn.content = content;
  }
  return zrListTableNameLanguageMapCn;
}

Map<String, dynamic> $ZrListTableNameLanguageMapCnToJson(
    ZrListTableNameLanguageMapCn entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['languageCode'] = entity.languageCode;
  data['content'] = entity.content;
  return data;
}

extension ZrListTableNameLanguageMapCnExtension on ZrListTableNameLanguageMapCn {
  ZrListTableNameLanguageMapCn copyWith({
    String? languageCode,
    String? content,
  }) {
    return ZrListTableNameLanguageMapCn()
      ..languageCode = languageCode ?? this.languageCode
      ..content = content ?? this.content;
  }
}

ZrListTableNameLanguageMapTc $ZrListTableNameLanguageMapTcFromJson(
    Map<String, dynamic> json) {
  final ZrListTableNameLanguageMapTc zrListTableNameLanguageMapTc = ZrListTableNameLanguageMapTc();
  final String? languageCode = jsonConvert.convert<String>(
      json['languageCode']);
  if (languageCode != null) {
    zrListTableNameLanguageMapTc.languageCode = languageCode;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    zrListTableNameLanguageMapTc.content = content;
  }
  return zrListTableNameLanguageMapTc;
}

Map<String, dynamic> $ZrListTableNameLanguageMapTcToJson(
    ZrListTableNameLanguageMapTc entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['languageCode'] = entity.languageCode;
  data['content'] = entity.content;
  return data;
}

extension ZrListTableNameLanguageMapTcExtension on ZrListTableNameLanguageMapTc {
  ZrListTableNameLanguageMapTc copyWith({
    String? languageCode,
    String? content,
  }) {
    return ZrListTableNameLanguageMapTc()
      ..languageCode = languageCode ?? this.languageCode
      ..content = content ?? this.content;
  }
}

ZrListTableOnline $ZrListTableOnlineFromJson(Map<String, dynamic> json) {
  final ZrListTableOnline zrListTableOnline = ZrListTableOnline();
  final String? onlineNumber = jsonConvert.convert<String>(
      json['onlineNumber']);
  if (onlineNumber != null) {
    zrListTableOnline.onlineNumber = onlineNumber;
  }
  final String? totalAmount = jsonConvert.convert<String>(json['totalAmount']);
  if (totalAmount != null) {
    zrListTableOnline.totalAmount = totalAmount;
  }
  return zrListTableOnline;
}

Map<String, dynamic> $ZrListTableOnlineToJson(ZrListTableOnline entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['onlineNumber'] = entity.onlineNumber;
  data['totalAmount'] = entity.totalAmount;
  return data;
}

extension ZrListTableOnlineExtension on ZrListTableOnline {
  ZrListTableOnline copyWith({
    String? onlineNumber,
    String? totalAmount,
  }) {
    return ZrListTableOnline()
      ..onlineNumber = onlineNumber ?? this.onlineNumber
      ..totalAmount = totalAmount ?? this.totalAmount;
  }
}