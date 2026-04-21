/// account_name : "张三"
/// bank_code : "暂无"
/// bank_name : "中国人民银行"
/// account_no : "6666666666666666"
/// province : "11"
/// city : "1101"
/// area : "110101"

class AddressInfo {
  AddressInfo({
      this.accountName, 
      this.bankCode, 
      this.bankName, 
      this.accountNo, 
      this.province, 
      this.city, 
      this.area,
      this.phone,
      this.img,

  });

  AddressInfo.fromJson(dynamic json) {
    accountName = json['account_name'];
    bankCode = json['bank_code'];
    bankName = json['bank_name'];
    accountNo = json['account_no'];
    province = json['province'];
    city = json['city'];
    area = json['area'];
    phone = json['phone'];
    img = json['img'];
  }
  String? accountName;
  String? bankCode;
  String? bankName;
  String? accountNo;
  String? province;
  String? city;
  String? area;
  String? phone;
  String? img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_name'] = accountName;
    map['bank_code'] = bankCode;
    map['bank_name'] = bankName;
    map['account_no'] = accountNo;
    map['province'] = province;
    map['city'] = city;
    map['area'] = area;
    map['phone'] = phone;
    map['img'] = img;
    return map;
  }

}