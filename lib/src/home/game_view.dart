import 'package:filbet/constants/provider_config.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/services/global/global_service.dart';
import 'home_view_controller.dart';
import 'homegame_model.dart';
import 'package:filbet/widgets/empty_view.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/generated/assets.dart';
import 'dart:ui';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/common/language.dart';

class SliverStickyGameList extends GetView<HomeViewController> {
  SliverStickyGameList({super.key});

  final ScrollController _scrollController = ScrollController(); //滚动
  final Map<int, double> _offsetMap = {}; // 分类起始
  bool isMenuTapScrolling = false; // 防止滚动监听
  List<CategoryModel> categories = []; //分类
  int _lastDetectedIndex = -1; // 记录上次检测到的索引，避免重复更新
  int _lastTapIndex = -1; // 记录上次点击的索引，防止快速重复点击
  double? _lastScrollOffset; // 记录上次滚动位置，用于检测滚动方向

  @override
  Widget build(BuildContext context) {
    Language languagemodel = GlobalService.to.state.language;
    categories = GlobalService.to.state.allCategoryConfig;
    if (categories.isEmpty) return SliverToBoxAdapter(child: EmptyView());
    final hasAnyVenue = categories.any((c) => (c.venues?.isNotEmpty ?? false));
    if (!hasAnyVenue) return SliverToBoxAdapter(child: EmptyView());
    final leftItemCount = categories.length;
    final double rightContentHeight = _calculateRightContentHeight(categories);
    final bottomNavHeight = 56.r + Get.mediaQuery.padding.bottom;
    final topBarHeight = 44.r + Get.mediaQuery.padding.top;
    final bannerHeight = (Get.width - 28.r) / 2.4;
    final noticeHeight = 20.r + 8.r;
    final infoHeight = 70.r + 10.r;
    final viewportHeight = Get.height -
        topBarHeight -
        bannerHeight -
        noticeHeight -
        infoHeight -
        bottomNavHeight;
    // 左侧导航再减 16（底部导航凸起占位）
    final double leftNavHeight = viewportHeight - 16.r;
    // 左侧导航适配屏幕剩余高度：在 40.r~57.r 范围内按可视高度均分
    final double itemHeight =
        (leftNavHeight / leftItemCount).clamp(40.r, 57.r).toDouble();
    final double totalHeight = leftItemCount * itemHeight;
    // 图标、文字随 itemHeight 等比缩放（基准 57.r 时图标 32、字号 12）
    final double navIconSize = itemHeight * 32 / 57;
    final double navFontSize = 12 * itemHeight / 57.r;
    final double layoutHeight =
        totalHeight > viewportHeight ? totalHeight : viewportHeight;
    // 计算右侧每个 section 的 offset（在首次 build 后）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calcOffsetMap(categories);
    });
    // 右侧滚动时更新左侧高亮
    _scrollController.addListener(() {
      _onScroll();
    });

    return SliverToBoxAdapter(
      child: SizedBox(
        height: layoutHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 12.r,
              top: 0,
              child: Container(
                height: leftNavHeight + 12.r,
                width: 50.r,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFEBF0F9),
                      Color(0xFFDBE5F5),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  border: Border.all(color: appnewColors.bg1, width: 1),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(12.r),
                    right: Radius.circular(8.r),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12.r + 48.r,
              right: 29.r,
              top: 0,
              child: Obx(() {
                return Container(
                  height: layoutHeight + 10.r,
                  decoration: BoxDecoration(
                    color: Color(0xFFEFF4FD),
                    border: Border.all(color: appnewColors.bg1, width: 1),
                    borderRadius: BorderRadius.only(
                      topLeft: controller.selIndex != 0
                          ? Radius.circular(12.r)
                          : Radius.zero,
                      topRight: Radius.circular(12.r),
                      bottomLeft: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r),
                    ),
                  ),
                );
              }),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ✅ 左侧导航固定（不滚动）

                Container(
                  width: 50.r,
                  margin: EdgeInsets.only(left: 12.r, right: 7.r),
                  child: Obx(() {
                    final categories = GlobalService.to.state.allCategoryConfig;
                    return Stack(children: [
                      Obx(() {
                        final int idx = controller.selIndex;
                        final double top = idx * itemHeight;
                        return AnimatedPositioned(
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.easeInOutCubic,
                          top: top,
                          left: 0.r,
                          child: Image.asset(
                            Assets.homeLeftNavSel,
                            width: 50.r,
                            height: itemHeight + 10.r,
                            fit: BoxFit.fill,
                          ),
                        );
                      }),
                      Column(
                        children: List.generate(categories.length, (index) {
                          final item = categories[index];
                          final isSelected = controller.selIndex == index;
                          return GestureDetector(
                            onTap: () async {
                              _onMenuTap(index);
                            },
                            child: SizedBox(
                              height: itemHeight,
                              width: 50.r,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isSelected
                                      ? TweenAnimationBuilder<double>(
                                          key: ValueKey('nav-selected-$index'),
                                          tween: Tween(begin: 0, end: 1),
                                          duration:
                                              const Duration(milliseconds: 220),
                                          curve: Curves.easeOutBack,
                                          builder: (context, value, child) {
                                            final clamped =
                                                value.clamp(0.0, 1.0);
                                            return Transform.scale(
                                              scale: value,
                                              child: Opacity(
                                                opacity: clamped,
                                                child: child,
                                              ),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/images/new/home/left_nav_${item.id}_s.webp',
                                            width: navIconSize,
                                            height: navIconSize,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Image.asset(
                                          'assets/images/new/home/left_nav_${item.id}.webp',
                                          width: navIconSize,
                                          height: navIconSize,
                                          fit: BoxFit.cover,
                                        ),
                                  Text(
                                    item.name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: navFontSize,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Color(0xFF303442)
                                          : Color(0xff545A78),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ]);
                  }),
                ),

                /// ✅ 右侧内容可滚动
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 12.r),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: layoutHeight,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 内容少于可视高度时上下居中
                            if (rightContentHeight < layoutHeight)
                              SizedBox(
                                  height:
                                      (layoutHeight - rightContentHeight) / 2),
                            // 实际内容
                            ...List.generate(categories.length, (i) {
                              final venues = categories[i].venues ?? [];
                              if (venues.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Container(
                                key: ValueKey("section_$i"),
                                margin: EdgeInsets.only(top: 4.r),
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: venues.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 4.r,
                                    childAspectRatio: 290 / 120,
                                  ),
                                  itemBuilder: (context, index) {
                                    final VenueModel game = venues[index];
                                    return HomeGameItemView(
                                      categoryModel: categories[i],
                                      count: game.activeGames ?? 0,
                                      image:
                                          "${Api.imageurl}/game/platform/h5h/${languagemodel.code}/${game.id}.webp?t=${DateTime.now().hour}",
                                      name: game.name,
                                      id: game.id ?? '',
                                      isMaintain: game.maintained == 2,
                                      onTap: () {
                                        if (game.maintained == 2) {
                                          //  AppUtils.showToast('场馆维护中');
                                          return;
                                        }
                                        if (game.id == '-1') {
                                          AppUtils.showToast('coming_soon'.tr);
                                          return;
                                        }
                                        AppNavigator.gotoGameList(
                                            game,
                                            CategoryType.fromId(
                                                    categories[i].id ?? 0) ??
                                                CategoryType.video);
                                      },
                                    );
                                  },
                                ),
                              );
                            }),
                            if (rightContentHeight < layoutHeight)
                              SizedBox(
                                  height:
                                      (layoutHeight - rightContentHeight) / 2),
                            SizedBox(height: 10.r),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 计算右侧内容实际需要的高度（与右侧 Column 布局一致）
  double _calculateRightContentHeight(List<CategoryModel> categories) {
    double itemHeight = calcItemHeight(Get.width);
    final double itemSpacing = 4.0.r; // GridView mainAxisSpacing
    final double sectionTopMargin =
        4.0.r; // Container margin: EdgeInsets.only(top: 4.r)

    double totalHeight = 0;
    for (final category in categories) {
      final venues = category.venues ?? [];
      if (venues.isEmpty) {
        totalHeight += sectionTopMargin;
        continue;
      }
      final double itemsTotal = venues.length * itemHeight;
      final double spacingTotal = (venues.length - 1) * itemSpacing;
      final double sectionHeight = itemsTotal + spacingTotal;
      totalHeight += sectionTopMargin + sectionHeight;
    }
    return totalHeight;
  }

  /// 计算每个分类对应的偏移量（与右侧 Column + Container margin.top + GridView 一致）
  void _calcOffsetMap(List<CategoryModel> categories) {
    double offset = 0;
    _offsetMap.clear();
    double itemHeight = calcItemHeight(Get.width);
    final double itemSpacing = 4.0.r; // GridView mainAxisSpacing
    final double sectionTopMargin =
        4.0.r; // Container margin: EdgeInsets.only(top: 4.r)

    for (int i = 0; i < categories.length; i++) {
      _offsetMap[i] = offset;
      final venues = categories[i].venues ?? [];
      if (venues.isEmpty) {
        offset += sectionTopMargin;
        continue;
      }
      final double itemsTotal = venues.length * itemHeight;
      final double spacingTotal = (venues.length - 1) * itemSpacing;
      final double sectionHeight = itemsTotal + spacingTotal;
      offset += sectionTopMargin + sectionHeight;
    }
  }

  double calcItemHeight(double pageWidth) {
    // 与 Row 布局一致：左侧 12.r + 50.r + 7.r，右侧 margin 12.r
    final double leftUsed = 12.r + 50.r + 7.r;
    final double rightWidth = pageWidth - leftUsed - 12.r;
    // GridView childAspectRatio: 290 / 120
    const double childAspectRatio = 290 / 120;
    final double itemHeight = rightWidth / childAspectRatio;
    return itemHeight;
  }

  void _onScroll() {
    if (isMenuTapScrolling) {
      return; // 如果当前是左侧点击触发的滚动，不响应右侧滚动监听
    }
    // 快速响应检测，减少延迟
    // 确保偏移量已计算
    if (_offsetMap.isEmpty || _offsetMap.length < categories.length) {
      _calcOffsetMap(categories);
    }
    final double offset = _scrollController.offset;
    final double viewportHeight = _scrollController.position.viewportDimension;
    final double viewportCenter = offset + viewportHeight / 2;
    int targetIndex = -1;
    // 检测滚动方向
    final double currentOffset = _scrollController.offset;
    bool isScrollingDown = false;

    if (_lastScrollOffset != null) {
      isScrollingDown = currentOffset > _lastScrollOffset!;
    }
    _lastScrollOffset = currentOffset;
    // 根据滚动方向使用不同的切换逻辑
    for (int i = categories.length - 1; i >= 0; i--) {
      if (!_offsetMap.containsKey(i)) {
        continue;
      }
      final double sectionStart = _offsetMap[i]!;
      final double sectionEnd = i == categories.length - 1
          ? _scrollController.position.maxScrollExtent
          : (_offsetMap[i + 1] ?? sectionStart);
      if (isScrollingDown) {
        // 向下滚动：分类完全到达头部时才切换
        // 使用滚动偏移量检测，当偏移量 >= 分类起始位置时切换
        if (currentOffset >= sectionStart) {
          targetIndex = i;
          break;
        }
      } else {
        // 向上滚动：分类刚开始显示时就切换
        // 使用视口中心位置检测，提前切换
        double switchPoint = sectionStart - 100; // 提前100px切换

        if (viewportCenter >= switchPoint) {
          targetIndex = i;
          break;
        }
      }
    }

    // 如果没找到，选择第一个分类
    if (targetIndex == -1) {
      targetIndex = 0;
    }

    // 只有当检测到不同的分类时才更新
    if (targetIndex != -1 && targetIndex != _lastDetectedIndex) {
      _lastDetectedIndex = targetIndex;
      controller.selIndex = targetIndex;
    }
  }

  void _onMenuTap(int index) async {
    if (index < 0 || index >= categories.length) return;

    // 防止快速重复点击同一个分类
    if (index == _lastTapIndex && isMenuTapScrolling) return;

    // 如果正在滚动，重置状态
    if (isMenuTapScrolling) {
      isMenuTapScrolling = false;
    }

    // 立即设置状态，让指示器开始动画
    controller.selIndex = index;
    _lastDetectedIndex = index; // 更新检测索引，防止重复检测
    _lastTapIndex = index; // 记录当前点击的索引
    isMenuTapScrolling = true;

    final double targetOffset = _offsetMap[index] ?? 0;

    // 如果目标位置很近，直接跳转，避免动画冲突
    final double currentOffset = _scrollController.offset;
    final double distance = (targetOffset - currentOffset).abs();

    if (distance < 100) {
      // 距离很近，直接跳转
      _scrollController.jumpTo(targetOffset);
      Future.delayed(const Duration(milliseconds: 100), () {
        isMenuTapScrolling = false;
      });
    } else {
      // 距离较远，使用动画，与指示器动画时长保持一致
      await _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 150), // 与指示器动画时长一致
        curve: Curves.easeOutCubic,
      );

      // 动画结束后恢复监听
      Future.delayed(const Duration(milliseconds: 100), () {
        isMenuTapScrolling = false;
      });
    }
  }
}

class HomeGameItemView extends StatelessWidget {
  final VoidCallback? onTap;
  final String image;
  final String? name;

  final bool isMaintain;
  final String id;
  final num count;
  final CategoryModel categoryModel;

  const HomeGameItemView({
    super.key,
    this.onTap,
    this.name,
    required this.id,
    required this.count,
    required this.image,
    required this.isMaintain,
    required this.categoryModel,
  });

  @override
  Widget build(BuildContext context) {
    String? providerName;
    var list = GlobalService.to.state.allPlatformNameConfig
        .where((item) => item.id == id);
    if (list.isNotEmpty) {
      providerName = list.first.name;
    }
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          // ✅ 主体容器：不规则圆角 + 边框 + 阴影 + 模糊 + 渐变
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              topLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(30.r),
              bottomLeft: Radius.circular(8.r),
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // ✅ 网络图片 (可空)
                  if (image.isNotEmpty)
                    SKNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.fill,
                      expand: true,
                      placeholderType: 2,
                    ),
                  // Positioned(
                  //   top: 15.r,
                  //   child: Container(
                  //     height: 20.r,
                  //     alignment: Alignment.centerLeft,
                  //     padding: EdgeInsets.only(left: 10.r, right: 10.r),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.horizontal(
                  //         right: Radius.circular(10.r),
                  //       ),
                  //       gradient: LinearGradient(
                  //         colors: [
                  //           Color(0xFFBED9FF),
                  //           Color(0xFF79AFFF),
                  //           Color(0xFF79AFFF),
                  //           Color(0xFF98C4FF),
                  //         ],
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //       ),
                  //     ),
                  //     child: Text(
                  //       'unlimited_cashback'.tr,
                  //       style: TextStyle(
                  //         color: appnewColors.text4,
                  //         fontSize: 8.sp,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    left: 41.w + 4.w,
                    top: 40.w,
                    child: Text(
                      providerName ?? name ?? '',
                      style: TextStyle(
                        color: appnewColors.text3,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (count != 0)
                    Positioned(
                      left: 41.w + 4.w,
                      bottom: 22.w,
                      child: Row(
                        children: [
                          Text(
                            '$count',
                            style: TextStyle(
                              color: appnewColors.textGray,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 2.r),
                          Text(
                            categoryModel.id == 1
                                ? PlatformUnit.table.value
                                : categoryModel.id == 4
                                    ? PlatformUnit.field.value
                                    : PlatformUnit.kind.value,
                            style: TextStyle(
                              color: appnewColors.text3,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          if (isMaintain)
            Positioned.fill(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.homeBgMaintain),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text(
                  '维护中...',
                  style: TextStyle(
                    color: appnewColors.textWhite,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class GameTopRightIcon extends StatelessWidget {
  final String gameLogo;

  const GameTopRightIcon({super.key, required this.gameLogo});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5.r),
          bottomLeft: Radius.circular(5.r),
        ),
        color: const Color.fromRGBO(255, 255, 255, .3),
      ),
      child: SKNetworkImage(
        imageUrl: gameLogo,
        height: 18.r,
        fit: BoxFit.fitHeight,
        expand: false,
        customPlaceholder: const SizedBox.shrink(),
        radius: BorderRadius.only(topRight: Radius.circular(5.r)),
      ),
    );
  }
}
