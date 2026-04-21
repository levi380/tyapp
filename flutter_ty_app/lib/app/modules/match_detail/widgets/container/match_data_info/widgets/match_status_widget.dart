import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../app/config/theme/app_color.dart';
import '../../../../states/match_data_state.dart';

/// 比赛状态组件（如中场休息）
class MatchStatusWidget extends StatelessWidget {
  const MatchStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 12.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 26.w,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.w),
                border: Border.all(
                  color: AppColor.colorSelectBorder,
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.mmp_1_31.tr,
                style: TextStyle(
                  fontSize: MatchDataState.statusTextFontSize.sp,
                  color: AppColor.colorSelectBorder,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 5.h),
          width: 2,
          height: 40.h,
          color: MatchDataState.eventLineColor,
        ),
      ],
    );
  }
}

