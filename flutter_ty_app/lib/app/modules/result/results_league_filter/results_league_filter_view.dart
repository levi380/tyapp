
import 'package:flutter_ty_app/app/modules/result/results_league_filter/results_league_filter_controller.dart';
import 'package:flutter_ty_app/app/modules/result/results_league_filter/results_league_filter_controller_ext.dart';

import '../../../../generated/locales.g.dart';
import '../../../../main.dart';
import '../../login/login_head_import.dart';
import '../../setting_menu/league_filter/widgets/alphabet_filter_widget.dart';
import '../../setting_menu/league_filter/widgets/league_search_bar_widget.dart';
import '../../setting_menu/league_filter/widgets/league_title_widget.dart';
import '../../setting_menu/league_filter/widgets/list_widget.dart';
import '../../setting_menu/league_filter/widgets/no_data_widget.dart';
import '../../setting_menu/league_filter/widgets/select_all_box_widget.dart';
import '../widgets/results_no_data_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-245a3681-af98-492f-85f3-b3190a23bc35-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 普通赛果联赛筛选】】】
    【【【 AUTO_PARAGRAPH_TITLE  普通赛果 联赛筛选 视图页面 ResultsLeagueFilterPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  普通赛果 联赛筛选 视图页面 ResultsLeagueFilterPage
    - ResultsLeagueFilterPage
    ```
    ///联赛头部
    LeagueTitleWidget
    ///联赛搜索框
    LeagueSearchBarWidget

    /// 联赛列表
    ResultsNoDataWidget

    ///列表页面
    ListWidget

    ///字母排序列表
    AlphabetFilterWidget

    ///全选按钮
    SelectAllBoxWidget
    ```
    】】】
 *
 */
class ResultsLeagueFilterPage extends StatefulWidget {
  const ResultsLeagueFilterPage({Key? key}) : super(key: key);

  @override
  State<ResultsLeagueFilterPage> createState() => _ResultsLeagueFilterPage();
}

class _ResultsLeagueFilterPage extends State<ResultsLeagueFilterPage> {
  final controller = Get.find<ResultsLeagueFilterController>();
  final logic = Get.find<ResultsLeagueFilterController>().logic;

  @override
  Widget build(BuildContext context) {
    double stateHeight = MediaQueryData.fromView(View.of(context)).padding.top;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: stateHeight),
      child: GetBuilder<ResultsLeagueFilterController>(
        builder: (controller) {
          return SizedBox(
            height: isSDK ? 600.h :700.h,
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
                            focusNode:controller.focusNode,
                            titles: [LocaleKeys.filter_match_select_title.tr],
                            onTap: () => controller.onFinish(),
                            onChanged: (value) {

                            },
                          ),

                          ///联赛搜索框
                          LeagueSearchBarWidget(
                              isDark: context.isDarkMode,
                              focusNode:controller.focusNode,
                              debounceSearch: (value) => controller.debounceSearch(value),
                              onClearSearchText: () => controller.onClearSearchText(),
                              searchController: controller.searchController,),



                        ],
                      ),
                    ),
                    Container(height: 10.h,),
                    /// 联赛列表
                    logic.downloadData == true
                    ? const NoDataWidget()
                    : logic.noData == true ?
                const ResultsNoDataWidget()

                    : Expanded(
                  child: Stack(
                    children: [
                      ///列表页面
                      ListWidget(
                        isDark: context.isDarkMode,
                        listObserverController: controller.listObserverController,
                        getFilterMatchListNewsData: controller.getFilterMatchListNewsData,
                        autoScrollController: controller.autoScrollController,
                        onlyOne: logic.onlyOne,
                        onClickItemExpand: (index) => controller.onClickItemExpand(index),
                        onObserves: (index) => controller.onObserves(index),
                        onSelectGroup: (index) => controller.onSelectGroup(index),
                        onSelectItem: (id) => controller.onSelectItem(id),
                        searchController:  controller.searchController,

                      ),

                      ///字母排序列表
                      AlphabetFilterWidget(
                        isDark: context.isDarkMode,
                        toOnVerticalDragDown: (details) => controller.toOnVerticalDragDown(details),
                        toOnVerticalDragEnd: (details) => controller.toOnVerticalDragEnd(details),
                        toOnVerticalDragUpdate: (details) => controller.toOnVerticalDragUpdate(details),
                        getFilterMatchListNewsData: controller.getFilterMatchListNewsData,
                        changeIndex: (index) => controller.changeIndex(index),
                        currentIndex: logic.currentIndex,
                        indicator: logic.indicator,
                        location: logic.location,
                        searchController:  controller.searchController,
                        spell:  logic.spell,
                      ),
                    ],
                  ),
                ),

                    ///全选按钮
                    if(logic.noData == false)
                    SelectAllBoxWidget(
                      isDark: context.isDarkMode,
                      onSelectAll: () => controller.onSelectAll(),
                      searchController: controller.searchController,
                      getFilterMatchListNewsData: controller.getFilterMatchListNewsData,
                      selectAll: logic.selectAll,
                      isSelectCount:  logic.isSelectCount,
                      onTap: () => controller.onFinish(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ResultsLeagueFilterPage>();
    super.dispose();
  }
}
