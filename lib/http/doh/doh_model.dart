/// Status : 0
/// Answer : [{"type":5,"data":"levi.j1.greatgtm.com."},{"type":1,"data":"38.182.168.248"},{"type":1,"data":"38.182.168.247"}]

class DohModel {
  DohModel({
      this.status, 
      this.answer,});

  DohModel.fromJson(dynamic json) {
    status = json['Status'];
    if (json['Answer'] != null) {
      answer = [];
      json['Answer'].forEach((v) {
        answer?.add(Answer.fromJson(v));
      });
    }
  }
  num? status;
  List<Answer>? answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    if (answer != null) {
      map['Answer'] = answer?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// type : 5
/// data : "levi.j1.greatgtm.com."

class Answer {
  Answer({
      this.type, 
      this.data,});

  Answer.fromJson(dynamic json) {
    type = json['type'];
    data = json['data'];
    name = json['name'];
    TTL = json['TTL'];
  }
  String? name;
  num? TTL;
  num? type;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['data'] = data;
    return map;
  }

}