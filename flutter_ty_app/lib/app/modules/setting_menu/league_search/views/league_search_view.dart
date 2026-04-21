import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/widgets/league_search_bar_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_search/views/search_place_hold_view.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_search/widgets/tab_bar_widget.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

import 'package:get/get.dart';

import '../controllers/league_search_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选  搜索界面试图 LeagueSearchView  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选  搜索界面控制器 LeagueSearchView
    - LeagueSearchView
    ```
    ```
    】】】
 *
 */
class LeagueSearchView extends StatelessWidget {
  const LeagueSearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeagueSearchController>(
      init: LeagueSearchController(),
      initState: (_) {},
      global: true,
      autoRemove: false,
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              // /联赛搜索框
              Container(
                color:
                    context.isDarkMode ? const Color(0xFF272931) : Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LeagueSearchBarWidget(
                      isDark: context.isDarkMode,
                      debounceSearch: (value) {},
                      onClearSearchText: () => controller.onClearSearchText(),
                      searchController: controller.searchController,
                      hintText: LocaleKeys.league_search_search_placeholder.tr,
                      focusNode: FocusNode(),
                      onSubmitted: (value) {
                        controller.onSearch();
                      },
                    ),
                    8.verticalSpace,
                  ],
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: controller.tabs.length,
                  initialIndex: controller.index,
                  child: Container(
                    color: context.isDarkMode
                        ? Color(0xFF1E2029)
                        : Color(0xFFF8F9FA),
                    child: Column(children: [
                      TabBarWidget(
                        tabs: controller.tabs
                            .map((e) => ConfigController.to.getName(e.mi))
                            .toList(),
                        onValueChange: controller.onChanged,
                      ),
                      Expanded(
                        child: SearchPlaceHoldView(
                          controller: controller,
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
