import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import 'head_sport_finsh_common_widget/next_match_countdown_widget.dart';
///头部足球结束页面
class FootballFinishedWidget extends StatelessWidget {
  const FootballFinishedWidget({
    super.key,
    required this.teams,
    required this.mhlu,
    required this.malu,
    required this.score,
    this.nextVrMatch,
    this.onNextMatchCountdownEnd,
  });

  final List<String> teams;

  final String mhlu;
  final String malu;
  final VrSportReplayDetailScoreRanking? score;
  final VrMatchEntity? nextVrMatch;
  final VoidCallback? onNextMatchCountdownEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UnconstrainedBox(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: Colors.black.withValues(alpha:0.6),
            ),
            constraints:  BoxConstraints(minHeight: 24.w),
            padding:  EdgeInsets.symmetric(horizontal: 8.w),
            alignment: Alignment.center,
            child: Text(
              LocaleKeys.list_match_end.tr,
              style: TextStyle(
                color: AppColor.colorWhite,
                fontSize: 10.sp.scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          color: Colors.black.withValues(alpha:0.6),
          constraints:  BoxConstraints(minHeight: 54.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    teams.firstOrNull ?? '布莱顿海鸥',
                    style: TextStyle(
                      color: AppColor.colorWhite,
                      fontSize: 12.sp.scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  ImageView(
                    mhlu,
                    cdn: true,
                    width: 20.w,
                    height: 20.w,
                  ),
                ],
              ),
              Text(
                '${score?.home ?? '0'}-${score?.away ?? '0'}',
                style: TextStyle(
                  color: AppColor.colorWhite,
                  fontSize: 20.sp.scale,
                  fontWeight: FontWeight.w600,
                ),
              ).marginSymmetric(horizontal: 24.w),
              Row(
                children: [
                  ImageView(
                    malu,
                    cdn: true,
                    width: 20.w,
                    height: 20.w,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    teams.lastOrNull ?? '维拉人',
                    style: TextStyle(
                      color: AppColor.colorWhite,
                      fontSize: 12.sp.scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).marginSymmetric(vertical: 20.w),
        if (nextVrMatch != null)
          NextMatchCountdownWidget(
            nextVrMatch: nextVrMatch,
            onCountdownEnd: onNextMatchCountdownEnd,
          ),
      ],
    );
  }
}
