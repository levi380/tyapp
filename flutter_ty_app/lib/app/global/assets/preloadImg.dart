
import 'package:flutter/material.dart';

import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart' show AppLogger;
import 'package:flutter_ty_app/app/global/assets/smart_image_preloader.dart';
import 'package:flutter_ty_app/app/utils/image_util.dart';



/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9236b86d-2f93-40b7-a267-6fcfe0acb8fe-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  图片预加载 】】】
    【【【 AUTO_PARAGRAPH_TITLE 图片预加载 PreloadImg 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 图片预加载 PreloadImg
    - PreloadImg
    ```
    static preloadOnHome(BuildContext context) {
      loadLoop(homeImgList, context);
    }

    ```
    】】】
 *
 */

class PreloadImg {
  static void preloadOnHome(BuildContext context) {
    SmartImagePreloader.instance.addPreloadTask(homeImgList, priority: PreloadPriority.high, context: context);
    AppLogger.debug('预加载首页');
  }

  static void preloadOnNb(BuildContext context) {
    SmartImagePreloader.instance.addPreloadTask(nbList, priority: PreloadPriority.medium, context: context);
    AppLogger.debug('预加载背景图片');
  }

  static void preloadOnSetting(BuildContext context) {
    SmartImagePreloader.instance.addPreloadTask(settingImgList, priority: PreloadPriority.low, context: context);
    AppLogger.debug('预加载设置菜单');
  }

  static void preloadOnVrSport(BuildContext context) {
    SmartImagePreloader.instance.addPreloadTask(vrSportImgList, priority: PreloadPriority.medium, context: context);
    AppLogger.debug('预加载vr');
  }

  static void preloadLeague(BuildContext context) {
    List<String> leagueUrls = [];
    [0, 7, 3, 10, 4, 5, 6, 40].forEach((element) {
      leagueUrls.add('assets/images/league/sportstab_ico_${element}_nor_night_league.png');
      leagueUrls.add('assets/images/league/sportstab_ico_${element}_sel_league.png');
      leagueUrls.add('assets/images/league/sportstab_ico_${element}_nor_league.png');
    });
    SmartImagePreloader.instance.addPreloadTask(leagueUrls, priority: PreloadPriority.medium, context: context);
    // AppLogger.debug('预加载联赛');
  }

  static void preloadMenu(BuildContext context) {
    List<String> menuUrls = [];
    for (int i = 0; i <= 66; i++) {
      menuUrls.add('assets/images/sport/sportstab_ico_${i}_nor.png');
      menuUrls.add('assets/images/sport/sportstab_ico_${i}_nor_night.png');
      menuUrls.add('assets/images/sport/sportstab_ico_${i}_sel.png');
    }
    SmartImagePreloader.instance.addPreloadTask(menuUrls, priority: PreloadPriority.medium, context: context);
    // AppLogger.debug('预加载菜单');
  }

  static void delayPreloadOnDetail(BuildContext context) {
    // 详情页背景大图 除足球和篮球外延迟预加载
    // SmartImagePreloader.instance.addPreloadTask(detailImgList, priority: PreloadPriority.low, context: context);
    // 调整为延迟加载，但仍通过 SmartImagePreloader
    delayLoad(3, detailImgList, context);
    // AppLogger.debug('预加载详情图片 可以放到最后级别');
  }

  static void delayLoad(int seconds, List<String> list, BuildContext context) {
    Future.delayed(Duration(seconds: seconds), () {
      SmartImagePreloader.instance.addPreloadTask(list, priority: PreloadPriority.low, context: context);
      // AppLogger.debug('延迟预加载');
    });
  }
}

// home页面 预加载的图片
List<String> homeImgList = [
  oddsInfoLoadingGif,
  'assets/images/detail/odds-info-loading.webp',
  'assets/images/jlt/play-act.png',
  'assets/images/jlt/play.png',
  'assets/images/jlt/play-dark.png',
  'assets/images/shopcart/order_status_success1.png',
  'assets/images/shopcart/order_status_failure1.png',
  'assets/images/shopcart/order_status_prebook_success2.png',
  'assets/images/shopcart/order_status_standby1.png',
  'assets/images/shopcart/tandem_success2.png',
  'assets/images/shopcart/tandem_failed2.png',
  'assets/images/shopcart/closed_pic1.png',
  'assets/images/shopcart/backspace1.png',
  'assets/images/shopcart/collapse1.png',
  'assets/images/icon/main_tab1.png',
  'assets/images/icon/main_tab2.png',
  'assets/images/icon/main_tab3.png',
  'assets/images/icon/main_tab4.png',
  'assets/images/icon/main_tab5.png',
  'assets/images/detail/bg/football_n.png',
  'assets/images/detail/bg/basketball_n.png',
  'assets/images/shopcart/arrow_right.svg',
  'assets/images/shopcart/arrow_right_3.svg',
  'assets/images/icon/footballBasketballTemplate_tabbar_1.png',
  'assets/images/icon/footballBasketballTemplate_tabbar_2.png',
  'assets/images/icon/footballBasketballTemplate_tabbar_3.png',
  'assets/images/icon/footballBasketballTemplate_tabbar_4.png',
  'assets/images/icon/football_1.png',
  'assets/images/icon/football_2.png',
  'assets/images/icon/basketball_1.png',
  'assets/images/icon/basketball_2.png',
  'assets/images/icon/footballBasketballTemplate_1.png',
  'assets/images/icon/footballBasketballTemplate_2.png',
  'assets/images/icon/footballBasketballTemplate_3.png',
  'assets/images/icon/footballBasketballTemplate_4.png',
  'assets/images/icon/footballBasketballTemplate_5.png',
  'assets/images/xsyd/cn_1_zy_light.png',
  'assets/images/xsyd/cn_1_xs_light.png',
  'assets/images/xsyd/cn_1_zy_dark.png',
  'assets/images/xsyd/cn_1_xs_dark.png',
  'assets/images/xsyd/beginners_guide_close.png',
];

// 设置
List<String> settingImgList = [
  'assets/images/icon/search_unselected.png',
  'assets/images/icon/search_selected.png',
  'assets/images/icon/league_icon.png'
  'assets/images/date _background_dark.png'
  'assets/images/date _background_light.png'
  'assets/images/date _background_light.png'
  'assets/images/announcement _date.png'
  'assets/images/announcement _dates.png'
];

// 详情
List<String> detailImgList = [
  'assets/images/detail/bottom_nav_text.svg',
  'assets/images/detail/bottom_nav_result2.svg',
  'assets/images/detail/bottom_nav_refresh2.svg',
  'assets/images/detail/detail-refresh-night.png',
  'assets/images/detail/detail-refresh.png',
  'assets/images/detail/match-result-icon-night.png',
  'assets/images/detail/match-result-icon.png',
  'assets/images/detail/detail-settle-night.png',
  'assets/images/detail/detail-settle.png',
  // 投注按钮
  'assets/images/detail/odds_up.svg',
  'assets/images/detail/odds_down.svg',
  'assets/images/detail/match-icon-lock.svg',
  // 缺省图
  'assets/images/detail/icon_arrowleft_nor_night.svg',
  'assets/images/detail/icon_arrowleft_nor.svg',
  'assets/images/detail/no-data-bg-night.svg',
  'assets/images/detail/no-data-bg.svg',
  'assets/images/detail/no-data-night.svg',
  'assets/images/detail/no-data.svg',
  'assets/images/detail/fullscreen-nodata-network.svg',
  'assets/images/detail/no_data_collect.png',
  'assets/images/detail/fullscreen-nodata-lock.svg',
  'assets/images/detail/def_marketclose.png',
  'assets/images/detail/fullscreen-nodata.svg',
  'assets/images/detail/bg/baseball_n.png',
  'assets/images/detail/bg/ice_hockey_n.png',
  'assets/images/detail/bg/tennis_n.png',
  'assets/images/detail/bg/american_football.jpg',
  'assets/images/detail/bg/snooker_pool_n.png',
  'assets/images/detail/bg/ping_pong_n.png',
  'assets/images/detail/bg/volleyball_n.png',
  'assets/images/detail/bg/badminton_n.png',
  'assets/images/detail/bg/handball.jpg',
  'assets/images/detail/bg/boxing_n.png',
  'assets/images/detail/bg/beach_volleyball_n.png',
  'assets/images/detail/bg/esports_n.png',
  'assets/images/detail/bg/cricket.png',
  'assets/images/detail/bg/rugby_n.png',
  'assets/images/detail/bg/hockey_n.png',
  'assets/images/detail/bg/water_polo.jpg',
  'assets/images/detail/bg/details-LOL.jpg',
  'assets/images/detail/bg/DOTA.jpg',
  'assets/images/detail/bg/CS_GO.jpg',
  'assets/images/detail/bg/details-KPL.jpg',
  "assets/images/detail/icon_arrowleft_nor_night.svg",
  "assets/images/detail/icon_arrowdown_nor_night.svg",
  "assets/images/detail/icon_arrowleft_nor.svg",
  "assets/images/detail/icon_arrowup_nor.svg",
  'assets/images/detail/bg-dark.png',
  'assets/images/detail/bg-dark2.png',
  'assets/images/detail/odds-pin-active-night.svg',
  'assets/images/detail/odds-pin-active.svg',
  'assets/images/detail/odds-pin-night.svg',
  'assets/images/detail/odds-pin.svg',
  'assets/images/detail/list_pintop_sel_night.svg',
  'assets/images/detail/list_pintop_sel.svg',
  'assets/images/detail/list_pintop_nor_night.svg',
  'assets/images/detail/list_pintop_nor.svg',
];

// vr 体育
List<String> vrSportImgList = [
  // 菜单
  'assets/images/vr/vr_home_football.png',
  'assets/images/vr/vr_home_football_sel.png',
  'assets/images/vr/vr_home_basketball.png',
  'assets/images/vr/vr_home_basketball_sel.png',
  'assets/images/vr/vr_home_horse.png',
  'assets/images/vr/vr_home_horse_sel.png',
  'assets/images/vr/vr_home_dog.png',
  'assets/images/vr/vr_home_dog_sel.png',
  'assets/images/vr/vr_home_motorcycle.png',
  'assets/images/vr/vr_home_motorcycle_sel.png',
  'assets/images/vr/vr_home_dirt_bike.png',
  'assets/images/vr/vr_home_dirt_bike_sel.png',
  // 视频
  'assets/images/vr/video_mute.svg',
  'assets/images/vr/video_volume.svg',
  'assets/images/detail/bg/vr_football_video_bg_n.png',
  'assets/images/detail/bg/vr_basketball_video_bg_n.png',
  'assets/images/detail/bg/vr_horse_video_bg_new_n.png',
  'assets/images/detail/bg/vr_dog_video_bg_n.png',
  'assets/images/detail/bg/vr_motorcycle_video_bg_n.png',
  'assets/images/detail/bg/vr_dirtbike_video_bg_n.png',
  // 余额
  // 'assets/images/home/icon_trans_nor_new.svg',
  'assets/images/home/icon_trans_nor_RMB.svg',
  'assets/images/home/icon_trans_nor_USDT.svg',
  // 其他
  'assets/images/icon/icon_arrow_right_grey.png',
  // detail
  'assets/images/data/icondefault.png',
  'assets/images/vr/Wimage.png',
  'assets/images/vr/Dimage.png',
  'assets/images/vr/Limage.png',
  'assets/images/vr/Wimage.svg',
  'assets/images/vr/Dimage.svg',
  'assets/images/vr/Limage.svg',
  'assets/images/vr/ico_fav_sel.svg',
  'assets/images/vr/ico_fav.svg',
  'assets/images/detailnew/rank1.png',
  'assets/images/detailnew/rank2.png',
  'assets/images/detailnew/rank3.png',
  'assets/images/detailnew/rank4.png',
  'assets/images/vr/bet_record_NO.1.png',
  'assets/images/vr/bet_record_NO.2.png',
  'assets/images/vr/bet_record_NO.3.png',
];

List<String> nbList = [
  'assets/images/nb/nb_bg_0.jpg',
  'assets/images/nb/nb_bg_1.jpg',
  'assets/images/nb/nb_bg_6.jpg',
  'assets/images/nb/nb_bg_7.jpg',
  'assets/images/nb/nb_bg_8.jpg',
  'assets/images/nb/nb_bg_20.jpg',
  'assets/images/nb/nb_bg_22.jpg',
  'assets/images/nb/nb_bg_24.jpg',
  'assets/images/nb/nb_panda_0.png',
  'assets/images/nb/nb_panda_1.png',
  'assets/images/nb/nb_panda_3.png',
  'assets/images/nb/nb_panda_4.png',
  'assets/images/nb/nb_panda_5.png',
  'assets/images/nb/nb_panda_6.png',
  'assets/images/nb/nb_panda_9.png',
  'assets/images/nb/nb_panda_10.png',
  'assets/images/nb/nb_panda_11.png',
  'assets/images/nb/nb_panda_12.png',
  'assets/images/nb/nb_panda_13.png',
  'assets/images/nb/nb_panda_14.png',
  'assets/images/nb/nb_panda_15.png',
  'assets/images/nb/nb_panda_16.png',
  'assets/images/nb/nb_panda_17.png',
  'assets/images/nb/nb_panda_18.png',
  'assets/images/nb/nb_panda_19.png',
  'assets/images/nb/nb_panda_20.png',
  'assets/images/nb/nb_panda_21.png',
  'assets/images/nb/nb_panda_22.png',
  'assets/images/nb/nb_panda_23.png',
  'assets/images/nb/nb_panda_24.png',
];
