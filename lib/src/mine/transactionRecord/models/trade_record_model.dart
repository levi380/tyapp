/// id : "52707304402848767"
/// created_at : 1767105601561
/// amount : "0.00000000"
/// sub_type : 6
/// status : 1
/// status_name : "等待"
/// bill_no : "52707304402848767"

class TradeRecordModel {
  TradeRecordModel({
    this.id,
    this.createdAt,
    this.amount,
    this.subType,
    this.status,
    this.statusName,
    this.billNo,
  });

  TradeRecordModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    amount = json['amount'];
    subType = json['sub_type'];
    status = json['status'];
    statusName = json['status_name'];
    billNo = json['bill_no'];
    subTypeName = json['sub_type_name'];
  }

  String? id;
  num? createdAt;
  String? amount;
  num? subType;
  num? status;
  String? statusName;
  String? billNo;
  String? subTypeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['amount'] = amount;
    map['sub_type'] = subType;
    map['status'] = status;
    map['status_name'] = statusName;
    map['bill_no'] = billNo;
    return map;
  }
}
