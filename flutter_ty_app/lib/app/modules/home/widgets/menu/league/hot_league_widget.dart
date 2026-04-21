import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';

import 'package:flutter_ty_app/app/modules/home/models/hot_league_info.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/config/analytic/analytics_utils.dart';

import '../../../../../../main.dart';
import '../../../../../global/config_controller.dart';

import '../../../../../widgets/image_view.dart';
import 'hotLeagueController.dart';
import 'league_search_item.dart';

class HotLeagueWidget extends GetView<HotLeagueController> {
  const HotLeagueWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HotLeagueController>(
      init: HotLeagueController(),
      assignId: true,
      builder: (logic) {
        return _leagueSearch();
      },
    );
  }

  _leagueSearch() {
    return Container(
      height: isIPad ? 36.h : 24.w,
      padding: isIPad
          ? EdgeInsets.only(left: 10.w, right: 10.w, top: 8.w)
          : EdgeInsets.symmetric(horizontal: 10.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: TabBar(
              controller: controller.tabController,
              isScrollable: true,
              onTap: (index) {
                controller.setSelectedIndex(index);
              },
              indicator: BoxDecoration(),
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              tabs: List.generate(controller.hotLeagueList.length, (index) {
                HotLeagueInfo league = controller.hotLeagueList[index];
                bool isSelected = controller.currentIndex == index;
                if (index == 0) {
                  return Container(
                    height: 32.w,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      league.name.tr,
                      style: TextStyle(
                        fontSize: isIPad ? 16.sp.scale : 12.sp.scale,
                        fontWeight: FontWeight.w400,
                        color: isSelected
                            ? const Color(0xff179CFF)
                            : Get.isDarkMode
                                ? Colors.white.withAlpha(50)
                                : const Color(0xff7981A4),
                      ),
                    ),
                  );
                }
                if (league.sportConfigInfo.mi == SportConfig.Featured.sportId.toString()) {
                  return league_search_Item(
                    tilte: LocaleKeys.home_popular_featured.tr,
                    icon: ImageView(
                      isSelected
                          ? 'assets/images/sports/selected_active.svg'
                          : 'assets/images/sports/selected.svg',
                      width: 18.w,
                      height: 18.w,
                    ),
                    isSelected: isSelected,
                  );
                }
                if (league.show) {
                  return league_search_Item(
                    tilte: league.name,
                    icon: ImageView(
                        isSelected
                            ? league.selected
                            : (Get.isDarkMode ? league.night : league.normal),
                        cdn: true,
                        width: 18.w,
                        height: 18.w),
                    isSelected: isSelected,
                  );
                } else {
                  return SizedBox();
                }
              }),
            ),
          ),
          Obx(() {
            return ConfigController.to.accessConfig.value.searchSwitch
                ? InkWell(
                    onTap: () {
                      // controller.isSearch = !controller.isSearch;
                      // controller.update();
                      // controller.focusNode.requestFocus();
                      /// 热门联赛不展示赛选
                      bool showFilter = (HotLeagueController.to?.showLeageuFilter.value ??
                          true);
                      SettingMenuController.onLeagueFilter(showFilter ? 1 : 0,!showFilter);

                      // 搜索埋点
                      Analytics.track(AnalyticsEvent.menu_search, pagePath: '', clickTarget: (AnalyticsEvent.menu_search).toString());
                    },
                    child: Container(
                      height: 32.w,
                      alignment: Alignment.center,
                      child: ImageView(
                          Get.isDarkMode
                              ? 'assets/images/home/league_search_nor.png'
                              : 'assets/images/home/league_search.png',
                          width: 20.w,
                          height: 20.h),
                    ),
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  );
          }),
        ],
      ),
    );
  }

  // _search() {
  //   return Container(
  //     height: isIPad ? 36.h : 24.w,
  //     padding: isIPad
  //         ? EdgeInsets.only(left: 8.w, top: 8.w)
  //         : EdgeInsets.only(left: 8.w),
  //     alignment: Alignment.center,
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Container(
  //               height: 24.w,
  //               decoration: BoxDecoration(
  //                 color: Get.isDarkMode
  //                     ? Colors.white.withValues(alpha:0.04)
  //                     : const Color(0xffF2F2F6),
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //               padding: const EdgeInsets.only(left: 12, right: 8),
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Expanded(
  //                     child: TextField(
  //                       focusNode: controller.focusNode,
  //                       controller: controller.editingController,
  //                       decoration: InputDecoration(
  //                         hintText: LocaleKeys.ouzhou_search_placeholder.tr,
  //                         hintStyle: TextStyle(
  //                           fontSize: 12.sp.scale,
  //                           fontWeight: FontWeight.w400,
  //                           color: Get.isDarkMode
  //                               ? Colors.white.withAlpha(80)
  //                               : const Color(0xffC9CDDB),
  //                         ),
  //                         contentPadding: EdgeInsets.zero,
  //                         border: InputBorder.none,
  //                         focusedBorder: InputBorder.none,
  //                         enabledBorder: InputBorder.none,
  //                       ),
  //                       cursorColor: const Color(0xff179CFF),
  //                       style: TextStyle(
  //                         fontSize: 12.sp.scale,
  //                         fontWeight: FontWeight.w400,
  //                         color: Get.isDarkMode
  //                             ? Colors.white
  //                             : const Color(0xff303442),
  //                       ),
  //                     ),
  //                   ),
  //                   // controller.editingController.text.isNotEmpty
  //                   //     ? InkWell(
  //                   //         onTap: () {
  //                   //           controller.editingController.clear();
  //                   //         },
  //                   //         child: Container(
  //                   //           height: 24.w,
  //                   //           width: 24.w,
  //                   //           alignment: Alignment.center,
  //                   //           child: ImageView(
  //                   //             'assets/images/home/search_clear.png',
  //                   //             width: 12.w,
  //                   //             height: 12.w,
  //                   //           ),
  //                   //         ),
  //                   //       )
  //                   //     : Container(),
  //                 ],
  //               )),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             // controller.editingController.clear();
  //             // controller.isSearch = false;
  //             // controller.focusNode.unfocus();
  //             // TyHomeController.to.search('');
  //             // controller.update();
  //           },
  //           child: Container(
  //             height: 24.w,
  //             width: 44.w,
  //             alignment: Alignment.center,
  //             child: Text(
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //               LocaleKeys.common_cancel.tr,
  //               style: TextStyle(
  //                 fontSize: 12.sp.scale,
  //                 color: Get.isDarkMode
  //                     ? Colors.white.withAlpha(80)
  //                     : const Color(0xff303442),
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
