import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_common_box_shadow.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';


class BallRealtimeTeamScoreWidget extends StatelessWidget {
  const BallRealtimeTeamScoreWidget({
    super.key,
    required this.teams,
    required this.score,
    required this.isSelected,
    this.onItemTap,
  });

  final List<String> teams;
  final VrSportReplayDetailScoreRanking? score;
  final bool isSelected;
  final VoidCallback? onItemTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemTap,
      child: VrCommonBoxShadow(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
        color: isSelected
            ? (Get.isDarkMode ? AppColor.colorDarkMode : '#D1EBFF'.hexColor)
            : Get.isDarkMode
                ? Colors.white.withValues(alpha:0.03999999910593033)
                : AppColor.colorWhite,

        child: Column(
          mainAxisAlignment: isIPad ? MainAxisAlignment.center :MainAxisAlignment.spaceAround,
          children: [

            _buildTeamNameScore(
              teamName: teams.firstOrNull ?? '布莱顿海鸥',
              score: score?.home ?? '0',
              isSelected: isSelected,
            ),
             SizedBox(
              height: 3.h,
            ),
            _buildTeamNameScore(
              teamName: teams.lastOrNull ?? '维拉人',
              score: score?.away ?? '0',
              isSelected: isSelected,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamNameScore({
    required String teamName,
    required String score,
    bool isSelected = false,
  }) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 12.sp.scale,
        color: isSelected
            ? (Get.isDarkMode ? Colors.white : '#127DCC'.hexColor)
            : Get.isDarkMode
                ? Colors.white
                : '#303442'.hexColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              teamName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            score,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14.sp.scale,
            ),
          ),
        ],
      ),
    );
  }
}
