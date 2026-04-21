class AddressAreasModel {
  String? cityCode;
  String? code;
  String? name;
  String? provinceCode;

  AddressAreasModel({this.cityCode, this.code, this.name, this.provinceCode});

  AddressAreasModel.fromJson(Map<String, dynamic> json) {
    cityCode = json['city_code'];
    code = json['code'];
    name = json['name'];
    provinceCode = json['province_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_code'] = this.cityCode;
    data['code'] = this.code;
    data['name'] = this.name;
    data['province_code'] = this.provinceCode;
    return data;
  }
}
