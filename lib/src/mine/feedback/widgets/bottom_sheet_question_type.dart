import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BottomSheetQuestionType extends StatelessWidget {
  BottomSheetQuestionType({super.key});

  final menus = [
    '存款问题',
    '取款问题',
    '游戏问题',
    '优惠问题',
    '网站/APP登录',
    '修改资料',
    '流水问题',
    '其他'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleView(),
          contentView(),
          SizedBox(height: 125.r),
        ],
      ),
    );
  }

  Widget titleView() {
    return Container(
      margin: EdgeInsets.only(top: 10.r, bottom: 20.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 46.r,
          ),
          Text(
            '选择问题类型',
            style: TextStyle(
              color: appnewColors.textMain,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.all(15.r),
              child: Image.asset(
                Assets.mineIconCloes,
                width: 16.r,
                height: 16.r,
                color: appnewColors.textMain,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget contentView() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var model = menus[index];
        return InkWell(
          onTap: () {
            Get.back(result: model);
          },
          child: Container(
            height: 44.r,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 14.r),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: appnewColors.colorLine3, width: 0.5),
              ),
            ),
            child: Text(
              model,
              style: TextStyle(
                color: appnewColors.textMain,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
      itemCount: menus.length,
    );
  }
}
