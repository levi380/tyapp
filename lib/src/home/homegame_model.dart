import 'dart:convert';

/// 顶层分类模型
class CategoryModel {
  int? id;
  String? name;
  List<VenueModel>? venues;
  VenueModel? deft;

  CategoryModel({
    this.id,
    this.name,
    this.venues,
    this.deft,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      name: json['name']?.toString(),
      venues: (json['d'] as List?)
          ?.map((e) => VenueModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      deft: json['deft'] != null
          ? VenueModel.fromJson(Map<String, dynamic>.from(json['deft']))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'd': venues?.map((e) => e.toJson()).toList(),
      };
}

/// 场馆模型
class VenueModel {
  String? id; // 场馆ID
  String? venueId; // 厂商ID
  String? logo; // 场馆logo
  int? maintained; // 维护状态 1=正常 2=维护中
  String? name; // 场馆名称
  String? gameId; // game_id 不为空时直进游戏
  int? sort; // 排序值
  num? activeGames; // 游戏个数

  VenueModel({
    this.id,
    this.venueId,
    this.logo,
    this.maintained,
    this.name,
    this.gameId,
    this.sort,
    this.activeGames,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id']?.toString(),
      venueId: json['venue_id']?.toString(),
      logo: json['logo']?.toString(),
      maintained: json['maintained'] is int
          ? json['maintained']
          : int.tryParse(json['maintained']?.toString() ?? ''),
      name: json['name']?.toString(),
      gameId: json['game_id']?.toString(),
      sort: json['sort'] is int
          ? json['sort']
          : int.tryParse(json['sort']?.toString() ?? ''),
      activeGames: json['active_games'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'venue_id': venueId,
        'logo': logo,
        'maintained': maintained,
        'name': name,
        'game_id': gameId,
        'sort': sort,
        'active_games': activeGames,
      };
}

/// 工具：解析整个 JSON 列表
List<CategoryModel> parseCategories(String jsonStr) {
  final data = json.decode(jsonStr) as List<dynamic>;
  return data.map((e) => CategoryModel.fromJson(e)).toList();
}
