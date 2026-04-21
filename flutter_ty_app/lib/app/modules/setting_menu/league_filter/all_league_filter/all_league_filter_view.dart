import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/all_league_filter/all_league_filter_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_search/controllers/league_search_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_search/views/league_search_view.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../main.dart';
import '../../../../utils/bus/event_bus.dart';
import '../widgets/all_alphabet_filter_widget.dart';
import '../widgets/all_list_widget.dart';
import '../widgets/all_select_all_box_widget.dart';
import '../widgets/league_search_bar_widget.dart';
import '../widgets/league_title_widget.dart';
import '../widgets/no_data_widget.dart';
import 'all_league_filter_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选 滚球全部 视图页面 AllLeagueFilterPage  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选 滚球全部 视图页面 AllLeagueFilterPage
    - AllLeagueFilterPage
    ```
    ///筛选界面
    _leagueFilter(),
    ///搜索界面
    LeagueSearchView(),
    ```
    】】】
 *
 */
class AllLeagueFilterPage extends StatefulWidget {
  const AllLeagueFilterPage({Key? key, this.index, this.isHot = false})
      : super(key: key);
  final int? index;
  final bool isHot;

  @override
  State<AllLeagueFilterPage> createState() => _AllLeagueFilterPageState();
}

class _AllLeagueFilterPageState extends State<AllLeagueFilterPage> {
  final controller = Get.find<AllLeagueFilterController>();
  final logic = Get.find<AllLeagueFilterController>().logic;

  bool _isHot = false;

  int currentIndex = 0;

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
    double stateHeight = MediaQueryData.fromView(View.of(context)).padding.top;
    return GestureDetector(
      onTap: () {
        Bus.getInstance().emit(EventType.tyCloseDialog);
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: stateHeight),
        child: GetBuilder<AllLeagueFilterController>(
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
                        child: Column(
                          children: [
                            ///联赛头部
                            LeagueTitleWidget(
                              isDark: context.isDarkMode,
                              titles: [
                                if (!_isHot) LocaleKeys.footer_menu_filter.tr,
                                LocaleKeys.search_search_title.tr
                              ],
                              index: currentIndex,
                              onChanged: (index) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              focusNode: controller.focusNode,
                              onTap: () => controller.onFinish(),
                            ),
                          ],
                        ),
                      ),
                      IndexedStack(
                        index: _isHot ? 1 : currentIndex,
                        children: [
                          ///联赛搜索框
                          _leagueFilter(),
                          LeagueSearchView(),
                        ],
                      ).expanded(),
                      // _isHot
                      //     ? LeagueSearchView().expanded()
                      //     : (currentIndex == 0
                      //         ? _leagueFilter().expanded()
                      //         : LeagueSearchView().expanded()),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _leagueFilter() {
    return Column(children: [
      ///联赛搜索框
      LeagueSearchBarWidget(
          focusNode: controller.focusNode,
          isDark: context.isDarkMode,
          debounceSearch: (value) => controller.debounceSearch(value),
          onClearSearchText: () => controller.onClearSearchText(),
          searchController: controller.searchController),
      8.verticalSpace,

      /// 联赛列表
      logic.noData == true
          ? const NoDataWidget()
          : Expanded(
              child: Stack(
                children: [
                  ///列表页面
                  AllListWidget(
                    isDark: context.isDarkMode,
                    listObserverController: controller.listObserverController,
                    sportVOs: controller.sportVOs,
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
                  AllAlphabetFilterWidget(
                    isDark: context.isDarkMode,
                    toOnVerticalDragDown: (details) =>
                        controller.toOnVerticalDragDown(details),
                    toOnVerticalDragEnd: (details) =>
                        controller.toOnVerticalDragEnd(details),
                    toOnVerticalDragUpdate: (details) =>
                        controller.toOnVerticalDragUpdate(details),
                    sportVOs: controller.sportVOs,
                    changeIndex: (index) => controller.changeIndex(index),
                    currentIndex: logic.currentIndex,
                    indicator: logic.indicator,
                    location: logic.location,
                    searchController: controller.searchController,
                    spell: logic.spell,
                  ),
                ],
              ),
            ),

      ///全选按钮
      AllSelectAllBoxWidget(
        isDark: context.isDarkMode,
        onSelectAll: () => controller.onSelectAll(),
        searchController: controller.searchController,
        sportVOs: controller.sportVOs,
        selectAll: logic.selectAll,
        isSelectCount: logic.isSelectCount,
        onTap: () => controller.onFinish(),
      )
    ]);
  }

  @override
  void dispose() {
    Get.delete<AllLeagueFilterController>();
    Get.delete<LeagueSearchController>();
    super.dispose();
  }
}
