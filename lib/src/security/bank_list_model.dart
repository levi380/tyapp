class BankListModel {
  String? id;
  int? riskState; // 风险状态 1：开启，2：关闭  当开启的时候需要提示风险信息
  String? name;
  String? img;

  BankListModel({
    this.id,
    this.name,
    this.img,
    this.riskState,
  });

  BankListModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['bank_name'] ?? json['name'];
    img = json['img'];
    riskState = json['risk_state'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['img'] = img;
    map['risk_state'] = riskState;
    return map;
  }
}
