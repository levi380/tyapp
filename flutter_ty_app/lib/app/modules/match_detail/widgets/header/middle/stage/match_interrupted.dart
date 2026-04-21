import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';



class MatchInterrupted extends StatelessWidget {
  const MatchInterrupted({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ImageView(
          'assets/images/detail/match_interrupted_icon.svg',
          width: 18.w,
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 120.w),
          child: Text(
            LocaleKeys.app_match_status_interrupted.tr,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: (12.sp),
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
