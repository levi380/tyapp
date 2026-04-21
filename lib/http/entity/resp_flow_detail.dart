/// d : [{"bonus":"0.00","created_at":1762862263304,"currency":101,"finished":"0.00","id":"45588164147943278","multiple":"0.00","pid":"0","plat_names":"EVO 真人,PP真人,SEXY真人,WE真人,PA真人,DB真人,CQ9真人","plats":"[101, 102, 104, 105, 106, 107, 108]","pname":"admin","ramin_turnover":"333","turnover":"333.00","ty":6,"ty_type":4,"updated_at":1762862263304},{"bonus":"0.00","created_at":1762591880983,"currency":101,"finished":"0.00","id":"45134537889421166","multiple":"0.00","pid":"0","plat_names":"WE电子,PA电子","plats":"[320, 321]","pname":"admin","ramin_turnover":"1000","turnover":"1000.00","ty":6,"ty_type":4,"updated_at":1762591880983},{"bonus":"0.00","created_at":1762591649009,"currency":101,"finished":"0.00","id":"45134148691564398","multiple":"0.00","pid":"0","plat_names":"","plats":"[]","pname":"admin","ramin_turnover":"1000","turnover":"1000.00","ty":6,"ty_type":4,"updated_at":1762591649009},{"bonus":"0.00","created_at":1761804479639,"currency":101,"finished":"50.20","id":"43813497636657006","multiple":"0.00","pid":"0","plat_names":"","plats":"[]","pname":"admin","ramin_turnover":"49.8","turnover":"100.00","ty":6,"ty_type":4,"updated_at":1761804479639}]
/// s : 0
/// t : 4

class RespFlowDetail {
  RespFlowDetail({
    this.d,
    this.s,
    this.t,
  });

  RespFlowDetail.fromJson(dynamic json) {
    if (json['d'] != null) {
      d = [];
      json['d'].forEach((v) {
        d?.add(FlowModel.fromJson(v));
      });
    }
    s = json['s'];
    t = json['t'];
  }

  List<FlowModel>? d;
  num? s;
  num? t;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (d != null) {
      map['d'] = d?.map((v) => v.toJson()).toList();
    }
    map['s'] = s;
    map['t'] = t;
    return map;
  }
}

/// bonus : "0.00"
/// created_at : 1762862263304
/// currency : 101
/// finished : "0.00"
/// id : "45588164147943278"
/// multiple : "0.00"
/// pid : "0"
/// plat_names : "EVO 真人,PP真人,SEXY真人,WE真人,PA真人,DB真人,CQ9真人"
/// plats : "[101, 102, 104, 105, 106, 107, 108]"
/// pname : "admin"
/// ramin_turnover : "333"
/// turnover : "333.00"
/// ty : 6
/// ty_type : 4
/// updated_at : 1762862263304

class FlowModel {
  FlowModel({
    this.bonus,
    this.createdAt,
    this.currency,
    this.finished,
    this.id,
    this.multiple,
    this.pid,
    this.platNames,
    this.plats,
    this.pname,
    this.raminTurnover,
    this.turnover,
    this.ty,
    this.tyType,
    this.updatedAt,
  });

  FlowModel.fromJson(dynamic json) {
    bonus = json['bonus'];
    createdAt = json['created_at'];
    currency = json['currency'];
    finished = json['finished'];
    id = json['id'];
    multiple = json['multiple'];
    pid = json['pid'];
    platNames = json['plat_names'];
    plats = json['plats'];
    pname = json['pname'];
    raminTurnover = json['ramin_turnover'];
    turnover = json['turnover'];
    ty = json['ty'];
    tyType = json['ty_type'];
    updatedAt = json['updated_at'];
  }

  String? bonus;
  num? createdAt;
  num? currency;
  String? finished;
  String? id;
  String? multiple;
  String? pid;
  String? platNames;
  String? plats;
  String? pname;
  String? raminTurnover;
  String? turnover;
  num? ty;
  num? tyType;
  num? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bonus'] = bonus;
    map['created_at'] = createdAt;
    map['currency'] = currency;
    map['finished'] = finished;
    map['id'] = id;
    map['multiple'] = multiple;
    map['pid'] = pid;
    map['plat_names'] = platNames;
    map['plats'] = plats;
    map['pname'] = pname;
    map['ramin_turnover'] = raminTurnover;
    map['turnover'] = turnover;
    map['ty'] = ty;
    map['ty_type'] = tyType;
    map['updated_at'] = updatedAt;
    return map;
  }
}
