import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/main.dart';

/// 篮球队伍信息 - VS 中间文案
class BasketBallTeamInfoVS extends StatelessWidget {
  const BasketBallTeamInfoVS({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'VS',
      maxLines: 1,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Get.theme.tabPanelSelectedColor,
        fontSize: isIPad ? 20.sp : 14.sp,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
