import 'dart:math';

import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_search/controllers/league_search_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_search/utils/hot_search_util.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选  搜索界面列表 SearchPlaceHoldView  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选  搜索界面列表 SearchPlaceHoldView
    - SearchPlaceHoldView
    ```
    ```
    】】】
 *
 */
class SearchPlaceHoldView extends StatelessWidget {
  const SearchPlaceHoldView({super.key, required this.controller});
  final LeagueSearchController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _history(context, controller).marginOnly(bottom: 20.h),
          _hotSearch(context, controller),
        ],
      ),
    );
  }

  Widget _history(BuildContext context, LeagueSearchController controller) {
    if (controller.searchHistory.isEmpty) {
      return Container();
    }

    return Container(
      child: Column(
        children: [
          20.verticalSpace,
          Container(
            height: 41.h,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.league_search_search_history.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color:
                        context.isDarkMode ? Colors.white : Color(0xFF303442),
                  ),
                ),
                Text(
                  LocaleKeys.league_search_search_clear.tr,
                  style: TextStyle(
                    color:
                        context.isDarkMode ? Colors.white : Color(0xFF7881A3),
                    fontSize: 14.sp,
                  ),
                ).onTap(() {
                  controller.clearHistory();
                }),
              ],
            ),
          ),
          ListView.builder(
            itemCount: min(3, controller.searchHistory.length),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              String title = controller.searchHistory[index];
              return InkWell(
                onTap: () {
                  controller.searchController.text = title;
                  controller.onSearch();
                },
                child: Container(
                  height: 44.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: context.isDarkMode
                                ? Colors.white.withValues(alpha:0.1)
                                : Color(0xFFE4E6ED),
                            width: 0.5)),
                  ),
                  child: Row(
                    children: [
                      ImageView(
                        'assets/image/icon_history.svg',
                        cdn: true,
                        svgColor: context.isDarkMode
                            ? Colors.white.withValues(alpha:0.9)
                            : Color(0xFF303442),
                        width: 14.w,
                      ),
                      4.horizontalSpace,
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: context.isDarkMode
                              ? Colors.white.withValues(alpha:0.9)
                              : Color(0xFF303442),
                        ),
                      ).expanded(),
                      Icon(
                        Icons.close,
                        size: 13.w,
                        color: context.isDarkMode
                            ? Colors.white.withValues(alpha:0.9)
                            : Color(0xFF7881A3),
                      ).paddingSymmetric(vertical: 14.w).onTap(() {
                        controller.searchHistory.removeAt(index);
                        controller.update();
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _hotSearch(BuildContext context, LeagueSearchController controller) {
    if (controller.hotSearch.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        Text(
          LocaleKeys.league_search_hot_search.tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 8.w),
        Wrap(
          spacing: 20.w,
          runSpacing: 0.w,
          children: controller.hotSearch.asMap().entries.map((e) {
            String keyword = HotSearchUtil.handelHotSearchForLang(e.value);
            return Container(
              width: 171.w,
              height: 40.h,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  e.key < 3
                      ? ImageView(
                          'assets/image/hot_${1 + e.key}.png',
                          width: 16.w,
                          cdn: true,
                        )
                      : Container(
                          width: 16.w,
                          height: 16.w,
                          alignment: Alignment.center,
                          child: Text(
                            '${e.key + 1}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Akrobat',
                              color: context.isDarkMode
                                  ? Colors.white.withValues(alpha:0.9)
                                  : Color(0xFF616783),
                            ),
                          ),
                        ),
                  2.horizontalSpace,
                  Text(
                    keyword,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: e.key < 3 ?  FontWeight.w700 : FontWeight.w400,
                      fontFamily: 'PingFangSC',
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha:0.9)
                          : Color(0xFF333333),
                    ),
                  ).expanded(),
                ],
              ),
            ).onTap(() {
              controller.onSearchHot(keyword);
            });
          }).toList(),
        )
      ],
    );
  }
}
