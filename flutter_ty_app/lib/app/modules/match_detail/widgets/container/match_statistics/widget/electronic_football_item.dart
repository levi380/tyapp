
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';

import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/front_fight_p_b_bean_entity_electronic_football_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/main.dart';

/// 电子足球单个列表项组件
///
/// 展示单场赛事的日期、球队名及得分
class ElectronicFootballItem extends StatelessWidget {
  final int index;
  final FrontFightPBBeanEntityElectronicFootballEntity item;
  final String? leftTeam1;
  final String? leftUrl;
  final String? leftNumber;
  final String? rightTeam1;
  final String? rightUrl;
  final String? rightNumber;

  const ElectronicFootballItem({
    super.key,
    required this.index,
    required this.item,
    this.leftTeam1,
    this.leftUrl,
    this.leftNumber,
    this.rightTeam1,
    this.rightUrl,
    this.rightNumber,
  });

  @override
  Widget build(BuildContext context) {
    String? finalLeftUrl = leftUrl ?? 'assets/images/detail/default_team_home.svg';
    String? finalRightUrl = rightUrl ?? 'assets/images/detail/default_team_away.svg';
    
    if (((leftTeam1 ?? "") != (item.homeName ?? ""))) {
      String tempUrl = finalLeftUrl;
      finalLeftUrl = finalRightUrl;
      finalRightUrl = tempUrl;
    }
    
    return Container(
      color: Get.isDarkMode
          ? MatchStatisticMatchHistoryState.headOnConfrontationItemBackgroundColorDark
          : MatchStatisticMatchHistoryState.headOnConfrontationItemBackgroundColorLight,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: MatchStatisticMatchHistoryState.headOnConfrontationItemHorizontalPadding.w,
      ),
      height: MatchStatisticMatchHistoryState.headOnConfrontationItemHeight.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "${FormatDate.formatDate(int.tryParse(item.time ?? "0") ?? 0, formatString: "yyyy/MM/dd")}\n${item.mid} ",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isIPad
                      ? MatchStatisticMatchHistoryState.headOnConfrontationItemFontSizeIPad.sp
                      : MatchStatisticMatchHistoryState.headOnConfrontationItemFontSize.sp,
                  color: Get.theme.oddsTeamNameFontColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MatchStatisticMatchHistoryState.headOnConfrontationItemTeamNameWidth.w,
                  alignment: Alignment.centerRight,
                  child: Text(
                    textAlign: TextAlign.right,
                    item.homeName ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isIPad
                          ? MatchStatisticMatchHistoryState.headOnConfrontationItemFontSizeIPad.sp
                          : MatchStatisticMatchHistoryState.headOnConfrontationItemFontSize.sp,
                      color: Get.theme.tabPanelSelectedColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: MatchStatisticMatchHistoryState.headOnConfrontationItemIconSpacing.w,
                ),
                ImageView(
                  finalLeftUrl,
                  width: MatchStatisticMatchHistoryState.headOnConfrontationItemIconSize.w,
                  height: MatchStatisticMatchHistoryState.headOnConfrontationItemIconSize.w,
                  cdn: true,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${item.t1}- ${item.t2}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isIPad
                      ? MatchStatisticMatchHistoryState.headOnConfrontationItemScoreFontSizeIPad.sp
                      : MatchStatisticMatchHistoryState.headOnConfrontationItemScoreFontSize.sp,
                  color: MatchStatisticMatchHistoryState.headOnConfrontationItemScoreColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MatchStatisticMatchHistoryState.headOnConfrontationItemIconSize.w,
                  height: MatchStatisticMatchHistoryState.headOnConfrontationItemIconSize.w,
                  alignment: Alignment.center,
                  child: ImageView(
                    finalRightUrl,
                    width: MatchStatisticMatchHistoryState.headOnConfrontationItemIconSize.w,
                    height: MatchStatisticMatchHistoryState.headOnConfrontationItemIconSize.w,
                    cdn: true,
                  ),
                ),
                SizedBox(
                  width: MatchStatisticMatchHistoryState.headOnConfrontationItemIconSpacing.w,
                ),
                Container(
                  width: MatchStatisticMatchHistoryState.headOnConfrontationItemTeamNameWidth.w,
                  child: Text(
                    item.awayName ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isIPad
                          ? MatchStatisticMatchHistoryState.headOnConfrontationItemFontSizeIPad.sp
                          : MatchStatisticMatchHistoryState.headOnConfrontationItemFontSize.sp,
                      color: Get.theme.tabPanelSelectedColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
