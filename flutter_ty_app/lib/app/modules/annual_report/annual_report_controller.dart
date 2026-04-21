import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/annual_report/annual_report_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../global/ty_user_controller.dart';
import '../../services/api/base_data_api.dart';
import '../../services/models/res/get_big_data_annual_report_info_entity.dart';
import '../../services/models/res/get_user_annual_report_template_entity.dart';
import '../../utils/utils.dart';
import 'annual_report_logic.dart';
import 'package:http/http.dart' as http;

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1509bbab-4a30-49cc-837f-3535741f55b4-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  年报】】】
    【【【 AUTO_PARAGRAPH_TITLE 年报 控制器 AnnualReportController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 控制器 AnnualReportController
    - 年报 音乐播放器 AudioPlayer
    - 年报 音乐图标旋转动画控制器  AnimationController
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

    ```
    】】】
 *
 */
class AnnualReportController extends GetxController
    with GetTickerProviderStateMixin {
  final AnnualReportlogic logic = AnnualReportlogic();
  ///翻页控制器
  final  pageController = PageController();

  GlobalKey globalKey = GlobalKey();

  Timer? timer;

  AudioPlayer audioPlayer = AudioPlayer();

  late AnimationController animationController;

  late AnimationController pandaAnimationController;
  late Animation<double> pandaAnimation;


  late AnimationController nbAnimationController;
  late Animation<double> nbAnimation;

  late AnimationController bgAnimationController;
  late Animation<double> bgAnimation;

  late AnimationController annualTitleAnimationController;
  late Animation<double> annualTitleAnimation;


  late AnimationController upperSlipController;
  late Animation<double> upperSlipAnimation;

  late  AnimationController leftAnimationController;
  late Animation<double>  leftSlipAnimation;

  late AnimationController rightAnimationController;
  late Animation<double>  rightSlipAnimation;

  late AnimationController testAnimationController1;
  late Animation<double> testOpacityAnimation1;
  late Animation<double> testFallAnimation1;

  late AnimationController testAnimationController2;
  late Animation<double> testOpacityAnimation2;
  late Animation<double> testFallAnimation2;

  late AnimationController testAnimationController3;
  late Animation<double> testOpacityAnimation3;
  late Animation<double> testFallAnimation3;

  late AnimationController testAnimationController4;
  late Animation<double> testOpacityAnimation4;
  late Animation<double> testFallAnimation4;

  late AnimationController testAnimationController5;
  late Animation<double> testOpacityAnimation5;
  late Animation<double> testFallAnimation5;


  late AnimationController testAnimationController6;
  late Animation<double> testOpacityAnimation6;
  late Animation<double> testFallAnimation6;

  late List<GetUserAnnualReportTemplateDataReportPO> reportPO = [];
  late List<GetBigDataAnnualReportInfoAnnualUserTitle> annualUserTitle = [];



  @override
  void onInit() {
    // TODO: implement onInit

    ///初始化数据
    initData();
    ///字体加载
    loadFont();
    ///熊猫入场动画
    pandaEntranceAnimation();
    /// 文字掉落动画
    textAnimationn();

    ///音乐按钮 旋转播放动画
    musicPlaybackRotation();

    ///播放音乐
    playMusic();

    ///年报埋点 进入
    initFillingPoint(15);

    ///日期 年报用户报告动画
    dateAnimation();

    /// 生成报告动画
    generateReport();

    ///向上滑动动画
    perSlip();

    /// 年度称号
    annualTitle();

    /// 左右翻页跳动动画
    leftRightSlip();
    Future.delayed(Duration(seconds: 2), () {
     update();
    });
    super.onInit();
  }


  ///初始化数据
  Future<void> initData() async {
    String? userId = TYUserController.to.userInfo.value?.userId;
    AppLogger.debug(userId!);
    ///文案模版数据接口
    final ress = await BaseDataApi.instance().getUserAnnualReportTemplate(
      logic.year,
      userId,
      // userId,
    );

    GetUserAnnualReportTemplateDataReportPO getUserAnnualReportTemplateDataReportPO = new GetUserAnnualReportTemplateDataReportPO();
    getUserAnnualReportTemplateDataReportPO.id = 0;
    getUserAnnualReportTemplateDataReportPO.pageNo = 0;
    reportPO.add(getUserAnnualReportTemplateDataReportPO);
    reportPO.addAll(ress.data.reportPO);
    reportPO.sort((a, b) => a.pageNo.compareTo(b.pageNo));
    update();


    ///填充替换字段接口
    final res = await BaseDataApi.instance().getBigDataAnnualReportInfo(
      logic.year,
      userId,
    );
    if (res.code == 200) {
      final result = await http.get(Uri.parse(ensureHttps(res.data.url.toString())));
      final text = result.body;

      /// 解密
      final decrypted = decryptWithAes(text, userId);
      print(decrypted);
      GetBigDataAnnualReportInfoEntity arinfe = GetBigDataAnnualReportInfoEntity.fromJson(json.decode(decrypted));
      annualUserTitle = arinfe.annualUserTitle;
      logic.userCreateTime = arinfe.userCreateTime;

      logic.diffFriendTime = arinfe.diffFriendTime.toString();
      logic.annualBetCount = arinfe.annualBetCount.toString();
      logic.annualBetPercentRank =  getRoundedPercent(double.parse(arinfe.annualBetPercentRank.toString()));
      logic.annualBetSingleCount = arinfe.annualBetSingleCount.toString();
      logic.annualBetComboCount = arinfe.annualBetComboCount.toString();
      logic.annualHobbySportName = Get.locale?.languageCode == 'zh' ? arinfe.annualHobbySportNameCn :Get.locale?.languageCode == 'tw' ?  arinfe.annualHobbySportNameTw : arinfe.annualHobbySportNameEn ;
      logic.annualHobbyPlayName = Get.locale?.languageCode == 'zh' ? arinfe.annualHobbyPlayNameCn :Get.locale?.languageCode == 'tw' ?  arinfe.annualHobbyPlayNameTw : arinfe.annualHobbyPlayNameEn ;
      logic.annualHobbyPlayCount = arinfe.annualHobbyPlayCount.toString() ;
      logic.annualHobbyBetTime = arinfe.annualHobbyBetTime;
      logic.annualHobbyTournamentName = Get.locale?.languageCode == 'zh' ? arinfe.annualHobbyTournamentNameCn :Get.locale?.languageCode == 'tw' ?  arinfe.annualHobbyTournamentNameTw : arinfe.annualHobbyTournamentNameEn ;
      logic.annualHobbyTournamentCount = arinfe.annualHobbyTournamentCount.toString();

      logic.annualMaxSettleAmountCreateTime = arinfe.annualMaxSettleAmountCreateTime;
      logic.annualMaxBetAmountCreateTime = arinfe.annualMaxBetAmountCreateTime;
      logic.annualMaxBetAmountTournamentIdName = Get.locale?.languageCode == 'zh' ? arinfe.annualMaxBetAmountTournamentIdNameCn :Get.locale?.languageCode == 'tw' ?  arinfe.annualMaxBetAmountTournamentIdNameTw : arinfe.annualMaxBetAmountTournamentIdNameEn ;
      logic.sannualMaxBetAmountMatchIdName = Get.locale?.languageCode == 'zh' ? arinfe.annualMaxBetAmountMatchIdNameCn :Get.locale?.languageCode == 'tw' ?  arinfe.annualMaxBetAmountMatchIdNameTw : arinfe.annualMaxBetAmountMatchIdNameEn ;
      logic.annualMaxBetAmount = arinfe.annualMaxBetAmount.toString();
      logic.annualMaxBetAmountPlayOptionName = Get.locale?.languageCode == 'zh' ? arinfe.annualMaxBetAmountPlayOptionNameCn :Get.locale?.languageCode == 'tw' ?  arinfe.annualMaxBetAmountPlayOptionNameTw : arinfe.annualMaxBetAmountPlayOptionNameEn ;
      logic.annualMaxBetAmountPercentRank =    getRoundedPercent(arinfe.annualMaxBetAmountPercentRank) ;
      logic.annualMaxSettleAmount = arinfe.annualMaxSettleAmount.toString();
      logic.annualMaxSettleAmountPercentRank =  getRoundedPercent(arinfe.annualMaxSettleAmountPercentRank);
      logic.annualHobbySportBackgroundType =  arinfe.annualHobbySportBackgroundType;
      logic.annualHobbyTournamentBackgroundType =  arinfe.annualHobbyTournamentBackgroundType;
      print(arinfe.annualMaxBetAmountMatchIdNameCn);

      print(decrypted.toString());
      logic.annualMaxBetCurrency = Get.locale?.languageCode == 'zh' ? arinfe.annualMaxBetCurrencyCn :Get.locale?.languageCode == 'tw' ?  arinfe.annualMaxBetCurrencyCn : arinfe.annualMaxBetCurrencyEn ;
      logic.annualMaxSettleCurrency = Get.locale?.languageCode == 'zh' ? arinfe.annualMaxSettleCurrencyCn :Get.locale?.languageCode == 'tw' ?  arinfe.annualMaxSettleCurrencyCn : arinfe.annualMaxSettleCurrencyEn ;

      ///条件满足不展示 6 7 模版
      if (!(int.parse(logic.annualMaxBetAmountPercentRank) >= 50 && int.parse(logic.annualMaxSettleAmountPercentRank) >= 50 && int.parse(logic.annualBetPercentRank) >= 50)) {

       reportPO  = reportPO.where((element) {
          return element.pageNo!= 6 && element.pageNo != 7;
        }).toList();
      }
    } else {
      // ToastUtils.show(res.msg);
      logic.noData = true;
    }
    update();
    // print('年度最大投注金额百分比排名: $annualMaxBetAmountPercentRank');
    // print('年度最大结算金额百分比排名: $annualMaxSettleAmountPercentRank');
    // print('年度投注百分比排名: $annualBetPercentRank');
  }

  ///年报埋点接口
  Future<void> initFillingPoint(int eventId) async {
    final res = await BaseDataApi.instance().eventCollection(
      Platform.isAndroid ? 3 : 4,
      eventId,
      "2023亚洲版",
      '2',
    );
    print(res);
    update();
  }

  ///熊猫入场动画
  void pandaEntranceAnimation() async {
    pandaAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    pandaAnimation = Tween<double>(begin: -200, end: 0).animate(CurvedAnimation(
      parent: pandaAnimationController,
      curve: Curves.easeInOut,
    ));

    /// 开始动画
    Future.delayed(Duration(milliseconds: 800), () {
      logic.pandaIsVisible = true;
      pandaAnimationController.forward(); // 启动动画
      update();
    });
    update();
  }




  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    audioPlayer.stop();
    audioPlayer.dispose();

    animationController.stop();
    animationController.dispose();
    pandaAnimationController.stop();
    pandaAnimationController.dispose();
    nbAnimationController.stop();
    nbAnimationController.dispose();
    bgAnimationController.stop();
    bgAnimationController.dispose();
    annualTitleAnimationController.stop();
    annualTitleAnimationController.dispose();
    testAnimationController1.stop();
    testAnimationController1.dispose();
    testAnimationController2.stop();
    testAnimationController2.dispose();
    testAnimationController3.stop();
    testAnimationController3.dispose();
    testAnimationController4.stop();
    testAnimationController4.dispose();
    testAnimationController5.stop();
    testAnimationController5.dispose();
    testAnimationController6.stop();
    testAnimationController6.dispose();
    leftAnimationController.stop();
    leftAnimationController.dispose();
    rightAnimationController.stop();
    rightAnimationController.dispose();
    upperSlipController.stop();
    upperSlipController.dispose();

    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    super.onClose();
  }

}
