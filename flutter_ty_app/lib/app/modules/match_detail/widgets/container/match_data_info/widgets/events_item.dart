import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';
import '../../../../controllers/match_data_controller.dart';

import 'event_content_card.dart';
import 'event_icon_line.dart';
import 'event_video_service.dart';
import 'match_status_widget.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE  篮球重点数据页面】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  数据-事件 子项
    】】】
 */
class EventsItem extends StatelessWidget {
  const EventsItem(
      {super.key, required this.eventItem, required this.controller});

  final AnalyzeLiveVideoLiveEventEntityDataEvents eventItem;
  final MatchDataController controller;

  /// 构建事件项组件
  /// 
  /// 该方法构建比赛事件列表中的单个事件项：
  /// 1. 根据事件类型（match_status、home、away）显示不同位置的事件
  /// 2. 主队事件显示在左侧，客队事件显示在右侧
  /// 3. 比赛状态事件（如中场休息）显示在中间
  /// 4. 支持点击播放视频功能（如果有视频URL）
  /// 5. 显示事件图标和连接线
  /// 
  /// 视频播放逻辑：
  /// - 全部事件：播放fragmentPic对应的视频
  /// - 回放事件：播放fragmentVideo对应的视频，并切换到回放模式
  /// 
  /// 参数：
  /// - context: 构建上下文
  /// 
  /// 返回：
  /// - Widget: 返回事件项组件，包含事件信息和可能的视频播放功能
  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    
    void onPlayVideo() {
      EventVideoService.playEventVideo(eventItem, controller.tag, state);
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        _buildEventContent(onPlayVideo),
        if (eventItem.eventCode != 'match_status')
          EventIconLine(
            eventItem: eventItem,
            controller: controller,
          ),
      ],
    );
  }

  /// 构建事件内容
  Widget _buildEventContent(VoidCallback onPlayVideo) {
    if (eventItem.eventCode == 'match_status') {
      return eventItem.matchPeriodId == "31"
          ? InkWell(child: const MatchStatusWidget())
          : const SizedBox();
    } else if (eventItem.homeAway == 'home') {
      return InkWell(
        onTap: onPlayVideo,
        child: _buildLeftItem(),
      );
    } else {
      return InkWell(
        onTap: onPlayVideo,
        child: _buildRightItem(),
      );
    }
  }

  /// 构建左侧事件项（主队事件）
  Widget _buildLeftItem() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EventContentCard(
                  eventItem: eventItem,
                  isLeft: true,
                ),
              ],
            ),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }




  /// 构建右侧事件项（客队事件）
  Widget _buildRightItem() {
    return Row(
      children: [
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                EventContentCard(
                  eventItem: eventItem,
                  isLeft: false,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
