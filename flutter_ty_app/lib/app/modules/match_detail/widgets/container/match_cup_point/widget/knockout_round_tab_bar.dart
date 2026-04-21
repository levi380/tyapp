import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_cup_point_controller.dart';

/// 淘汰赛轮次横向 Tab 栏
///
/// 根据 [dataList] 生成可点击的 Tab，当前选中项及之前的项高亮 [colorSelectBorder]，其余为 [colorBorder6]。
class KnockoutRoundTabBar extends StatelessWidget {
  const KnockoutRoundTabBar({
    super.key,
    required this.controller,
  });

  /// 杯赛积分控制器，提供 [state.dataList] 与 [state.currentIndex]，点击时调用 [selectIndex]。
  final MatchCupPointController controller;

  /// 构建横向可滚动 [Row]：每个轮次为 [InkWell] 包裹的 [Column]（轮次名 [Text] + 底部 82.w×3.w 高亮条），选中态与未选中态颜色区分。
  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: state.dataList
            .map((e) => InkWell(
                  onTap: () => controller.selectIndex(state.dataList.indexOf(e)),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          e.name,
                          style: TextStyle(
                            color: state.dataList.indexOf(e) <= controller.state.currentIndex
                                ? AppColor.colorSelectBorder
                                : AppColor.colorBorder6,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.w),
                        Container(
                          width: 82.w,
                          height: 3.w,
                          decoration: BoxDecoration(
                            color: state.dataList.indexOf(e) <= controller.state.currentIndex
                                ? AppColor.colorSelectBorder
                                : AppColor.colorBorder6,
                            borderRadius: BorderRadius.all(Radius.circular(2.w)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
