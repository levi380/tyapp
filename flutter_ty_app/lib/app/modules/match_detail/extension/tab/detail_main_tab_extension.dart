import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/constants/detail_constant.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_analysis_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/match_detail_tab.dart';
import 'package:flutter_ty_app/app/modules/match_detail/views/odds_list_view.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/widget/appreciation_odds_widget.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_cup_point/match_cup_page.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_data_info/match_data_basketball_page.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_data_info/match_data_football_page.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_league_points/league_points_basketball_page.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_league_points/league_points_football_page.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_market_overview/match_market_news/match_market_new_page.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_market_overview/match_market_overview_page.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/match_statistics_container.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/sport.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import '../../../../global/config_controller.dart';

// 缓存的足球tabs, 提供给UI使用
List<MatchDetailTab> oBDetailCacheTabs = [];

/// 详情主Tab逻辑扩展
extension DetailMainTabExtension on MatchDetailController {
  /// 初始化主Tab导航
  void initMainTab() {
    final List<MatchDetailTab> tempTabs = [
      // 默认投注列表
      MatchDetailTab(
        LocaleKeys.app_betting.tr,
        DetailTabType.bet,
        (tag) => OddsListView(tag: tag),
      ),
    ];
    if (showMatchTab()) {
      final MatchEntity? match = detailState.match;
      final bool isShow = TyHomeController.to.homeState.menu.isEarly == false;
      final switchEntity = detailState.statisticsTabSwitchEntity;

      // 足球特殊处理（C01） 电子赛事 电子赛事不走权限验证
      if (match?.cds == "C01") {
        // 足球显示统计 - 统计模块
        if (match?.mss == 1) {
          tempTabs.add(
            MatchDetailTab(
              LocaleKeys.match_result_statistics.tr,
              DetailTabType.statistics,
              (tag) => MatchStatisticsContainer(tag: tag),
            ),
          );
        }
      } else {
        if (switchEntity != null) {
          // 数据
          if (checkStatsData() && isShow) {
            tempTabs.add(
              MatchDetailTab(
                LocaleKeys.analysis_football_matches_analysis_data.tr,
                DetailTabType.data,
                (tag) => detailState.match?.csid == "2"
                    ? MatchDataBasketballPage(tag: tag)
                    : MatchDataFootballPage(tag: tag),
              ),
            );
          }

          // 杯赛积分榜
          if (checkPoints()) {
            /// 构建联赛积分组件
            Widget _buildLeaguePointsWidget() {
              return detailState.match?.csid == "2"
                  ? LeaguePointsBasketballPage(tag: detailState.tag)
                  : LeaguePointsFootballPage(tag: detailState.tag);
            }

            if (switchEntity.points?.pointType == "2") {
              // 杯赛积分组件
              tempTabs.add(
                MatchDetailTab(
                  LocaleKeys.analysis_football_matches_cup_points.tr,
                  DetailTabType.cupIntegral,
                  (tag) => MatchCupPage(tag: tag),
                ),
              );
            } else {
              // 联赛积分
              tempTabs.add(
                MatchDetailTab(
                  LocaleKeys.analysis_football_matches_league_points.tr,
                  DetailTabType.leagueIntegral,
                  (tag) => _buildLeaguePointsWidget(),
                ),
              );
            }
          }

          // 统计模块
          if (checkStatistics()) {
            tempTabs.add(
              MatchDetailTab(
                LocaleKeys.match_result_statistics.tr,
                DetailTabType.statistics,
                (tag) => MatchStatisticsContainer(tag: tag),
              ),
            );
          }

          // 盘面 显示统计 - 篮球文章 和 足球盘面
          if (checkMarketView()) {
            if (detailState.match?.csid == "2") {
              // 赛事文章
              tempTabs.add(
                MatchDetailTab(
                  LocaleKeys.analysis_football_matches_match_article.tr,
                  DetailTabType.article,
                  (tag) => MatchMarketNewsPage(tag: tag),
                ),
              );
            } else {
              tempTabs.add(
                MatchDetailTab(
                  LocaleKeys.analysis_football_matches_Disk.tr,
                  DetailTabType.disk,
                  (tag) => MatchMarketOverview(tag: tag),
                ),
              );
            }
          }
          if (detailState.match?.csid == "1") {
            // 足球缓存导航tabs
            oBDetailCacheTabs = List<MatchDetailTab>.from(tempTabs);
          }
        } else {
          if (detailState.match?.csid == "1") {
            // 展示导航判断缓存中是否有导航数据,没有的话赋值原始数据
            initCacheTabs();
            tempTabs
              ..clear()
              ..addAll(oBDetailCacheTabs);
          }
        }
      }
    }

    // 更新主标签页
    detailState.mainTabs
      ..clear()
      ..addAll(tempTabs);
  }

  /// Tab 变更监听
  void _onTabChanged() {
    if (detailState.tabController == null) return;
    final idx = detailState.tabController!.index;
    if (idx.toDouble() == detailState.tabController!.animation?.value) {
      // 可以在此处添加 Tab 切换后的逻辑
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 详情列表】】】
      【【【 AUTO_PARAGRAPH_TITLE 详情主控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 设置当前选中标签
      】】】
   *
   */
  void setCurMainTab(int index) {
    detailState.curMainTab.value = index;
    update([matchBetMainTabGetBuildId]);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 详情列表】】】
      【【【 AUTO_PARAGRAPH_TITLE 详情主控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 标签初始化
      】】】
   *
   */
  void setTabController() {
    initMainTab();

    final newLength = detailState.mainTabs.length;
    // 计算新的 initialIndex（保留原 index，如果越界则取最大合法索引）
    int newIndex = 0;
    if (detailState.tabController != null) {
      final oldIndex = detailState.tabController!.index;
      if (newLength == 0) {
        newIndex = 0;
      } else {
        newIndex = oldIndex < newLength ? oldIndex : (newLength - 1);
      }
    }

    // 安全移除旧监听并 dispose
    detailState.tabController?.removeListener(_onTabChanged);
    detailState.tabController?.dispose();
    detailState.tabController = null;

    // 只有在有 tab 的情况下创建新的 controller
    if (newLength > 0) {
      detailState.tabController = TabController(
        length: newLength,
        vsync: this,
        initialIndex: newIndex,
      );
      detailState.tabController!.addListener(_onTabChanged);
    }
    update([matchBetMainTabGetBuildId]);
  }

  /// 是否展示详情 Tab
  bool showMatchTab() {
    // 足球篮球赛种后台开关开了才显示
    bool show = !['B03', 'O01'].contains(detailState.match?.cds) &&
        [SportData.sportCsid_1, SportData.sportCsid_2]
            .contains(int.tryParse(detailState.match?.csid ?? "")) &&
        ConfigController.to.accessConfig.value.statisticsSwitch &&
        (!(idPDBasketball(detailState.match)));

    return show;
  }

  /// 是否为 PD 模式的篮球赛事
  bool idPDBasketball(MatchEntity? match) {
    return ['2', '91'].contains(match?.csid ?? "") && match?.ecds == 'PD';
  }

  /// 初始化足球 Tab 缓存
  void initCacheTabs() {
    if (oBDetailCacheTabs.isEmpty) {
      List<MatchDetailTab> originalTabList = [
        // 投注
        MatchDetailTab(
          LocaleKeys.app_betting.tr,
          DetailTabType.bet,
          (tag) => OddsListView(
            tag: tag,
          ),
        ),
        // 数据
        MatchDetailTab(LocaleKeys.analysis_football_matches_analysis_data.tr,
            DetailTabType.data, (tag) => MatchDataFootballPage(tag: tag)),

        // 杯赛积分
        MatchDetailTab(LocaleKeys.analysis_football_matches_integral.tr,
            DetailTabType.cupIntegral, (tag) => MatchCupPage(tag: tag)),

        // 统计
        MatchDetailTab(
            LocaleKeys.match_result_statistics.tr,
            DetailTabType.statistics,
            (tag) => MatchStatisticsContainer(tag: tag)),

        // 盘面
        MatchDetailTab(LocaleKeys.analysis_football_matches_Disk.tr,
            DetailTabType.disk, (tag) => MatchMarketOverview(tag: tag)),
      ];
      if (detailState.isAppreciationOddsOpen) {
        // 增值赔率
        originalTabList.add(MatchDetailTab(
            LocaleKeys.analysis_football_matches_Disk.tr,
            DetailTabType.disk,
            (tag) => AppreciationOddsWidget()));
      }
      oBDetailCacheTabs = List<MatchDetailTab>.from(originalTabList);
    }
  }
}
