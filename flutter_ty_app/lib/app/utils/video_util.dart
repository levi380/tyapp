import 'dart:math';

import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_list_entity.dart';
import 'package:get/get.dart';

import '../../generated/locales.g.dart';
import '../db/app_cache.dart';
import '../services/models/domain_model.dart';
import '../services/models/res/match_entity.dart';

class VideoUtil {
  ///详情视频url拼接
  /// 视频链接拼接
  static String getVideoUrlH5(String referUrl, String mid,
      {int liveType = 1,
      int hdSd = 0,
      bool muted = false,
      MatchEntity? matchEntity}) {
    String mediaSrc = '';

    // 最优api
    String? requestDomain = DOMAIN_RESULT.first_one == ""
        ? StringKV.best_api.get()
        : DOMAIN_RESULT.first_one;
    double random = Random().nextDouble();
    String token = StringKV.token.get() ?? "";
    String lang = Get.locale?.languageCode ?? "zh";
    int volumeNumber = muted ? 0 : 100;
    int sound = muted ? 0 : 1;
    int dplayerVolume = 0; // 声音按钮
    String? domain =
        referUrl.startsWith("http") ? referUrl : ("http://" + referUrl);

    ///F01 视频 需要拼接 e_match=1 否则播放不了
    mediaSrc =
        '$domain?live_type=$liveType&hd_sd=$hdSd&random=$random&mid=$mid&domain=$requestDomain&is_client=1&load_error=${LocaleKeys.video_sorry.tr}&refresh=${LocaleKeys.footer_menu_refresh.tr}&token=$token&lang=$lang&controls=1&volume_number=$volumeNumber&sound=$sound'
        '&dplayer-volume=$dplayerVolume';

    /// 获取电子赛事标识
    int mbmty = matchEntity?.mbmty ?? 0;
    if (mbmty == 2 || mbmty == 4) {
      /// 电子赛事时增加e_match参数,标志是电子足球/篮球
      mediaSrc += '&e_match=1';
    }
    // mediaSrc = 'https:' + mediaSrc;

    mediaSrc = Uri.encodeFull(mediaSrc);
    return mediaSrc;
  }

  static String? name;
  static ZrListEntity? bean;
  static String? base;

  static getIstheSame(n, bean) {
    if (name == null || name == '') {
      name = n;
    }
    if (n == name) {
      if (base == null || base == '') {
        base = bean.roadPaper.bigPairRoad;
      }
      AppLogger.debug("roadPaperData?.dealerName = ${bean?.dealerName}");
      AppLogger.debug(
          "roadPaperData?.bigPairRoad = ${bean.roadPaper?.bigPairRoad.substring(0, 20)}");

      if (base == bean.roadPaper.bigPairRoad) {
        AppLogger.debug("相同");
      }
    }
  }
}
