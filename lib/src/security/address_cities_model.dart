class AddressCitiesModel {
  String? code;
  String? name;
  String? provinceCode;

  AddressCitiesModel({this.code, this.name, this.provinceCode});

  AddressCitiesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    provinceCode = json['province_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['province_code'] = this.provinceCode;
    return data;
  }
}
