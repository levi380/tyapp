import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ActivityVenueTypeSel extends StatefulWidget {
  final Function(String)? callback;
  final Function? cancelCallback;
  final Function? closeCallback;
  final String text;

  const ActivityVenueTypeSel({
    super.key,
    required this.text,
    this.callback,
    this.cancelCallback,
    this.closeCallback,
  });

  @override
  State<StatefulWidget> createState() {
    return _ActivityVenueTypeSelState();
  }
}

class _ActivityVenueTypeSelState extends State<ActivityVenueTypeSel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      constraints: BoxConstraints(
        maxHeight: 316.h,
      ),
      child: Column(
        children: [
          // 顶部操作栏
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                    widget.closeCallback?.call();
                  },
                  child: Text(
                    '取消',
                    style: TextStyle(fontSize: 14.sp, color: appnewColors.text1),
                  ),
                ),
                const Spacer(),
                Text(
                  '请选择类型',
                  style: TextStyle(fontSize: 16.sp, color: appnewColors.text1),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    widget.callback?.call(widget.text);
                  },
                  child: Text(
                    '确定',
                    style: TextStyle(fontSize: 14.sp, color: appnewColors.text1),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: appnewColors.bg23,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  widget.text,
                  style: TextStyle(fontSize: 14.sp, color: appnewColors.text1),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
