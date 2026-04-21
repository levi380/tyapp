/// ways : []
/// third_partys : [{"type":"主线客服","url":"https://im.skbet.com/"}]

class RespServiceModel {
  RespServiceModel({
    this.ways,
    this.thirdPartys,
  });

  RespServiceModel.fromJson(dynamic json) {
    if (json['ways'] != null) {
      ways = [];
      json['ways'].forEach((v) {
        ways?.add(ThirdPartys.fromJson(v));
      });
    }
    if (json['third_partys'] != null) {
      thirdPartys = [];
      json['third_partys'].forEach((v) {
        thirdPartys?.add(ThirdPartys.fromJson(v));
      });
    }
  }

  List<ThirdPartys>? ways;
  List<ThirdPartys>? thirdPartys;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ways != null) {
      map['ways'] = ways?.map((v) => v.toJson()).toList();
    }
    if (thirdPartys != null) {
      map['third_partys'] = thirdPartys?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// type : "主线客服"
/// url : "https://im.skbet.com/"

class ThirdPartys {
  ThirdPartys({
    this.type,
    this.url,
  });

  ThirdPartys.fromJson(dynamic json) {
    type = json['type'];
    url = json['url'];
  }

  String? type;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['url'] = url;
    return map;
  }
}
