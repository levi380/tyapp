import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../generated/locales.g.dart';

///球种id
enum SportConfig {
  ///首页-全部
  MatchAllPage(100),

  ///首页-电竞
  EsportsPage(2000),

  ///首页-vr体育
  VirtualSportsPage(300),

  ///首页-真人
  ZRPage(3000),

  ///首页-彩票
  CPPage(4000),

  ///首页-收藏
  FavoritesPage(50000),

  ///首页-注单列表
  BettingPage(6000),

  ///首页-热门联赛
  HotMenuLeague(600),

  ///精选
  Featured(50199),

  ///--------------------  以下是球种 sportid ------------------///

  ///足球
  football(101),

  ///篮球
  basketball(102),

  ///棒球
  baseball(103),

  ///冰球
  iceHockey(104),

  ///网球
  tennis(105),

  ///美式足球
  americanFootball(106),

  ///斯诺克
  snooker(107),

  ///乒乓球
  tableTennis(108),

  ///排球
  volleyball(109),

  ///羽毛球
  badminton(110),

  ///手球
  handball(111),

  ///拳击/格斗
  boxing(112),

  ///沙滩排球
  beachVolleyball(113),

  ///联合式橄榄球
  rugbyUnion(114),

  ///曲棍球
  hockey(115),

  ///水球
  waterPolo(116),

  ///板球
  cricket(137),

  ///电子足球
  eFootball(190),

  ///电子篮球
  eBasketball(191),

  ///VR体育
  virtualSports(300),

  ///冠军
  champion(400),

  ///冠军-足球
  championFootball(401),

  ///冠军-篮球
  championBasketball(402),

  ///冠军-棒球
  championBaseball(403),

  ///冠军-冰球
  championIceHockey(404),

  ///冠军-网球
  championTennis(405),

  ///冠军-美式足球
  championAmericanFootball(406),

  ///冠军-斯诺克
  championSnooker(407),

  ///冠军-乒乓球
  championTableTennis(408),

  ///冠军-排球
  championVolleyball(409),

  ///冠军-羽毛球
  championBadminton(410),

  ///冠军-手球
  championHandball(411),

  ///冠军-拳击/格斗
  championBoxing(412),

  ///冠军-沙滩排球
  championBeachVolleyball(413),

  ///冠军-联合式橄榄球
  championRugbyUnion(414),

  ///冠军-曲棍球
  championHockey(415),

  ///冠军-水球
  championWaterPolo(416),

  ///冠军-田径
  championAthletics(417),

  ///冠军-娱乐
  championEntertainment(418),

  ///冠军-游泳
  championSwimming(419),

  ///冠军-体操
  championGymnastics(420),

  ///冠军-跳水
  championDiving(421),

  ///冠军-射击
  championShooting(422),

  ///冠军-举重
  championWeightlifting(423),

  ///冠军-射箭
  championArchery(424),

  ///冠军-击剑
  championFencing(425),

  ///冠军-冰壶
  championCurling(426),

  ///冠军-跆拳道
  championTaekwondo(427),

  ///冠军-高尔夫
  championGolf(428),

  ///冠军-自行车
  championCycling(429),

  ///冠军-赛马
  championHorseRacing(430),

  ///冠军-帆船
  championSailing(431),

  ///冠军-划船
  championRowing(432),

  ///冠军-赛车运动
  championRacing(433),

  ///冠军-柔道
  championJudo(434),

  ///冠军-空手道
  championKarate(435),

  ///冠军-摔跤
  championWrestling(436),

  ///冠军-板球
  championCricket(437),

  ///冠军-飞镖
  championDarts(438),

  ///冠军-沙滩足球
  championBeachFootball(439),

  ///冠军-其他
  championOther(440),

  ///趣味
  fun(450),

  ///热门赛事
  hotMatches(500),

  ///热门
  hot(600),

  ///英雄联盟
  lol(2100),

  ///Dota2
  dota2(2101),

  ///CS2
  cs2(2102),

  ///王者荣耀
  honorOfKings(2103),

  ///无畏契约
  valorant(2105),

  ///竞足
  jingZu(50101),

  ///竞篮
  jingLan(50102);

  final int sportId;
  const SportConfig(this.sportId);
}

class configStaticData {
  static final Map<String, int> sportSortMap = {
    '50000': 0, // 收藏
    SportConfig.championFootball.sportId.toString(): 1, // 足球
    SportConfig.championBasketball.sportId.toString(): 2, // 篮球
    SportConfig.championEntertainment.sportId.toString() : 3, // 娱乐
    SportConfig.championTennis.sportId.toString() : 4, // 网球
    SportConfig.championBoxing.sportId.toString() : 5, // 拳击 格斗
    SportConfig.championSnooker.sportId.toString() : 6, // 斯诺克
    SportConfig.championBaseball.sportId.toString() : 7, // 棒球
    SportConfig.championVolleyball.sportId.toString() : 8, // 排球
    SportConfig.badminton.sportId.toString() : 9, // 羽毛球
    SportConfig.championAmericanFootball.sportId.toString() : 10, // 美式足球
    SportConfig.championTableTennis.sportId.toString() : 11, // 乒乓球
    SportConfig.championIceHockey.sportId.toString(): 12, // 冰球
    SportConfig.iceHockey.sportId.toString() : 13, // 乒乓球
    SportConfig.beachVolleyball.sportId.toString() : 14, // 沙滩排球
    SportConfig.championHandball.sportId.toString() : 15, // 手球
    SportConfig.rugbyUnion.sportId.toString(): 16, // 联合式橄榄球
    SportConfig.championGolf.sportId.toString() : 17, // 高尔夫
    SportConfig.championCycling.sportId.toString() : 18, // 自行车
    SportConfig.championRacing.sportId.toString() : 19, // 赛车运动
    SportConfig.championCricket.sportId.toString() : 20, // 板球
    SportConfig.championDarts.sportId.toString() : 21, // 飞镖
    SportConfig.championOther.sportId.toString()  : 22, // 其他
  };

  static final  Map<String, String> sportNameMap = {
    SportConfig.FavoritesPage.sportId.toString():
    LocaleKeys.footer_menu_collect.tr,
    SportConfig.MatchAllPage.sportId.toString():
    LocaleKeys.app_h5_match_all.tr,
    SportConfig.EsportsPage.sportId.toString():
    LocaleKeys.menu_itme_name_esports.tr,
    SportConfig.VirtualSportsPage.sportId.toString():
    LocaleKeys.common_virtual_sports.tr,
    SportConfig.ZRPage.sportId.toString():
    LocaleKeys.menu_itme_name_zr_menu.tr,
    SportConfig.CPPage.sportId.toString():
    LocaleKeys.menu_itme_name_cp_menu.tr,
    SportConfig.BettingPage.sportId.toString(): LocaleKeys.app_bet.tr,
    SportConfig.HotMenuLeague.sportId.toString():
    LocaleKeys.setting_menu_league.tr,
  };
}