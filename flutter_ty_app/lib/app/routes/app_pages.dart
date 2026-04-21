import 'package:get/get.dart';

import '../modules/annual_report/annual_report_binding.dart';
import '../modules/annual_report/annual_report_view.dart';
import '../modules/cp/cp_betting_tutorial/cp_betting_tutorial_binding.dart';
import '../modules/cp/cp_betting_tutorial/cp_betting_tutorial_view.dart';
import '../modules/cp/cp_ticket_web_view/cp_ticket_web_view_binding.dart';
import '../modules/cp/cp_ticket_web_view/cp_ticket_web_view_view.dart';
import '../modules/discount_odd/bindings/discount_odd_binding.dart';
import '../modules/discount_odd/discount_odd_page.dart';
import '../modules/dj/bindings/dj_binding.dart';
import '../modules/dj/views/dj_view.dart';
import '../modules/european_cup/european_cup_binding.dart';
import '../modules/european_cup/european_cup_view.dart';
import '../modules/football_basketball_template/football_basketball_template_binding.dart';
import '../modules/football_basketball_template/football_basketball_template_view.dart';
import '../modules/group_bet/bets/ongoing/ongoing_bets_binding.dart';
import '../modules/group_bet/bets/ongoing/ongoing_bets_view.dart';
import '../modules/group_bet/main/bindings/group_bet_binding.dart';
import '../modules/group_bet/main/views/group_bet_view.dart';
import '../modules/group_bet/participate/bindings/participate_binding.dart';
import '../modules/group_bet/participate/views/participate_view.dart';
import '../modules/group_bet/sponser/bindings/sponser_binding.dart';
import '../modules/group_bet/sponser/views/sponser_view.dart';
import '../modules/login/ty_login_binding.dart';
import '../modules/login/ty_login_view.dart';
import '../modules/lottery_betting/views/lottery_betting_view.dart';
import '../modules/main_tab/main_tab_binding.dart';
import '../modules/main_tab/main_tab_view.dart';
import '../modules/olympic_games/olympic_games_binding.dart';
import '../modules/olympic_games/olympic_games_view.dart';
import '../modules/result/result_binding.dart';
import '../modules/result/result_view.dart';
import '../modules/result/results_details/results_details_binding.dart';
import '../modules/result/results_details/results_details_view.dart';
import '../modules/sdk_home/sdk_home_binding.dart';
import '../modules/sdk_home/sdk_home_view.dart';
import '../modules/setting_menu/announcement_center/announcement_center_binding.dart';
import '../modules/setting_menu/announcement_center/announcement_center_view.dart';
import '../modules/setting_menu/daily_activities/daily_activities_binding.dart';
import '../modules/setting_menu/daily_activities/daily_activities_view.dart';
import '../modules/setting_menu/handicap_settings/handicap_settings_binding.dart';
import '../modules/setting_menu/handicap_settings/handicap_settings_view.dart';
import '../modules/setting_menu/language/language_binding.dart';
import '../modules/setting_menu/language/language_view.dart';
import '../modules/setting_menu/one_click_betting/one_click_betting_binding.dart';
import '../modules/setting_menu/one_click_betting/one_click_betting_view.dart';
import '../modules/setting_menu/quick_bet_amount/quick_bet_amount_binding.dart';
import '../modules/setting_menu/quick_bet_amount/quick_bet_amount_view.dart';
import '../modules/setting_menu/rule_description/rule_description_binding.dart';
import '../modules/setting_menu/rule_description/rule_description_view.dart';
import '../modules/setting_menu/select_time_zone/select_time_zone_binding.dart';
import '../modules/setting_menu/select_time_zone/select_time_zone_view.dart';
import '../modules/setting_menu/tutorial/simulation_training/simulation_training_binding.dart';
import '../modules/setting_menu/tutorial/simulation_training/simulation_training_view.dart';
import '../modules/setting_menu/tutorial/tutorial_binding.dart';
import '../modules/setting_menu/tutorial/tutorial_view.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';
import '../modules/token_expired/token_expired_binding.dart';
import '../modules/token_expired/token_expired_view.dart';
import '../modules/vr/views/competition_detail/vr_competition_detail_binding.dart';
import '../modules/vr/views/competition_detail/vr_competition_detail_view.dart';
import '../modules/vr/views/living/bindings/living_binding.dart';
import '../modules/vr/views/living/view/living_view.dart';
import '../modules/vr/vr_home_binding.dart';
import '../modules/vr/vr_home_view.dart';
import '../modules/vr/vr_sport_detail/bindings/vr_sport_detail_binding.dart';
import '../modules/vr/vr_sport_detail/vr_sport_detail_view.dart';
import '../modules/web_games/web_games_binding.dart';
import '../modules/web_games/web_games_view.dart';
import '../modules/zr/zr_tutorial/zr_tutorial_binding.dart';
import '../modules/zr/zr_tutorial/zr_tutorial_view.dart';
import 'app_middle_page.dart';
import 'app_route_observer.dart';


// import 'package:flutter_ty_app/app/modules/basketball_appreciation_odds/basketball_appreciation_odds_page.dart';
// import 'package:flutter_ty_app/app/modules/basketball_appreciation_odds/bindings/basketball_appreciation_odds_binding.dart';

part 'app_routes.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-90096206-e368-4c62-8f1a-2847bac1f3c3-sz 】】】
    【【【 AUTO_DOCUMENT_MENU  公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  全局路由 】】】
    【【【 AUTO_PARAGRAPH_TITLE 全局路由入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 全局路由管理

    ```
     sdk
    name: _Paths.home,

    启动页
    name: _Paths.splash,

    模拟登陆
    name: _Paths.login,

    主页面入口
    name: _Paths.mainTab,

    赛果
    name: _Paths.matchResults,

    赛果详情
    name: _Paths.matchResultsDetails,

    规则说明
    name: _Paths.ruleDescription,

    公告中心
    name: _Paths.noticeCenter,

    盘口教程
    name: _Paths.tutorial,

    赛事详情
    name: _Paths.matchDetail,

    vr体育详情
    name: _Paths.vrSportDetail,

    国际化语言切换
    name: _Paths.language,

    模拟练习
    name: _Paths.simulationTraining,

    vr体育首页
    name: _Paths.vrHomePage,

    vr体育头部直播
    name: _Paths.vrLivingPage,

    电竞页面
    name: _Paths.DJView,

    每日活动
    name: _Paths.dailyActivities,

    自定义投注金额
    name: _Paths.quickBetAmount,

    toke失效页面
    name: _Paths.tokenExpired,
    一键投注
    name: _Paths.oneClickBetting,

    欧洲杯专题页
    name: _Paths.europeanCup,

    奥运会专题页
    name: _Paths.olympicGames,

    一键投注
    name: _Paths.oneClickBetting,

    真人教程
    name: _Paths.zRTutorial,

    彩票投注教程
    name: _Paths.cPBettingTutorial,

    彩票投注
    name: _Paths.lotteryBetting,

    网页游戏
    name: _Paths.webGam
    盘口设置
    name: _Paths.handicapSetting,

    选择时区
    name: _Paths.selectTimeZone,
    ```
    】】】
 *
 */
class TYAppPages {
  TYAppPages._();

  static const initAPP = Routes.splash;
  static const initSDK = Routes.home;

  static final routes = [
    /// sdk
    GetPage(
      name: _Paths.home,
      page: () => const SdkHomePage(),
      binding: SdkHomeBinding(),
    ),

    /// 启动页
    GetPage(
      name: _Paths.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),

    ///模拟登陆
    GetPage(
      name: _Paths.login,
      page: () => const TyLoginPage(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: _Paths.mainTab,
      page: () => const MainTabPage(),
      binding: MainTabBinding(),
      transition: Transition.noTransition,
    ),

    /// 赛果
    GetPage(
      name: _Paths.matchResults,
      page: () => const ResultPage(),
      binding: ResultBinding(),
      // middlewares: [TYRouteMiddlePage()],
    ),

    /// 赛果详情
    GetPage(
      name: _Paths.matchResultsDetails,
      page: () => const ResultsDetailsPage(),
      binding: ResultsDetailsBinding(),
      middlewares: [TYRouteMiddlePage()],
    ),

    /// 规则说明
    GetPage(
      name: _Paths.ruleDescription,
      page: () => const RuleDescriptionPage(),
      binding: RuleDescriptionBinding(),
    ),

    /// 盘口教程
    GetPage(
      name: _Paths.tutorial,
      page: () => const TutorialPage(),
      binding: TutorialBinding(),
    ),

    /// 赛事详情
    // GetPage(
    //   name: Routes.matchDetail,
    //   page: () => MatchDetailView(tag: Get.arguments?['mid'] ?? ''),
    //   binding: MatchDetailBinding(tag: Get.arguments?['mid'] ?? ''),
    // ),

    GetPage(
      name: _Paths.vrSportDetail,
      page: () => const VrSportDetailPage(),
      binding: VrSportDetailBinding(),
    ),

    ///模拟练习
    GetPage(
      name: _Paths.simulationTraining,
      page: () => const SimulationTrainingPage(),
      binding: SimulationTrainingBinding(),
    ),
    GetPage(
      name: _Paths.vrHomePage,
      page: () => const VrHomeView(),
      binding: VrHomeBinding(),
      middlewares: [TYRouteMiddlePage()],
    ),
    GetPage(
      name: _Paths.vrLivingPage,
      page: () => const VrLivingView(),
      binding: VrLivingBinding(),
    ),
    GetPage(
      name: _Paths.vrCompetitionDetailPage,
      page: () => const VrCompetitionDetailView(),
      binding: VrCompetitionDetailBinding(),
    ),
    GetPage(
      name: _Paths.DJView,
      page: () => DJView(),
      binding: DJBinding(),
      middlewares: [TYRouteMiddlePage()],
    ),

    GetPage(
      name: _Paths.dailyActivities,
      page: () => const DailyActivitiesPage(),
      binding: DailyActivitiesBinding(),
    ),

    /// 自定义投注金额
    GetPage(
      name: _Paths.quickBetAmount,
      page: () => const QuickBetAmountPage(),
      binding: QuickBetAmountBinding(),
    ),

    ///toke 失效
    GetPage(
      name: _Paths.tokenExpired,
      page: () => const TokenExpiredPage(),
      binding: TokenExpiredBinding(),
    ),

    ///一键投注
    GetPage(
      name: _Paths.oneClickBetting,
      page: () => const OneClickBettingPage(),
      binding: OneClickBettingBinding(),
    ),

    ///欧洲杯专题页
    GetPage(
      name: _Paths.europeanCup,
      page: () => const EuropeanCupPage(),
      binding: EuropeanCupBinding(),
      middlewares: [TYRouteMiddlePage()],
    ),

    ///奥运会专题页
    GetPage(
      name: _Paths.olympicGames,
      page: () => const OlympicGamesPage(),
      binding: OlympicGamesBinding(),
      middlewares: [TYRouteMiddlePage()],
    ),

    ///一键投注
    GetPage(
      name: _Paths.oneClickBetting,
      page: () => const OneClickBettingPage(),
      binding: OneClickBettingBinding(),
    ),

    /// 真人教程
    GetPage(
      name: _Paths.zRTutorial,
      page: () => const ZrTutorialPage(),
      binding: ZrTutorialBinding(),
    ),

    /// 彩票投注教程
    GetPage(
      name: _Paths.cPBettingTutorial,
      page: () => const CpBettingTutorialPage(),
      binding: CpBettingTutorialBinding(),
    ),

    GetPage(
      name: _Paths.lotteryBetting,
      page: () => const LotteryBettingView(),
    ),

    /// 网页游戏
    GetPage(
      name: _Paths.webGames,
      page: () => const WebGamesPage(),
      binding: WebGamesBinding(),
    ),

    GetPage(
      name: _Paths.cpTicketWebView,
      page: () => const CpTicketWebViewPage(),
      binding: CpTicketWebViewBinding(),
    ),

    /// 盘口设置
    GetPage(
      name: _Paths.handicapSetting,
      page: () => const HandicapSettingsView(),
      binding: HandicapSettingsBinding(),
    ),

    /// 选择时区
    GetPage(
      name: _Paths.selectTimeZone,
      page: () => const SelectTimeZonePage(),
      binding: SelectTimeZoneBinding(),
    ),

    /// 年报
    GetPage(
      name: _Paths.annualReport,
      page: () => const AnnualReportPage(),
      binding: AnnualReportBinding(),
    ),

    /// 优惠赔率二级页面
    GetPage(
        name: _Paths.discountOdd,
        page: () => DiscountOddPage(),
        binding: DiscountOddBinding()),

    /// 合买
    GetPage(
        name: _Paths.GROUP_BET,
        page: () => GroupBetView(),
        binding: GroupBetBinding()),

    /// 发起合买
    GetPage(
      name: _Paths.SPONSER,
      page: () => const SponserView(),
      binding: SponserBinding(),
    ),

    /// 参与合买
    GetPage(
      name: _Paths.PARTICIPATE,
      page: () => const ParticipateView(),
      binding: ParticipateBinding(),
    ),

    /// 合买注单进行中
    GetPage(
      name: _Paths.ongoing,
      page: () => const OngoingBetsPage(),
      binding: OngoingBetsBinding(),
    ),

    ///国际化语言切换
    GetPage(
      name: _Paths.language,
      page: () => const LanguagePage(),
      binding: LanguageBinding(),
    ),

    ///公告中心
    GetPage(
      name: _Paths.announcementCenter,
      page: () => const AnnouncementCenterPage(),
      binding: AnnouncementCenterBinding(),
    ),

    ///足球篮球运营模版
    GetPage(
      name: _Paths.footballBasketballTemplate,
      page: () => const FootballBasketballTemplatePage(),
      binding: FootballBasketballTemplateBinding(),
    ),
    // 篮球赔率页面
    // GetPage(
    //     name: _Paths.basketballAppreciationOddsPage,
    //     page: () => BasketballAppreciationOddsPage(),
    //     binding: BasketballAppreciationOddsBinding()),
  ];
}
