import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/match_stage.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/show_start_time.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/team_logo.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';
import '../../../../services/models/res/match_entity.dart';
import '../../../../utils/format_score_util.dart';
import '../../controllers/match_detail_controller.dart';
import '../../controllers/match_tools_methods.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 下拉联赛选择】】】
    【【【 AUTO_PARAGRAPH_TITLE 下拉赛事选择项】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 下拉赛事选择项 tag对应不同的注入
    - 包含队伍名称、比分、赛事阶段
    】】】
 *
 */
class MatchSelectItem extends StatelessWidget {
  const MatchSelectItem(
      {super.key,
      required this.match,
      required this.index,
      required this.controller});

  final MatchEntity match;
  final int index;
  final MatchDetailController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.selectChangeMatch(match.mid);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: match.mid == controller.detailState.mId
              ? Get.theme.matchSelectedBgColor
              : Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        constraints: BoxConstraints(
            maxHeight: isIPad ? 160.h : 100.h,
            minHeight: isIPad ? 150.h : 90.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: isIPad ? 270.w : 121.5.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      14.verticalSpace,
                      // 队徽 type 0表示主队 mhlu主队的url
                      // 队徽 type 0表示主队 mhlu主队的url
                      TeamLogo(
                        isHome: true,
                        match: match,
                        isDJDetail: controller.detailState.isDJDetail,
                        size: 25.w,
                        offset: 20.w,
                      ),

                      SizedBox(height: 4.h),
                      Container(
                        alignment: Alignment.center,
                        width: isIPad ? 150.w : 100.w,
                        child: Text(
                          getTeamName(type: 1, match: match),
                          maxLines: 2,
                          textAlign: TextAlign.center,
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
                  width: isIPad ? 270.w : 121.5.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      14.verticalSpace,
                      TeamLogo(
                        isHome: false,
                        match: match,
                        isDJDetail: controller.detailState.isDJDetail,
                        size: 25.w,
                        offset: 20.w,
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        alignment: Alignment.center,
                        width: isIPad ? 150.w : 100.w,
                        child: Text(
                          getTeamName(type: 2, match: match),
                          textAlign: TextAlign.center,
                          maxLines: 2,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                if ([1, 2, 3, 4].contains(match.ms))
                  AutoSizeText(
                    "${FormatScore.formatTotalScore(match, 0)} - ${FormatScore.formatTotalScore(match, 1)}",
                    maxLines: 1,
                    style: TextStyle(
                      color: !Get.isDarkMode
                          ? Get.theme.matchSelectTitleColor
                          : Colors.white,
                      fontSize: isIPad ? 40.sp : 32.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
