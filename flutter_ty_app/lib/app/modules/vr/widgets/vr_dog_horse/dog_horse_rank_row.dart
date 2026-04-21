import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

import '../../../../utils/vr_rank_icon_utils.dart';
import '../vr_common_box_shadow.dart';
import '../../vr_sport_state.dart';

class DogHorseRankRow extends StatelessWidget {
  const DogHorseRankRow({
    super.key,
    required this.rank,
    this.iconSrc,
    this.title,
    this.subtitle,
    required this.teamNum,
    required this.csid,
  });

  final int rank;
  final String teamNum;
  final String? iconSrc;
  final String? title;
  final String? subtitle;
  final String? csid;
  @override
  Widget build(BuildContext context) {
    ///公共获取vr赛狗 vr赛马 vr摩托车 vr泥地摩托车 图标 公共方法
    String icon =   VrRankIconUtils.getRankIcon(int.tryParse(csid ?? '1002') ?? 1002,(int.tryParse(teamNum) ?? 0 + 1).toString());
    if(icon.isEmpty){
      icon = VRSportState.dogHorseRankIcon(int.tryParse(teamNum) ?? 0);
    }
    return VrCommonBoxShadow(
      padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
      color: Get.isDarkMode
          ? Colors.white.withValues(alpha:0.03999999910593033)
          : AppColor.colorWhite,
      child: Row(
        children: [
          ImageView(
            icon,
            width: 20.w,
            height: 20.w,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              title ?? 'Annette Black',
              style: TextStyle(
                fontSize: 12.sp.scale,
                color: Get.isDarkMode ? Colors.white : '#303442'.hexColor,
              ),
            ),
          ),
          Text(
            subtitle ?? '${rank + 1}',
            style: TextStyle(
              fontSize: 12.sp.scale,
              color: Get.isDarkMode ? Colors.white : '#303442'.hexColor,
              fontWeight: FontWeight.w700,
              // 设计稿字体：Akrobat，字重：bold，字号：12
              // fontFamily: '',
            ),
          ),
        ],
      ),
    );
  }
}
