
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

class TimeFilteringView extends StatelessWidget {
  TimeFilteringView({
    required this.type,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final int type;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.h,
      decoration: ShapeDecoration(
        color: Color(0xFFF2F2F6),
        // color: Colors.amberAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _single(
            0,
            '全部',
          ),
          _single(
            1,
            '今天',
          ),
          _single(
            2,
            '昨天',
          ),
          _single(
            3,
            '近7日',
          ),
        ],
      ),
    );
  }

  Widget _single(int singleType, String title) {
    bool selected = type == singleType;
    return Expanded(
      child: InkWell(
        onTap: () => {
          onChanged(singleType),
        },
        child: Container(
          height: double.maxFinite,
          margin: EdgeInsets.all(2),
          decoration: selected
              ? ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                )
              : null,
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(selected ? 0xFF179CFF : 0xFF949AB6),
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
