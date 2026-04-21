import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/bet_title_group_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/header/seaction_header_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../main.dart';
import '../../../config/app_logger/app_logger.dart';
import '../../../utils/change_skin_tone_color_util.dart';
import '../../../widgets/scroll_index_widget.dart';
import '../../main_tab/main_tab_controller.dart';
import '../controllers/match_expand_controller.dart';
import '../logic/home_controller_logic.dart';
import '../states/home_state.dart';
import '../widgets/item/profession/match_group_header_widget.dart';
import 'common_match_list_item_builder.dart';
import '../widgets/home_back_top_button.dart';

var kFirstIndex = HomeState.commonListFirstIndex.obs;
var kLastIndex = HomeState.commonListLastIndex;

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
class CommonMatchListView extends StatelessWidget {
  const CommonMatchListView({super.key});

  _body(TyHomeController controller) {
    var listviewLength = controller.homeState.combineList.length;

    if (controller.homeState.showMatchtDiscount &&
        controller.homeState.matchtDiscount.length > 0) {
      listviewLength += 1;
    }
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          controller: controller.commonScrollController,
          physics: const ClampingScrollPhysics(),
          itemCount: listviewLength,
          // 使用正常的滚动行为
          itemBuilder: (BuildContext context, int index) {
            return CommonMatchListItemBuilder(
              controller: controller,
              index: index,
            );
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
              TyHomeController.to.homeState.combineList.safe(index);

          if (c == null) return Container();
          List<Widget> widgets = [];

          if (c.sectionGroupEnum != SectionGroupEnum.Pin) {
            CombineInfo? cPin =
                TyHomeController.to.homeState.combineList.safe(0);
            if (cPin != null && cPin.sectionGroupEnum == SectionGroupEnum.Pin) {
              Widget pinStatus = Container(
                decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? ChangeSkinToneColorUtil.instance()
                            .getDarkBackgroundColor()
                        : Colors.transparent),
                child: SectionHeaderWidget(
                  isExpand:
                      !FoldMatchManager.isGroupFold(cPin.sectionGroupEnum!),
                  onExpand: (value) {
                    ///设置组折叠状态
                    FoldMatchManager.setGroupFold(
                        cPin.sectionGroupEnum ?? SectionGroupEnum.ALL, !value);

                    ///子折叠
                    TyHomeController.to.homeState.combineList
                        .forEach((element) {
                      if (element.sectionGroupEnum == cPin.sectionGroupEnum) {
                        FoldMatchManager.setFoldByTid(
                            element.tid, element.sectionGroupEnum!, !value);
                      }
                    });
                    controller.update();
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      ///滑动至顶部
                      TyHomeController.to.commonScrollController.animateTo(
                        0,
                        duration: HomeState.commonScrollToTopDuration,
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                  sectionGroupEnum: cPin.sectionGroupEnum!,
                ),
              );
              widgets.add(pinStatus);
            }
          }

          Widget matchStatus = Container(
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? ChangeSkinToneColorUtil.instance()
                        .getDarkBackgroundColor()
                    : null),
            child: SectionHeaderWidget(
              isExpand: !FoldMatchManager.isGroupFold(c.sectionGroupEnum!),
              onExpand: (value) {
                ///设置组折叠状态
                FoldMatchManager.setGroupFold(c.sectionGroupEnum!, !value);

                ///子折叠
                TyHomeController.to.homeState.combineList.forEach((element) {
                  if (element.sectionGroupEnum == c.sectionGroupEnum) {
                    FoldMatchManager.setFoldByTid(
                        element.tid, element.sectionGroupEnum!, !value);
                  }
                });
                controller.update();
              },
              sectionGroupEnum: c.sectionGroupEnum!,
            ),
          );
          widgets.add(matchStatus);
          // 未展开 不悬停
          bool isFold =
              FoldMatchManager.isFoldByTid(c.tid, c.sectionGroupEnum!);
          if (!isFold &&
              (c.type == CombineType.matchWithHeader ||
                  c.type == CombineType.match)) {
            CombineInfo headerInfo = c;
            // 如果当前是普通比赛item，向前查找它的 Header item
            if (c.type == CombineType.match) {
              final list = TyHomeController.to.homeState.combineList;
              // 从当前索引向前遍历
              for (var i = index; i >= 0; i--) {
                final item = list.safe(i);
                // 找到同联赛 (tid相同) 且带 Header 的 item
                if (item?.tid == c.tid &&
                    item?.type == CombineType.matchWithHeader) {
                  headerInfo = item!;
                  break;
                }
                // 如果 tid 变了，说明跨联赛了（安全跳出）
                if (item?.tid != c.tid) break;
              }
            }

            Widget matchLeague = _MatchLeagueItem(
              headerInfo: headerInfo,
              c: c,
              controller: controller,
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

  @override
  Widget build(BuildContext context) {
    // final tag = Get.isRegistered<MainTabController>()
    //     ? Get.find<MainTabController>().uuid
    //     : '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return Container(
      color: context.isDarkMode ? null : HomeState.commonBackgroundColor,
      child: Stack(children: [
        ///滚动监听控件
        GetBuilder<TyHomeController>(
            tag: MainTabController.to.uuid,
            builder: (controller) {
              return ScrollIndexWidget(
                isStopCallback: false,
                scrollDirection: Axis.vertical,
                endCallBack: (bool endScroll) {
                  if (!Get.isRegistered<MainTabController>()) return;
                  TyHomeController.to.homeState.endScroll = endScroll;

                  if(endScroll) {
                    //滚动停下来的时候，取一下可视区的数据。
                    // 如果已经有数据的话（midList为空），则不取
                    List<String> midList = [];
                    midList = TyHomeControllerLogic.getNextMatchIds(
                      TyHomeController.to.homeState.combineList,
                      controller.homeState.visiableFirstIndex,
                      controller.homeState.visiableLastIndex,
                    );
                    midList.removeWhere((e) =>
                        TyHomeController.to.homeState.showMatchIdSet.contains(
                            e));
                    TyHomeControllerLogic.preLoadNextMatchBaseInfoList(midList);
                  }
                },
                callBack: (int firstIndex, int lastIndex) {
                  if (!Get.isRegistered<MainTabController>()) return;

                  // kFirstIndex.value = firstIndex;
                  kLastIndex = lastIndex;
                  List<String> midList = [];
                  midList = TyHomeControllerLogic.getNextMatchIds(
                    TyHomeController.to.homeState.combineList,
                    firstIndex,
                    lastIndex,
                  );
                  TyHomeControllerLogic.preLoadNextMatchBaseInfoList(midList);
                },
                stickyCallBack: (int firstIndex, int lastIndex) {
                  // 列表翻转
                  kFirstIndex.value = firstIndex;
                  controller.homeState.visiableFirstIndex = firstIndex;
                  controller.homeState.visiableLastIndex = lastIndex;
                },
                child: _body(controller),
              );
            }),
        GetBuilder<TyHomeController>(
            id: "showTop",
            tag: MainTabController.to.uuid,
            builder: (controller) {
              return Visibility(
                  visible: controller.showTop,
                  child: HomeBackTopButton(
                    bottom: bottomHideSwitch
                        ? HomeState.bottomHideSwitchThreshold.h
                        : HomeState.bottomShowSwitchThreshold.h,
                    onTap: () {
                      ///滑动至指定位置
                      TyHomeController.to.commonScrollController.animateTo(
                        0,
                        duration: HomeState.commonScrollToTopDuration,
                        curve: Curves.easeInOut,
                      );
                    },
                  ));
            })
      ]),
    );
  }
}

class _MatchLeagueItem extends StatelessWidget {
  final CombineInfo headerInfo;
  final CombineInfo c;
  final TyHomeController controller;

  const _MatchLeagueItem({
    required this.headerInfo,
    required this.c,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
            : HomeState.listItemBackgroundColor,
        border: Get.isDarkMode
            ? null
            : const Border(
                top: BorderSide(
                  color: HomeState.listItemBorderColor,
                  width: 1,
                ),
                left: BorderSide(
                  color: HomeState.listItemBorderColor,
                  width: 1,
                ),
                right: BorderSide(
                  color: HomeState.listItemBorderColor,
                  width: 1,
                ),
              ),
      ),
      margin: EdgeInsets.only(
        left: HomeState.listItemHorizontalPadding.w,
        right: HomeState.listItemHorizontalPadding.w,
      ),
      child: Column(
        children: [
          if (headerInfo.data != null)
            MatchGroupHeaderWidget(combineInfo: headerInfo),
          if (controller.homeState.isProfess)
            Divider(
              height: HomeState.listItemDividerHeight.w,
              color: Get.isDarkMode
                  ? HomeState.dividerColorDark
                  : HomeState.dividerColorLight,
            ),

          /// 增加多层空值检查
          if (controller.homeState.isProfess && c.data != null)

            ///列表sub标题 全场独赢\让球\大小等
            BetTitleGroupWidget(
              hps: c.data?.hps ?? [],
              matchEntity: c.data!,
              isPinned: true,
            ).paddingOnly(bottom: HomeState.listItemBottomMargin.h),
        ],
      ),
    );
  }
}
