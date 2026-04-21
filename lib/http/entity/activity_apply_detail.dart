/// status : true
/// data : 0

class ActivityApplyDetail {
  ActivityApplyDetail({
      this.status, 
      this.data,});

  ActivityApplyDetail.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'];
  }
  bool? status;
  num? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['data'] = data;
    return map;
  }

}