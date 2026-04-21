
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../../../../main.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../controllers/league_points_controller.dart';


/**
 * 联赛积分分组选择器组件
 */
class LeaguePointsFootballSelectBtn extends StatelessWidget {
  final LeaguePointsController controller;

  const LeaguePointsFootballSelectBtn({
    super.key,
    required this.controller,
  });

  /// 构建联赛积分分组选择器UI
  /// 当有多个分组时显示分组选择按钮
  @override
  Widget build(BuildContext context) {
    if ((controller.state.currentCupBasketBallEventDataEvents.isEmpty) ||
        controller.state.currentCupBasketBallEventDataEvents.length == 1) {
      return SizedBox();
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.w),
      padding: EdgeInsets.symmetric(vertical: 4.w),
      decoration: BoxDecoration(
          color: Get.theme.analsTextTabBgColor,
          borderRadius: BorderRadius.all(Radius.circular(8.w))),
      child: Row(
        children: controller.state.currentCupBasketBallEventDataEvents.map((e) {
          return Expanded(
              child: InkWell(
            onTap: () {
              controller.setCurrentCupBasketBallEventPageIndex(e);
            },
            child: Container(
              alignment: Alignment.center,
              height: 25.w,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
              decoration: controller.state.currentCupBasketBallEventPageIndex ==
                      controller.state.currentCupBasketBallEventDataEvents
                          .indexOf(e)
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w),
                      color: Get.theme.tabPanelBackgroundColor,
                    )
                  : null,
              child: Text(
                e.rankingName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: isIPad ? 14.sp : 10.sp,
                  fontWeight: FontWeight.w400,
                  color: Get.theme.analyzeSecondTabPanelSelectedFontColor,
                ),
              ),
            ),
          ));
        }).toList(),
      ),
    );
  }
}

