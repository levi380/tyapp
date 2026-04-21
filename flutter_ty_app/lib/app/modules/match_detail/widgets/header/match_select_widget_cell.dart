import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/match_select_state_bubble.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/match_stage.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/show_start_time.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';
import '../../../../services/models/res/match_entity.dart';
import '../../../../utils/format_score_util.dart';
import '../../../../widgets/image_view.dart';
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
class MatchSelectWidgetCell extends StatelessWidget {
  const MatchSelectWidgetCell(
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
          color: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        // padding: EdgeInsets.all(12.w),
        padding: EdgeInsets.symmetric(vertical: 10.w,horizontal: 2.w),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        constraints: BoxConstraints(
            maxHeight: isIPad ? 160.h : 100.h,
            minHeight: isIPad ? 150.h : 94.h),
        child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 展示赛事阶段，开赛时间以及倒计时等
                          /// 赛事阶段展示
                          MatchStage(
                            match: match,
                            isMatchSelect: true,
                            isMatchSelectCell : true,
                            timeLineWrapDisplay: true,
                          ),

                          /// 时间展示、比分、即将开赛时间
                          // SizedBox(height: 2.h),
                          if (match.ms == 0)
                            ShowStartTime(
                              match: match,
                              isPinnedAppbar: false,
                              isMatchSelect: true,
                              showGMT: true,
                              isMatchSelectCell : true,
                            ),
                          MatchSelectStateBubble(
                              match: match,
                              isHeader: false
                          ),

                        ],
                      ),
                    ),
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
                              // 队徽 type 0表示主队 mhlu主队的url
                              // 双打情况
                              match.mhlu.length > 1
                                  ? SizedBox(
                                width: isIPad ? 114.w : 44.w,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: isIPad ? 84.w : 44.w,
                                        height: isIPad ? 84.w : 30.w,
                                        alignment: Alignment.center,
                                        child: ImageView(
                                          ObjectUtil.isNotEmpty(
                                              (match.mhlu as List).safeFirst)
                                              ? (match.mhlu as List).safeFirst
                                              : 'assets/images/home/home_team_logo.svg',
                                          width: isIPad ? 56.36.w : 25.w,
                                          height: isIPad ? 56.36.w : 25.w,
                                          cdn: true,
                                          errorWidget: ImageView(
                                            'assets/images/detail/default_team_home.svg',
                                            width: 40.w,
                                            height: 40.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Positioned(
                                    //   left: 25.w,
                                    //   child: Container(
                                    //     width: isIPad ? 84.w : 44.w,
                                    //     height: isIPad ? 84.w : 44.w,
                                    //     alignment: Alignment.center,
                                    //     child: ImageView(
                                    //       ObjectUtil.isNotEmpty(
                                    //           (match.mhlu as List).safe(1))
                                    //           ? (match.mhlu as List).safe(1)
                                    //           : 'assets/images/home/home_team_logo.svg',
                                    //       width: isIPad ? 56.36.w : 25.w,
                                    //       height: isIPad ? 56.36.w : 25.w,
                                    //       cdn: true,
                                    //       errorWidget: ImageView(
                                    //         'assets/images/detail/default_team_home.svg',
                                    //         width: 40.w,
                                    //         height: 40.w,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              )
                                  : // 单打
                              Container(
                                width: isIPad ? 84.w : 44.w,
                                height: isIPad ? 84.w : 30.w,
                                alignment: Alignment.center,
                                child: controller.detailState.isDJDetail
                                    ? ImageView(
                                  ObjectUtil.isNotEmpty(
                                      (match.mhlu as List).safeFirst)
                                      ? (match.mhlu as List).safeFirst
                                      : 'assets/images/home/home_team_logo.svg',
                                  width: isIPad ? 56.36.w : 25.w,
                                  height: isIPad ? 56.36.w : 25.w,
                                  dj: true,
                                  errorWidget: ImageView(
                                    'assets/images/detail/default_team_home.svg',
                                    width: 25.w,
                                    height: 25.w,
                                  ),
                                )
                                    : ImageView(
                                  ObjectUtil.isNotEmpty(
                                      (match.mhlu as List).safeFirst)
                                      ? (match.mhlu as List).safeFirst
                                      : 'assets/images/home/home_team_logo.svg',
                                  width: isIPad ? 56.36.w : 25.w,
                                  height: isIPad ? 56.36.w : 25.w,
                                  cdn: true,
                                  errorWidget: ImageView(
                                    'assets/images/detail/default_team_home.svg',
                                    width: 25.w,
                                    height: 25.w,
                                  ),
                                  // cdn: true,
                                ),
                              ),

                              // SizedBox(height: 4.h),
                              Container(
                                // alignment: Alignment.center,
                                width: isIPad ? 200.w : 156.w,
                                child: Text(
                                  getTeamName(type: 1, match: match),
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
                              // 双打情况
                              match.malu.length > 1
                                  ? SizedBox(
                                width: isIPad ? 114.w : 44.w,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: isIPad ? 84.w : 44.w,
                                        height: isIPad ? 84.w : 30.w,
                                        alignment: Alignment.center,
                                        child: ImageView(
                                          ObjectUtil.isNotEmpty(
                                              (match.malu as List).safeFirst)
                                              ? (match.malu as List).safeFirst
                                              : 'assets/images/home/default_team_away.svg',
                                          width: isIPad ? 56.36.w : 25.w,
                                          height: isIPad ? 56.36.w : 25.w,
                                          cdn: true,
                                          errorWidget: ImageView(
                                            'assets/images/detail/default_team_away.svg',
                                            width: 40.w,
                                            height: 40.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                                  : // 单打
                              Container(
                                width: isIPad ? 84.w : 44.w,
                                height: isIPad ? 84.w : 30.w,
                                alignment: Alignment.center,
                                child: controller.detailState.isDJDetail
                                    ? ImageView(
                                  ObjectUtil.isNotEmpty(
                                      (match.malu as List).safeFirst)
                                      ? (match.malu as List).safeFirst
                                      : 'assets/images/home/default_team_away.svg',
                                  width: isIPad ? 56.36.w : 25.w,
                                  height: isIPad ? 56.36.w : 25.w,
                                  dj: true,
                                  errorWidget: ImageView(
                                    'assets/images/detail/default_team_away.svg',
                                    width: 25.w,
                                    height: 25.w,
                                  ),
                                )
                                    : ImageView(
                                  ObjectUtil.isNotEmpty(
                                      (match.malu as List).safeFirst)
                                      ? (match.malu as List).safeFirst
                                      : 'assets/images/home/default_team_away.svg',
                                  width: isIPad ? 56.36.w : 25.w,
                                  height: isIPad ? 56.36.w : 25.w,
                                  cdn: true,
                                  errorWidget: ImageView(
                                    'assets/images/detail/default_team_away.svg',
                                    width: 25.w,
                                    height: 25.w,
                                  ),
                                ),
                              ),
                              // SizedBox(height: 4.h),
                              Container(
                                // alignment: Alignment.center,
                                width: isIPad ? 200.w : 156.w,
                                child: Text(
                                  getTeamName(type: 2, match: match),
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

                    [1, 2, 3, 4].contains(match.ms) ?
                    Column(
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
                    ) : SizedBox(),

                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child:
                      ImageView(
                        'assets/images/icon/icon_expand_gray.png',
                        width: 12.w,
                        height: 20.w,
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
