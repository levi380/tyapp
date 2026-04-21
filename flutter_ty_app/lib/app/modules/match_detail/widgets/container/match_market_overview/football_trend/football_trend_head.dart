import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_market_overview/widget/football_trend_select_widget.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/custom_position_toast.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_market_overview_logic.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_market_overview_state.dart';

/// 足球走势 - 顶部筛选头
///
/// 包含多级玩法下拉（Option1/2/3）与确认按钮，点击确认请求走势图数据。
class FootballTrendHead extends StatelessWidget {
  const FootballTrendHead({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMarketOverviewLogic>(
      id: 'getBuildHead',
      tag: tag,
      builder: (AnalyzeMarketOverviewLogic controller) {
        return Container(
          height: 30.w,
          margin: EdgeInsets.only(top: 8.w),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOption1(context, controller),
              _buildOption2(context, controller),
              _buildOption3(context, controller),
              _buildConfirmButton(controller),
            ],
          ),
        );
      },
    );
  }

  /// 一级玩法下拉
  Widget _buildOption1(BuildContext context, AnalyzeMarketOverviewLogic controller) {
    return Visibility(
      visible: controller.state.showSelect_Option1,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          final globalPosition = details.globalPosition;
          final morePlays = controller.state.selectBeans
              .map((e) => e.name ?? '')
              .toList();
          CustomPositionToast.showCustomWidget(
            context: context,
            contentWidget: Container(
              color: Get.theme.oddsButtonBackgroundColor,
              child: FootballTrendSelectWidget(
                morePlays,
                controller.state.selectOptionIndex1,
                (int itemIndex) {
                  controller.setSelectPlayInfo(itemIndex);
                },
              ),
            ),
            isLeft: false,
            position: Offset(0.08.sw, globalPosition.dy + 12.w),
          );
        },
        child: _buildDropdownChip(
          context,
          controller.state.select_Option1.isEmpty
              ? LocaleKeys.analysis_please_select.tr
              : controller.state.select_Option1,
        ),
      ),
    );
  }

  /// 二级玩法下拉
  Widget _buildOption2(BuildContext context, AnalyzeMarketOverviewLogic controller) {
    return Visibility(
      visible: controller.state.showSelect_Option2,
      child: GestureDetector(
        onDoubleTapDown: (details) {
          final globalPosition = details.globalPosition;
          final morePlays = controller.state.selectBeans[controller.state.selectOptionIndex1]
                  .datas
                  ?.map((e) => e.name ?? '')
                  .toList() ??
              [];
          final dx = (controller.state.showSelect_Option2 &&
                  controller.state.showSelect_Option1 &&
                  controller.state.showSelect_Option3)
              ? 0.36.sw
              : 0.4.sw;
          CustomPositionToast.showCustomWidget(
            context: context,
            contentWidget: Container(
              color: Get.theme.oddsButtonBackgroundColor,
              child: FootballTrendSelectWidget(
                morePlays,
                controller.state.selectOptionIndex2,
                (int itemIndex){
                  controller.setSelectChildPlayInfo(itemIndex);
                },
              ),
            ),
            isLeft: false,
            position: Offset(dx, globalPosition.dy + 12.w),
          );
        },
        child: _buildDropdownChip(
          context,
          controller.state.select_Option2.isEmpty
              ? LocaleKeys.analysis_please_select.tr
              : controller.state.select_Option2,
        ),
      ),
    );
  }

  /// 三级玩法下拉
  Widget _buildOption3(BuildContext context, AnalyzeMarketOverviewLogic controller) {
    return Visibility(
      visible: controller.state.showSelect_Option3,
      child: GestureDetector(
        onTapDown: (details) {
          final globalPosition = details.globalPosition;
          final morePlays = controller.state.selectBeans[controller.state.selectOptionIndex1]
                  .datas?[controller.state.selectOptionIndex2].datas
                  ?.map((e) => e.name ?? '')
                  .toList() ??
              [];
          CustomPositionToast.showCustomWidget(
            context: context,
            contentWidget: Container(
              color: Get.theme.oddsButtonBackgroundColor,
              child: FootballTrendSelectWidget(
                morePlays,
                controller.state.selectOptionIndex3,
                (int itemIndex){
                  controller.setSelectThirdChildPlayInfo(itemIndex);
                },
              ),
            ),
            isLeft: false,
            position: Offset(0.6.sw, globalPosition.dy + 12.w),
          );
        },
        child: _buildDropdownChip(
          context,
          controller.state.select_Option3.isEmpty
              ? LocaleKeys.analysis_please_select.tr
              : controller.state.select_Option3,
        ),
      ),
    );
  }

  /// 单个下拉展示：文案 + 下箭头
  Widget _buildDropdownChip(BuildContext context, String text) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: context.isDarkMode
                  ? MatchMarketOverviewState.footballTrendTextColorDark
                  : MatchMarketOverviewState.footballTrendTextColorLight,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 16.w,
            color: MatchMarketOverviewState.footballTrendArrowColor,
          ),
        ],
      ),
    );
  }

  /// 确认按钮：请求走势图
  Widget _buildConfirmButton(AnalyzeMarketOverviewLogic controller) {
    return InkWell(
      onTap: () => controller.fetchTrendChart(),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.w)),
          color: Get.theme.tabIndicatorColor,
        ),
        child: Text(
          LocaleKeys.app_h5_bet_confirm.tr,
          style: TextStyle(
            fontSize: 12.sp,
            color: MatchMarketOverviewState.footballTrendConfirmButtonTextColor,
          ),
        ),
      ),
    );
  }
}
