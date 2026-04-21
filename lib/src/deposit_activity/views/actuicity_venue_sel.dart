import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/src/home/homegame_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ActivityVenueSel extends StatefulWidget {
  final Function(VenueModel)? callback;
  final Function? cancelCallback;
  final Function? closeCallback;
  final RxList<VenueModel> activityList;

  const ActivityVenueSel({
    super.key,
    required this.activityList,
    this.callback,
    this.cancelCallback,
    this.closeCallback,
  });

  @override
  State<StatefulWidget> createState() {
    return _ActivityVenueTypeSelState();
  }
}

class _ActivityVenueTypeSelState extends State<ActivityVenueSel> {
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
                  onTap: () {
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
                  '请选择场馆',
                  style: TextStyle(fontSize: 16.sp, color: appnewColors.text1),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    // widget.callback?.call(widget.text);
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
              child: ListView.builder(
                  itemCount: widget.activityList.length,
                  itemBuilder: (context, index) {
                    final model = widget.activityList[index];
                    return _buildActivityItem(model, index);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(VenueModel item, int index) {
    return InkWell(
      onTap: () {
        if (item.maintained == 2) {
          return;
        }
        Get.back();
        widget.callback?.call(item);
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Text(
              "${item.name} ${item.maintained == 2 ? "（维护中）" : ""}",
              style: TextStyle(fontSize: 14.sp, color: appnewColors.text1),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Divider(
              color: appnewColors.text5,
              thickness: 0.5.h,
              indent: 1,
            ),
          ),
        ],
      ),
    );
  }
}
