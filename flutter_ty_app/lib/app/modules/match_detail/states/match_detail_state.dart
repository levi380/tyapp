import 'dart:async';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rxdart/subjects.dart';
import '../../../../generated/locales.g.dart';
import '../../../../main.dart';
import '../../../services/models/res/analyze_v_s_info_entity.dart';
import '../../../services/models/res/category_list_entity.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../services/models/res/play_top_entity.dart';
import '../../../services/models/res/statistics_tab_switch_entity.dart';
import '../../../services/models/res/vr_hot_entity.dart';
import '../constants/detail_constant.dart';
import '../models/header_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/match_detail_tab.dart';
import '../models/request_status.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MatchDetailState {
  MatchEntity? match; // Rx<MatchEntity?>(null);

  /// 下拉联赛赛事数据
  List<MatchEntity> matchListData = [];

  /// ExtendedNestedScrollView 滚动controller
  ScrollController scrollController = ScrollController();

  RxBool showTopBtn = false.obs;

  /// 赛事分析tab控制开关
  StatisticsTabSwitchEntity? statisticsTabSwitchEntity;

  /// appbar悬停标识
  RxBool appbarPinned = false.obs;

  /// 赛事选择下拉标识
  RxBool isMatchSelectExpand = false.obs;

  /// 视频说明打开标识
  RxBool isOpenVideoInfo = false.obs;

  /// 头部状态 通用、视频、动画
  Rx<HeaderType> headerType = HeaderType.normal.obs;

  /// 当前一级标签页
  RxInt curMainTab = 0.obs;

  String mId = "";
  String csid = "";

  bool isDJDetail = false;

  /// 是否赛果
  bool isResult = false;

  /// 全屏标识
  RxBool fullscreen = false.obs;

  /// 详情loading
  bool detailLoading = true;

  /// 控制视频动画遮盖文字显示
  RxBool videoTopShow = true.obs;

  //进入视频，不隐藏工具栏，点击后触发隐藏逻辑
  bool lockVideoTopShow = true;

  /// 遮盖文字持久化
  bool topShowPermanent = false;

  /// 视频动画loading
  RxBool liveLoading = true.obs;

  /// 视频直播url
  String videoUrl = "";

  /// 动画直播url
  String animationUrl = "";

  /// 直播回放url
  String replayUrl = "";

  /// 选择的清晰度 0 标清 1高清
  RxInt selectLine = 0.obs;

  /// 视频直播声音
  RxBool liveMuted = false.obs;

  /// 视频区域是否固定
  RxBool videoFixed = true.obs;

  /// 头部固定高度
  RxDouble pinnedHeaderHeight = 0.0.obs;

  /// 记录真机状态栏高度（全屏切换时会变化）
  double physicalPaddingTop = 0;

  /// 投注原始数据
  List<MatchHps> oddsInfoList = [];

  // 筛选的列表
  List<dynamic> filterOddsInfoList = [];

  bool hasHotName = false;

  /// vr热门投注
  VrHotEntity? vrHotEntity;

  // vr体育锁盘状态
  bool vrLockStatus = false;
  bool isVrGameEnd = false;

  /// 投注请求状态RequestStatus
  RequestStatus oddsInfoRequestStatus = RequestStatus.loading;

  int oddsInfoRequestCount = 0;

  /// 当前选中玩法集 0所有投注
  String curCategoryTabId = "0";

  /// 玩法集
  List<CategoryListData> categoryList = [];

  /// 一键收起状态：1、全展开 2、全收起 3、部分展开  1和3箭头向下
  RxInt getFewer = 3.obs;

  /// 折叠动画控制
  bool toggleAnimate = false;

  /// 电竞Chpid
  Map<String, String> chpids = {};

  /// 节流
  late StreamSubscription<void> throttleCategoryList; // 玩法集
  late StreamSubscription<void> throttleOddsInfo; // 投注数据
  late StreamSubscription<void> throttleOddsInfoWithOneSecond; // 投注数据

  final throttleCategoryListSubject = PublishSubject<void>();
  final throttleOddsInfoSubject = PublishSubject<void>();
  final throttleOddsInfoSubjectWithOneSecond =
      PublishSubject<void>(); // 投注数据 : 一秒限流

  // InAppWebViewController? webViewController;
  late final WebViewController webViewController;

  /// 置顶控制
  // final eventController = DefaultEventController<dynamic>();

  /// 非全屏时动画高度
  RxDouble animateHeaderHeight = 0.0.obs;

  // 玩法集无数据
  bool oddsInfoIsNoData = true;

  // 变更的赛事 用于返回列表时提供给列表刷新
  List<String> mIds = [];

  // 保存展开收起状态
  Map<String, String> hShowMap = {};

  // 置顶状态列表
  List<PlayTopEntity> playTopList = [];

  bool endScroll = true;

  // GifController? gifController;

  // gif默认关闭
  RxBool gifAnimatedStatus = true.obs;

  /// 视频清晰度
  List<String> playTypeList = [
    LocaleKeys.video_flv.tr,
    LocaleKeys.video_m3u8.tr
  ];

  RxInt videoProgress = 0.obs;

  /// 记录赛事时间
  Map<String, String> matchTimes = {};

  // 底部导航
  bool showBottom = true;

  // 置顶操作标识
  bool topOpRequest = false;

  // 赛事切换锁 赛事切换有可能调用多次 导致切换错误
  bool eventSwitchLock = false;

  /// 头部高度 状态栏 + 置顶悬浮条 + 内容区域
  double obtyHeaderHeight = 200.h;

  /// 冠军引导盘赛事
  List<MatchEntity> championMatchs = [];

  // 赛事分析，显示杯赛积分，还是联赛积分
  RxList<AnalyzeVSInfoEntity> analyzeList = <AnalyzeVSInfoEntity>[].obs;

  // 是否是杯赛
  bool showCupMatch = false;

  // 展示使用的tab
  List<MatchDetailTab> mainTabs = [];

  // 首页带入的次要玩法playId
  String playId = "";

  // 首页带入的次要玩法玩法集id 进详情跳转对应玩法集
  String cid = "";

  // 首页带入的次要玩法玩法集pids
  String pids = "";

  // 展示全屏投注引导
  RxBool isShowBetGuide = false.obs;

  // 全屏按钮的key
  final GlobalKey fullscreenKey = GlobalKey();

  // 赛事分析开关用
  Timer? analysisTimer;


  // 开关 增值赔率开关 ture 打开  false 关闭
  bool  isAppreciationOddsOpen=false;

  GlobalKey<ExtendedNestedScrollViewState> matchScrollerViewGlobalKey = GlobalKey();

  // Getx controller tag 不可变
  late final String tag;

  TabController? tabController;
  bool isDarkMode = Get.isDarkMode;

  MatchDetailState() {
    physicalPaddingTop = Get.mediaQuery.padding.top;

    // 动画竖屏高度 宽度全屏
    animateHeaderHeight.value =
        1.sw / (obtyAnimateZ01Ratio) + physicalPaddingTop;
    if (isIPad) {
      obtyHeaderHeight = 300.h;
    } else {
      obtyHeaderHeight = 200.h;
    }

    categoryList.add(CategoryListData.fromJson({
      "id": "0",
      "marketName": LocaleKeys.app_play_category.tr,
      "orderNo": -2147483648
    }));

    final double statusBarHeight = physicalPaddingTop;
    pinnedHeaderHeight.value = statusBarHeight + obtyAppbarHeight;

    // 页面头部高度 加上状态栏高度
    obtyHeaderHeight = obtyHeaderHeight + physicalPaddingTop;
    // pinnedHeaderHeight.value = obtyHeaderHeight;
    obtyHeaderBottomHeight = (isIPad ? 68.h : 50.h);
  }
}
