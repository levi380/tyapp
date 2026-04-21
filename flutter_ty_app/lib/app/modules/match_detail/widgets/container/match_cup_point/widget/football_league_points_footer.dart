import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_cup_point_controller.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

/// 足球杯赛积分 - 底部展开按钮与图例
///
/// 仅在第一个分组（currentCupBasketBallEventPageIndex == 0）时显示展开/收起按钮；
/// 下方始终显示颜色图例（晋级区等），数据来自 [controller.state.union]。
class FootballLeaguePointsFooter extends StatelessWidget {
  final String tag;

  const FootballLeaguePointsFooter({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchCupPointController>(
      id: 'pointTitleList',
      tag: tag,
      builder: (controller) {
        final state = controller.state;
        return Container(
          child: Column(
            children: [
              // 仅第一组显示展开/收起
              if (state.currentCupBasketBallEventPageIndex == 0)
                InkWell(
                  onTap: () =>
                      controller.setExpandImport(!state.isExpandImport),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Get.theme.betItemTabSelectedColor,
                        ),
                        borderRadius:
                            BorderRadius.all(Radius.circular(15.w)),
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
                              fontSize: 12.sp,
                              color: Get.theme.betItemTabSelectedColor,
                            ),
                          ),
                          Icon(
                            state.isExpandImport
                                ? Icons.arrow_right_outlined
                                : Icons.arrow_drop_down_rounded,
                            size: 24.w,
                            fill: 1,
                            color: Get.theme.betItemTabSelectedColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              // 图例：晋级区等颜色说明
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
                          decoration: BoxDecoration(
                            color: e['color'] ?? Colors.black,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          e['label'] ?? '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Get.theme.analsTextTabSelectColor,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
