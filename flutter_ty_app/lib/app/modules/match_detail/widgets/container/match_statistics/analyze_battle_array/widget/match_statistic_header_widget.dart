import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/widget/analyze_header_widget.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_statistic_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';


import '../../../../../../../../generated/locales.g.dart';


/// 正面交手头部组件
/// 用于显示正面交手页面的头部信息，包括比赛队伍和比赛信息
class MatchStatisticHeaderWidget {
  /// 构建正面交手-比赛头部
  /// [controller] 比赛统计控制器，包含正面交手数据
  /// [tag] 控制器标签，用于获取DataStoreController
  /// 返回包含比赛队伍和比赛信息的头部容器
  static Widget build({
    required MatchStatisticController controller,
    required String tag,
  }) {
    return Container(
      height: 132.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          gradient: LinearGradient(
            colors: [
              MatchStatisticMatchHistoryState.headerGradientColor1.withValues(alpha: MatchStatisticMatchHistoryState.headerGradientAlpha),
              MatchStatisticMatchHistoryState.headerGradientColor2.withValues(alpha: MatchStatisticMatchHistoryState.headerGradientAlpha),
              MatchStatisticMatchHistoryState.headerGradientColor3.withValues(alpha: MatchStatisticMatchHistoryState.headerGradientAlpha),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
      child: Column(
        children: [
          SizedBox(
            height: 12.w,
          ),
          _buildHead1(controller: controller, tag: tag),
          _buildHead2(controller: controller, tag: tag),
        ],
      ),
    );
  }

  /// 构建正面交手-比赛头-比赛队伍
  /// 显示主队和客队的胜率百分比
  /// [controller] 比赛统计控制器
  /// [tag] 控制器标签
  /// 返回包含胜率百分比的头部组件
  static Widget _buildHead1({
    required MatchStatisticController controller,
    required String tag,
  }) {
    // 计算主队胜率百分比
    int leftNum = (((controller.state.page1FrontFightPBBeanEntity?.homeWin ??
                    0) /
                ((controller.state.page1FrontFightPBBeanEntity?.countTotal == 0)
                    ? 1
                    : (controller
                            .state.page1FrontFightPBBeanEntity?.countTotal ??
                        1))) *
            100)
        .round();
    // 计算客队胜率百分比
    int rightNum = ((controller.state.page1FrontFightPBBeanEntity?.awayWin ??
                0) /
            ((controller.state.page1FrontFightPBBeanEntity?.countTotal == 0)
                ? 1
                : (controller.state.page1FrontFightPBBeanEntity?.countTotal ??
                    1)) *
            100)
        .round();
    return Container(
      height: 44.w,
      child: AnalyzeHeaderWidget(
          tag: tag,
          leftCenterName: "${leftNum}%",
          rightCenterName: "${rightNum}%"),
    );
  }

  /// 构建正面交手-比赛头-比赛信息
  /// 显示比赛总数、胜率分布条和未败场次
  /// [controller] 比赛统计控制器
  /// [tag] 控制器标签
  /// 返回包含比赛详细信息的容器
  static Widget _buildHead2({
    required MatchStatisticController controller,
    required String tag,
  }) {
    return GetBuilder<DataStoreController>(
        id: DataStoreController.to.getMatchId(tag),
        builder: (dataController) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 显示比赛总数
                Text(
                  "${controller.state.page1FrontFightPBBeanEntity?.countTotal ?? ""} ${LocaleKeys.ouzhou_match_matches.tr}",
                  style: TextStyle(
                      fontSize: TyTextScaler.instance().scale(12.sp),
                      color: Get.theme.orderDateTextColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 4.w,
                ),
                // 显示胜率分布条
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4.w)),
                  child: Row(
                    children: controller.state.lineColorBeans
                        .map((e) => Expanded(
                            flex: e.expand,
                            child: Container(
                              height: 20.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: e.getColor(controller
                                      .state.lineColorBeans
                                      .indexOf(e))),
                              child: Text(
                                "${e.number}%",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        TyTextScaler.instance().scale(12.sp)),
                              ),
                            )))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 4.w,
                ),
                // 显示未败场次
                Row(
                  children: [
                    Text(
                      "${controller.state.page1FrontFightPBBeanEntity?.awayNotLost ?? ""} ${LocaleKeys.analysis_football_matches_win.tr}",
                      style: TextStyle(
                          fontSize: TyTextScaler.instance().scale(12.sp),
                          color: AppColor.normalHintTextColor),
                    ),
                    Spacer(),
                    Text(
                      "${controller.state.page1FrontFightPBBeanEntity?.homeNotLost ?? ""} ${LocaleKeys.analysis_football_matches_win.tr}",
                      style: TextStyle(
                          fontSize: TyTextScaler.instance().scale(12.sp),
                          color: AppColor.normalHintTextColor),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

