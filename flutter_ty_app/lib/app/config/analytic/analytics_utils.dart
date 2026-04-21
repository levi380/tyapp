

import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../services/api/common_api.dart';
import '../app_logger/app_logger.dart';


///sdk数据埋点工具类
class Analytics {
  static void track(
      AnalyticsEvent event, {
        required String pagePath,
        required String clickTarget,
        int? stayTime,
        String? replaceEventName
      }) {
    AnalyticsEventModel model = AnalyticsEventModel(
      eventId: replaceEventName??event.name,
      pagePath: pagePath,
      clickTarget: clickTarget,
      userId: TYUserController.to.userInfo.value?.userId ?? '',
      ///商户编码
      merchantCode: '',
      platform: "APP",
      language: Get.locale?.languageCode ?? "zh",
      stayTime: stayTime,
    );
    _sendToServer(model);
  }

  ///上报
  static Future<void> _sendToServer(AnalyticsEventModel model) async {
    ///锚点 q3需求 暂时注释
    ///上报接口请求
    // Map<String, dynamic> data = model.toJson();
    // ///请求接口
    // ///详情的 展开/收起赛事列表
    // if(model.eventId == AnalyticsEvent.btn_expand_collapse_detail){
    //   data["event_id"] = AnalyticsEvent.btn_expand_collapse;
    //   data["click_target"] = AnalyticsEvent.btn_expand_collapse;
    //   model.eventId =  AnalyticsEvent.btn_expand_collapse.name;
    //   model.clickTarget =  AnalyticsEvent.btn_expand_collapse.name;
    // }
    //
    //
    // try {
    //   final res = await CommonApi.instance().analyticsApi(
    //       model.eventId,
    //       model.eventTime,
    //       model.pagePath,
    //       model.userId,
    //       model.merchantCode,
    //       model.platform,
    //       model.language,
    //       model.clickTarget,
    //       model.stayTime ?? 0);
    //     if (kDebugMode) AppLogger.debug('埋点成功上报 error: ${res.toString()}');
    // } catch (e) {
    //   if (kDebugMode) AppLogger.debug('埋点上报异常 catch error: $e');
    // }
  }

  /// 处理玩法埋点
  static void handleHpidTracking(String hpid) {
    print(hpid);
    if(hpidTrackMap.containsKey(hpid)) {
      track(hpidTrackMap[hpid]!, pagePath: '', clickTarget: hpidTrackMap[hpid]!.name);
    }
  }
}

Map<String,AnalyticsEvent> hpidTrackMap = {
  "1":  AnalyticsEvent.bet_click_fullwin,  // 全场独赢
  "4":  AnalyticsEvent.bet_click_fulllhc, // 全场让球
  "2":  AnalyticsEvent.bet_click_fulldx, // 全场大小
};

enum AnalyticsEvent {
  ///===============  顶部&菜单栏  ===============
  menu_today,                   /// 点击切换到“今日”页面
  menu_rolling,                 /// 点击切换到“滚球”页面
  menu_early,                   /// 点击切换到“早盘”页面
  menu_combo,                   /// 点击切换到“串关”页面
  menu_champion,                /// 点击切换到“冠军”页面
  btn_pro,                      /// 点击切换到“专业版”页面
  btn_rookie,                   /// 点击切换到“新手版”页面
  btn_hot,                      /// 点击切换到“热门”页面
  btn_time,                     /// 点击切换到“时间”页面
  btn_daymode,                  /// 切换为日间模式
  btn_nightmode,                /// 切换为夜间模式
  menu_live_casino,             /// 进入真人娱乐平台
  menu_group_bet,               ///进入合买大厅
  menu_lottery,                 ///进入彩票投注页面
  menu_all,                     ///切换到“全部”体育
  menu_hot_league,              ///点击热门联赛入口
  menu_search,                  ///点击搜索按钮
  menu_sport_xxx,               ///点击进入指定体育类型


  ///===============  赛事列表区热力区  ===============
  btn_favorite_1,               ///收藏/取消收藏该赛事
  btn_favorite_2,               ///收藏/取消收藏该赛事
  btn_team_name,                ///点击进入赛事详情页
  btn_pin_top_1,                ///点击将该赛事置顶
  btn_pin_top_2,                ///点击将该赛事置顶
  btn_expand_collapse,          ///展开/收起赛事列表

  ///===============  赔率增值/全部增值卡片  ===============
  tab_odds_boost,               ///点击切换显示/隐藏赔率增值内容
  btn_odds_expand,              ///点击进入全部增值内容页
  card_match_odds,              ///点击查看该赛事详情


  ///===============  赛事详情/盘口区热力区  ===============
  bet_click_fullwin,            ///点击全场独赢任一投注项
  bet_click_fulllhc,            ///点击全场让球任一投注项
  bet_click_fulldx,             ///点击全场大小任一投注项
  btn_score_tab,                ///切换比分板
  btn_live_tab,                 ///切换到视频源
  btn_early_settlement,         ///点击提前结算
  btn_corners,                  ///点击角球玩法tab
  btn_15min,                    ///点击15分钟玩法tab
  btn_correctscore,             ///点击波胆玩法tab
  btn_specialcombo,             ///点击特色组合玩法tab
  btn_expand_collapse_detail,   ///展开/收起盘口区列表
}

class AnalyticsEventModel {
  String eventId;         /// 事件ID
  final int eventTime;          /// 上报时间戳
  final String pagePath;        /// 页面路径
  final String userId;          /// 用户ID
  final String merchantCode;    /// 商户编码
  final String platform;        /// H5 / APP / PC
  final String language;        /// 当前语言
  String clickTarget;     /// 点击对象ID
  final int? stayTime;          /// 停留时间（秒）

  AnalyticsEventModel({
    required this.eventId,
    required this.pagePath,
    required this.userId,
    required this.merchantCode,
    required this.platform,
    required this.language,
    required this.clickTarget,
    this.stayTime,
    int? eventTime,
  }) : eventTime = eventTime ?? DateTime.now().millisecondsSinceEpoch;

  AnalyticsEventModel copyWith({
    String? eventId,
    int? eventTime,
    String? pagePath,
    String? userId,
    String? merchantCode,
    String? platform,
    String? language,
    String? clickTarget,
    int? stayTime,
  }) {
    return AnalyticsEventModel(
      eventId: eventId ?? this.eventId,
      eventTime: eventTime ?? this.eventTime,
      pagePath: pagePath ?? this.pagePath,
      userId: userId ?? this.userId,
      merchantCode: merchantCode ?? this.merchantCode,
      platform: platform ?? this.platform,
      language: language ?? this.language,
      clickTarget: clickTarget ?? this.clickTarget,
      stayTime: stayTime ?? this.stayTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "event_id": eventId,
      "event_time": eventTime,
      "page_path": pagePath,
      "user_id": userId,
      "merchant_code": merchantCode,
      "platform": platform,
      "language": language,
      "click_target": clickTarget,
      "stay_time": stayTime,
    };
  }

  factory AnalyticsEventModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsEventModel(
      eventId: json["event_id"],
      eventTime: json["event_time"],
      pagePath: json["page_path"],
      userId: json["user_id"],
      merchantCode: json["merchant_code"],
      platform: json["platform"],
      language: json["language"],
      clickTarget: json["click_target"],
      stayTime: json["stay_time"],
    );
  }
}