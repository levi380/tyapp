
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/statistics_tab_switch_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/match_detail_tab.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_data_info/pages/basketball_data_page.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_data_info/pages/basketball_event_page.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../match_data_controller.dart';
import '../match_detail_controller.dart';
import '../match_tools_methods.dart';
import 'match_data_processor.dart';
import 'match_data_basketball_handler.dart';
import 'match_data_video_handler.dart';


/**
 * Tab管理模块
 * 负责Tab的初始化、切换和管理
 */
extension MatchDataTabManager on MatchDataController {
  /**
   * 标签初始化
   * 根据赛事类型（足球/篮球）和权限配置初始化不同的Tab
   * 篮球：数据tab、事件tab
   * 足球：根据权限显示全部事件、关键事件、精彩回放等tab
   */
  initTab() {
    MatchDetailController detailController =
        Get.find<MatchDetailController>(tag: tag);
    StatisticsTabSwitchEntity? statisticsTabSwitchEntity =
        detailController.detailState.statisticsTabSwitchEntity;

    MatchEntity? match = detailController.detailState.match;
    if (match?.csid == "2") {
      // 篮球赛事：初始化篮球tab
      state.basketballTabs.clear();

      // 是否显示篮球数据tab
      if (statisticsTabSwitchEntity?.statsData?.data == "1") {
        state.basketballTabs.add(MatchDetailTab(
          LocaleKeys.analysis_football_matches_analysis_data.tr,
          DetailTabType.statsDataData,
          (tag) => BasketballDataPage(
            tag: tag,
          ),
        ));
      }

      // 是否显示篮球事件tab
      if (statisticsTabSwitchEntity?.statsData?.event == "1") {
        state.basketballTabs.add(MatchDetailTab(
          LocaleKeys.analysis_event.tr,
          DetailTabType.statsDataEvent,
          (tag) => BasketballEventPage(
            tag: tag,
          ),
        ));
      }
    } else if (match?.csid == "1") {
      // 足球赛事：根据权限配置显示不同的事件tab
      // 如果开启精彩回放且满足显示条件，显示全部回放、进球回放、角球回放、罚球回放
      if (statisticsTabSwitchEntity?.statsData?.playBack == "1" &&
          needShowReplay(match)) {
        state.generalEventList = [
          LocaleKeys.analysis_all_events.tr,
          LocaleKeys.analysis_key_events.tr,
          LocaleKeys.app_play_back_tab_all_play_back.tr, // 全部回放
          LocaleKeys.app_play_back_tab_goal_play_back.tr, // 进球回放
          LocaleKeys.app_play_back_tab_corner_play_back.tr, // 角球回放
          LocaleKeys.app_play_back_tab_fapai_play_back.tr, // 罚球回放
        ];
      } else {
        // 未开启精彩回放：只显示全部事件、关键事件
        state.generalEventList = [
          LocaleKeys.analysis_all_events.tr,
          LocaleKeys.analysis_key_events.tr,
        ];
      }
    }

    state.tabController = TabController(
        length: match?.csid == "2" ? state.basketballTabs.length : 3,
        vsync: this);
  }

  /**
   * 设置当前标题页面索引
   * [index] 页面索引：0-全场，1-90分钟，2-加时赛
   * 切换页面时收起展开状态并重新获取数据
   */
  void setCurrentTitlePage(int index) {
    state.currentTitlePageIndex = index;
    state.isExpandImport = false;
    getData();
    update();
  }

  /**
   * 设置篮球tab
   * @param indexOf tab索引
   */
  void setBasketBallTab(int indexOf) {
    state.selectBasketBallIndex.value = indexOf;
    changeTemplate(state.listTabs[state.selectBasketBallIndex.value]);
    update();
  }

  /**
   * 事件切换
   * 切换通用事件列表索引
   * [index] 事件索引：0-全部事件，1-关键事件，2-全部回放，3-进球回放，4-角球回放，5-罚球回放
   * index < 2 表示实时事件，调用setSelectVideo
   * index >= 2 表示回放事件，调用dealTabVideo（需要减2作为参数）
   */
  void setGeneralEventList(int index) {
    state.currentGeneralEventIndex = index;
    if (index < 2) {
      // 实时事件：全部事件或关键事件
      setSelectVideo(index);
    } else {
      // 回放事件：需要减2作为dealTabVideo的参数
      dealTabVideo(index - 2);
    }
    update();
  }
}

