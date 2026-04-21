
import 'package:flutter_ty_app/app/modules/result/djvr_league_filter/djvr_league_filter_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/result/djvr_league_filter/widgets/djvr_alphabet_filter_widget.dart';
import 'package:flutter_ty_app/app/modules/result/djvr_league_filter/widgets/djvr_list_widget.dart';
import 'package:flutter_ty_app/app/modules/result/djvr_league_filter/widgets/djvr_select_all_box_widget.dart';
import 'package:flutter_ty_app/app/modules/result/djvr_league_filter/widgets/djvr_title_widget.dart';
import '../../../../generated/locales.g.dart';
import '../../../../main.dart';
import '../../login/login_head_import.dart';
import '../../setting_menu/league_filter/widgets/league_search_bar_widget.dart';
import '../../setting_menu/league_filter/widgets/no_data_widget.dart';
import '../widgets/results_no_data_widget.dart';
import 'djvr_league_filter_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3a9df28f-c590-402c-a99e-edc66a224cb3-dj 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果电竞冠军联赛筛选】】】
    【【【 AUTO_PARAGRAPH_TITLE  电竞赛果冠军赛果 联赛筛选 视图页面 DjVrLeagueFilterPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  电竞赛果冠军赛果 联赛筛选 ResultsLeagueFilterPage
    - DjVrLeagueFilterPage
    ```
    ///联赛头部
    DjVrTitleWidget
    ///联赛搜索框
    LeagueSearchBarWidget
    /// 联赛列表
    ResultsNoDataWidget
    ///全选按钮
    DjVrSelectAllBoxWidget
    ///列表页面
    DjVrListWidget
    ///字母排序列表
    DjVrAlphabetFilterWidget
    ```
    】】】
 *
 */
class DjVrLeagueFilterPage extends StatefulWidget {
  const DjVrLeagueFilterPage({Key? key}) : super(key: key);

  @override
  State<DjVrLeagueFilterPage> createState() => _ResultsLeagueFilterPage();
}

class _ResultsLeagueFilterPage extends State<DjVrLeagueFilterPage> {
  final controller = Get.find<DjVrLeagueFilterController>();
  final logic = Get.find<DjVrLeagueFilterController>().logic;

  @override
  Widget build(BuildContext context) {
    double stateHeight = MediaQueryData.fromView(View.of(context)).padding.top;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: stateHeight),
      child: GetBuilder<DjVrLeagueFilterController>(
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
                          DjVrTitleWidget(
                            isDark: context.isDarkMode,
                            focusNode:controller.focusNode,
                            title: LocaleKeys.filter_match_select_title.tr,
                            onTap: () => controller.onFinish(),
                          ),

                          ///联赛搜索框
                          LeagueSearchBarWidget(
                              isDark: context.isDarkMode,
                              focusNode:controller.focusNode,
                              debounceSearch: (value) => controller.debounceSearch(value),
                              onClearSearchText: () => controller.onClearSearchText(),
                              searchController: controller.searchController),



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
                        Column(
                          children: [
                            ///全选按钮
                            DjVrSelectAllBoxWidget(
                              isDark: context.isDarkMode,
                              onSelectAll: () => controller.onSelectAll(),
                              searchController: controller.searchController,
                              getFilterMatchListNewsData: controller.getFilterMatchListNewsData,
                              selectAll: logic.selectAll,
                              isSelectCount:  logic.isSelectCount,
                              onTap: () => controller.onFinish(),
                            ),
                            ///列表页面
                            Expanded(
                              child: DjVrListWidget(
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
                            ),
                          ],
                        ),

                      ///字母排序列表
                      DjVrAlphabetFilterWidget(
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
    Get.delete<DjVrLeagueFilterPage>();
    super.dispose();
  }
}
