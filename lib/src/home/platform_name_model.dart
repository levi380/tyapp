/// 场馆模型
class PlatFormNameModel {
  String? id; // 场馆ID
  String? name; // 场馆名称

  PlatFormNameModel({this.id, this.name});

  factory PlatFormNameModel.fromJson(Map<String, dynamic> json) {
    return PlatFormNameModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
