import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import '../../../../../../services/models/res/analyze_live_video_live_event_entity_entity.dart';

/// 篮球事件页 - 单条事件行（时间 + 圆点 + 竖线 + 标题）
///
/// [eventItem] 事件数据；[isLast] 是否为最后一条（不画竖线）
class BasketballEventListItem extends StatelessWidget {
  final AnalyzeLiveVideoLiveEventEntityDataEvents eventItem;
  final bool isLast;

  const BasketballEventListItem({
    super.key,
    required this.eventItem,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final secondCount = int.tryParse(eventItem.secondsFromTart ?? '0') ?? 0;
    final minutes = (secondCount ~/ 60).toString().padLeft(2, '0');
    final minutesToSecond = (int.tryParse(minutes) ?? 0) * 60;
    final second = (secondCount - minutesToSecond).toString().padLeft(2, '0');
    final dotColor = _eventColor(eventItem);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.w),
      height: 40.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$minutes:$second',
            style: TextStyle(
              color: MatchDataState.basketballEventPageTextColor,
              fontSize: MatchDataState.basketballEventPageTextFontSize.sp,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 3.w),
                Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    color: dotColor,
                    borderRadius: BorderRadius.all(Radius.circular(6.w)),
                  ),
                ),
                SizedBox(height: 4.w),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.w,
                      decoration: BoxDecoration(
                        color: MatchDataState.basketballEventPageBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(2.w)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              eventItem.title ?? '',
              style: TextStyle(
                color: Get.theme.tabPanelSelectedColor,
                fontSize: MatchDataState.basketballEventPageTextFontSize.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Color _eventColor(AnalyzeLiveVideoLiveEventEntityDataEvents eventItem) {
    if (eventItem.homeAway?.isEmpty == true) return Colors.grey;
    if (eventItem.homeAway == 'home') return const Color.fromARGB(255, 23, 156, 255);
    if (eventItem.homeAway == 'away') return const Color.fromARGB(255, 255, 176, 1);
    return Colors.grey;
  }
}
