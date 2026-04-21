import 'package:flutter/material.dart'; // 导入Flutter的Material设计风格组件
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 导入屏幕适配插件
import 'package:flutter_ty_app/app/global/config_controller.dart'; // 导入全局配置控制器
import 'package:flutter_ty_app/app/global/config_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/dj/dj_league_search/views/dj_search_place_hold_view.dart'; // 导入DJ联赛搜索占位视图
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/widgets/league_search_bar_widget.dart'; // 导入联赛搜索条小部件
import 'package:flutter_ty_app/app/modules/setting_menu/league_search/widgets/tab_bar_widget.dart'; // 导入标签栏小部件
import 'package:flutter_ty_app/generated/locales.g.dart'; // 导入国际化语言文件

import 'package:get/get.dart'; // 导入GetX框架

import '../../../../utils/ty_text_scaler.dart'; // 导入文本缩放工具类
import '../controllers/dj_league_search_controller.dart'; // 导入DJ联赛搜索控制器

// DJ联赛搜索视图
class DjLeagueSearchView extends GetView<DJLeagueSearchController> {
  const DjLeagueSearchView({super.key});

  /// 显示 DJ 联赛搜索弹窗
  static Future<Map<String, dynamic>?> show() async {
    /// 创建 Controller（保证生命周期正确）
    Get.put(DJLeagueSearchController());
    return await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const DjLeagueSearchView(),
    );

  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final Color bgColor = isDark ? const Color(0xFF272931) : Colors.white;
    final Color tabBg = isDark ? const Color(0xFF1E2029) : const Color(0xFFF8F9FA);

    return Container(
      height: 800.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: GetBuilder<DJLeagueSearchController>(
        init: DJLeagueSearchController(),
        builder: (controller) {
          return Column(
            children: [
              ///顶部标题栏
              _HeaderBar(controller: controller, isDark: isDark),
              /// 搜索栏区域
              _SearchBarArea(controller: controller, isDark: isDark),
              /// Tab内容区域
              _TabContent(controller: controller, tabBg: tabBg),
            ],
          );
        },
      ),
    );
  }
}


/// 顶部标题栏
class _HeaderBar extends StatelessWidget {
  final DJLeagueSearchController controller;
  final bool isDark;

  const _HeaderBar({
    required this.controller,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final Color titleColor = isDark ? Colors.white : const Color(0xFF303442);

    return Container(
      height: 62.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _textBtn(LocaleKeys.common_cancel.tr, onTap: Get.back),
          Text(
            LocaleKeys.league_search_search.tr,
            style: TextStyle(
              color: titleColor,
              fontSize: TyTextScaler.instance().scale(18.sp),
              fontWeight: FontWeight.w500,
              fontFamily: 'PingFang SC',
            ),
          ),
          _textBtn(LocaleKeys.league_search_search.tr, onTap: controller.onSearch),
        ],
      ),
    );
  }

  Widget _textBtn(String text, {required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF179CFF),
          fontSize: 17.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'PingFang SC',
        ),
      ),
    );
  }
}

/// 搜索栏区域
class _SearchBarArea extends StatelessWidget {
  final DJLeagueSearchController controller;
  final bool isDark;

  const _SearchBarArea({
    required this.controller,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark ? const Color(0xFF272931) : Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LeagueSearchBarWidget(
            isDark: isDark,
            debounceSearch: (value) {},
            onClearSearchText: controller.onClearSearchText,
            searchController: controller.searchController,
            hintText: LocaleKeys.league_search_search_dj_placeholder.tr,
            focusNode: controller.searchFocusNode,
            onSubmitted: (_) => controller.onSearch(),
          ),
          8.verticalSpace,
        ],
      ),
    );
  }
}


/// Tab内容区域
class _TabContent extends StatelessWidget {
  final DJLeagueSearchController controller;
  final Color tabBg;

  const _TabContent({
    required this.controller,
    required this.tabBg,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: controller.tabs.length,
        initialIndex: controller.index,
        child: Container(
          color: tabBg,
          child: Column(
            children: [
              TabBarWidget(
                tabs: controller.tabs
                    .map((e) => ConfigController.to.getName(e.mi))
                    .toList(),
                onValueChange: controller.onChanged,
              ),
              Expanded(
                child: DJSearchPlaceHoldView(controller: controller),
              )
            ],
          ),
        ),
      ),
    );
  }
}

