import 'package:filbet/http/entity/activity_apply_model.dart';

/// d : [{"bonus":"0.00","created_at":1762862263304,"currency":101,"finished":"0.00","id":"45588164147943278","multiple":"0.00","pid":"0","plat_names":"EVO 真人,PP真人,SEXY真人,WE真人,PA真人,DB真人,CQ9真人","plats":"[101, 102, 104, 105, 106, 107, 108]","pname":"admin","ramin_turnover":"333","turnover":"333.00","ty":6,"ty_type":4,"updated_at":1762862263304},{"bonus":"0.00","created_at":1762591880983,"currency":101,"finished":"0.00","id":"45134537889421166","multiple":"0.00","pid":"0","plat_names":"WE电子,PA电子","plats":"[320, 321]","pname":"admin","ramin_turnover":"1000","turnover":"1000.00","ty":6,"ty_type":4,"updated_at":1762591880983},{"bonus":"0.00","created_at":1762591649009,"currency":101,"finished":"0.00","id":"45134148691564398","multiple":"0.00","pid":"0","plat_names":"","plats":"[]","pname":"admin","ramin_turnover":"1000","turnover":"1000.00","ty":6,"ty_type":4,"updated_at":1762591649009},{"bonus":"0.00","created_at":1761804479639,"currency":101,"finished":"50.20","id":"43813497636657006","multiple":"0.00","pid":"0","plat_names":"","plats":"[]","pname":"admin","ramin_turnover":"49.8","turnover":"100.00","ty":6,"ty_type":4,"updated_at":1761804479639}]
/// s : 0
/// t : 4

class RespActivityApplyList {
  RespActivityApplyList({
    this.d,
  });

  RespActivityApplyList.fromJson(dynamic json) {
    if (json['d'] != null) {
      d = [];
      json['d'].forEach((v) {
        d?.add(ActivityApplyModel.fromJson(v));
      });
    }
  }

  List<ActivityApplyModel>? d;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (d != null) {
      map['d'] = d?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
