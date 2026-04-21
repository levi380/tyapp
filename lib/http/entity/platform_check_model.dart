/// plat_id : "301"
/// plat_name : "AG真人"
/// transfer_amount : "100.00"
/// multiple : 1
/// new_turnover : "100.00"
/// existing_turnover : "500.00"
/// total_turnover : "600.00"
/// turnover_records : [{"id":"123456789","ty":1,"ty_name":"存款","bonus":"100","multiple":"1","turnover":"500","finished":"0","remain_turnover":"500.00","plats":"[301,302]","plat_names":"AG真人,开元棋牌","created_at":1701234567890}]
/// turnover_records_count : 1

class PlatformCheckModel {
  PlatformCheckModel({
      this.platId, 
      this.platName, 
      this.transferAmount, 
      this.multiple, 
      this.newTurnover, 
      this.existingTurnover, 
      this.totalTurnover, 
      this.turnoverRecords, 
      this.turnoverRecordsCount,});

  PlatformCheckModel.fromJson(dynamic json) {
    platId = json['plat_id'];
    platName = json['plat_name'];
    transferAmount = json['transfer_amount'];
    multiple = json['multiple'];
    newTurnover = json['new_turnover'];
    existingTurnover = json['existing_turnover'];
    totalTurnover = json['total_turnover'];
    if (json['turnover_records'] != null) {
      turnoverRecords = [];
      json['turnover_records'].forEach((v) {
        turnoverRecords?.add(TurnoverRecords.fromJson(v));
      });
    }
    turnoverRecordsCount = json['turnover_records_count'];
  }
  String? platId;
  String? platName;
  String? transferAmount;
  num? multiple;
  String? newTurnover;
  String? existingTurnover;
  String? totalTurnover;
  List<TurnoverRecords>? turnoverRecords;
  num? turnoverRecordsCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['plat_id'] = platId;
    map['plat_name'] = platName;
    map['transfer_amount'] = transferAmount;
    map['multiple'] = multiple;
    map['new_turnover'] = newTurnover;
    map['existing_turnover'] = existingTurnover;
    map['total_turnover'] = totalTurnover;
    if (turnoverRecords != null) {
      map['turnover_records'] = turnoverRecords?.map((v) => v.toJson()).toList();
    }
    map['turnover_records_count'] = turnoverRecordsCount;
    return map;
  }

}

/// id : "123456789"
/// ty : 1
/// ty_name : "存款"
/// bonus : "100"
/// multiple : "1"
/// turnover : "500"
/// finished : "0"
/// remain_turnover : "500.00"
/// plats : "[301,302]"
/// plat_names : "AG真人,开元棋牌"
/// created_at : 1701234567890

class TurnoverRecords {
  TurnoverRecords({
      this.id, 
      this.ty, 
      this.tyName, 
      this.bonus, 
      this.multiple, 
      this.turnover, 
      this.finished, 
      this.remainTurnover, 
      this.plats, 
      this.platNames, 
      this.createdAt,});

  TurnoverRecords.fromJson(dynamic json) {
    id = json['id'];
    ty = json['ty'];
    tyName = json['ty_name'];
    bonus = json['bonus'];
    multiple = json['multiple'];
    turnover = json['turnover'];
    finished = json['finished'];
    remainTurnover = json['remain_turnover'];
    plats = json['plats'];
    platNames = json['plat_names'];
    createdAt = json['created_at'];
  }
  String? id;
  num? ty;
  String? tyName;
  String? bonus;
  String? multiple;
  String? turnover;
  String? finished;
  String? remainTurnover;
  String? plats;
  String? platNames;
  num? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['ty'] = ty;
    map['ty_name'] = tyName;
    map['bonus'] = bonus;
    map['multiple'] = multiple;
    map['turnover'] = turnover;
    map['finished'] = finished;
    map['remain_turnover'] = remainTurnover;
    map['plats'] = plats;
    map['plat_names'] = platNames;
    map['created_at'] = createdAt;
    return map;
  }

}