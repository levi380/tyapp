import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/league_filter_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/widgets/league_search_bar_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/widgets/league_title_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/widgets/nation_alphabet_filter_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/widgets/nation_list_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/widgets/nation_select_all_box_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/widgets/no_data_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_search/controllers/league_search_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_search/views/league_search_view.dart';
import 'package:flutter_ty_app/app/utils/bus/event_bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../../main.dart';
import 'league_filter_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选 视图页面 LeagueFilterPage  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选 视图页面 LeagueFilterPage
    - LeagueFilterPage
    ```
    ///筛选界面
    _leagueFilter(),
    ///搜索界面
    LeagueSearchView(),
    ```
    】】】
 *
 */

class LeagueFilterPage extends StatefulWidget {
  const LeagueFilterPage({Key? key, this.index, this.isHot = false})
      : super(key: key);
  final int? index;
  final bool isHot;

  @override
  State<LeagueFilterPage> createState() => _LeagueFilterPageState();
}

class _LeagueFilterPageState extends State<LeagueFilterPage> {
  final controller = Get.find<LeagueFilterController>();
  final logic = Get.find<LeagueFilterController>().logic;

  int currentIndex = 0;
  bool _isHot = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index ?? 0;
    _isHot = widget.isHot;

    EventBus().on<EventPayLoad>().listen((payload) {
      if (payload.eventType == EventType.isHot) {
        setState(() {
          _isHot = payload.data;
          if (_isHot) {
            currentIndex = 0;
          } else {
            currentIndex = 1;
          }
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeagueFilterController>(
      builder: (controller) {
        return SizedBox(
          height: isSDK ? 600.h : 700.h,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            child: Container(
              color: context.isDarkMode
                  ? const Color(0xFF272931)
                  : const Color(0xFFF8F9FA),
              child: Column(
                children: [
                  Container(
                    color: context.isDarkMode
                        ? const Color(0xFF272931)
                        : Colors.white,
                    child: LeagueTitleWidget(
                      isDark: context.isDarkMode,
                      titles: [
                        if (!_isHot) LocaleKeys.footer_menu_filter.tr,
                        LocaleKeys.search_search_title.tr
                      ],
                      onTap: () => controller.onFinish(),
                      focusNode: controller.focusNode,
                      index: currentIndex,
                      onChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      onSearch: () {
                        EventBus().fire(
                          EventType.leagueSearchClick,
                        );
                      },
                    ),
                  ),
                  IndexedStack(
                    index: _isHot ? 1 : currentIndex,
                    children: [
                      ///筛选界面
                      _leagueFilter(),
                      ///搜索界面
                      LeagueSearchView(),
                    ],
                  ).expanded(),
                ],
              ).safeArea(),
            ),
          ),
        );
      },
    );
  }

  Widget _leagueFilter() {
    return Column(
      children: [
        ///联赛搜索框
        Container(
          color: context.isDarkMode ? const Color(0xFF272931) : Colors.white,
          child: Column(
            children: [
              LeagueSearchBarWidget(
                isDark: context.isDarkMode,
                debounceSearch: (value) => controller.debounceSearch(value),
                onClearSearchText: () => controller.onClearSearchText(),
                searchController: controller.searchController,
                focusNode: controller.focusNode,
              ),
              8.verticalSpace,
            ],
          ),
        ),

        /// 联赛列表
        logic.noData == true
            ? const NoDataWidget()
            : Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    ///列表页面
                    NationListWidget(
                      isDark: context.isDarkMode,
                      listObserverController: controller.listObserverController,
                      getFilterMatchListData: controller.getFilterMatchListData,
                      autoScrollController: controller.autoScrollController,
                      onlyOne: logic.onlyOne,
                      onClickItemExpand: (index) =>
                          controller.onClickNationItemExpand(index),
                      onObserves: (index) => controller.onObserves(index),
                      onSelectGroup: (index) =>
                          controller.onSelectNationGroup(index),
                      onSelectNationItem: (id) =>
                          controller.onSelectNationItem(id),
                      searchController: controller.searchController,
                    ),

                    ///字母排序列表
                    NationAlphabetFilterWidget(
                      isDark: context.isDarkMode,
                      toOnVerticalDragDown: (details) =>
                          controller.toOnVerticalDragDown(details),
                      toOnVerticalDragEnd: (details) =>
                          controller.toOnVerticalDragEnd(details),
                      toOnVerticalDragUpdate: (details) =>
                          controller.toOnVerticalDragUpdate(details),
                      getFilterMatchListData: controller.getFilterMatchListData,
                      changeIndex: (index) => controller.changeIndex(index),
                      currentIndex: logic.currentIndex,
                      indicator: logic.indicator,
                      location: logic.location,
                      searchController: controller.searchController,
                      spell: logic.spell,
                    )
                  ],
                ),
              ),

        ///全选按钮
        NationSelectAllBoxWidget(
          isDark: context.isDarkMode,
          onSelectAll: () => controller.onSelectAll(),
          searchController: controller.searchController,
          getFilterMatchListData: controller.getFilterMatchListData,
          selectAll: logic.selectAll,
          isSelectCount: logic.isSelectCount,
          onTap: () => controller.onFinish(),
        )
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<LeagueFilterController>();
    Get.delete<LeagueSearchController>();
    super.dispose();
  }
}
