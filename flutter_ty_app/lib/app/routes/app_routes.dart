part of 'app_pages.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-90096206-e368-4c62-8f1a-2847bac1f3c3-sz 】】】
    【【【 AUTO_DOCUMENT_MENU  公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  全局路由 】】】
    【【【 AUTO_PARAGRAPH_TITLE 全局路由 命名规则 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 全局路由 命名规则
    - 新增路由命名  加 ty_  避免接入方冲突

    ```
    ///SDK 入口
    static const home = _Paths.home;
    static const homeView = _Paths.homeView;

    static const mainTab = _Paths.mainTab;

    ///启动页
    static const splash = _Paths.splash;

    ///模拟登录
    static const login = _Paths.login;
    // token 过期
    static const tokenExpired = _Paths.tokenExpired;

    /// 赛果
    static const matchResults = _Paths.matchResults;

    /// 赛果详情
    static const matchResultsDetails = _Paths.matchResultsDetails;

    /// 规则说明
    static const ruleDescription = _Paths.ruleDescription;

    /// 公告中心
    static const noticeCenter = _Paths.noticeCenter;

    /// 盘口教程
    static const tutorial = _Paths.tutorial;

    /// 赛事详情
    static const matchDetail = _Paths.matchDetail;

    /// 国际化语言切换
    static const language = _Paths.language;

    /// 盘口设置
    static const handicapSetting = _Paths.handicapSetting;

    /// 大小球模拟训练
    static const simulationTraining = _Paths.simulationTraining;
    static const CHAMPION = _Paths.CHAMPION;
    static const DJView = _Paths.DJView;

    ///每日活动
    static const dailyActivities = _Paths.dailyActivities;

    ///欧洲杯专题页
    static const europeanCup = _Paths.europeanCup;

    ///奥运会专题页
    static const olympicGames = _Paths.olympicGames;

    ///自定义快捷投注金额
    static const quickBetAmount = _Paths.quickBetAmount;

    ///一键投注
    static const oneClickBetting = _Paths.oneClickBetting;

    // VR
    static const vrHomePage = _Paths.vrHomePage;
    static const vrLivingPage = _Paths.vrLivingPage;
    static const vrSportDetail = _Paths.vrSportDetail;
    static const vrCompetitionDetailPage = _Paths.vrCompetitionDetailPage;
    static const ZR = _Paths.ZR;
    static const CP = _Paths.CP;
    static const BET = _Paths.BET;

    /// 真人教程
    static const zRTutorial = _Paths.zRTutorial;

    /// 彩票投注教程
    static const cPBettingTutorial = _Paths.cPBettingTutorial;
    static const lotteryBetting = _Paths.lotteryBetting;

    ///网页游戏
    static const webGames = _Paths.webGames;
    static const cpTicketWebView = _Paths.cpTicketWebView;

    ///选择时区
    static const selectTimeZone = _Paths.selectTimeZone;

    ///年报
    static const annualReport = _Paths.annualReport;

    ///公告中心
    static const announcementCenter = _Paths.announcementCenter;

    ///篮球足球运营模版
    static const footballBasketballTemplate = _Paths.footballBasketballTemplate;

    ///优惠赔率二级页面
    static const discountOdd = _Paths.discountOdd;
    static const GROUP_BET = _Paths.GROUP_BET;
    static const SPONSER = _Paths.SPONSER;
    static const PARTICIPATE = _Paths.PARTICIPATE;
    static const basketballAppreciationOddsPage = _Paths.basketballAppreciationOddsPage;
    static const ongoing = _Paths.ongoing;
    ```
    】】】
 *
 */

abstract class Routes {
  Routes._();

  static final AppRouteObserver observer = AppRouteObserver();
  static List<String> history = [];

  ///SDK 入口
  static const home = _Paths.home;
  static const homeView = _Paths.homeView;

  static const mainTab = _Paths.mainTab;

  ///启动页
  static const splash = _Paths.splash;

  ///模拟登录
  static const login = _Paths.login;
  // token 过期
  static const tokenExpired = _Paths.tokenExpired;

  /// 赛果
  static const matchResults = _Paths.matchResults;

  /// 赛果详情
  static const matchResultsDetails = _Paths.matchResultsDetails;

  /// 规则说明
  static const ruleDescription = _Paths.ruleDescription;

  /// 公告中心
  static const noticeCenter = _Paths.noticeCenter;

  /// 盘口教程
  static const tutorial = _Paths.tutorial;

  /// 赛事详情
  static const matchDetail = _Paths.matchDetail;

  /// 国际化语言切换
  static const language = _Paths.language;

  /// 盘口设置
  static const handicapSetting = _Paths.handicapSetting;

  /// 大小球模拟训练
  static const simulationTraining = _Paths.simulationTraining;
  static const CHAMPION = _Paths.CHAMPION;
  static const DJView = _Paths.DJView;

  ///每日活动
  static const dailyActivities = _Paths.dailyActivities;

  ///欧洲杯专题页
  static const europeanCup = _Paths.europeanCup;

  ///奥运会专题页
  static const olympicGames = _Paths.olympicGames;

  ///自定义快捷投注金额
  static const quickBetAmount = _Paths.quickBetAmount;

  ///一键投注
  static const oneClickBetting = _Paths.oneClickBetting;

  // VR
  static const vrHomePage = _Paths.vrHomePage;
  static const vrLivingPage = _Paths.vrLivingPage;
  static const vrSportDetail = _Paths.vrSportDetail;
  static const vrCompetitionDetailPage = _Paths.vrCompetitionDetailPage;
  static const ZR = _Paths.ZR;
  static const CP = _Paths.CP;
  static const BET = _Paths.BET;

  /// 真人教程
  static const zRTutorial = _Paths.zRTutorial;

  /// 彩票投注教程
  static const cPBettingTutorial = _Paths.cPBettingTutorial;
  static const lotteryBetting = _Paths.lotteryBetting;

  ///网页游戏
  static const webGames = _Paths.webGames;
  static const cpTicketWebView = _Paths.cpTicketWebView;

  ///选择时区
  static const selectTimeZone = _Paths.selectTimeZone;

  ///年报
  static const annualReport = _Paths.annualReport;

  ///公告中心
  static const announcementCenter = _Paths.announcementCenter;

  ///篮球足球运营模版
  static const footballBasketballTemplate = _Paths.footballBasketballTemplate;

  ///优惠赔率二级页面
  static const discountOdd = _Paths.discountOdd;
  static const GROUP_BET = _Paths.GROUP_BET;
  static const SPONSER = _Paths.SPONSER;
  static const PARTICIPATE = _Paths.PARTICIPATE;
  static const basketballAppreciationOddsPage =
      _Paths.basketballAppreciationOddsPage;
  static const ongoing = _Paths.ongoing;
  static const PIP_VIDEO = _Paths.PIP_VIDEO;
}

abstract class _Paths {
  _Paths._();

  static const home = '/ty_home';
  static const homeView = '/ty_HomeView';
  static const login = '/ty_login';
  static const splash = '/ty_splash';
  static const mainTab = '/ty_mainTab';
  static const matchResults = '/ty_matchResults';
  static const matchResultsDetails = '/ty_matchResultsDetails';
  static const ruleDescription = '/ty_ruleDescription';
  static const noticeCenter = '/ty_noticeCenter';
  static const tutorial = '/ty_tutorial';
  static const matchDetail = '/ty_matchDetail';
  static const language = '/ty_language';
  static const handicapSetting = '/ty_handicapSetting';
  static const simulationTraining = '/ty_simulationTraining';
  static const vrHomePage = '/ty_vrHomePage';
  static const vrLivingPage = '/ty_vrLivingPage';
  static const vrCompetitionDetailPage = '/ty_vrCompetitionDetailPage';
  static const vrSportDetail = '/ty_vrSportDetail';
  static const CHAMPION = '/ty_champion';
  static const DJView = '/ty_djView';
  static const dailyActivities = '/ty_dailyActivities';
  static const quickBetAmount = '/ty_quickBetAmount';
  static const tokenExpired = '/ty_tokenExpired';
  static const oneClickBetting = '/ty_oneClickBetting';
  static const europeanCup = '/ty_europeanCup';
  static const olympicGames = '/ty_olympicGames';

  static const ZR = '/ty_zr';
  static const CP = '/ty_cp';
  static const BET = '/ty_bet';
  static const zRTutorial = '/ty_zRTutorial';
  static const cPBettingTutorial = '/ty_cPBettingTutorial';
  static const lotteryBetting = '/ty_lotteryBetting';

  static const webGames = '/ty_webGames';

  static const cpTicketWebView = '/ty_cpTicketWebView';
  static const selectTimeZone = '/selectTimeZone';
  static const annualReport = '/annualReport';
  static const discountOdd = '/discountOdd';
  static const GROUP_BET = '/group-bet';
  static const SPONSER = '/sponser';
  static const PARTICIPATE = '/participate';

  static const ongoing = '/ongoing';
  static const basketballAppreciationOddsPage =
      '/basketballAppreciationOddsPage';
  static const announcementCenter = '/ty_announcementCenter';
  static const footballBasketballTemplate = '/ty_footballBasketballTemplate';
  static const PIP_VIDEO = '/pip-video';
}
