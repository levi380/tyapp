import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/match_stage.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/show_start_time.dart';
import 'package:get/get.dart';

import '../../../../../../main.dart';

import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/format_score_util.dart';
import '../../../../../widgets/image_view.dart';
import '../../vr_sport_detail_state.dart';

class VrMatchSelectWidgetCell extends StatelessWidget {
  const VrMatchSelectWidgetCell({
    super.key,
    required this.match,
    required this.index,
    this.onSelect,
  });

  final MatchEntity match;
  final int index;
  final ValueChanged<MatchEntity>? onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect?.call(match),
      child: Container(
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 20.h),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 展示赛事阶段，开赛时间以及倒计时等
                    /// 赛事阶段展示
                    MatchStage(
                      match: match,
                      isMatchSelect: true,
                    ),

                    /// 时间展示、比分、即将开赛时间
                    SizedBox(height: 2.h),
                    if (match.ms == 0)
                      ShowStartTime(
                        match: match,
                        isPinnedAppbar: false,
                        isMatchSelect: true,
                      ),
                  ],
                ),
                20.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: isIPad ? 270.w : 200.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: isIPad ? 84.w : 44.w,
                            height: isIPad ? 84.w : 30.w,
                            alignment: Alignment.center,
                            child: ImageView(
                              match.mhlu.toString().isNotEmpty
                                  ? match.mhlu
                                  : VrSportDetailState.defaultTeamHome,
                              width: isIPad ? 56.36.w : 25.w,
                              height: isIPad ? 56.36.w : 25.w,
                              cdn: true,
                              errorWidget: ImageView(
                                VrSportDetailState.defaultTeamHome,
                                width: 40.w,
                                height: 40.w,
                              ),
                              // cdn: true,
                            ),
                          ),
                          Container(
                            width: isIPad ? 200.w : 156.w,
                            child: Text(
                              match.teams.firstOrNull ?? "",
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: !Get.isDarkMode
                                    ? Get.theme.matchSelectTitleColor
                                    : Colors.white,
                                fontSize: isIPad ? 20.sp : 14.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: isIPad ? 270.w : 200.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: isIPad ? 84.w : 44.w,
                            height: isIPad ? 84.w : 30.w,
                            alignment: Alignment.center,
                            child: ImageView(
                              match.malu.toString().isNotEmpty
                                  ? match.malu
                                  : VrSportDetailState.defaultTeamAway,
                              width: isIPad ? 56.36.w : 25.w,
                              height: isIPad ? 56.36.w : 25.w,
                              cdn: match.malu.toString().isNotEmpty,
                              errorWidget: ImageView(
                                VrSportDetailState.defaultTeamAway,
                                width: 35.w,
                                height: 35.w,
                              ),
                            ),
                          ),
                          // SizedBox(height: 4.h),
                          Container(
                            // alignment: Alignment.center,
                            width: isIPad ? 200.w : 156.w,
                            child: Text(
                              match.teams.lastOrNull ?? "",
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: !Get.isDarkMode
                                    ? Get.theme.matchSelectTitleColor
                                    : Colors.white,
                                fontSize: isIPad ? 20.sp : 14.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                [1, 2, 3, 4].contains(match.ms)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AutoSizeText(
                            "${FormatScore.formatTotalScore(match, 0)}",
                            maxLines: 1,
                            style: TextStyle(
                              color: !Get.isDarkMode
                                  ? Get.theme.matchSelectTitleColor
                                  : Colors.white,
                              fontSize: isIPad ? 20.sp : 18.sp,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          AutoSizeText(
                            "${FormatScore.formatTotalScore(match, 1)}",
                            maxLines: 1,
                            style: TextStyle(
                              color: !Get.isDarkMode
                                  ? Get.theme.matchSelectTitleColor
                                  : Colors.white,
                              fontSize: isIPad ? 20.sp : 18.sp,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      )
                    : SizedBox(),
                Container(
                  margin: EdgeInsets.only(left: 15.w),
                  child: AutoSizeText(
                    "›",
                    maxLines: 1,
                    style: TextStyle(
                      color: !Get.isDarkMode
                          ? Get.theme.matchSelectTitleColor
                          : Colors.white,
                      fontSize: isIPad ? 30.sp : 24.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
