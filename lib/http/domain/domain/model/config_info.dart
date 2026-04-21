class ConfigInfo {
  ConfigInfo({
    this.h5,
    this.img,
  });

  ConfigInfo.fromJson(dynamic json) {
    h5 = json['h5'] != null ? json['h5'].cast<String>() : [];
    img = json['img'] != null ? json['img'].cast<String>() : [];
  }

  List<String>? h5;
  List<String>? img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['h5'] = h5;
    map['img'] = img;
    return map;
  }
}
