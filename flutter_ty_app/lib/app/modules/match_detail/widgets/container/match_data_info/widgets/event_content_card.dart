import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import '../../../../extension/theme_extension.dart';
import '../../../../states/match_data_state.dart';

/// 事件内容卡片组件
/// 显示事件的详细信息，包括时间、球员、比分等
class EventContentCard extends StatelessWidget {
  const EventContentCard({
    super.key,
    required this.eventItem,
    required this.isLeft, // true: 左侧显示，false: 右侧显示
  });

  final AnalyzeLiveVideoLiveEventEntityDataEvents eventItem;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    final secondsFromTart = int.tryParse(eventItem.secondsFromTart ?? '0') ?? 0;
    final hasVideo = eventItem.fragmentPic?.isNotEmpty == true;

    return Container(
      constraints: BoxConstraints(minWidth: 158.w, minHeight: 32.w),
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: Get.theme.analsTextTabBgColor,
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
      ),
      child: isLeft ? _buildLeftContent(secondsFromTart, hasVideo) : _buildRightContent(secondsFromTart, hasVideo),
    );
  }

  /// 构建左侧内容（主队事件）
  Widget _buildLeftContent(int secondsFromTart, bool hasVideo) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (hasVideo)
          ImageView(
            'assets/images/icon/icon_play_list.png',
            width: 18.w,
            height: 18.w,
          ),
        if (hasVideo) SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (eventItem.centerTopName?.isNotEmpty == true)
              Text(
                eventItem.centerTopName ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: MatchDataState.eventContentTextFontSize.sp,
                  fontWeight: MatchDataState.eventContentTitleFontWeight,
                  color: Get.theme.tabPanelSelectedColor,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (eventItem.player1Name?.isNotEmpty == true ||
                    eventItem.centerName?.isNotEmpty == true)
                  Text(
                    eventItem.centerName ?? eventItem.player1Name ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: MatchDataState.eventContentTextFontSize.sp,
                      color: Get.theme.tabPanelSelectedColor,
                    ),
                  ),
                if (eventItem.player1Name?.isNotEmpty == true ||
                    eventItem.centerName?.isNotEmpty == true)
                  SizedBox(width: 4.w),
                if (eventItem.t1?.isNotEmpty == true &&
                    eventItem.t2?.isNotEmpty == true)
                  Text(
                    "${eventItem.t1.toString()}:${eventItem.t2.toString()}",
                    style: TextStyle(
                      fontSize: MatchDataState.eventContentTextFontSize.sp,
                      color: Get.theme.tabPanelSelectedColor,
                    ),
                  ),
              ],
            ),
          ],
        ),
        SizedBox(width: 8.w),
        Container(
          height: 32.w,
          width: 1.w,
          color: Get.theme.selectTabPanelBgColor,
        ),
        SizedBox(width: 8.w),
        _buildTimeText(secondsFromTart),
      ],
    );
  }

  /// 构建右侧内容（客队事件）
  Widget _buildRightContent(int secondsFromTart, bool hasVideo) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildTimeText(secondsFromTart),
            SizedBox(width: 6.w),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 6.w),
                height: 32.w,
                width: 1.w,
                color: Get.theme.selectTabPanelBgColor,
              ),
            ),
            SizedBox(width: 6.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (eventItem.centerTopName?.isNotEmpty == true)
                  Container(
                    constraints: BoxConstraints(maxWidth: 90.w),
                    child: Text(
                      eventItem.centerTopName ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: MatchDataState.eventContentTextFontSize.sp,
                        fontWeight: MatchDataState.eventContentTitleFontWeight,
                        color: Get.theme.tabPanelSelectedColor,
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (eventItem.player2Name?.isNotEmpty == true ||
                        eventItem.centerName?.isNotEmpty == true)
                      Text(
                        eventItem.centerName ?? eventItem.player2Name ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: MatchDataState.eventContentTextFontSize.sp,
                          color: Get.theme.tabPanelSelectedColor,
                        ),
                      ),
                    if (eventItem.player2Name?.isNotEmpty == true ||
                        eventItem.centerName?.isNotEmpty == true)
                      SizedBox(width: 4.w),
                    if (eventItem.t1?.isNotEmpty == true &&
                        eventItem.t2?.isNotEmpty == true)
                      Text(
                        "${eventItem.t1?.isEmpty == true ? "" : "${eventItem.t1}:"}${eventItem.t2.toString()}",
                        style: TextStyle(
                          fontSize: MatchDataState.eventContentTextFontSize.sp,
                          color: Get.theme.tabPanelSelectedColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
        if (hasVideo)
          Align(
            alignment: Alignment.centerRight,
            child: ImageView(
              'assets/images/icon/icon_play_list.png',
              width: 18.w,
              height: 18.w,
            ),
          ),
      ],
    );
  }

  /// 构建时间文本
  Widget _buildTimeText(int secondsFromTart) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          secondsFromTart > 5400
              ? '90'
              : FormatDate.formatSecondMs(secondsFromTart, model: 'minute'),
          style: TextStyle(
            fontSize: MatchDataState.eventContentTextFontSize.sp,
            color: Get.theme.tabPanelSelectedColor,
          ),
        ),
        // 加时赛
        if (secondsFromTart - 5400 > 0)
          Text(
            ' +${FormatDate.formatSecondMs(secondsFromTart - 5400, model: 'minute')}',
            style: TextStyle(
              fontSize: MatchDataState.eventContentTextFontSize.sp,
              color: Get.theme.tabPanelSelectedColor,
            ),
          ),
      ],
    );
  }
}

