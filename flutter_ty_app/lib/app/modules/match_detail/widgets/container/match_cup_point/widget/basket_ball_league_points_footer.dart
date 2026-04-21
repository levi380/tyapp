import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_cup_point_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_cup_point_controller.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

/// 篮球杯赛积分榜底部展开组件
///
/// 包含展开/收起按钮和颜色图例说明
class BasketBallLeaguePointsFooter extends StatelessWidget {
  final MatchCupPointController controller;

  const BasketBallLeaguePointsFooter({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    return Container(
      child: Column(
        children: [
          // 展开/收起按钮
          InkWell(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Get.theme.betItemTabSelectedColor),
                    borderRadius: BorderRadius.all(Radius.circular(15.w)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.isExpandImport
                            ? LocaleKeys.bet_pack_up.tr
                            : LocaleKeys.bet_record_pack_down.tr,
                        style: TextStyle(
                            fontSize: (12.sp),
                            color: Get.theme.betItemTabSelectedColor),
                      ),
                      Icon(
                        state.isExpandImport
                            ? Icons.arrow_right_outlined
                            : Icons.arrow_drop_down_rounded,
                        size: 24.w,
                        fill: 1,
                        color: Get.theme.betItemTabSelectedColor,
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                controller.setExpandImport(!state.isExpandImport);
              }),
          // 颜色图例
          Container(
            height: 40.w,
            width: 1.sw,
            alignment: Alignment.center,
            child: Wrap(
              spacing: 4.w,
              alignment: WrapAlignment.center,
              children: state.union.values.map((e) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(color: e["color"] ?? Colors.black),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      e["label"] ?? "",
                      style: TextStyle(
                        fontSize: MatchCupPointState.basketballLeaguePointsLabelFontSize.sp,
                        color: Get.theme.betItemTextColor,
                      ),
                    )
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
