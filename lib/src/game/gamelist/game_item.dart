import 'dart:convert';

class GameInfoModel {
  final String? id;
  final String? gameId;
  final String? platformId;
  final String? venueId;
  final String? platformName;
  final String? gameType;
  final String? zhName;
  final String? enName;
  final String? vnName;
  final List<String>? currency;
  final String? img;
  final int? zhSort;
  final int? enSort;
  final int? vnSort;
  final int? online;
  final int? isHot;
  final int? isNew;
  final String? rtp;
  final int? createdAt;
  final int? updatedAt;
  final String? updatedUid;
  final String? updatedName;
  final String? name;
  final int? sort;

  bool fav;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameInfoModel &&
          runtimeType == other.runtimeType &&
          id == other.id;
  @override
  int get hashCode => id.hashCode;
  GameInfoModel({
    this.id,
    this.gameId,
    this.platformId,
    this.venueId,
    this.platformName,
    this.gameType,
    this.zhName,
    this.enName,
    this.vnName,
    this.currency,
    this.img,
    this.zhSort,
    this.enSort,
    this.vnSort,
    this.online,
    this.isHot,
    this.isNew,
    this.rtp,
    this.createdAt,
    this.updatedAt,
    this.updatedUid,
    this.updatedName,
    this.name,
    this.sort,
    isFav = false,
  }) : fav = isFav;

  factory GameInfoModel.fromJson(Map<String, dynamic> json) {
    return GameInfoModel(
      id: json['id'] as String?,
      gameId: json['game_id'] as String?,
      platformId: json['platform_id'] as String?,
      venueId: json['venue_id'] as String?,
      platformName: json['platform_name'] as String?,
      gameType: json['game_type'] as String?,
      zhName: json['zh_name'] as String?,
      enName: json['en_name'] as String?,
      vnName: json['vn_name'] as String?,
      currency: _parseCurrency(json['currency']),
      img: json['img'] as String?,
      zhSort: json['zh_sort'] as int?,
      enSort: json['en_sort'] as int?,
      vnSort: json['vn_sort'] as int?,
      online: json['online'] as int?,
      isHot: json['is_hot'] as int?,
      isNew: json['is_new'] as int?,
      rtp: json['rtp'] as String?,
      createdAt: json['created_at'] as int?,
      updatedAt: json['updated_at'] as int?,
      updatedUid: json['updated_uid'] as String?,
      updatedName: json['updated_name'] as String?,
      name: json['name'] as String?,
      sort: json['Sort'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'game_id': gameId,
      'platform_id': platformId,
      'venue_id': venueId,
      'platform_name': platformName,
      'game_type': gameType,
      'zh_name': zhName,
      'en_name': enName,
      'vn_name': vnName,
      'currency': currency,
      'img': img,
      'zh_sort': zhSort,
      'en_sort': enSort,
      'vn_sort': vnSort,
      'online': online,
      'is_hot': isHot,
      'is_new': isNew,
      'rtp': rtp,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'updated_uid': updatedUid,
      'updated_name': updatedName,
      'name': name,
      'Sort': sort,
    };
  }

  static List<String>? _parseCurrency(dynamic value) {
    if (value == null) return null;
    try {
      if (value is String) {
       List<String> stringList = value.split(',');
       return stringList;
      } else if (value is List) {
        return value.map((e) => e.toString()).toList();
      }
    } catch (_) {}
    return null;
  }
}
