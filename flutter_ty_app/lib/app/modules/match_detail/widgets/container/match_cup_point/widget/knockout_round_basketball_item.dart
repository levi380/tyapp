import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_cup_point_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/services/models/res/knockout_info_bean_entity.dart';

/// 淘汰赛-篮球单场结果项
///
/// 显示主客队名称与比分，中间分隔线。
class KnockoutRoundBasketballItem extends StatelessWidget {
  const KnockoutRoundBasketballItem({super.key, required this.entity});

  /// 单场淘汰赛数据：主客队名、比分等
  final KnockoutInfoBeanEntity entity;

  /// 构建单场卡片：圆角背景容器，内部分两行（主队名+主队分、[AnalyzeDivider]、客队名+客队分），字体 12.sp，颜色使用主题 [tabPanelSelectedColor] / [secondTabPanelSelectedFontColor]。
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 81.w,
      margin: EdgeInsets.only(top: 16.w),
      decoration: BoxDecoration(
        color: MatchCupPointState.knockoutBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(4.w)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entity.homeName ?? "",
                      style: TextStyle(
                        color: Get.theme.secondTabPanelSelectedFontColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          entity.homeScores ?? "",
                          style: TextStyle(
                            color: Get.theme.tabPanelSelectedColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6.w),
                AnalyzeDivider(),
                SizedBox(height: 6.w),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entity.awayName ?? "",
                      style: TextStyle(
                        color: Get.theme.tabPanelSelectedColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          entity.awayScores ?? "",
                          style: TextStyle(
                            color: Get.theme.tabPanelSelectedColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
