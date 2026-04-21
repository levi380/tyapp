
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/league_points_state.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../controllers/league_points_controller.dart';

/**
 * 联赛积分底部组件
 */
class LeaguePointsFootballFooter extends StatelessWidget {
  final LeaguePointsController controller;
  final bool? needBottomPadding;

  const LeaguePointsFootballFooter({
    super.key,
    required this.controller,
    this.needBottomPadding,
  });

  /// 构建联赛积分底部组件UI
  /// 显示分组颜色图例，当数据列表长度大于等于5时显示
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: controller.state.dataList.length >= 5,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40.w,
              width: 1.sw,
              alignment: Alignment.center,
              child: Wrap(
                spacing: 4.w,
                alignment: WrapAlignment.center,
                children: controller.state.union.values.map((e) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration:
                            BoxDecoration(color: e["color"] ?? Colors.black),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        e["label"] ?? "",
                        style: TextStyle(
                          fontSize: LeaguePointsState.basketballFooterLegendFontSize.sp,
                          color: Get.theme.orderDateTextColor,
                        ),
                      )
                    ],
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

