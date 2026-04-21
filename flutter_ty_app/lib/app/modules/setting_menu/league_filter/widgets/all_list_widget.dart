import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../../../main.dart';
import '../../../../services/models/res/get_filter_match_list_all_entity.dart';
import '../../../result/widgets/results_no_data_widget.dart';
import 'dart:math' as math;

import '../all_league_filter/all_league_filter_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选 滚球全部 列表组件 AllListWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选 滚球全部 列表组件 AllListWidget
    - AllListWidget
    ```
    ///滚球全部 列表页面
    AllListWidget(
      isDark: context.isDarkMode,
      listObserverController: controller.listObserverController,
      sportVOs: controller.sportVOs,
      autoScrollController: controller.autoScrollController,
      onlyOne: controller.onlyOne,
      onClickItemExpand: (index) =>
      controller.onClickNationItemExpand(index),
      onObserves: (index) => controller.onObserves(index),
      onSelectGroup: (index) =>
      controller.onSelectNationGroup(index),
      onSelectNationItem: (id) =>
      controller.onSelectNationItem(id),
      searchController: controller.searchController,
    ),
    ```
    】】】
 *
 */

class AllListWidget extends StatelessWidget {
  const AllListWidget({
    super.key,
    required this.isDark,
    required this.listObserverController,
    required this.sportVOs,
    required this.autoScrollController,
    required this.onlyOne,
    required this.onClickItemExpand,
    required this.onObserves,
    required this.onSelectGroup,
    required this.onSelectNationItem,
    required this.searchController,
  });

  final bool isDark;
  final dynamic listObserverController;
  final List<GetFilterMatchListAllDataSportVOs> sportVOs;
  final dynamic autoScrollController;
  final bool onlyOne;
  final void Function(dynamic) onClickItemExpand;
  final void Function(dynamic) onObserves;
  final void Function(dynamic) onSelectGroup;
  final void Function(dynamic) onSelectNationItem;
  final dynamic searchController;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AllLeagueFilterController>();
    var getFilterMatchList = controller.getFilterMatchList;

    return ListViewObserver(
      controller: listObserverController,
      child: getFilterMatchList.isNotEmpty
          ? ListView.builder(
              controller: autoScrollController,
              padding: EdgeInsets.zero,
              itemCount: getFilterMatchList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      top: index == 0 ? 0.h : 5.h,
                      bottom:
                          index == getFilterMatchList.length - 1 ? 550.h : 0.h),
                  child: Column(
                    children: [
                      if (!onlyOne)
                        Container(
                          height: 48.h,
                          color: context.isDarkMode
                              ? const Color(0xFF1E2029)
                              : const Color(0xFFF2F2F6),
                          child: Container(
                            margin: EdgeInsets.only(left: 14.w, right: 25.w),
                            child: InkWell(
                              onTap: () => onClickItemExpand(index),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Transform.rotate(
                                        angle:
                                            getFilterMatchList[index].isExpand
                                                ? -math.pi / 2
                                                : 0,
                                        child: ImageView(
                                          "assets/images/icon/icon_expand_gray_night.png",
                                          height: 16.w,
                                          width: 16.w,
                                        ),
                                      ),
                                      Container(
                                        width: 8.w,
                                      ),
                                      Container(
                                        width: isIPad ? 600.w : 280.w,
                                        child: Text(
                                          getFilterMatchList[index].nameText,
                                          style: TextStyle(
                                            color: context.isDarkMode
                                                ? Colors.grey
                                                : const Color(0xFF303442),
                                            fontSize: 14.sp,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () => onSelectGroup(index),
                                    child: ImageView(
                                      getFilterMatchList[index].isSelect ==
                                              false
                                          ? "assets/images/icon/search_unselected.png"
                                          : "assets/images/icon/search_selected.png",
                                      height: 20.w,
                                      width: 20.w,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      getFilterMatchList[index].isExpand
                          ? Container()
                          : Column(
                              children: generateGroupContainers(
                                  getFilterMatchList[index].tournamentList),
                            ),
                    ],
                  ),
                );
              })
          : Container(
              alignment: Alignment.center,
              child: const ResultsNoDataWidget(),
            ),
      onObserve: (resultModel) => onObserves(resultModel.firstChild?.index),
    );
  }

  /// 生成分组UI
  generateGroupContainers(List<GetFilterMatchListAllDataSportVOsTournamentList> tournamentListse) {

    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    /// 过滤比赛列表，根据搜索关键词进行匹配
    var tournamentList = tournamentListse.where((item) {
      /// 如果搜索文本为空，返回所有项目
      if (searchControllerText.isEmpty) {
        return true;
      }

      /// 检查每个关键词是否都在项目名称中找到
      return keywords.every((keyword) {
        /// 将关键词转换为小写
        var lowerKeyword = keyword.toLowerCase();

        /// 检查项目名称和 tnjc 是否包含该关键词
        return item.nameText.toLowerCase().contains(lowerKeyword) ||
            item.tnjc.toLowerCase().contains(lowerKeyword); /// 同时匹配 nameText 和 tnjc
      });
    }).toList();


    return List.generate(tournamentList.length, (index) {
      var groupItem = tournamentList[index];
      return Container(
        height: 48.h,
        margin: EdgeInsets.only(left: 30.w, right: 25.w),
        decoration: tournamentList.length - 1 != index
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withValues(alpha:0.3),
                    // Set the color of the bottom_nav border
                    width: 0.5.w, // Set the width of the bottom_nav border
                  ),
                ),
              )
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                groupItem.picUrlthumb.isNotEmpty
                    ? ImageView(
                        groupItem.picUrlthumb,
                        height: 22.w,
                        width: 22.w,
                        cdn: true,
                      )
                    : ImageView(
                        'assets/images/league/match_cup.svg',
                        height: 22.w,
                        width: 22.w,
                      ),
                Container(
                  width: 10.w,
                ),
                SizedBox(
                  width: isIPad ? 500.w : 200.w,
                  child: Text(
                    groupItem.nameText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: isDark ? Colors.white : const Color(0xFF303442),
                      fontSize: isIPad ? 16.sp : 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '(${groupItem.num})',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withValues(alpha:0.30000001192092896)
                        : const Color(0xFFAFB3C8),
                    fontSize: 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  width: 10.w,
                ),
                InkWell(
                  onTap: () => onSelectNationItem(groupItem.id),
                  child: ImageView(
                    groupItem.isSelect == false
                        ? "assets/images/icon/search_unselected.png"
                        : "assets/images/icon/search_selected.png",
                    height: 20.w,
                    width: 20.w,
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
