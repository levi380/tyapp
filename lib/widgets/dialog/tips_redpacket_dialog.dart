import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/platform_check_out_model.dart';
import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/src/mine/vip/models/resp_vip_rate_detail.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TipsRedpacketDialog extends StatelessWidget {
  const TipsRedpacketDialog(
      {super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.r),
        decoration: BoxDecoration(
          color: appnewColors.bg1,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleView(),
            contentView(),
            bottomView(),
          ],
        ),
      ),
    );
  }

  Widget titleView() {
    return Container(
      height: 48.r,
      margin: EdgeInsets.only(top: 10.r),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: appnewColors.textMain,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget contentView() {
    return Container(
      margin: EdgeInsets.only(top: 10.r, bottom: 20.r, left: 25.r, right: 25.r),
      alignment: Alignment.centerLeft,
      child: Text(
        content,
        style: TextStyle(
          color: appnewColors.textMain,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget bottomView() {
    return Container(
      height: 48.r,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: appnewColors.colorLine,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '确定',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appnewColors.textBlue,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentItemView(String title, String content, {bool isTitle = false}) {
    return Container(
      height: 36.r,
      decoration: BoxDecoration(
        color: isTitle ? appnewColors.bgGray2 : null,
        borderRadius: BorderRadius.vertical(
          top: isTitle ? Radius.circular(8.r) : Radius.zero,
          bottom: isTitle ? Radius.zero : Radius.circular(8.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appnewColors.textMain,
                fontSize: 14.sp,
              ),
            ),
          ),
          Container(
            color: appnewColors.colorLine2,
            width: 1,
            height: 48.r,
          ),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appnewColors.textMain,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
