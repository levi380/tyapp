class AddressProvincesModel {
  String? code;
  String? name;

  AddressProvincesModel({this.code, this.name});

  AddressProvincesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}
