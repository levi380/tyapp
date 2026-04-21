import 'dart:math';

import 'package:collection/collection.dart';

import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/penalty_shootout/penalty_Item.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../utils/bus/event_bus.dart';

import '../../../../login/login_head_import.dart';

enum ScrollDirection {
  up, // 显示上一页
  down, // 显示下一页
}

class PenaltyPageChanged {
  final int page;

  PenaltyPageChanged(this.page);
}

class PenaltyShootoutWidget extends StatefulWidget {
  final MatchEntity match;
  final String teamStr;
  final bool isHomeTeam;

  const PenaltyShootoutWidget({
    Key? key,
    required this.match,
    required this.teamStr,
    required this.isHomeTeam,
  }) : super(key: key);

  @override
  _PenaltyShootoutWidgetState createState() => _PenaltyShootoutWidgetState();
}

class _PenaltyShootoutWidgetState extends State<PenaltyShootoutWidget> {
  final PageController pageController = PageController();
  int _totalRounds = 0;
  final int _maxTotalRounds = 24;
  ScrollDirection _lastDirection = ScrollDirection.up;

  StreamSubscription? _sub;
  bool _selfChangingPage = false;

  int? _lastPage;

  @override
  void initState() {
    super.initState();
    _calculateTotalRounds();

    // 延迟初始化滚动位置到最新两行
    // 必须在第一帧结束后执行
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 总页数（每页最多 10 个点球：两行 * 5）
      final int pageCount = (_totalRounds / 10).ceil();

      pageController.jumpToPage(pageCount - 1); // 最后一页
    });

    // 监听同步事件
    _sub = EventBus().on<PenaltyPageChanged>().listen((event) {
      // 自己触发的事件不处理，否则会无限循环
      if (_selfChangingPage) return;

      pageController.jumpToPage(event.page);
      setState(() {});
    });

    pageController.addListener(() {
      final double? p = pageController.page;

      // 避免抖动，确保是整数页
      if (p != null && p % 1 == 0) {
        final page = p.toInt();
        if (_lastPage != page) {
          _lastPage = page;

          _selfChangingPage = true;
          EventBus().fire(PenaltyPageChanged(page));
          Future.delayed(Duration(milliseconds: 50), () {
            _selfChangingPage = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sub?.cancel();
    pageController.dispose();
  }

  @override
  void didUpdateWidget(covariant PenaltyShootoutWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final eq = const DeepCollectionEquality();
    if (!eq.equals(oldWidget.match.mscMap, widget.match.mscMap)) {
      _calculateTotalRounds();
      // 延迟初始化滚动位置到最新两行
      // 必须在第一帧结束后执行
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 总页数（每页最多 10 个点球：两行 * 5）
        final int pageCount = (_totalRounds / 10).ceil();
        pageController.jumpToPage(pageCount - 1); // 最后一页
      });
    }
  }

  void _calculateTotalRounds() {
    // 计算总轮数
    int rounds = 0;

    for (int i = 1; i <= _maxTotalRounds; i++) {
      String key;

      // 特殊处理第11轮和第12轮
      if (i == 11) {
        key = 'S17101'; // 第11轮的特殊key
      } else if (i == 12) {
        key = 'S17102'; // 第12轮的特殊key
      } else {
        // 其他轮次使用标准格式
        final index = i.toString().padLeft(2, '0');
        key = 'S17$index';
      }

      if (widget.match.mscMap.containsKey(key)) {
        rounds = i;
      }
    }

    setState(() {
      _totalRounds = rounds;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_totalRounds == 0) {
      return Container(
        width: 66.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (_) => Container(width: 12.w)),
        ),
      );
    }

    // 总页数（每页最多 10 个点球：两行 * 5）
    final int pageCount = (_totalRounds / 10).ceil();

    return Container(
      margin: EdgeInsets.only(top: 2.h),
      width: 100.w,
      height: 35.w, // 显示两行高度保持不变
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: pageCount,
            controller: pageController,
            itemBuilder: (context, pageIndex) {
              return _buildPage(pageIndex);
            },
          ),
          Positioned(
            left: widget.isHomeTeam ? -4.w : null,
            right: widget.isHomeTeam ? null : -4.w,
            child: _buildPageButtons(pageCount),
          ),
        ],
      ),
    );
  }

  /// 构建每一页：包含两行（每行 5 个点）
  Widget _buildPage(int pageIndex) {
    final start = pageIndex * 10 + 1;
    final end = min(start + 9, _totalRounds);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildPenaltyRowRange(start, min(start + 4, end)),
        4.verticalSpace,
        if (start + 5 <= end)
          _buildPenaltyRowRange(start + 5, min(start + 9, end))
        else
          Container(height: 10.w),
      ],
    );
  }

  /// 构建一个范围行（比如第 1–5，第 6–10）
  Widget _buildPenaltyRowRange(int startIndex, int endIndex) {
    // final count = endIndex - startIndex + 1;

    return Container(
      width: 80.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (i) {
          final idx = startIndex + i;
          if (idx <= endIndex) {
            return PenaltyItem(
              match: widget.match,
              teamStr: widget.teamStr,
              isHomeTeam: widget.isHomeTeam,
              index: idx,
            );
          } else {
            return Container(width: 14.w, height: 14.w);
          }
        }),
      ),
    );
  }

  /// 左右的上下按钮
  Widget _buildPageButtons(int pageCount) {
    if (pageCount <= 1) return SizedBox.shrink();

    return StatefulBuilder(
      builder: (context, setLocalState) {
        final double currentPage = pageController.page ?? 0;
        final int page = currentPage.round();

        // 监听滑动方向
        pageController.addListener(() {
          final double p = pageController.page ?? 0;
          final double old = currentPage;

          if (p > old) {
            // page 变大 → 往下滑（下一页）
            if (_lastDirection != ScrollDirection.down) {
              _lastDirection = ScrollDirection.down;
              setLocalState(() {});
            }
          } else if (p < old) {
            // page 变小 → 往上滑（上一页）
            if (_lastDirection != ScrollDirection.up) {
              _lastDirection = ScrollDirection.up;
              setLocalState(() {});
            }
          }
        });

        bool showUp = false;
        bool showDown = false;

        if (page == 0) {
          // 第一页永远显示下一页
          showDown = true;
        } else if (page == pageCount - 1) {
          // 最后一页永远显示上一页
          showUp = true;
        } else {
          // 中间页根据上一次滑动方向显示
          if (_lastDirection == ScrollDirection.up) {
            showUp = true;
          } else {
            showDown = true;
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showUp)
              InkWell(
                onTap: () {
                  final page = pageController.page?.round() ?? 0;
                  if (page > 0) {
                    _lastDirection = ScrollDirection.up;
                    pageController
                        .animateToPage(
                      page - 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    )
                        .then((_) {
                      _selfChangingPage = false;
                    });

                    setLocalState(() {});
                    EventBus().fire(PenaltyPageChanged(page - 1));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                  child: ImageView(
                    "assets/images/detail/shootout-arrow.svg",
                    width: 8.w,
                  ),
                ),
              ),
            if (showUp) 10.verticalSpace,
            if (showDown)
              InkWell(
                onTap: () {
                  final page = pageController.page?.round() ?? 0;
                  if (page < pageCount - 1) {
                    _lastDirection = ScrollDirection.down;
                    pageController
                        .animateToPage(
                      page + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    )
                        .then((_) {
                      _selfChangingPage = false;
                    });
                    setLocalState(() {});
                    EventBus().fire(PenaltyPageChanged(page + 1));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(1.0, -1.0, 1.0),
                    child: ImageView(
                      "assets/images/detail/shootout-arrow.svg",
                      width: 8.w,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
