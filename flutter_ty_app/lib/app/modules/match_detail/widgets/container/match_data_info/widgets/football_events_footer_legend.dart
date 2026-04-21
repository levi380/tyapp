import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_data_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

/// 足球事件页底部关键事件图例
///
/// 显示分隔线及 [bottomKeyEvent] 列表的图标+文案，使用 [Wrap] 自动换行。
class FootballEventsFooterLegend extends StatelessWidget {
  const FootballEventsFooterLegend({super.key, required this.controller});

  /// 数据控制器，用于读取 [state.bottomKeyEvent]（红牌、黄牌等关键事件配置）
  final MatchDataController controller;

  /// 构建图例区域：上方 8.w 间距 + 全宽分隔线 + 居中 [Wrap] 列表。
  /// 每个图例项为 [Row]：图标（assets/images/match_analysis/{id}.png）+ 文案（e["i18n"]）。
  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    return Column(
      children: [
        SizedBox(height: 8.w),
        Container(
          height: 1,
          color: Get.theme.dividerColor,
          width: 1.sw,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: state.bottomKeyEvent.map((e) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageView(
                  "assets/images/match_analysis/${e["id"]}.png",
                  width: 10.w,
                  height: 10.w,
                  boxFit: BoxFit.fitWidth,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  child: Text(
                    "${e["i18n"]}",
                    style: TextStyle(
                      fontSize: MatchDataState.eventFooterTextFontSize.sp,
                      color: Get.theme.betItemTextColor,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
