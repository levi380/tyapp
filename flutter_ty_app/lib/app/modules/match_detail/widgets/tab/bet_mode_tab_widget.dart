import 'dart:math';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_api_service.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_tab_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../main.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/models/res/category_list_entity.dart';
import '../../../../utils/change_skin_tone_color_util.dart';
import '../../../../widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import '../../models/request_status.dart';
import 'second_tab_item.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 比分+队伍+赛事阶段】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛事阶段乒乓球】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 更多投注切换页面
    】】】
 *
 */
class BetModeTab extends StatefulWidget {
  const BetModeTab(
      {super.key,
      required this.tag,
      this.fullscreen = false,
      this.refresh = false});

  final String tag;
  final bool fullscreen;
  final bool refresh;

  @override
  State<BetModeTab> createState() => _BetModeTabState();
}

class _BetModeTabState extends State<BetModeTab> {
  final ScrollController _controller = ScrollController();
  final GlobalKey _listKey = GlobalKey();

  /// 为 ListView 的每个 item 保留一个 GlobalKey（对应 categoryList 的第 2..n 项）
  final List<GlobalKey> _itemKeys = [];

  /// 控制重试次数（布局可能还没完成，需要多次尝试）
  int _scrollAttempt = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 确保 _itemKeys 的数量等于 list 中可滚动项的数量（categoryList.length - 1）
  void _ensureItemKeys(int count) {
    if (_itemKeys.length < count) {
      for (int i = _itemKeys.length; i < count; i++) {
        _itemKeys.add(GlobalKey());
      }
    } else if (_itemKeys.length > count) {
      _itemKeys.removeRange(count, _itemKeys.length);
    }
  }

  // 根据 fullIndex（在完整 categoryList 中的索引）滚动到居中
  void _scrollToIndexWithKeys(int fullIndex,
      List<CategoryListData> categoryList, MatchDetailController controller) {
    if (!mounted || controller.detailState.playId.isEmpty) return;

    10.milliseconds.delay(() {
      if (!mounted) return;

      if (fullIndex < 0 || fullIndex >= categoryList.length) return;

      // fullIndex == 0 表示第一个 item（固定项），直接滚到起点
      if (fullIndex == 0) {
        if (_controller.hasClients) {
          _controller.animateTo(
            0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.ease,
          );
        }
        return;
      }

      final listIndex = fullIndex - 1; // 映射到 ListView.builder 的 index
      if (listIndex < 0 || listIndex >= _itemKeys.length) return;

      final itemKey = _itemKeys[listIndex];
      final itemContext = itemKey.currentContext;
      final listContext = _listKey.currentContext;

      // 如果任意 context 还没准备好，重试（最多 3 次）
      if (itemContext == null ||
          listContext == null ||
          !_controller.hasClients) {
        if (_scrollAttempt < 5) {
          AppLogger.debug("----重试");
          _scrollAttempt++;
          _controller.animateTo(
            600,
            duration: const Duration(milliseconds: 250),
            curve: Curves.linear,
          );
          // 再试一次（下一帧）
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToIndexWithKeys(fullIndex, categoryList, controller);
          });
        }
        return;
      }
      AppLogger.debug("开始滚动");
      final RenderBox itemBox = itemContext.findRenderObject() as RenderBox;
      final Offset itemPos = itemBox.localToGlobal(Offset.zero);
      final double itemCenter = itemPos.dx + itemBox.size.width / 2;

      final RenderBox listBox = listContext.findRenderObject() as RenderBox;
      final Offset listPos = listBox.localToGlobal(Offset.zero);
      final double listCenter = listPos.dx + listBox.size.width / 2;

      // 目标 offset = 当前 offset + (itemCenter - listCenter)
      double targetOffset = _controller.offset + (itemCenter - listCenter);

      final double min = _controller.position.minScrollExtent;
      final double max = _controller.position.maxScrollExtent;
      if (targetOffset < min) targetOffset = min;
      if (targetOffset > max) targetOffset = max;

      _controller.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
      );
      controller.detailState.playId = "";
      controller.detailState.cid = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
      tag: widget.tag,
      id: matchBetModeTabGetBuildId,
      initState: (_) {
        /// 初始化玩法集
        if (widget.refresh) {
          Get.find<MatchDetailController>(tag: widget.tag).fetchCategoryList();
        }
      },
      builder: (controller) {
        final detailState = controller.detailState;
        // 投注列表数据有则显示
        if (detailState.oddsInfoIsNoData ||
            detailState.oddsInfoRequestStatus == RequestStatus.loading) {
          return Container();
        }
        List<CategoryListData> categoryList = detailState.categoryList;
        // marketName为空不显示该tab
        categoryList = List.from(categoryList)
          ..removeWhere((e) => e.marketName.isEmpty);

        // 确保 key 数量（可滚动部分为 categoryList.length - 1）
        final int scrollableCount =
            (categoryList.length > 0) ? (categoryList.length - 1) : 0;
        _ensureItemKeys(scrollableCount);
        // 页面加载完成后尝试滚动到当前选中项（重置尝试计数并调用）
        _scrollAttempt = 0;
        // 计算curCategoryTabId值
        controller.calCurCategoryTabId();

        final currentId = detailState.curCategoryTabId;
        final fullIndex = categoryList.indexWhere((e) => e.id == currentId);
        _scrollToIndexWithKeys(fullIndex, categoryList, controller);

        return ClipRect(
            child: Stack(
          children: [
            Container(
              height: widget.fullscreen
                  ? 43
                  : isIPad
                      ? 60.h
                      : 44.h,
              decoration: BoxDecoration(
                  color: widget.fullscreen
                      ? Colors.transparent
                      : Get.theme.secondTabPanelBackgroundColor,
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Get.isDarkMode
                          ? ChangeSkinToneColorUtil.instance()
                              .getDarkBackgroundColor()
                          : Colors.black.withValues(alpha: 0.06),
                    ),
                  )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 第一个玩法集不随滚动
                  Padding(
                    padding: widget.fullscreen
                        ? const EdgeInsets.symmetric(vertical: 8)
                        : EdgeInsets.only(
                            left: 10.w,
                            top: 7.h,
                            bottom: 7.h,
                          ),
                    child: SecondTabItem(
                      fullscreen: widget.fullscreen,
                      categoryList[0].marketName,
                      active:
                          detailState.curCategoryTabId == categoryList[0].id,
                      onTap: () {
                        controller.changeCategoryTab(categoryList[0].id);
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          _controller.animateTo(
                            0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.linear,
                          );
                        });
                      },
                    ),
                  ),

                  categoryList.length > 1
                      ? Expanded(
                          child: ListView.builder(
                            key: _listKey,
                            controller: _controller,
                            padding: widget.fullscreen
                                ? const EdgeInsets.symmetric(vertical: 8)
                                : EdgeInsets.symmetric(vertical: 7.w),
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryList.length - 1,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder:
                                (BuildContext buildContext, int index) {
                              // 从第二项开始
                              int tempIndex = index + 1;

                              // 把 GlobalKey 传给每个 item（用于测量位置）
                              final itemKey = _itemKeys[index];
                              return SecondTabItem(
                                key: itemKey,
                                categoryList[tempIndex].marketName,
                                //hasChampionIcon: categoryList[tempIndex].isChampion,
                                hasChampionIcon: false,
                                //冠军图标不再显示
                                fullscreen: widget.fullscreen,
                                onTap: () {
                                  controller.changeCategoryTab(
                                      categoryList[tempIndex].id);
                                },
                                active: detailState.curCategoryTabId ==
                                    categoryList[tempIndex].id,
                                centerBack: (Point<num> center) {
                                  selectTab(categoryList[tempIndex].id,
                                      center: center, listKey: _listKey);
                                },
                              ).marginOnly(left: 2.w);
                            },
                          ),
                        )
                      : Expanded(child: Container()),
                  // 虚拟体育、赛果没有全部折叠
                  if (![Routes.vrSportDetail, Routes.matchResultsDetails]
                      .contains(Get.currentRoute))
                    // 全部折叠、展开按钮（保持不变）
                    InkWell(
                      onTap: controller.changeBtn,
                      child: Obx(() {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: widget.fullscreen ? 10 : 10.w,
                              vertical: widget.fullscreen ? 8 : 7.w),
                          child: Container(
                            width:
                                widget.fullscreen ? 20 : (isIPad ? 50.w : 20.w),
                            height:
                                widget.fullscreen ? 16 : (isIPad ? 30.h : 16.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: widget.fullscreen ? 2 : 2.w),
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: widget.fullscreen
                                  ? Colors.white.withValues(alpha: 0.04)
                                  : Get.theme.foldColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    widget.fullscreen ? 20 : 20.r),
                              ),
                            ),
                            child: AnimatedRotation(
                              duration: const Duration(milliseconds: 200),
                              turns:
                                  detailState.getFewer.value != 2 ? 0 : -0.25,
                              child: ImageView(
                                  widget.fullscreen
                                      ? 'assets/images/detail/expand-arrow-night.svg'
                                      : Get.isDarkMode
                                          ? 'assets/images/detail/expand-arrow-night.svg'
                                          : 'assets/images/detail/expand-arrow.svg',
                                  width: widget.fullscreen
                                      ? 16
                                      : (isIPad ? 30.w : 16.w)),
                            ),
                          ),
                        );
                      }),
                    )
                  else
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: widget.fullscreen ? 10 : 10.w,
                          vertical: widget.fullscreen ? 8 : 7.w),
                    )
                ],
              ),
            ),
            // 阴影
            if (Get.currentRoute == Routes.matchDetail)
              Positioned(
                top: 0,
                child: _buildShadow(),
              ),
          ],
        ));
      },
    );
  }

  Widget _buildShadow() {
    return Container(
      height: 1,
      width: 1.sw,
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          // 底部阴影
          BoxShadow(
            color: Get.theme.tabPanelBoxShadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
    );
  }

  /// 切換Tab + 可選的居中滾動
  void selectTab(String id, {Point<num>? center, GlobalKey? listKey}) {
    // 获取ListView在屏幕上的位置和大小
    RenderBox listViewBox =
        _listKey.currentContext?.findRenderObject() as RenderBox;
    final listViewPosition = listViewBox.localToGlobal(Offset.zero);
    final listViewSize = listViewBox.size;
    // 计算ListView的中心点坐标
    final centerX = listViewPosition.dx + listViewSize.width / 2;
    var offset = _controller.offset;
    // 偏移量计算
    offset += ((center?.x ?? 0) - centerX);
    if (offset < 0) {
      offset = 0;
    } else if (offset > _controller.position.maxScrollExtent) {
      offset = _controller.position.maxScrollExtent;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
      );
    });
  }
}
