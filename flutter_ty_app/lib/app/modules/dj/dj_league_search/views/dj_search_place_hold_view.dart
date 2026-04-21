import 'dart:math'; // 导入数学库，用于随机数生成等操作

import 'package:flutter_ty_app/app/extension/widget_extensions.dart'; // 导入自定义的Widget扩展类
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart'; // 导入登录模块的头部导入文件

import 'package:flutter_ty_app/generated/locales.g.dart'; // 导入国际化语言文件

import '../controllers/dj_league_search_controller.dart'; // 导入DJ联赛搜索控制器

class DJSearchPlaceHoldView extends StatelessWidget {
  const DJSearchPlaceHoldView({super.key, required this.controller}); // 构造函数，接受控制器作为参数
  final DJLeagueSearchController controller; // DJ联赛搜索控制器

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w), // 设置容器的水平方向内边距
      child: Column(
        children: [
          _history(context, controller).marginOnly(bottom: 20.h), // 调用_history方法，生成搜索历史列表
          // _hotSearch(context, controller), // 注释掉的热门搜索方法
        ],
      ),
    );
  }

  Widget _history(BuildContext context, DJLeagueSearchController controller) {
    if (controller.searchHistory.isEmpty) {
      return const SizedBox.shrink(); // 如果搜索历史为空，则返回空容器
    }

    final bool isDark = context.isDarkMode;
    final Color titleColor = isDark ? Colors.white : const Color(0xFF303442);
    final Color actionColor = isDark ? Colors.white : const Color(0xFF7881A3);
    final Color contentColor =
        isDark ? Colors.white.withValues(alpha: 0.9) : const Color(0xFF303442);
    final Color dividerColor = isDark
        ? Colors.white.withValues(alpha: 0.1)
        : const Color(0xFFE4E6ED);

    return Column(
      children: [
        20.verticalSpace,
        _DjSearchSectionHeader(
          title: LocaleKeys.league_search_search_history.tr,
          actionText: LocaleKeys.league_search_search_clear.tr,
          titleColor: titleColor,
          actionColor: actionColor,
          onActionTap: controller.clearHistory,
        ),
        ListView.builder(
          itemCount: min(3, controller.searchHistory.length),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final String title = controller.searchHistory[index];
            return _DjSearchHistoryItem(
              title: title,
              dividerColor: dividerColor,
              contentColor: contentColor,
              actionColor: actionColor,
              onTap: () {
                controller.searchController.text = title;
                controller.onSearch();
              },
              onRemove: () => controller.removeHistory(title),
            );
          },
        ),
      ],
    );
  }

  // Widget _history(BuildContext context, DJLeagueSearchController controller) {
  //   if (controller.searchHistory.isEmpty) {
  //     return Container();
  //   }
  //
  //   return Container(
  //     child: Column(
  //       children: [
  //         20.verticalSpace,
  //         Container(
  //           height: 41.h,
  //           alignment: Alignment.center,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 '搜索历史',
  //                 style: TextStyle(
  //                   fontSize: 18.sp,
  //                   color:
  //                       context.isDarkMode ? Colors.white : Color(0xFF303442),
  //                 ),
  //               ),
  //               Text(
  //                 '清空',
  //                 style: TextStyle(
  //                   color:
  //                       context.isDarkMode ? Colors.white : Color(0xFF7881A3),
  //                   fontSize: 14.sp,
  //                 ),
  //               ).onTap(() {
  //                 // Clear search history
  //                 controller.searchHistory.clear();
  //               }),
  //             ],
  //           ),
  //         ),
  //         ListView.builder(
  //           itemCount: min(3, controller.searchHistory.length),
  //           shrinkWrap: true,
  //           physics: const NeverScrollableScrollPhysics(),
  //           itemBuilder: (BuildContext context, int index) {
  //             String title = controller.searchHistory[index];
  //             return Container(
  //               height: 44.h,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 border: Border(
  //                     bottom_nav: BorderSide(color: Color(0xFFE4E6ED), width: 0.5)),
  //               ),
  //               child: Row(
  //                 children: [
  //                   ImageView(
  //                     'assets/image/icon_history.svg',
  //                     isLocalImage: true,
  //                     svgColor: context.isDarkMode
  //                         ? Color(0xFF303442)
  //                         : Color(0xFF303442),
  //                     width: 14.w,
  //                   ),
  //                   4.horizontalSpace,
  //                   Text(
  //                     title,
  //                     style: TextStyle(
  //                       fontSize: 16.sp,
  //                       color: context.isDarkMode
  //                           ? Color(0xFF303442)
  //                           : Color(0xFF303442),
  //                     ),
  //                   ).expanded(),
  //                   Icon(
  //                     Icons.close,
  //                     size: 13.w,
  //                     color: context.isDarkMode
  //                         ? Color(0xFF7881A3)
  //                         : Color(0xFF7881A3),
  //                   ).paddingSymmetric(vertical: 14.w).onTap(() {
  //                     controller.searchHistory.removeAt(index);
  //                     controller.update();
  //                   }),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _hotSearch(BuildContext context, DJLeagueSearchController controller) {
  //   if (controller.hotSearch.isEmpty) {
  //     return Container();
  //   }
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       20.verticalSpace,
  //       Text(
  //         '热门搜索',
  //         style: TextStyle(
  //           fontSize: 16.sp,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.black,
  //         ),
  //       ),
  //       SizedBox(height: 8.w),
  //       Wrap(
  //         spacing: 20.w,
  //         runSpacing: 0.w,
  //         children: controller.hotSearch.asMap().entries.map((e) {
  //           return Container(
  //             width: 171.w,
  //             height: 40.h,
  //             alignment: Alignment.centerLeft,
  //             child: Row(
  //               children: [
  //                 e.key < 3
  //                     ? ImageView(
  //                         'assets/image/hot_${1 + e.key}.png',
  //                         width: 16.w,
  //                         isLocalImage: true,
  //                       )
  //                     : Container(
  //                         width: 16.w,
  //                         height: 16.w,
  //                         alignment: Alignment.center,
  //                         child: Text(
  //                           '${e.key + 1}',
  //                           style: TextStyle(
  //                             fontSize: 16.sp,
  //                             fontWeight: FontWeight.w800,
  //                             fontFamily: 'Akrobat',
  //                             color: Color(0xFF616783),
  //                           ),
  //                         ),
  //                       ),
  //                 2.horizontalSpace,
  //                 Text(
  //                   e.value,
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: TextStyle(
  //                     fontSize: 14.sp,
  //                     fontWeight: FontWeight.w400,
  //                     fontFamily: 'PingFangSC',
  //                     color: Color(0xFF333333),
  //                   ),
  //                 ).expanded(),
  //               ],
  //             ),
  //           ).onTap(() {});
  //         }).toList(),
  //       )
  //     ],
  //   );
  // }
}

/// 搜索历史的区块标题（左标题 + 右侧操作）
class _DjSearchSectionHeader extends StatelessWidget {
  const _DjSearchSectionHeader({
    required this.title,
    required this.actionText,
    required this.titleColor,
    required this.actionColor,
    required this.onActionTap,
  });

  final String title;
  final String actionText;
  final Color titleColor;
  final Color actionColor;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 41.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          Text(
            actionText,
            style: TextStyle(
              color: actionColor,
              fontSize: 14.sp,
            ),
          ).onTap(onActionTap),
        ],
      ),
    );
  }
}

/// 搜索历史单行（左图标 + 标题 + 右删除）
class _DjSearchHistoryItem extends StatelessWidget {
  const _DjSearchHistoryItem({
    required this.title,
    required this.dividerColor,
    required this.contentColor,
    required this.actionColor,
    required this.onTap,
    required this.onRemove,
  });

  final String title;
  final Color dividerColor;
  final Color contentColor;
  final Color actionColor;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            ImageView(
              'assets/image/icon_history.svg',
              cdn: true,
              svgColor: contentColor,
              width: 14.w,
            ),
            4.horizontalSpace,
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: contentColor,
              ),
            ).expanded(),
            Icon(
              Icons.close,
              size: 13.w,
              color: actionColor,
            ).paddingSymmetric(vertical: 14.w).onTap(onRemove),
          ],
        ),
      ),
    );
  }
}
