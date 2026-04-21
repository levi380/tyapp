import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_date_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';
import '../../../services/models/req/dj_list_req.dart';

/// 电竞游戏实体定义
class Game {
  Game(this.name, this.csid, this.euid, this.tid, this.img, this.alias);
  String alias;
  int csid;
  int euid;
  String? img;
  String name;
  String tid;
}

/// 视图分组枚举
enum ODJSectionGroupEnum {
  NOT_STARTED, // 未开赛
  IN_PROGRESS, // 进行中
  ALL, // 全部
}

/// 分组展开信息
class DJGroupExpandInfo {
  final bool isExpand;
  final ODJSectionGroupEnum groupEnum;
  DJGroupExpandInfo(this.isExpand, this.groupEnum);
}

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞列表 State】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞列表 State 临时存储数据
    】】】
 *
 */
class DjState {
  List<DjDateEntityEntity>? djDateEntity;
  List<MatchEntity> djListEntity = [];
  List<MatchEntity> tempList = []; //存储完整数据

  /// 电竞游戏配置
  /// - 封装电竞菜单的数据结构与默认列表
  /// - 统一在 DjState 中维护，避免散落在多个文件
  static List<Game> leagueList = [
    Game("收藏", 0, 0, '0', "", 'all'),
    Game("英雄联盟", SportConfig.lol.sportId - 2000, 41002, '239', "",
        'serie_league'),
    Game("Dota2", SportConfig.dota2.sportId - 2000, 41001, '320', "",
        'spanish_league'),
    Game("王者荣耀", SportConfig.honorOfKings.sportId - 2000, 41003, '276', "",
        'german_league'),
    Game("CS:Go/CS2", SportConfig.cs2.sportId - 2000, 41004, '79', "",
        'french_league'),
    Game("无畏契约", SportConfig.valorant.sportId - 2000, 41003, '72', "",
        'german_league'),
  ];

  /// 底部菜单图标（明/暗色）
  /// 统一管理视图中的资源路径，避免硬编码
  String mainTab1Light = 'assets/images/icon/main_tab1.png'; // 赛果-日间
  String mainTab1Dark = 'assets/images/icon/main_tab1_night.svg'; // 赛果-夜间
  String mainTab2Light = 'assets/images/icon/main_tab2.png'; // 设置-日间
  String mainTab2Dark = 'assets/images/icon/main_tab2_night.svg'; // 设置-夜间
  String mainTab3Light = 'assets/images/icon/main_tab3.png'; // 未结-日间
  String mainTab3Dark = 'assets/images/icon/main_tab3_night.svg'; // 未结-夜间
  String mainTab4Light = 'assets/images/icon/main_tab4.png'; // 已结-日间
  String mainTab4Dark = 'assets/images/icon/main_tab4_night.png'; // 已结-夜间
  String mainTab5Light = 'assets/images/icon/main_tab5.png'; // 刷新-日间
  String mainTab5Dark = 'assets/images/icon/main_tab5_night.svg'; // 刷新-夜间

  /// 足球篮球专题页入口相关图标
  String footballBasketballTemplate1 =
      'assets/images/icon/footballBasketballTemplate_1.png';
  String footballBasketballTemplate2 =
      'assets/images/icon/footballBasketballTemplate_2.png';
  String footballBasketballTemplate4 =
      'assets/images/icon/footballBasketballTemplate_4.png';
  String footballBasketballTemplate5 =
      'assets/images/icon/footballBasketballTemplate_5.png';

  /// 热门联赛、收藏、媒体、联赛箭头等图标
  /// 通过 controller.DJState 访问，便于后续主题与资源切换
  String hotLeagueSelectedActive =
      'assets/images/sports/selected_active.svg'; // 热门-选中
  String hotLeagueSelected = 'assets/images/sports/selected.svg'; // 热门-未选中
  String leagueSearchDark =
      'assets/images/home/league_search_nor.png'; // 联赛搜索-暗色
  String leagueSearchLight = 'assets/images/home/league_search.png'; // 联赛搜索-亮色
  String favSelectedSvg = 'assets/images/home/ico_fav_nor_sel.svg'; // 收藏-选中
  String favNormalDark = 'assets/images/home/ico_fav_nor.png'; // 收藏-暗色
  String favNormalLight = 'assets/images/home/ico_fav_nor_light.png'; // 收藏-亮色
  String leagueArrowRightDark =
      'assets/images/league/ico_arrowright_nor_darkmode.png'; // 联赛右箭头-暗色
  String leagueArrowRightLight =
      'assets/images/league/ico_arrowright_nor.png'; // 联赛右箭头-亮色
  String leagueItemExpandDark =
      'assets/images/league/item_expand_darkmode.png'; // 联赛展开-暗色
  String leagueItemExpandLight =
      'assets/images/league/item_expand.png'; // 联赛展开-亮色
  // lvs 直播   muUrl 视频  animationUrl 动画
  String sportFootballSvg =
      'assets/images/sport/ico_footerball.svg'; // 列表item图标-足球
  String sportVideoSvg = 'assets/images/sport/ico_video.svg'; // 列表item图标-视频
  String djBackArrow = 'assets/images/dj/icon_arrowleft_nor.svg'; // 电竞头部-返回
  String currencyUsdtIcon =
      'assets/images/home/icon_trans_nor_USDT.svg'; // 余额-USDT
  String currencyRmbIcon =
      'assets/images/home/icon_trans_nor_RMB.svg'; // 余额-RMB

  int oddsGroupColumns = 3; // 每页列数
  int oddsGroupRows = 2; // 每列展示行数
  int oddsButtonRadius = 2; // 赔率按钮圆角
  int oddsButtonWidthPhone = 60; // 赔率按钮宽度
  int oddsRowHeightPhone = 33; // 单行赔率高度
  int oddsWidgetWidthPhone = 184; // 赔率组容器宽度
  int oddsPageHeightPhone = 68; // 赔率页高度（
  int changeBetTypeAnimMs = 300; // 赔率分页切换动画时长
  int textScaleDeltaPage = 12; // 字体缩放额外高度
  int textScaleDeltaRow = 6; // 字体缩放额外高度

  /// 专业版-通用颜色常量
  Color djPrimaryTextColor = const Color(0xFF303442); // 主文字颜色（亮色）
  Color djSecondaryTextColor = const Color(0xFFAFB3C8); // 次要文字颜色（亮色）
  Color djDividerLightColor = const Color(0xFFE5E5E5); // 分割线颜色（亮色）

  /// 收藏图标选择封装
  /// 根据收藏状态与主题返回对应图标路径
  String favIcon({required bool isFav, required bool isDarkMode}) {
    if (isFav) return favSelectedSvg;
    return isDarkMode ? favNormalDark : favNormalLight;
  }

  /// 刷新中
  bool isLoading = false;

  ///选中日期
  DjDateEntityEntity? selectDate;

  /// 选中的菜单
  String gameId = ConfigController.to.gameMenuList.safeFirst?.mi ??
      SportConfig.lol.sportId.toString();

  DJListReq djListReq = DJListReq(
    category: 1,
    csid: '100',
    euid: '41002',
    hpsFlag: 0,
    md: '',
    sort: 2,
    type: 3000,
    cuid: TYUserController.to.getUid(),
  );

  /// 联赛
  Game league = DjState.leagueList.first;

  /// 是否展开
  var isExpand = true.obs;
  var isExpandProcess = true.obs;
  var isExpandAll = true.obs;
  var isExpandPin = true.obs;

  ///tids合并list
  List<String> collopList = [];
}
