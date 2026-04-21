import 'dart:io';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../../utils/oss_util.dart';
import 'annual_report_controller.dart';


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
extension AnnualReportControllerExt on AnnualReportController{

  ///文字动画
  void textAnimationn() async {
    /// 第一个文本项动画
    testAnimationController1 = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..forward();

    testOpacityAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: testAnimationController1,
        curve: Curves.easeIn,
      ),
    );

    testFallAnimation1 = Tween<double>(begin: -250.0, end: 0.0).animate(
      CurvedAnimation(
        parent: testAnimationController1,
        curve: Curves.easeOut,
      ),
    );

    /// 第二个文本项动画
    testAnimationController2 = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..forward();

    testOpacityAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: testAnimationController2,
        curve: Interval(0.1, 1.0, curve: Curves.easeIn),
      ),
    );

    testFallAnimation2 = Tween<double>(begin: -250.0, end: 0.0).animate(
      CurvedAnimation(
        parent: testAnimationController2,
        curve: Interval(0.1, 1.0, curve: Curves.easeOut),
      ),
    );

    /// 第三个文本项动画
    testAnimationController3 = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..forward();

    testOpacityAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: testAnimationController3,
        curve: Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    testFallAnimation3 = Tween<double>(begin: -250.0, end: 0.0).animate(
      CurvedAnimation(
        parent: testAnimationController3,
        curve: Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    /// 第四个文本项动画
    testAnimationController4 = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..forward();

    testOpacityAnimation4 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: testAnimationController4,
        curve: Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    testFallAnimation4 = Tween<double>(begin: -250.0, end: 0.0).animate(
      CurvedAnimation(
        parent: testAnimationController4,
        curve: Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    /// 第五个文本项动画
    testAnimationController5 = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..forward();

    testOpacityAnimation5 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: testAnimationController5,
        curve: Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    testFallAnimation5 = Tween<double>(begin: -250.0, end: 0.0).animate(
      CurvedAnimation(
        parent: testAnimationController5,
        curve: Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    /// 第六个文本项动画
    testAnimationController6 = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..forward();

    testOpacityAnimation6 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: testAnimationController6,
        curve: Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    testFallAnimation6 = Tween<double>(begin: -250.0, end: 0.0).animate(
      CurvedAnimation(
        parent: testAnimationController6,
        curve: Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    update();
  }

  ///日期 年报用户报告动画
  void dateAnimation() async {
    nbAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    nbAnimation =
        Tween<double>(begin: 1.0, end: 1.5).animate(nbAnimationController);

    /// 添加监听器以控制循环次数
    nbAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        logic.dateCount++;
        if (logic.dateCount < 4) {
          nbAnimationController.reverse();
        } else {
          nbAnimationController.stop();
        }
      } else if (status == AnimationStatus.dismissed) {
        nbAnimationController.forward();
      }
    });

    /// 启动动画
    nbAnimationController.forward();
    update();
  }

  /// 生成报告动画
  void generateReport() async {
    bgAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    bgAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(bgAnimationController);
    /// 使用 repeat() 方法使动画循环播放
    bgAnimationController.repeat(reverse: true);
    update();
  }

  /// 年度称号动画
  void annualTitle() async {
    annualTitleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    annualTitleAnimation = Tween<double>(begin: 0.9, end: 1.0)
        .animate(annualTitleAnimationController);

    /// 使用 repeat() 方法使动画循环播放
    annualTitleAnimationController.repeat(reverse: true);

    update();
  }

  ///向上滑动动画
  void perSlip() {
    upperSlipController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    upperSlipAnimation = Tween<double>(begin: 0, end: -20).animate(CurvedAnimation(
      parent: upperSlipController,
      curve: Curves.easeInOut,
    ));

    update();
  }

  ///左右滑动动画
  void leftRightSlip() {
    leftAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    leftSlipAnimation = Tween<double>(begin: 0, end: -20).animate(CurvedAnimation(
      parent: upperSlipController,
      curve: Curves.easeInOut,
    ));

    rightAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    rightSlipAnimation = Tween<double>(begin: 0, end: 20).animate(CurvedAnimation(
      parent: upperSlipController,
      curve: Curves.easeInOut,
    ));

    update();
  }

  ///播放熊猫动画
  void playPanda() async {
    // 开始动画
    Future.delayed(Duration(milliseconds: 500), () {
      logic.pandaIsVisible = true;
      pandaAnimationController.forward(); // 启动动画
      update();
    });
  }


  ///音乐按钮 旋转播放动画
  void musicPlaybackRotation() async {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    update();
  }

  ///播放音乐
  void playMusic() async {
    /// 设置音量为 50%
    await audioPlayer.setVolume(0.5);
    await audioPlayer.play(UrlSource(
      OssUtil.getServerPath(
        'assets/images/nbyy.mp3',
      ),));
    await audioPlayer.setReleaseMode(ReleaseMode.loop);
    logic.isPlaying = true;
    update();
  }

  ///暂停音乐
  void pauseMusic() async {
    await audioPlayer.pause();
    logic.isPlaying = false;
    update();
  }

  ///生成报告
  onProductionReport() {
    logic.clickgenerateReport = true;
    pageController.jumpToPage(1);
    update();
  }

  ///再看一次
  onWatchItAgain() {
    pageController.jumpToPage(0);
    initFillingPoint(17);
    update();
  }

  /// 用户滑动时暂停自动滚动
  onPageChanged(int page) {
    print(page);
    if(logic.clickgenerateReport == true){
      logic.currentPage = page;
      /// 重置动画
      pandaAnimationController.reset();
      /// 重新播放动画
      pandaAnimationController.forward();

      textAnimationn();
      if (page == 0) {
        bgAnimationController.reset();
        bgAnimationController.forward();
        generateReport();
      }
      if (page == 8 || page == 9) {
        annualTitle();
        leftRightSlip();
      } else {
        annualTitleAnimationController.stop();
      }
      logic.dateCount = 0;
      logic.bgCount = 0;
      nbAnimationController.reset();
      nbAnimationController.forward();
      update();
    }else {
      pageController.jumpToPage(0);
      return;
    }
  }

  ///称号弹框开关
  onTitlePopUp() {
    logic.titlePopUp = !logic.titlePopUp;
    update();
  }

  /// URL 地址开头头是否包含https
  String ensureHttps(String url) {
    if (!url.startsWith('https://')) {
      url = 'https://$url';
    }
    return url;
  }

  String getRoundedPercent(double percentRank) {
    /// 将百分比转换为整数并四舍五入
    int roundedValue = (percentRank * 100).round();

    /// 如果四舍五入后的值超过99，则将其设置为99
    if (roundedValue > 99) {
      roundedValue = 99;
    }

    /// 返回结果的字符串形式
    return roundedValue.toString();
  }

  ///字体加载
  Future<void> loadFont() async {
    /// 使用 rootBundle.load 方法加载字体文件
    String fontPath = 'fonts/eryaxindahei.ttf';

    var fontData;
    try {
      fontData = rootBundle.load(fontPath);

      /// 使用 FontLoader 加载字体文件
      var myCustomFont = FontLoader('eryaxindahei')..addFont(fontData);

      /// 开始加载字体文件
      await myCustomFont.load();
    } catch (e) {
      fontPath = 'packages/flutter_ty_app/$fontPath';
      try {
        fontData = rootBundle.load(fontPath);

        /// 使用 FontLoader 加载字体文件
        var myCustomFont = FontLoader('eryaxindahei')..addFont(fontData);

        /// 开始加载字体文件
        await myCustomFont.load();
      } catch (ee) {
        // AppLogger.debug(ee.toString());
      }
    }

  }

  ///保存图片到相册
  onSaveToPhoto() async {
    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      /// 获取设备的存储路径
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = File('${directory.path}/ScreenshotOfAnnualReport.png');
      await imagePath.writeAsBytes(pngBytes);

      /// 保存到相册
      final result = await ImageGallerySaverPlus.saveFile(imagePath.path);
      print(result);
      ToastUtils.show(LocaleKeys.annual_user_report_0_screenshot.tr);
    } catch (e) {
      print(e);
      ToastUtils.show(LocaleKeys.annual_user_report_0_failed.tr);
    }
  }

}
