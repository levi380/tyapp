
/// status : true
/// data : [{"id":"94","token_type":"USDT","payment_type":1,"name":"TY-USDT","min_amount":"94","fee_ratio":"0","max_amount":"511664","img":"payment/1771504853063.png","sort":1}]

class RespWidthdrawMethod {
  RespWidthdrawMethod({
    this.status,
    this.data,
  });

  RespWidthdrawMethod.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MethodModel.fromJson(v));
      });
    }
  }

  bool? status;
  List<MethodModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "94"
/// token_type : "USDT"
/// payment_type : 1
/// name : "TY-USDT"
/// min_amount : "94"
/// fee_ratio : "0"
/// max_amount : "511664"
/// img : "payment/1771504853063.png"
/// sort : 1

class MethodModel {
  MethodModel({
    this.id,
    this.tokenType,
    this.paymentType,
    this.name,
    this.minAmount,
    this.feeRatio,
    this.maxAmount,
    this.img,
    this.sort,
  });

  MethodModel.fromJson(dynamic json) {
    id = json['id'];
    tokenType = json['token_type'];
    paymentType = json['payment_type'];
    name = json['name'];
    minAmount = json['min_amount'];
    feeRatio = json['fee_ratio'];
    maxAmount = json['max_amount'];
    img = json['img'];
    sort = json['sort'];
  }

  String? id;
  String? tokenType;
  num? paymentType;
  String? name;
  String? minAmount;
  String? feeRatio;
  String? maxAmount;
  String? img;
  num? sort;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['token_type'] = tokenType;
    map['payment_type'] = paymentType;
    map['name'] = name;
    map['min_amount'] = minAmount;
    map['fee_ratio'] = feeRatio;
    map['max_amount'] = maxAmount;
    map['img'] = img;
    map['sort'] = sort;
    return map;
  }
}
