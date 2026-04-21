
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/data/data_event_extension.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/data/match_data_event_handler.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/data/match_data_tab_manager.dart';

import 'package:flutter_ty_app/app/modules/match_detail/controllers/data/match_data_analyze_initializer.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球数据控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 数据控制器
    - 数据初始化
    - 篮球足球切换
    】】】
 *
 */
class MatchDataController extends GetxController
    with GetTickerProviderStateMixin {
  final String tag;

  MatchDataController({required this.tag});

  final MatchDataState state = MatchDataState();

  /**
   * 控制器初始化方法
   * 初始化Tab、事件监听、数据和事件数据
   */
  @override
  void onInit() {
    super.onInit();

    initTab();
    initBus();
    initData();
    initEventData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    // 释放 Bus 监听
    Bus.getInstance().off(EventType.updata_detail_data);
    // 释放 TabController
    state.tabController?.dispose();
    state.tabController = null;
    // 释放 EventTabController
    state.eventTabController?.dispose();
    state.eventTabController = null;
    super.dispose();
  }

  /**
   * 过滤进球额外信息
   * @param key 额外信息key
   * @return 过滤后的信息
   */
  String filterGoalExtraInfo(String key) {
    Map<String, String> extraInfoMap = {
      "2": LocaleKeys.match_result_own_goals.tr,
    };
    return extraInfoMap[key] ?? LocaleKeys.match_result_goal.tr;
  }

  /**
   * 设置是否可以扩展
   * 切换事件列表的展开/收起状态
   */
  void setExpandImport() {
    state.isExpandImport = !state.isExpandImport;
    setExpandImportNotValue();
    update();
  }

  /**
   * 设置不可以扩展
   * 根据展开状态和最大显示数量设置当前事件数据列表
   * currentGeneralEventIndex < 2 表示全部事件或关键事件
   * currentGeneralEventIndex >= 2 表示精彩回放相关事件
   */
  void setExpandImportNotValue() {
    // 全部事件和关键事件的处理逻辑
    if (state.currentGeneralEventIndex < 2) {
      if (this.state.isExpandImport) {
        state.currentEventDataEvents =
            state.analyzeTotalLiveVideoEventDataEvents;
      } else {
        if (state.analyzeTotalLiveVideoEventDataEvents.length > state.MAX_INT) {
          state.currentEventDataEvents = state
              .analyzeTotalLiveVideoEventDataEvents
              .sublist(0, state.MAX_INT);
        } else {
          state.currentEventDataEvents =
              state.analyzeTotalLiveVideoEventDataEvents;
        }
      }
    }
    // 精彩回放逻辑
    else {
      if (state.isExpandImport) {
        state.currentEventDataEvents = state.totalEventDataEvents;
      } else {
        if (state.analyzeTotalLiveVideoEventDataEvents.length > state.MAX_INT) {
          state.currentEventDataEvents = state.totalEventDataEvents
              .toList(growable: true)
              .sublist(0, state.MAX_INT);
        } else {
          state.currentEventDataEvents =
              state.totalEventDataEvents.toList(growable: true);
        }
      }
    }
  }

  /**
   * 是否PD篮球
   * 判断是否为PD篮球赛事
   * @param match 赛事实体
   * @return 是否为PD篮球
   */
  bool idPDBasketball(MatchEntity? match) {
    return ['2', '91'].contains(match?.csid ?? "") && match?.ecds == 'PD';
  }
}
