/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1509bbab-4a30-49cc-837f-3535741f55b4-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  年报】】】
    【【【 AUTO_PARAGRAPH_TITLE 年报 AnnualReportlogic】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 AnnualReportlogic
    ```
    /// 日期年报次数
    int dateCount = 0;

    ///生成报告播放次数
    int bgCount = 0;

    ///文字列表行数
    int number = 4;

    ///无数据
    bool noData = false;

    ///生成报告
    bool clickgenerateReport = false;
    ///从什么 时间 说起
    late String userCreateTime = '';
    ///相识了多少天
    late String diffFriendTime = '';
    ///多少笔注单
    late String annualBetCount = '';
    ///超过了多少用户
    late String annualBetPercentRank = '';
    ///多少笔单关
    late String annualBetSingleCount = '';
    ///多少笔串关
    late String annualBetComboCount = '';
    ///最喜欢的运动
    late String annualHobbySportName = '';
    ///最喜欢的玩法
    late String annualHobbyPlayName = '';
    ///工竞猜了多少次
    late String annualHobbyPlayCount = '';
    ///竞猜赛事
    late int annualHobbyBetTime = 1;
    ///什么赛事是你的最爱
    late String annualHobbyTournamentName = '';
    ///你工竞猜了多少笔订单
    late String annualHobbyTournamentCount = '';
    ///年度时间
    late String annualMaxSettleAmountCreateTime = '';
    late String annualMaxBetAmountCreateTime = '';
    ///年度 类别
    late String annualMaxBetAmountTournamentIdName = '';
    ///年度球队名称
    late String sannualMaxBetAmountMatchIdName = '';
    ///你投注了多少钱
    late String annualMaxBetAmount = '';
    ///全场让球
    late String annualMaxBetAmountPlayOptionName = '';
    ///超过了多少用户
    late String annualMaxBetAmountPercentRank = '';
    ///你的盈利金额高达
    late String annualMaxSettleAmount = '';
    ///超过了多少用户
    late String annualMaxSettleAmountPercentRank = '';
    late String annualMaxBetCurrency = '';
    late String annualMaxSettleCurrency = '';

    ///运动类型
    late int annualHobbySportBackgroundType = 1;

    ///联赛类型
    late int annualHobbyTournamentBackgroundType = 1;

    ///年费
    late String year = '2025';

    /// 称号弹框
    bool titlePopUp = false;

    int currentPage = 0;

    bool pandaIsVisible = false;
    bool isPlaying = false;

    ```
    】】】
 *
 */
class AnnualReportlogic {

  /// 日期年报次数
  int dateCount = 0;

  ///生成报告播放次数
  int bgCount = 0;

  ///文字列表行数
  int number = 4;

  ///无数据
  bool noData = false;

  ///生成报告
  bool clickgenerateReport = false;
  ///从什么 时间 说起
  late String userCreateTime = '';
  ///相识了多少天
  late String diffFriendTime = '';
  ///多少笔注单
  late String annualBetCount = '';
  ///超过了多少用户
  late String annualBetPercentRank = '';
  ///多少笔单关
  late String annualBetSingleCount = '';
  ///多少笔串关
  late String annualBetComboCount = '';
  ///最喜欢的运动
  late String annualHobbySportName = '';
  ///最喜欢的玩法
  late String annualHobbyPlayName = '';
  ///工竞猜了多少次
  late String annualHobbyPlayCount = '';
  ///竞猜赛事
  late int annualHobbyBetTime = 1;
  ///什么赛事是你的最爱
  late String annualHobbyTournamentName = '';
  ///你工竞猜了多少笔订单
  late String annualHobbyTournamentCount = '';
  ///年度时间
  late String annualMaxSettleAmountCreateTime = '';
  late String annualMaxBetAmountCreateTime = '';
  ///年度 类别
  late String annualMaxBetAmountTournamentIdName = '';
  ///年度球队名称
  late String sannualMaxBetAmountMatchIdName = '';
  ///你投注了多少钱
  late String annualMaxBetAmount = '';
  ///全场让球
  late String annualMaxBetAmountPlayOptionName = '';
  ///超过了多少用户
  late String annualMaxBetAmountPercentRank = '';
  ///你的盈利金额高达
  late String annualMaxSettleAmount = '';
  ///超过了多少用户
  late String annualMaxSettleAmountPercentRank = '';
  late String annualMaxBetCurrency = '';
  late String annualMaxSettleCurrency = '';

  ///运动类型
  late int annualHobbySportBackgroundType = 1;

  ///联赛类型
  late int annualHobbyTournamentBackgroundType = 1;

  ///年费
  late String year = '2025';

  /// 称号弹框
  bool titlePopUp = false;

  int currentPage = 0;

  bool pandaIsVisible = false;
  bool isPlaying = false;


  AnnualReportlogic() {
    ///Initialize variables
  }
}
