/// type : 2
/// name : "存款"
/// sub_types : [{"sub_type":1,"name":"USDT TRC20"}]

class TradeDict {
  TradeDict({
    this.type,
    this.name,
    this.subTypes,
  });

  TradeDict.fromJson(dynamic json) {
    type = json['type'];
    name = json['name'];
    if (json['sub_types'] != null) {
      subTypes = [];
      json['sub_types'].forEach((v) {
        subTypes?.add(SubTypes.fromJson(v));
      });
    }
  }

  num? type;
  String? name;
  List<SubTypes>? subTypes;
  bool isSelected = false;
  bool bottomSelected = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['name'] = name;
    if (subTypes != null) {
      map['sub_types'] = subTypes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// sub_type : 1
/// name : "USDT TRC20"

class SubTypes {
  SubTypes({
    this.subType,
    this.name,
  });

  SubTypes.fromJson(dynamic json) {
    subType = json['sub_type'];
    name = json['name'];
  }

  num? subType;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sub_type'] = subType;
    map['name'] = name;
    return map;
  }
}
