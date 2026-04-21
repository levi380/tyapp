
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/result/vr_results/widgets/vr_lq_item/vr_lq_itme_team_score_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/query_tournament_score_result_entity.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/change_skin_tone_color_util.dart';
import '../../../../../utils/time_zone/timeZoneUtils.dart';
import '../vr_lq_itme_sub_title_widget.dart';
import '../vr_lq_itme_title_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 篮球列表组件 VrLqItemWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 篮球列表组件 VrLqItemWidget
    - VrLqItemWidget
    ```
    VrLqItemWidget(
      isDark: context.isDarkMode,
      recordsList: controller.recordsList,
      isExpand: controller.isExpand,
      onExpandItem: () => controller.onExpandItem(),
      vRMenuMenuId: controller.vRMenuMenuId,
      scrollController: controller.scrollController,
    )
    ```
    】】】
 *
 */

class VrLqItemWidget extends StatelessWidget {
  const VrLqItemWidget({
    super.key,
    required this.isDark,
    required this.recordsList,
    this.onExpandItem,
    required this.isExpand,
    required this.vRMenuMenuId,
    required this.scrollController,
  });

  final bool isDark;
  final List<QueryTournamentScoreResultDataRecords> recordsList;
  final VoidCallback? onExpandItem;
  final bool isExpand;
  final String vRMenuMenuId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.h),
      child: Column(
        children: [
          _title(),
          _subTitle(),
          Expanded(
            child: _ListComponent(),
          )
        ],
      ),
    );
  }

  ///联赛头部
  Widget _title() {
    return VrLqItemTitleWidget(
      isDark: isDark,
      title: recordsList.isNotEmpty ? recordsList[0].tournamentName : '',
      onExpandItem: onExpandItem,
      isExpand: isExpand,
    );
  }

  ///玩法头部
  Widget _subTitle() {
    return VrLqItemSubTitleWidget(
      isDark: isDark,
      isExpand: isExpand,
      title: LocaleKeys.msc_S1.tr,
    );
  }

  ///联赛列表
  Widget _ListComponent() {
    return Visibility(
      visible: isExpand,
      maintainAnimation: true,
      maintainState: true,
      child: Container(
        decoration: isDark
            ? ShapeDecoration(
                color: ChangeSkinToneColorUtil.instance()
                    .getDarkBackgroundColor(
                        colorStyle_1: Color(0xFF2B2D33),
                        colorStyle_2: Color(0xFF23292D),
                        colorStyle_3: Color(0xFF26242A)),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1.w,
                    color: Colors.white.withValues(alpha: 0.03999999910593033),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                shadows: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ])
            : ShapeDecoration(
                color: const Color(0xFFF8F9FA),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.w, color: Colors.white),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: List<Widget>.generate(recordsList.length, (index) {
                return Container(
                  margin: EdgeInsets.only(
                    top: 3.h,
                  ),
                  decoration: index != recordsList.length - 1
                      ? BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isDark
                                  ? Colors.white
                                      .withValues(alpha: 0.07999999821186066)
                                  : const Color(0xFFE4E6ED),
                              width: 0.6.w,
                            ),
                          ),
                        )
                      : null,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    recordsList[index].batchNo.toString() +
                                        ' ' +
                                        LocaleKeys
                                            .zr_cp_Lottery_Bet_Slips_period.tr,
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white.withValues(alpha: 0.90)
                                          : const Color(0xFF303442),
                                      fontSize: isIPad ? 14.sp : 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Container(
                                    width: 4.w,
                                  ),
                                  Text(
                                    formatDateTime(int.tryParse(TimeZoneUtils
                                                    .convertTimeToTimestamp(
                                                        recordsList[index]
                                                            .matchTime,
                                                        isMilliseconds: true,
                                                        returnMilliseconds:
                                                            true)
                                                .toString()) ??
                                            0) +
                                        " (" +
                                        TimeZoneUtils.getTimeZoneString() +
                                        ")",
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white.withValues(alpha: 0.30)
                                          : const Color(0xFFAFB3C8),
                                      fontSize: isIPad ? 14.sp : 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Container(
                                    width: 8.w,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 4.h,
                      ),
                      Column(
                        children: [
                          VrLqItemTeamScoreWidget(
                              isDark: isDark,
                              teamIcon: recordsList[index].homeUrl,
                              teamName: recordsList[index].homeName,
                              score: recordsList[index]
                                  .scoreResult
                                  .split(':')[0]
                                  .toString()),
                          VrLqItemTeamScoreWidget(
                              isDark: isDark,
                              teamIcon: recordsList[index].awayUrl,
                              teamName: recordsList[index].awayName,
                              score: recordsList[index]
                                  .scoreResult
                                  .split(':')[1]
                                  .toString()),
                        ],
                      ),
                      Container(
                        height: 8.h,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
    var formatter = DateFormat('MM/dd HH:mm');
    return formatter.format(date);
  }
}
