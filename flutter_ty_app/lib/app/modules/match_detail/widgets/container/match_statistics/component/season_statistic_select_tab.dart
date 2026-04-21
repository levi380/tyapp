
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../controllers/statistic/season_statistic_controller.dart';
import '../../../../states/match_statistic_state.dart';

/// 赛季统计选择标签组件
/// 用于展示和切换主队/客队选择，以及显示更多选项菜单
class SeasonStatisticSelectTab {
  /// 构建选择标签视图
  /// [controller] 赛季统计控制器，包含选择状态和菜单数据
  /// 返回包含主客队切换按钮和更多选项按钮的容器
  static Widget buildSelectTab(SeasonStatisticController controller) {
    final state = controller.state;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.w),
      height: 28.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTeamSelectButtons(controller),
          _buildMoreOptionsButton(controller, state),
        ],
      ),
    );
  }

  /// 构建主客队选择按钮组
  /// [controller] 赛季统计控制器
  /// 返回包含主队和客队选择按钮的容器
  static Widget _buildTeamSelectButtons(SeasonStatisticController controller) {
    return Container(
      decoration: BoxDecoration(
          color: Get.theme.leaguePointsBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(12.w))),
      child: Row(
        children: [
          _buildTeamSelectButton(controller, 0, true),
          _buildTeamSelectButton(controller, 1, false),
        ],
      ),
    );
  }

  /// 构建单个队伍选择按钮
  /// [controller] 赛季统计控制器
  /// [teamIndex] 队伍索引，0为主队，1为客队
  /// [isHomeTeam] 是否为主队
  /// 返回可点击的队伍选择按钮
  static Widget _buildTeamSelectButton(
      SeasonStatisticController controller, int teamIndex, bool isHomeTeam) {
    final isSelected = controller.state.selectTeamIndex.value == teamIndex;
    return Container(
      width: 68.w,
      height: isHomeTeam ? 28.w : 34.w,
      alignment: Alignment.center,
      decoration: isSelected
          ? BoxDecoration(
              color: MatchStatisticMatchHistoryState.selectedTabBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(12.w)))
          : BoxDecoration(),
      child: Text(
        isHomeTeam
            ? LocaleKeys.app_h5_handicap_tutorial_home_team.tr
            : LocaleKeys.app_h5_handicap_tutorial_away_team.tr,
        style: TextStyle(
            fontSize: 12.sp, color: MatchStatisticMatchHistoryState.primaryColor),
      ),
    ).onTap(() => controller.setTeamSelectIndex(teamIndex));
  }

  /// 构建更多选项按钮
  /// [controller] 赛季统计控制器
  /// [state] 控制器状态
  /// 返回可点击的更多选项按钮，点击后显示下拉菜单
  static Widget _buildMoreOptionsButton(
      SeasonStatisticController controller, dynamic state) {
    return Container(
      key: state.menuItemKey,
      child: Row(
        children: [
          Text(
            state.selectPlayInfo.value,
            style: TextStyle(
                color: Get.theme.tabPanelSelectedColor, fontSize: 12.sp),
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 16.w,
            color: MatchStatisticMatchHistoryState.primaryColor,
          )
        ],
      ),
    ).onTap(() {
      showMoreItem(controller);
    });
  }

  /// 显示更多选项菜单
  /// [controller] 赛季统计控制器
  /// 计算菜单位置并显示下拉菜单，用户可以选择不同的选项
  /// 返回一个Future，用于处理菜单选择结果
  static Future showMoreItem(SeasonStatisticController controller) {
    final state = controller.state;

    // 计算对应点击位置，用于弹窗定位
    final RenderBox button =
        state.menuItemKey.currentContext!.findRenderObject() as RenderBox;
    var leftoffset = button.localToGlobal(Offset.zero);
    var topoffset = button.localToGlobal(Offset(0, 6 * button.size.height));

    return showMenu(
      constraints: const BoxConstraints(
          minHeight: 30, maxHeight: 100, minWidth: 70, maxWidth: 150),
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      position: RelativeRect.fromLTRB(leftoffset.dx,
          topoffset.dy - 15.h - (25 * (state.morePlays.length)), 1.sw, 0),
      // 菜单栏位置
      items: _buildMenuItems(state),
      elevation: 5.0,
    ).then((value) async {
      // 处理选项菜单返回的值
      if (value != null) {
        controller.updateTeamIndex(value);
      }
    });
  }

  /// 构建菜单项列表
  /// [state] 控制器状态，包含菜单选项数据
  /// 返回菜单项列表，每个菜单项包含选项文本和选中状态样式
  static List<PopupMenuItem> _buildMenuItems(dynamic state) {
    return List.generate(
        state.morePlays.length,
        (index) => PopupMenuItem(
              height: 25.h.scale,
              padding: EdgeInsets.only(left: 8.h),
              value: index,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      textAlign: TextAlign.start,
                      state.morePlays[index],
                      style: TextStyle(
                        fontSize: 8.sp.scale,
                        fontWeight: FontWeight.w500,
                        color: state.selectPlayInfo == state.morePlays[index]
                            ? (Get.isDarkMode
                                ? MatchStatisticMatchHistoryState.primaryColor
                                : Colors.black)
                            : Get.isDarkMode
                                ? MatchStatisticMatchHistoryState.unselectedTextColor
                                : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
            ));
  }
}

