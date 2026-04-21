import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import '../../../../../utils/vr_rank_icon_utils.dart';
import 'head_sport_finsh_common_widget/next_match_countdown_widget.dart';
import '../../../vr_sport_state.dart';

class OtherSportFinishedWidget extends StatelessWidget {
  const OtherSportFinishedWidget({
    super.key,
    required this.teams,
    this.score,
    this.onNextMatchCountdownEnd,
    this.nextVrMatch,
    this.callbackSeconds = 10,
    required this.csid,
  });

  final List<String> teams;
  final VrSportReplayDetailScoreRanking? score;
  final VoidCallback? onNextMatchCountdownEnd;
  final VrMatchEntity? nextVrMatch;
  final int csid;
  /// 触发回调时间：单位秒，默认 10 秒
  final int callbackSeconds;

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
              ImageView(
                getIconByRankIndex(csid.toString(),int.parse(score?.ranking1 ?? '1')),
                width: 36.w,
                height: 36.w,
              ),
              ImageView(
                getIconByRankIndex(csid.toString(),int.parse(score?.ranking2 ?? '2')),
                width: 36.w,
                height: 36.w,
              ).marginSymmetric(horizontal: 24.w),
              ImageView(
                getIconByRankIndex(csid.toString(),int.parse(score?.ranking3 ?? '3')),
                width: 36.w,
                height: 36.w,
              ),
            ],
          ),
        ).marginSymmetric(vertical: 20.w),
        if (nextVrMatch != null)
          NextMatchCountdownWidget(
            nextVrMatch: nextVrMatch,
            onCountdownEnd: onNextMatchCountdownEnd,
            callbackSeconds: callbackSeconds,
          ),
      ],
    );
  }


  ///公共获取vr赛狗 vr赛马 vr摩托车 vr泥地摩托车 图标 公共方法
  String getIconByRankIndex(String? csid, int index){
    String icon =   VrRankIconUtils.getRankIcon(int.tryParse(csid ?? '1002') ?? 1002,index.toString());
    if(icon.isEmpty){
      icon = VRSportState.dogHorseRankIcon(index);
    }
    return icon;
  }


}
