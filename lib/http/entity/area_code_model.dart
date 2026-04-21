/// name : ""
/// code : ""

class AreaCodeModel {
  AreaCodeModel({
    this.name,
    this.code,
  });

  AreaCodeModel.fromJson(dynamic json) {
    name = json['name'];
    code = json['code'];
  }

  String? name;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['code'] = code;
    return map;
  }
}
