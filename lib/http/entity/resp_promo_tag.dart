import 'package:filbet/src/activity/model/activity_model.dart';

/// d : ""

class RespPromoTag {
  RespPromoTag({
    this.d,
  });

  RespPromoTag.fromJson(dynamic json) {
    if (json['d'] != null) {
      d = [];
      json['d'].forEach((v) {
        d?.add(ActivityTypeModel.fromJson(v));
      });
    }
  }

  List<ActivityTypeModel>? d;
}
