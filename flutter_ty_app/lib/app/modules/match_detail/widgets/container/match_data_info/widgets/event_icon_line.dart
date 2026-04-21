import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_data_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/data/match_data_event_handler.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';

/// 事件图标和连接线组件
/// 显示事件图标和下方的蓝色连接线
class EventIconLine extends StatelessWidget {
  const EventIconLine({
    super.key,
    required this.eventItem,
    required this.controller,
  });

  final AnalyzeLiveVideoLiveEventEntityDataEvents eventItem;
  final MatchDataController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.h),
          child: ImageView(
            "assets/images/match_analysis/${controller.getImgId(eventItem)}.png",
            width: 10.w,
            height: 10.w,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.h),
          width: 2,
          height: 40.h,
          color: MatchDataState.eventLineColor,
        ),
      ],
    );
  }
}

