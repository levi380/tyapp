import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/widget/blue_text_view_new.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/gray_text_view_new.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/season_statistic_controller.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../../../login/login_head_import.dart';

/// 篮球历史交战头部组件
/// 用于显示历史交战的标题和筛选标签（同场、同主客、同场/同主客）
class BasketBallHistoryWarHeaderWidget {
  /// 构建历史交战头部组件
  /// [name] 标题名称
  /// [controller] 赛季统计控制器，用于控制标签选择和状态更新
  /// 返回包含标题和筛选标签的容器组件
  static Widget build({
    required String name,
    required SeasonStatisticController controller,
  }) {
    return Container(
      height: 32.w,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14.sp,
                color: Get.theme.tabPanelSelectedColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          _buildTabButton(
            text: LocaleKeys.analysis_football_matches_same_game.tr,
            index: 0,
            controller: controller,
          ),
          Text("  "),
          _buildTabButton(
            text: LocaleKeys.analysis_football_matches_same_host_guest.tr,
            index: 1,
            controller: controller,
          ),
          Text("   "),
          _buildTabButton(
            text:
                "${LocaleKeys.analysis_football_matches_same_game.tr}/${LocaleKeys.analysis_football_matches_same_host_guest.tr}",
            index: 2,
            controller: controller,
            isWide: true,
          ),
        ],
      ),
    );
  }

  /// 构建标签按钮
  /// [text] 按钮文本
  /// [index] 标签索引（0: 同场, 1: 同主客, 2: 同场/同主客）
  /// [controller] 赛季统计控制器
  /// [isWide] 是否为宽按钮（用于组合标签）
  /// 返回可点击的标签按钮组件
  static Widget _buildTabButton({
    required String text,
    required int index,
    required SeasonStatisticController controller,
    bool isWide = false,
  }) {
    final isSelected = controller.state.curSelectTab1.value == index;
    final width = isWide ? 100.w : 50.w;

    return InkWell(
      onTap: () {
        controller.setCurSelectTab1(index);
      },
      child: isSelected
          ? BluetextNew(
              text,
              width,
              20.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                border: Border.all(
                  color: Get.theme.secondTabPanelSelectedFontColor,
                ),
              ),
            )
          : GraytextNew(
              text,
              width,
              20.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                border: Border.all(color: Colors.transparent),
                color: Get.theme.foldColor,
              ),
            ),
    );
  }
}

