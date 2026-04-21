import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/bet_title_group_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/item_body_widget.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/result/widgets/results_detail_featured_group_header_widget.dart';
import 'package:flutter_ty_app/app/utils/change_skin_tone_color_util.dart';

import '../../../global/data_store_operate/ws_handle/ws_handle.dart';

import '../../home/controllers/match_expand_controller.dart';
import '../../home/widgets/item/header/seaction_header_widget.dart';

import '../../home/widgets/item/noob/noob_item_body_widget.dart';

var kFirstIndex = 0.obs;
var kLastIndex = 10;

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
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
class ResultDetailFeaturedListViewBodyWidget extends StatelessWidget {
  const ResultDetailFeaturedListViewBodyWidget({
    super.key,
    required this.controller,
    required this.filterList,
  });

  final TyHomeController controller;
  final List<CombineInfo> filterList;

  @override
  Widget build(BuildContext context) {
    var listviewLength = filterList.length;

    if (controller.homeState.showMatchtDiscount &&
        controller.homeState.matchtDiscount.length > 0) {
      listviewLength += 1;
    }

    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          controller: controller.commonScrollController,
          physics: const ClampingScrollPhysics(),
          itemCount: listviewLength,
          // 使用正常的滚动行为
          itemBuilder: (BuildContext context, int index) {
            if (controller.homeState.showMatchtDiscount &&
                controller.homeState.matchtDiscount.length > 0) {
              if (index == 0) {
                // return DiscountOddWidget(
                //   controller: controller,
                // );
                return SizedBox();
              } else {
                index -= 1;
              }
            }

            CombineInfo? combineInfo =
            filterList.safe(index);
            if (combineInfo == null) {
              return 0.verticalSpaceFromWidth;
            }
            if (controller.homeState.isProfess) {
              /// 如果是大的分组标题  进行中 未开始等
              /// 如果是大的分组标题  进行中 未开始等
              if (combineInfo.type == CombineType.sectionHeader) {
                //  进行中  全部联赛  未开赛
                return SectionHeaderWidget(
                  isExpand: !FoldMatchManager.isGroupFold(
                      combineInfo.sectionGroupEnum!),
                  onExpand: (value) {
                    ///设置组折叠状态
                    FoldMatchManager.setGroupFold(
                        combineInfo.sectionGroupEnum!, !value);

                    ///子折叠
                    TyHomeController.to.homeState.combineList
                        .forEach((element) {
                      if (element.sectionGroupEnum ==
                          combineInfo.sectionGroupEnum) {
                        FoldMatchManager.setFoldByTid(
                            element.tid, element.sectionGroupEnum!, !value);
                      }
                    });
                    controller.update();
                  },
                  sectionGroupEnum: combineInfo.sectionGroupEnum!,
                );
              }

              /// 赛事数量统计
              // if (combineInfo.type == CombineType.sportHeader) {
              //   //足球头部
              //   return SportHeaderWidget(
              //     title: '${combineInfo.sportTitle}(${combineInfo.sportCount})',
              //   );
              // }

              if (combineInfo.type == CombineType.matchWithHeader) {
                bool isFold = FoldMatchManager.isFoldByTid(
                    combineInfo.tid, combineInfo.sectionGroupEnum!);

                bool isClose = MatchDataBaseWS.closeMatch(
                    mhs: combineInfo.data!.mhs,
                    mmp: combineInfo.data!.mmp,
                    ms: combineInfo.data!.ms);
                if (isClose) {
                  return const SizedBox();
                }
                return Container(
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha:0.03999999910593033)
                        : const Color(0xffF8F9FA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r),
                      bottomLeft: combineInfo.isLastMatch || isFold
                          ? Radius.circular(8.r)
                          : Radius.zero,
                      bottomRight: combineInfo.isLastMatch || isFold
                          ? Radius.circular(8.r)
                          : Radius.zero,
                    ),
                    border: context.isDarkMode
                        ? null
                        : Border(
                      top: const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      ),
                      left: const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      ),
                      right: const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      ),
                      bottom: combineInfo.isLastMatch || isFold
                          ? const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      )
                          : BorderSide.none,
                    ),
                  ),
                  margin: EdgeInsets.only(
                      left: 5.w,
                      right: 5.w,
                      bottom: combineInfo.isLastMatch || isFold ? 8.w : 0
                  ),
                  // padding: EdgeInsets.only(left: 8.w),
                  child: Column(
                    children: [
                      ///列表联赛标题
                      ResultsDetailFeaturedGroupHeaderWidget(combineInfo: combineInfo),

                      ///没有折叠展示数据
                      if (!isFold)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Divider(
                              height: 0.4.w,
                              color: context.isDarkMode
                                  ? Colors.white.withAlpha(10)
                                  : const Color(0xffE4E6ED),
                            ),

                            ///列表sub标题 全场独赢\让球\大小等
                            BetTitleGroupWidget(
                              hps: combineInfo.data!.hps,
                              matchEntity: combineInfo.data!,
                            ).paddingOnly(bottom: 1.h),

                            ///body数据
                            ItemBodyWidget(
                              matchEntity: combineInfo.data!,
                              isDetail: true,
                            ),
                            if (combineInfo.isLastMatch)
                              2.verticalSpaceFromWidth,
                          ],
                        ),
                    ],
                  ),
                );
              }

              /// 没有头部等比赛展示
              if (combineInfo.type == CombineType.match) {
                bool isFold = FoldMatchManager.isFoldByTid(
                    combineInfo.tid, combineInfo.sectionGroupEnum!);
                if (isFold) return 0.verticalSpaceFromWidth;
                return Container(
                  margin: EdgeInsets.only(
                    bottom: combineInfo.isLastMatch ? 8.w : 0,
                    left: 5.w,
                    right: 5.w,
                  ),
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha:0.03999999910593033)
                        : const Color(0xffF8F9FA),
                    borderRadius: BorderRadius.only(
                      bottomLeft: combineInfo.isLastMatch
                          ? Radius.circular(4.r)
                          : Radius.zero,
                      bottomRight: combineInfo.isLastMatch
                          ? Radius.circular(4.r)
                          : Radius.zero,
                    ),
                    border: context.isDarkMode
                        ? null
                        : Border(
                      left: const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      ),
                      right: const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      ),
                      bottom: combineInfo.isLastMatch
                          ? const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      )
                          : BorderSide.none,
                    ),
                  ),
                  child: ItemBodyWidget(
                    matchEntity: combineInfo.data!,
                    isDetail: true,
                  ),
                );
              }
              return 0.verticalSpaceFromWidth;
            }

            else {
              ///新手版 赛事列表
              // if (combineInfo.type == CombineType.sectionHeader) {
              //   return SectionHeaderWidget(
              //     isExpand: !FoldMatchManager.isGroupFold(
              //         combineInfo.sectionGroupEnum!),
              //     onExpand: (value) {
              //       //折叠
              //       FoldMatchManager.setGroupFold(
              //           combineInfo.sectionGroupEnum!, !value);
              //
              //       TyHomeController.to.homeState.combineList
              //           .forEach((element) {
              //         if (element.sectionGroupEnum ==
              //             combineInfo.sectionGroupEnum) {
              //           //头部折叠
              //           FoldMatchManager.setFoldByTid(
              //               element.tid, element.sectionGroupEnum!, !value);
              //         }
              //       });
              //       controller.update();
              //     },
              //     sectionGroupEnum: combineInfo.sectionGroupEnum!,
              //   );
              // }

              // if (combineInfo.type == CombineType.sportHeader) {
              //   return SportHeaderWidget(
              //     title: '${combineInfo.sportTitle}(${combineInfo.sportCount})',
              //   );
              // }

              if (combineInfo.type == CombineType.matchWithHeader) {
                bool isFold = FoldMatchManager.isFoldByTid(
                    combineInfo.tid, combineInfo.sectionGroupEnum!);

                bool isClose = MatchDataBaseWS.closeMatch(
                    mhs: combineInfo.data!.mhs,
                    mmp: combineInfo.data!.mmp,
                    ms: combineInfo.data!.ms);
                if (isClose) {
                  return const SizedBox();
                }

                ///联赛头部展开和收起
                return Container(
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha:0.03999999910593033)
                        : const Color(0xffF8F9FA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r),
                      bottomLeft: combineInfo.isLastMatch || isFold
                          ? Radius.circular(8.r)
                          : Radius.zero,
                      bottomRight: combineInfo.isLastMatch || isFold
                          ? Radius.circular(8.r)
                          : Radius.zero,
                    ),
                    border: context.isDarkMode
                        ? null
                        : Border(
                      top: const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      ),
                      left: const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      ),
                      right: const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      ),
                      bottom: combineInfo.isLastMatch || isFold
                          ? const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      )
                          : BorderSide.none,
                    ),
                  ),
                  margin: EdgeInsets.only(
                      left: 5.w,
                      right: 5.w,
                      bottom: combineInfo.isLastMatch || isFold ? 8.w : 0
                  ),
                  child: Column(
                    children: [
                      ///新手版  联赛标题
                      ResultsDetailFeaturedGroupHeaderWidget(combineInfo: combineInfo),
                      isFold
                          ? const SizedBox()

                      ///数据body
                          : NoobItemBodyWidget(
                        matchEntity: combineInfo.data!,
                        combineType: combineInfo.type,
                        isDetail: true,
                      ), //折叠控制
                      // if (combineInfo.isLastMatch) 8verticalSpaceFromWidth,
                    ],
                  ),
                );
              }

              ///没有头部
              if (combineInfo.type == CombineType.match) {
                bool isFold = FoldMatchManager.isFoldByTid(
                    combineInfo.tid, combineInfo.sectionGroupEnum!);
                if (isFold) return 0.verticalSpaceFromWidth;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  margin: EdgeInsets.only(
                    bottom: combineInfo.isLastMatch ? 8.w : 0,
                    left: 5.w,
                    right: 5.w,
                  ),
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha:0.03999999910593033)
                        : const Color(0xffF8F9FA),
                    borderRadius: BorderRadius.only(
                      bottomLeft: combineInfo.isLastMatch
                          ? Radius.circular(8.r)
                          : Radius.zero,
                      bottomRight: combineInfo.isLastMatch
                          ? Radius.circular(8.r)
                          : Radius.zero,
                    ),
                    border: context.isDarkMode
                        ? null
                        : Border(
                      left: const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      ),
                      right: const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      ),
                      bottom: combineInfo.isLastMatch
                          ? const BorderSide(
                        color: Color(0xffFFFFFF),
                        width: 1,
                      )
                          : BorderSide.none,
                    ),
                  ),
                  child: NoobItemBodyWidget(
                    matchEntity: combineInfo.data!,
                    combineType: combineInfo.type,
                    isDetail: true,
                  ), //折叠控制
                );
              }
              return 0.verticalSpaceFromWidth;
            }
          },
        ),
        Obx(() {
          int index = kFirstIndex.value;
          // AppLogger.debug('index 11 = ${index}');

          if (controller.homeState.showMatchtDiscount &&
              controller.homeState.matchtDiscount.length > 0) {
            if (kFirstIndex.value == 0 || kFirstIndex.value == 1) {
              return Container();
            } else {
              index -= 1;
            }
          }

          CombineInfo? c =
          filterList.safe(index);
          // AppLogger.debug("index = " + index.toString());
          // AppLogger.debug("kFirstIndex.value = " + kFirstIndex.value.toString());

          if (c == null) return Container();
          List<Widget> widgets = [];
          Widget matchStatus = Container(
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? ChangeSkinToneColorUtil.instance()
                    .getDarkBackgroundColor()
                    : null
              // image: Get.isDarkMode
              //     ? DecorationImage(
              //         // image: AssetImage('assets/image/bg3.png'),
              //         image: NetworkImage(
              //           OssUtil.getServerPath(
              //             // 'assets/images/home/match_sticky_top.png',
              //             ChangeSkinToneColorUtil.instance().getModeStatus().bgUri,
              //           ),
              //         ),
              //         fit: BoxFit.cover)
              //     : null,
            ),
            // child: SectionHeaderWidget(
            //   isExpand: !FoldMatchManager.isGroupFold(c.sectionGroupEnum!),
            //   onExpand: (value) {
            //     ///设置组折叠状态
            //     FoldMatchManager.setGroupFold(c.sectionGroupEnum!, !value);
            //
            //     ///子折叠
            //     TyHomeController.to.homeState.combineList.forEach((element) {
            //       if (element.sectionGroupEnum == c.sectionGroupEnum) {
            //         FoldMatchManager.setFoldByTid(
            //             element.tid, element.sectionGroupEnum!, !value);
            //       }
            //     });
            //     controller.update();
            //   },
            //   sectionGroupEnum: c.sectionGroupEnum!,
            // ),
          );
          widgets.add(matchStatus);
          // 未展开 不悬停
          bool isFold =
          FoldMatchManager.isFoldByTid(c.tid, c.sectionGroupEnum!);
          if (!isFold &&
              (c.type == CombineType.matchWithHeader ||
                  c.type == CombineType.match)) {
            Widget matchLeague = Container(
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? ChangeSkinToneColorUtil.instance()
                    .getDarkBackgroundColor()
                    : const Color(0xffF8F9FA),
                border: Get.isDarkMode
                    ? null
                    : const Border(
                  top: BorderSide(
                    color: Color(0xffFFFFFF),
                    width: 1,
                  ),
                  left: BorderSide(
                    color: Color(0xffFFFFFF),
                    width: 1,
                  ),
                  right: BorderSide(
                    color: Color(0xffFFFFFF),
                    width: 1,
                  ),
                ),
              ),
              margin: EdgeInsets.only(
                left: 5.w,
                right: 5.w,
              ),
              child: Column(
                children: [
                  ResultsDetailFeaturedGroupHeaderWidget(combineInfo: c),

                  if (controller.homeState.isProfess)
                    Divider(
                      height: 0.4.w,
                      color: Get.isDarkMode
                          ? Colors.white.withAlpha(10)
                          : const Color(0xffE4E6ED),
                    ),

                  if (controller.homeState.isProfess)

                  ///列表sub标题 全场独赢\让球\大小等
                    BetTitleGroupWidget(
                      hps: c.data!.hps,
                      matchEntity: c.data!,
                      isPinned: true,
                    ).paddingOnly(bottom: 1.h),

                ],
              ),
            );
            widgets.add(matchLeague);
          }
          return widgets.isNotEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [...widgets],
          )
              : Container();
        }),
      ],
    );
  }


}
