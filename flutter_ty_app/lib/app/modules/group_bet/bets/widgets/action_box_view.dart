import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionBoxView extends StatelessWidget {
  const ActionBoxView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: InkWell(
            ///确定和修改赔率共同一个widget
            onTap: () => {},
            child: Container(
              alignment: Alignment.center,
              height: 35.h,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF179CFF)),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: AutoSizeText(
                "查看详情",
                maxLines: 1,
                minFontSize: 8,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF179CFF),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: InkWell(
            ///确定和修改赔率共同一个widget
            onTap: () => {},
            child: Container(
              alignment: Alignment.center,
              height: 35.h,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF179CFF)),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: AutoSizeText(
                "撤单",
                maxLines: 1,
                minFontSize: 8,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF179CFF),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
