import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleView extends StatelessWidget {
  const TitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      '瓦伦西亚',
                      style: TextStyle(
                        color: Color(0xFF303442),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'VS',
                    style: TextStyle(
                      color: Color(0xFF303442),
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    child: Text(
                      '罗斯托拉夫',
                      style: TextStyle(
                        color: Color(0xFF303442),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Container(
            width: 48.w,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              color: Color(0x19179CFF),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.50, color: Color(0x19179CFF)),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            child: Text(
              '进行中',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF179CFF),
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
