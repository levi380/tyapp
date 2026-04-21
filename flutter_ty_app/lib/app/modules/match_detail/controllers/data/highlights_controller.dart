import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/services/api/analyze_detail_api.dart';
import 'package:get/get.dart';

import '../../../../services/models/res/match_playback_video_info_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛事分析】】】
    【【【 AUTO_PARAGRAPH_TITLE 历史回放主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -精彩回放logic
    - 杯赛列表
    - 初始化以及销毁逻辑回调
    】】】
 */
class HighlightsController extends GetxController
    with GetTickerProviderStateMixin {
  HighlightsController({required this.tag});

  final String tag;
  TabController? tabController;

  // 是否有点球分类
  bool shootout = false;

  RxInt curMainTab = 0.obs;

  MatchPlaybackVideoInfoEntityEventList?
      curAnalyzeBackVideoInfoEntityEntityEntityEventList;

  MatchPlaybackVideoInfoEntity? analyzeBackVideoInfoEntity;
  List<MatchPlaybackVideoInfoEntityEventList> analyzeList = [];

  /// 控制器初始化方法
  /// 设置tab控制器并初始化数据
  @override
  void onInit() {
    super.onInit();
    setTabController();
    init();
  }

  /// 控制器准备就绪方法
  @override
  void onReady() {
    super.onReady();
  }

  /// 初始化方法
  /// 初始化数据
  init() {
    initData();
  }

  /**
   * 初始化数据
   * 请求回放数据并处理排序和点球分类
   * 按时间倒序排序（时间大的在前），时间相同则按序号倒序
   */
  void initData() async {
    // 请求回放数据
    AnalyzeDetailApi.instance().playbackVideoUrl(tag, "H5", "0").then((value) {
      analyzeBackVideoInfoEntity = value.data;
      // 按时间倒序排序，时间相同则按序号倒序
      (value.data?.eventList ?? []).sort((a, b) {
        if ((b.secondsFromStart ?? 0) < (a.secondsFromStart ?? 0)) {
          return -1;
        } else if ((b.secondsFromStart ?? 0) > (a.secondsFromStart ?? 0)) {
          return 1;
        }
        // 时间相同时，按序号倒序
        if ((b.firstNum ?? 0) < (a.firstNum ?? 0)) {
          return -1;
        } else if ((b.firstNum ?? 0) > (a.firstNum ?? 0)) {
          return 1;
        }

        return 0;
      });
      // 检查是否存在点球事件（extraInfo包含'5'表示点球）
      if ((value.data?.eventList ?? [])
              .where((element) => element.extraInfo?.contains('5') == true)
              .toList()
              .length >
          0) {
        shootout = true;
      } else {
        shootout = false;
      }
      analyzeList = value.data?.eventList ?? [];
      setTabController();
      update();
    });

    update();
  }

  /**
   * 处理不同分类的视频数据
   * [page] 页面索引：0-全部，1-进球，2-角球，3-黄牌，4-点球
   * 根据页面索引筛选对应类型的事件并按时间倒序排序
   */
  void dealTabVideo(int page) {
    MatchPlaybackVideoInfoEntity value =
        analyzeBackVideoInfoEntity ??
            MatchPlaybackVideoInfoEntity();
    if (page == 0) {
      // 全部事件：按时间倒序
      value.eventList.sort(
          (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      analyzeList = value.eventList;
    } else if (page == 1) {
      // 进球事件：筛选goal类型并按时间倒序
      List<MatchPlaybackVideoInfoEntityEventList>? eventList =
          getEventCode("goal", value);
      eventList.sort(
          (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      analyzeList = eventList;
    } else if (page == 2) {
      // 角球事件：筛选corner类型并按时间倒序
      List<MatchPlaybackVideoInfoEntityEventList>? eventList =
          getEventCode("corner", value);
      eventList.sort(
          (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      analyzeList = eventList;
    } else if (page == 3) {
      // 黄牌事件：筛选yellow_card类型并按时间倒序
      List<MatchPlaybackVideoInfoEntityEventList>? eventList =
          getEventCode("yellow_card", value);
      eventList.sort(
          (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      analyzeList = eventList;
    } else if (page == 4) {
      // 点球事件：筛选extraInfo包含'5'的事件并按时间倒序
      List<MatchPlaybackVideoInfoEntityEventList>? eventList =
          getDianQiuCode(value);
      eventList.sort(
          (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      analyzeList = eventList;
    }
    update();
  }

  /// 获取事件集合
  /// [eventCode] 事件代码
  /// [value] 回放视频信息实体
  List<MatchPlaybackVideoInfoEntityEventList> getEventCode(
      String eventCode, MatchPlaybackVideoInfoEntity value) {
    List<MatchPlaybackVideoInfoEntityEventList> eventList = [];
    for (MatchPlaybackVideoInfoEntityEventList MatchPlaybackVideoInfoEntityEventList
        in value.eventList) {
      if (MatchPlaybackVideoInfoEntityEventList.eventCode == eventCode) {
        eventList.add(MatchPlaybackVideoInfoEntityEventList);
      }
    }
    return eventList;
  }

  /// 获取点球集合
  /// [value] 回放视频信息实体
  List<MatchPlaybackVideoInfoEntityEventList> getDianQiuCode(
      MatchPlaybackVideoInfoEntity value) {
    List<MatchPlaybackVideoInfoEntityEventList> eventList = [];
    for (MatchPlaybackVideoInfoEntityEventList MatchPlaybackVideoInfoEntityEventList
        in value.eventList) {
      if (MatchPlaybackVideoInfoEntityEventList.extraInfo?.contains('5') ==
          true) {
        eventList.add(MatchPlaybackVideoInfoEntityEventList);
      }
    }
    return eventList;
  }

  /// 设置选中的项目
  /// [element] 回放视频信息事件列表项
  setSelectItem(MatchPlaybackVideoInfoEntityEventList element) {
    curAnalyzeBackVideoInfoEntityEntityEntityEventList = element;
    update();
  }

  /**
   * 设置tab控制器
   * 根据是否有点球分类创建不同长度的tab控制器
   * 有点球：3个tab（全部、进球、点球）
   * 无点球：4个tab（全部、进球、角球、黄牌）
   */
  void setTabController() {
    if (shootout) {
      // 有点球分类：3个tab
      tabController = TabController(length: 3, vsync: this)
        ..addListener(() {
          if (tabController?.index.toDouble() ==
              tabController?.animation?.value) {
            curMainTab.value = tabController?.index ?? 0;
            dealTabVideo(curMainTab.value);
          }
        });
    } else {
      // 无点球分类：4个tab
      tabController = TabController(length: 4, vsync: this)
        ..addListener(() {
          if (tabController?.index.toDouble() ==
              tabController?.animation?.value) {
            curMainTab.value = tabController?.index ?? 0;
            dealTabVideo(curMainTab.value);
          }
        });
    }

    update();
  }
}
