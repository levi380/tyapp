
import 'dart:io';

import 'package:get/get.dart';

import '../../db/app_cache.dart';
import '../../services/api/match_detail_api.dart';
import '../../services/models/res/api_res.dart';
import '../../services/models/res/video_animation_url_entity.dart';
import '../../services/network/app_dio.dart';

class PipVideoService {
  static final PipVideoService _instance = PipVideoService._internal();

  factory PipVideoService() => _instance;

  PipVideoService._internal();

  /// 检查是否登录
  Future<bool> checkLogin() async {
    try {
      var response = await AppDio.getInstance()
          .dio
          .post('${StringKV.baseUrl.get()!}/yewu11/v1/w/isLogin');
      Map data = response.data;
      return data['code'] == "0000000" && data['data']['isLogin'];
    } catch (e) {
      Get.log("PipVideoService checkLogin error: $e");
      return false;
    }
  }

  /// 获取视频引用链接
  Future<Map<String, dynamic>?> getVideoReferUrl(String gcuuid) async {
    try {
      Map<String, dynamic> param = {'gcuuid': gcuuid, 'device': 'H5'};
      var response = await AppDio.getInstance().dio.post(
          '${StringKV.baseUrl.get()!}/yewu11/v1/w/videoReferUrl?device=H5',
          data: param);
      return response.data;
    } catch (e) {
      Get.log("PipVideoService getVideoReferUrl error: $e");
      return null;
    }
  }

  /// 获取视频动画 URL
  Future<ApiRes<VideoAnimationUrlEntity>> getVideoAnimationUrl(
      String mid) async {
    return await MatchDetailApi.instance()
        .getVideoAnimationUrl("Animation", mid);
  }

  /// 获取赛事详情 (合并普通和电竞)
  Future<ApiRes<Map<String, dynamic>>> getMatchDetail(
      String mid, String uid, String init,
      {bool isEsport = false}) async {
    if (isEsport) {
      return await MatchDetailApi.instance().getESMatchDetail(mid, uid, init);
    } else {
      return await MatchDetailApi.instance().getMatchDetail(mid, uid, init);
    }
  }

  /// 检查 URL 是否有效
  Future<bool> checkUrl(String url) async {
    var httpClient = HttpClient();
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      return response.statusCode == HttpStatus.ok;
    } catch (e) {
      Get.log('PipVideoService checkUrl error: $e');
      return false;
    } finally {
      httpClient.close();
    }
  }
}
