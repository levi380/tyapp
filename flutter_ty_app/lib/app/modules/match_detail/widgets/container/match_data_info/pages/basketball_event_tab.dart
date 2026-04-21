import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/data/match_data_tab_manager.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_data_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';

/// 篮球事件页 - 节次 Tab（第一节、第二节等）
class BasketballEventTab extends StatelessWidget {
  final MatchDataController controller;

  const BasketballEventTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28.w,
      width: 1.sw,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.w),
      decoration: BoxDecoration(
        color: MatchDataState.basketballEventPageBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(6.w)),
      ),
      child: Row(
        children: controller.state.listTabs.map((e) {
          final index = controller.state.listTabs.indexOf(e);
          final isSelected = controller.state.selectBasketBallIndex == index;
          return Expanded(
            child: Container(
              height: 24.w,
              decoration: isSelected
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.w)),
                    )
                  : const BoxDecoration(),
              alignment: Alignment.center,
              child: Text(
                e['name'],
                style: TextStyle(
                  color: Get.theme.tabPanelSelectedColor,
                  fontSize: MatchDataState.basketballEventPageTextFontSize.sp,
                ),
              ),
            ).onTap((){
              controller.setBasketBallTab(index);
            }),
          );
        }).toList(),
      ),
    );
  }
}
