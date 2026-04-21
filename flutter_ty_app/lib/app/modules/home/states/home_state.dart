import 'dart:async';

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/home/models/hot_league_info.dart';
import 'package:flutter_ty_app/app/modules/home/models/match_list_type.dart';
import 'package:flutter_ty_app/app/modules/home/models/refresh_status.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/req/match_list_req.dart';
import 'package:flutter_ty_app/app/services/models/res/get_odd_count_bean_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/outright_display_matchs_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';
import 'package:flutter_ty_app/app/config/analytic/analytics_utils.dart';

import '../../../db/app_cache.dart';
import '../models/main_menu.dart';




class HomeState {

  List<CombineInfo> combineList = [];
  /// 日期
  int? dateTime;

  /// 新增优惠赔率数量
  int discountCount = 0;

  List<String> discountMidStringList = [];
  /// 联赛列表是否停止滚动
  bool endScroll = true;

  /// 是否展开
  Map<SectionGroupEnum, bool> expandMap = {
    SectionGroupEnum.IN_PROGRESS: true,
    SectionGroupEnum.NOT_STARTED: true,
    SectionGroupEnum.ALL: true,
  };

  Map<String, bool> expandStateCache = {};

  /// 新增优惠赔率折叠
  bool isFold = false;

  bool isHot = BoolKV.sort.get() ?? true;
  var isLight = !Get.isDarkMode;
  /// 是否专业版
  bool isProfess = BoolKV.userVersion.get() ?? true;

  /// 处于搜索模式
  bool isSearch = false;

  /// 选中的联赛
  HotLeagueInfo league = HotLeagueInfo(SportConfigInfo());

  /// 列表类型
  MatchListType listType = MatchListType.home;

  /// 赛事列表请求实体
  MatchListReq matchListReq = MatchListReq(
      cuid: TYUserController.to.getUid(),
      euid: '40203',
      // 默认足球
      type: 3,
      sort: BoolKV.sort.get() ?? true ? 1 : 2,
      device: 'v2_h5_st',
      hpsFlag: 0,
      category: 1,
      md: null,
      tid: null);

  /// 新增优惠赔率
  List<MatchEntity> matchtDiscount = [];

  // 新增优惠赔率  对象
  GetOddCountBeanEntity? oddCountBeanEntity;
  /// 赛事列表
  List<MatchEntity> matchtSet = [];

  /// 菜单
  MainMenu menu = MainMenu.menuList.first;

  Map<String, MatchEntity> outrightDisplayMap = {};
  ///冠军引导的返回实体
  OutrightDisplayMatchsEntity? outrightDisplayMatchsEntity;

  /// 刷新中
  RefreshStatus refreshStatus = RefreshStatus.isLoading;

  String searchText = '';
  ///优惠盘口  显示和列表下标计算开关
  bool showMatchtDiscount = true;

  /// 选中的菜单
  String sportId = ConfigController.to.sportMenuList.safe(1)?.mi ?? '101';

  Timer? timerForMatchById;

  // 50000:收藏   1:滚球  2:今日  3:早盘  4:电子竞技  6:串关
  Map<int, AnalyticsEvent> sportMenuMap = {
    50000: AnalyticsEvent.menu_rolling,
    1: AnalyticsEvent.menu_rolling,
    2: AnalyticsEvent.menu_today,
    3: AnalyticsEvent.menu_early,
    5: AnalyticsEvent.menu_combo,
    6: AnalyticsEvent.menu_combo,
    400: AnalyticsEvent.menu_champion,
  };

  /// 显示画中画
  bool isShowPipVideo = false;

  ///已获取到数据的赛事id
  Set<String> showMatchIdSet = {};
  //可视区
  int visiableFirstIndex = 0;
  int visiableLastIndex = 0;
  //第一次获取
  bool firstFetch = true;

  // ========================== 视图常量配置 ==========================
  /// 专题页动画按钮相关常量
  static const double olympicButtonWidth = 70.0; // 专题页按钮宽度
  static const double olympicButtonHeight = 100.0; // 专题页按钮高度
  static const double olympicCloseButtonWidth = 13.0; // 关闭按钮宽度
  static const Duration olympicAnimationDuration =
      Duration(milliseconds: 240); // 动画持续时间
  static const double olympicButtonMarginRight = 10.0; // 右边距
  static const double olympicCloseButtonHeight = 20.0; // 关闭按钮高度

  /// 冠军列表滚动配置
  static const double championShowTopThreshold = 800.0; // 显示顶部按钮阈值
  static const Duration championHideTopDelay =
      Duration(milliseconds: 3000); // 隐藏顶部按钮延迟

  /// 骨架屏配置
  static const int skeletonItemCount = 8; // 骨架屏项目数量
  static const double skeletonPaddingHorizontal = 8.0; // 骨架屏水平内边距
  static const double skeletonBoxDefaultRadius = 10.0; // 骨架屏默认圆角
  static const double skeletonIconSize = 18.0; // 骨架屏图标大小
  static const double skeletonIconRadius = 4.0; // 骨架屏图标圆角
  static const double skeletonIconMarginRight = 4.0; // 骨架屏图标右边距
  static const double skeletonItemWidth = 32.0; // 骨架屏项目宽度
  static const double skeletonItemHeight = 12.0; // 骨架屏项目高度
  static const double skeletonItemRadius = 24.0; // 骨架屏项目圆角
  static const double skeletonTopItemHeight = 16.0; // 骨架屏顶部项目高度
  static const double skeletonTopItemSpacing = 7.0; // 骨架屏顶部项目间距
  static const double skeletonMiddleItemWidth = 170; // 骨架屏中间项目宽度
  static const double skeletonMiddleItemHeight = 12; // 骨架屏中间项目高度
  static const double skeletonMiddleItemRadius = 4; // 骨架屏中间项目圆角
  static const double skeletonBottomMargin = 8; // 骨架屏底部外边距
  static const double skeletonItemPadding = 8; // 骨架屏项目内边距
  static const double skeletonBorderRadius = 6; // 骨架屏边框圆角

  /// 列表索引配置
  static const int commonListFirstIndex = 0; // 列表起始索引
  static const int commonListLastIndex = 10; // 列表结束索引

  /// 颜色配置
  static const Color skeletonLightBackgroundColor =
      Color(0xffF8F9FA); // 骨架屏亮色背景
  static const Color skeletonLightItemColor = Color(0xfff2f2f6); // 骨架屏亮色项目颜色
  static const double skeletonOpacityDark = 0.1; // 骨架屏暗色透明度
  static const double skeletonOpacityLight = 0.6; // 骨架屏亮色透明度

  /// 通用背景色
  static const Color commonBackgroundColor = Color(0xfff2f2f6);

  /// 列表项背景色
  static const Color listItemBackgroundColor = Color(0xffF8F9FA);

  /// 列表项边框颜色
  static const Color listItemBorderColor = Color(0xffFFFFFF);

  /// 分割线颜色 (亮色模式)
  static const Color dividerColorLight = Color(0xffE4E6ED);

  /// 分割线颜色 (暗色模式)
  static Color dividerColorDark = Colors.white.withAlpha(10);

  /// 其他UI配置
  static const double professionalBtnWidthIPad = 200; // ipad专业版按钮宽度
  static const double professionalBtnWidthMobile = 90; // 手机型号专业版按钮宽度
  static const double outrightDisplayItemHeight = 50; // 冠军展示项高度
  static const String olympicCloseButtonAsset =
      'assets/images/home/olympic_close.png'; // 专题页关闭按钮资源路径

  /// 顶部按钮图标 (暗色模式)
  static const String backTopImageDark = 'assets/images/home/back_top_d.png';

  /// 顶部按钮图标 (亮色模式)
  static const String backTopImageLight = 'assets/images/home/back_top_l.png';

  /// 列表项间距配置
  static const double listItemHorizontalPadding = 5; // 列表项水平内边距
  static const double listItemBottomPadding = 8; // 列表项底部内边距
  static const double listItemBorderRadius = 8; // 列表项边框圆角
  static const double listItemDividerHeight = 0.4; // 列表项分割线高度
  static const double listItemBottomMargin = 1; // 列表项底部外边距
  static const double listItemOpacity = 0.03999999910593033; // 列表项透明度
  static const double listItemHorizontalSpacing = 3; // 列表项水平间距

  /// 动画偏移配置
  static const double olympicAnimationOffsetBegin = 0.5; // 专题页动画起始偏移
  static const double olympicAnimationOffsetEnd = 0; // 专题页动画结束偏移

  /// 其他UI数值
  static const double homeViewTopPadding = 80; // 首页顶部内边距
  static const double homeViewTopPaddingSecondary = 50; // 首页次级顶部内边距
  static const double homeViewImageHeight = 50; // 首页图片高度
  static const double ipadImageWidth = 30; // ipad图片宽度
  static const double mobileImageWidth = 40; // 手机图片宽度
  static const double ipadImageHeight = 30; // ipad图片高度
  static const double mobileImageHeight = 40; // 手机图片高度
  static const double listItemVerticalSpacing = 4; // 列表项垂直间距
  static const double outrightBottomPadding = 90; // 冠军底部内边距
  static const double outrightRightPadding = 14; // 冠军右侧内边距
  static const double bottomHideSwitchThreshold = 320; // 底部隐藏开关阈值
  static const double bottomShowSwitchThreshold = 120; // 底部显示开关阈值

  /// 动画时长配置
  ///列表返回顶部动画时长
  static const Duration commonScrollToTopDuration = Duration(milliseconds: 200);

  /// 菜单滑动动画时长
  static const Duration menuScrollDuration = Duration(milliseconds: 300);

  /// 获取赛事详细数据，一页数量
  static const int pageCount = 20;
}
