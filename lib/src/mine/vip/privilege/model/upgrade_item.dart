/// title : "最低转账"
/// result : "100.00"

class UpgradeItem {
  UpgradeItem({
      this.title, 
      this.result,});

  UpgradeItem.fromJson(dynamic json) {
    title = json['title'];
    result = json['result'];
  }
  String? title;
  String? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['result'] = result;
    return map;
  }

}