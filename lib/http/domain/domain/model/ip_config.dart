/// ip : "202.187.229.197"
/// pro : ""
/// proCode : "999999"
/// city : ""
/// cityCode : "0"
/// region : ""
/// regionCode : "0"
/// addr : " 马来西亚"
/// regionNames : ""
/// err : "noprovince"

class IpConfig {
  IpConfig({
      this.ip, 
      this.pro, 
      this.proCode, 
      this.city, 
      this.cityCode, 
      this.region, 
      this.regionCode, 
      this.addr, 
      this.regionNames, 
      this.err,});

  IpConfig.fromJson(dynamic json) {
    ip = json['ip'];
    pro = json['pro'];
    proCode = json['proCode'];
    city = json['city'];
    cityCode = json['cityCode'];
    region = json['region'];
    regionCode = json['regionCode'];
    addr = json['addr'];
    regionNames = json['regionNames'];
    err = json['err'];
  }
  String? ip;
  String? pro;
  String? proCode;
  String? city;
  String? cityCode;
  String? region;
  String? regionCode;
  String? addr;
  String? regionNames;
  String? err;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ip'] = ip;
    map['pro'] = pro;
    map['proCode'] = proCode;
    map['city'] = city;
    map['cityCode'] = cityCode;
    map['region'] = region;
    map['regionCode'] = regionCode;
    map['addr'] = addr;
    map['regionNames'] = regionNames;
    map['err'] = err;
    return map;
  }

}