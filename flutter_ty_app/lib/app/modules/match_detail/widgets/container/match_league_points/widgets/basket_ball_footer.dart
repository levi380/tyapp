import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/league_points_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/league_points_controller.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';

/// 篮球积分榜底部的折叠/展开组件，包含图例和按钮
class BasketBallFooter extends StatelessWidget {
  final LeaguePointsController controller;
  final bool? needBottomPadding;

  const BasketBallFooter({
    super.key,
    required this.controller,
    this.needBottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: controller.state.dataList.length >= 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LeaguePointsState.basketballFooterButtonTopSpacing.verticalSpace,
          // 淘汰赛等图例说明
          Container(
            margin: EdgeInsets.only(
              bottom: LeaguePointsState.basketballFooterButtonBottomMargin.h,
            ),
            width: 1.sw,
            alignment: Alignment.center,
            child: Wrap(
              spacing: LeaguePointsState.basketballFooterLegendSpacing.w,
              alignment: WrapAlignment.center,
              children: controller.state.union.values.map((e) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: LeaguePointsState.basketballFooterLegendIconSize.w,
                      height: LeaguePointsState.basketballFooterLegendIconSize.w,
                      decoration: BoxDecoration(color: e["color"] ?? Colors.black),
                    ),
                    SizedBox(
                      width: LeaguePointsState.basketballFooterLegendIconSpacing.w,
                    ),
                    Text(
                      e["label"] ?? "",
                      style: TextStyle(
                        fontSize: LeaguePointsState.basketballFooterLegendFontSize.sp,
                        color: Colors.black,
                      ),
                    )
                  ],
                );
              }).toList(),
            ),
          ),
          // 展开/收起按钮
          InkWell(
            onTap: () {
              controller.setExpand();
              controller.requestVSInfo(flag: controller.state.expand ? "0" : "");
            },
            child: Container(
              height: LeaguePointsState.basketballFooterButtonHeight.w,
              margin: EdgeInsets.symmetric(
                horizontal: LeaguePointsState.basketballFooterButtonHorizontalMarginRatio.sw,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Get.theme.secondTabPanelSelectedFontColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(LeaguePointsState.basketballFooterButtonBorderRadius.w),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: LeaguePointsState.basketballFooterButtonHorizontalPadding.w,
              ),
              child: controller.state.expand
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: LeaguePointsState.basketballFooterButtonHorizontalPadding.w),
                        Text(
                          LocaleKeys.bet_pack_up.tr,
                          style: TextStyle(
                            color: Get.theme.secondTabPanelSelectedFontColor,
                            fontSize: isIPad
                                ? LeaguePointsState.basketballFooterButtonFontSizeIPad.sp
                                : LeaguePointsState.basketballFooterButtonFontSize.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.arrow_drop_up_outlined,
                              size: LeaguePointsState.basketballFooterButtonIconSize.w,
                              color: Get.theme.secondTabPanelSelectedFontColor,
                            ),
                            SizedBox(
                              height: LeaguePointsState.basketballFooterButtonHorizontalPadding.w,
                            )
                          ],
                        )
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: LeaguePointsState.basketballFooterButtonHorizontalPadding.w),
                        Text(
                          LocaleKeys.tips_expand.tr,
                          style: TextStyle(
                            color: Get.theme.secondTabPanelSelectedFontColor,
                            fontSize: isIPad
                                ? LeaguePointsState.basketballFooterButtonFontSizeIPad.sp
                                : LeaguePointsState.basketballFooterButtonFontSize.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: LeaguePointsState.basketballFooterButtonHorizontalPadding.w),
                        Column(
                          children: [
                            Icon(
                              Icons.arrow_drop_down,
                              size: LeaguePointsState.basketballFooterButtonIconSize.w,
                              color: Get.theme.secondTabPanelSelectedFontColor,
                            ),
                            SizedBox(
                              height: LeaguePointsState.basketballFooterButtonHorizontalPadding.w,
                            )
                          ],
                        )
                      ],
                    ),
            ),
          ),
          SizedBox(
            height: LeaguePointsState.basketballFooterButtonBottomSpacing.w,
          ),
        ],
      ),
    );
  }
}
