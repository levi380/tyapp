import 'dart:io';
import 'dart:math';

import 'package:filbet/api/api.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/deposit_activity/views/activity_promo_detail_model.dart';
import 'package:filbet/src/mine/vip/models/member_vip_info.dart';
import 'package:filbet/utils/fp.dart';

class ActivityService {
  Future<ActivityPromoDetailModel> queryPromoDetail(String id, String ty) async {
    final response = await HttpClient.get(Api.activityDetail, queryParameters: {
      'id': id,
      'ty': ty,
    });
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is Map) {
      return ActivityPromoDetailModel.fromJson(response.data);
    } else {
      return ActivityPromoDetailModel();
    }
  }

  ///获取活动列表
  Future<List<ActivityModel>> promoList(String type) async {
    Map<String, dynamic> params = {};
    params["tag_id"] = type;

    var response = await HttpClient.get(Api.promoList, queryParameters: params);
    if (response.status == false) {
      throw response.error!;
    }
    List<dynamic> rawList = response.data ?? [];
    List<ActivityModel> list = rawList.map((e) => ActivityModel.fromJson(Map<String, dynamic>.from(e))).toList();
    return list;
  }
}
