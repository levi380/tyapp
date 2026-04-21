import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/home/models/match_group.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:flutter_ty_app/app/modules/result/widgets/result_detail_featured_list_view_body_widget.dart';
import '../../services/models/res/match_entity.dart';
import '../home/models/section_group_enum.dart';
import '../main_tab/main_tab_controller.dart';

// var kFirstIndex = 0.obs;
// var kLastIndex = 10;

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 常规赛事 】】】
    【【【 AUTO_PARAGRAPH_TITLE 基础列表公共UI组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 列表上下滑动监听 ScrollIndexWidget
    ```
    ///向下滚动
    Bus.getInstance().emit(EventType.listScrollingDown);
    ///向上滚动
    Bus.getInstance().emit(EventType.listScrollingUp);
    ```
    - 滑动至顶部
    ```
    Bus.getInstance().on(EventType.scrollToTop, (value) {
    if (mounted) {
    try {
    _scrollController.animateTo(0,
    duration: const Duration(milliseconds: 100),
    curve: Curves.easeInOut);
    } catch (e) {}
    }
    });
    ```
    - 赛事列表 ListView
    ```
    1:SectionHeaderWidget 进行中  全部联赛  未开赛 组折叠状态
    2:SportHeaderWidget 足球头部 赛事数量统计
    3:MatchGroupHeaderWidget 列表联赛标题 联赛折叠也显示
    4:BetTitleGroupWidget 联赛未折叠显示
      BetTitleGroupWidget 列表sub标题 全场独赢\让球\大小等
      ItemBodyWidget body数据
    ```
    】】】
 *
 */
///精选赛事 最新样式
///
class ResultDetailFeaturedListView extends StatelessWidget {
  const ResultDetailFeaturedListView({
    super.key,
    required this.isDark,
    this.onExpandItem,
    required this.matchHandpickData,
    required this.onGoToDetails,
  });
  final bool isDark;
  final VoidCallback? onExpandItem;
  final List<MatchEntity> matchHandpickData;
  final void Function(dynamic) onGoToDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.isDarkMode ? null : const Color(0xfff2f2f6),
      margin: EdgeInsets.only(top: 10.w),
      child: Stack(children: [
        ///滚动监听控件
        GetBuilder<TyHomeController>(
            tag: MainTabController.to.uuid,
            builder: (controller) {
              // AppLogger.debug("对照组1");
              // AppLogger.debug(TyHomeController.to.homeState.combineList.length);
              // print("对照组2");
              // print(matchHandpickData.length);

              // print("对照组3");
              // print(filterList.length);
              Map<String, List<MatchEntity>> matchsMap =
                  groupMatchesByTid(matchHandpickData);
              List<String> tidList = matchsMap.keys.toList();
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: tidList.length,
                itemBuilder: (context, index) {
                  String tid = tidList[index];
                  var matchGroup = MatchGroup(
                    tn: '',
                    tid: tid,
                    matches: matchsMap[tid] ?? [],
                    isSectionHeader: false,
                    sectionGroupEnum: SectionGroupEnum.SELECTED,
                    isSportHeader: false,
                    sportTitle: '',
                    sportCount: 0,
                    csid: '',
                  );
                  var combineList = CombineInfo.generateFrom(matchGroup);
                  return ResultDetailFeaturedListViewBodyWidget(
                    controller: controller,
                    filterList: combineList,
                  );
                },
              );
            }),
        // GetBuilder<TyHomeController>(
        //     id: "showTop",
        //     tag: MainTabController.to.uuid,
        //     builder: (controller) {
        //       return Visibility(
        //           visible: controller.showTop,
        //           child: Positioned(
        //             right: 14.w,
        //             bottom: bottomHideSwitch ? 320.h : 120.h,
        //             child: ImageView(
        //               context.isDarkMode
        //                   ? 'assets/images/home/back_top_d.png'
        //                   : 'assets/images/home/back_top_l.png',
        //               width: context.isDarkMode ? 30.w : 40.w,
        //               height: context.isDarkMode ? 30.w : 40.w,
        //               onTap: () {
        //                 ///滑动至指定位置
        //                 TyHomeController.to.commonScrollController.animateTo(
        //                   0,
        //                   duration: const Duration(milliseconds: 200),
        //                   curve: Curves.easeInOut,
        //                 );
        //               },
        //             ),
        //           ));
        //     })
      ]),
    );
  }

  ///精选赛事数据合并
  // List<MatchEntity> mergeMatchEntities(List<MatchEntity> matchList) {
  //   final Map<String, MatchEntity> mergedMap = {};
  //   for (MatchEntity match in matchList) {
  //     final tid = match.tid;
  //     if (!mergedMap.containsKey(tid)) {
  //       /// 首次 tid记录
  //       MatchEntity newMatch = match.copyWith(
  //         hps: List.from(match.hps),
  //       );
  //       newMatch.mids = [match.mid]; // 初始化 mids 列表
  //       mergedMap[tid] = newMatch;
  //     } else {
  //       /// 合并 hps
  //       mergedMap[tid]!.hps.addAll(match.hps);
  //       /// 记录所有 mid（去重）
  //       if (!mergedMap[tid]!.mids.contains(match.mid)) {
  //         mergedMap[tid]!.mids.add(match.mid);
  //       }
  //     }
  //   }
  //
  //   return mergedMap.values.toList();
  // }

  /// 按 tid 分组，每个 tid 下保留多个不同 mid 的 MatchEntity
  Map<String, List<MatchEntity>> groupMatchesByTid(
      List<MatchEntity> matchList) {
    final Map<String, List<MatchEntity>> groupedMap = {};
    for (MatchEntity match in matchList) {
      groupedMap.putIfAbsent(match.tid, () => []);
      groupedMap[match.tid]!.add(match);
    }
    return groupedMap;
  }

  // _secondFilter () {
  //   try {
  //     print('走了');
  //     TyHomeController.to.changeMenu(MainMenu.menuList[2]);
  //
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
