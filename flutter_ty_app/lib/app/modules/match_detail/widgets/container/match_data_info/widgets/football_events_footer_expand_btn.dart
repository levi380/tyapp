import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

/// 足球事件页底部「展开/收起」按钮
///
/// 当 [currentEventDataEvents] 非空时显示，点击调用 [onToggle] 切换展开状态。
class FootballEventsFooterExpandBtn extends StatelessWidget {
  /// 当前是否处于展开状态（true 显示「收起」，false 显示「展开」）
  final bool isExpanded;
  /// 点击时回调，由父组件切换 [isExpanded] 并刷新列表展示条数
  final VoidCallback onToggle;

  const FootballEventsFooterExpandBtn({
    super.key,
    required this.isExpanded,
    required this.onToggle,
  });

  /// 构建按钮：圆角容器 + 根据 [isExpanded] 显示「收起」或「展开」文案，样式来自 [MatchDataState.eventFooterTextFontSize]。
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
          color: Get.theme.resultContainerBgColor,
        ),
        margin: EdgeInsets.only(top: 4.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
        child: Text(
          isExpanded ? LocaleKeys.bet_pack_up.tr : LocaleKeys.bet_record_pack_down.tr,
          style: TextStyle(
            fontSize: MatchDataState.eventFooterTextFontSize.sp,
            color: Get.theme.tabPanelSelectedColor,
          ),
        ),
      ),
    );
  }
}
