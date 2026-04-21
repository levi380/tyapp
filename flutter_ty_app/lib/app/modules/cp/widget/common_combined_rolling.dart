import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../main.dart';

typedef CCRollingLeftTabBuilder = Widget? Function(
  int tabIndex,
  bool isSelected,
);

typedef CCRollingLeftTopWidgetBuilder = Widget? Function();

typedef CCRollingRightItemBuilder = Widget? Function(
  int tabIndex,
  int itemIndex,
);

typedef CCRollingRightSectionHeaderBuilder = Widget? Function(
  int tabIndex,
);

typedef CCRollingRightDatasGetter = List? Function(int tabIndex);

class CommonCombinedRolling extends StatefulWidget {
  const CommonCombinedRolling({
    super.key,
    required this.tabs,
    this.leftDecoration,
    this.leftTopWidgetBuilder,
    this.leftTabBuilder,
    this.rightItemBuilder,
    this.rightSectionHeaderBuilder,
    this.rightDatasGetter,
    this.space,
    this.padding,
    this.leftFlex,
    this.rightFlex,
    this.rightGridViewVPadding = CpState.rollingGridViewVPadding,
    this.initialSelTabIndex = 0,
    this.rightGridMainAxisSpacing = CpState.rollingMainAxisSpacing,
    this.rightGridCrossAxisSpacing = CpState.rollingCrossAxisSpacing,
  });

  final CCRollingLeftTopWidgetBuilder? leftTopWidgetBuilder;
  final CCRollingLeftTabBuilder? leftTabBuilder;
  final Decoration? leftDecoration;
  final CCRollingRightItemBuilder? rightItemBuilder;
  final CCRollingRightSectionHeaderBuilder? rightSectionHeaderBuilder;
  final CCRollingRightDatasGetter? rightDatasGetter;

  /// 左右列表间距
  final double? space;

  /// 整体左右间距
  final double? padding;

  /// 左边列表 flex
  final int? leftFlex;

  /// 右边列表 flex
  final int? rightFlex;

  final List tabs;

  final double rightGridViewVPadding;

  final int initialSelTabIndex;

  final double rightGridMainAxisSpacing;

  final double rightGridCrossAxisSpacing;

  @override
  State<CommonCombinedRolling> createState() => _CommonCombinedRollingState();
}

class _CommonCombinedRollingState extends State<CommonCombinedRolling> {
  late final ScrollController _leftScrollController;
  late final ScrollController _rightScrollController;

  // 右侧 grid item 配置参数
  final _crossAxisCount = isIPad ? 3 : 2;
  double _mainAxisSpacing = CpState.rollingMainAxisSpacing;
  double _crossAxisSpacing = CpState.rollingCrossAxisSpacing;
  final _childAspectRatio = CpState.rollingChildAspectRatio;
  double _gridViewVPadding = CpState.rollingGridViewVPadding;
  double _gridItemHeight = 0.0;

  // 这个数组是用来统计右边每个分类的偏移量
  final List<double> _rightStepOffsets = [];

  // 最后一个分类对应的右边需要补齐的高度
  double _lastGridDiffHeight = 0.0;

  // 整个布局空间的高度
  double _spaceHeight = 0.0;

  int _indexLeft = 0;

  List get _tabs => widget.tabs;

  int get _leftWidgetFlex => widget.leftFlex ?? CpState.rollingLeftFlexDefault; // 左边组件占据空间的比例
  // 10 * 3：左右以及联动列表之间的间距
  int get _rightWidgetFlex =>
      widget.rightFlex ??
      375 - (widget.space?.toInt() ?? 0) * 3 - _leftWidgetFlex; // 右边组件占据空间的比例

  void _leftScrollListener() {}

  void _rightScrollListener() {
    if (_rightStepOffsets.isEmpty) return;
    // 滚动超过右侧 Listview 的项目长度时，将左侧选中最后一项，这一个判断不添加的话，左侧 ListView 选择不到最后一项
    if (_rightStepOffsets.last <= _rightScrollController.offset) {
      if (mounted) {
        setState(() {
          _indexLeft = _rightStepOffsets.length - 1;
        });
      }
    } else {
      for (int i = 0; i < _rightStepOffsets.length; i++) {
        if (_rightStepOffsets[i] > _rightScrollController.offset + 0.1) {
          if (mounted) {
            setState(() {
              _indexLeft = i - 1 < 0 ? 0 : (i - 1);
            });
          }
          break;
        }
      }
    }
  }

  @override
  void initState() {
    _mainAxisSpacing = widget.rightGridMainAxisSpacing;
    _crossAxisSpacing = widget.rightGridCrossAxisSpacing;
    _indexLeft = widget.initialSelTabIndex;
    _gridViewVPadding = widget.rightGridViewVPadding;

    _leftScrollController = ScrollController()
      ..addListener(_leftScrollListener);
    _rightScrollController = ScrollController()
      ..addListener(_rightScrollListener);

    super.initState();
  }

  // 统计右边每个分类的偏移量以便滚动
  void _calculateStepOffsets() {
    if (_gridItemHeight == 0) return;
    if (_tabs.isEmpty) return;

    _rightStepOffsets.clear();

    double offsetDy = 0;
    final tabCount = _tabs.length;
    for (int i = 0; i < tabCount; i++) {
      final itemList = widget.rightDatasGetter?.call(i) ?? [];

      int rows = itemList.length ~/ _crossAxisCount;
      if (itemList.length % _crossAxisCount > 0) {
        rows += 1;
      }

      final gridViewHeight = _gridItemHeight * rows +
          _gridViewVPadding * 2 +
          (rows - 1) * _mainAxisSpacing;

      _rightStepOffsets.add(offsetDy);
      offsetDy += gridViewHeight;

      // 最后一个分类需要补齐高度，否则左边不能滑动到最后一个分类
      if (i == tabCount - 1) {
        _lastGridDiffHeight =
            gridViewHeight > _spaceHeight ? 0 : _spaceHeight - gridViewHeight;
      }
    }
  }

  @override
  void didUpdateWidget(CommonCombinedRolling oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      _spaceHeight = 0.0;
      _gridItemHeight = 0.0;
    }
  }

  @override
  void dispose() {
    _leftScrollController.removeListener(_leftScrollListener);
    _leftScrollController.dispose();
    _rightScrollController.removeListener(_rightScrollListener);
    _rightScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: widget.padding ?? 10),
        Expanded(
          flex: _leftWidgetFlex,
          child: _buildLeftTabListView(),
        ),
        SizedBox(width: widget.space ?? 10),
        Expanded(
          flex: _rightWidgetFlex,
          child: _buildRightItemGridView(),
        ),
        SizedBox(width: widget.padding ?? 10),
      ],
    );
  }

  // 左侧分类栏
  Widget _buildLeftTabListView() {
    final leftTopWidget = widget.leftTopWidgetBuilder?.call();
    return Container(
      decoration: widget.leftDecoration,
      child: CustomScrollView(
        slivers: [
          if (leftTopWidget != null) SliverToBoxAdapter(child: leftTopWidget),
          SliverList.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  _rightScrollController.animateTo(
                    _rightStepOffsets[index],
                    duration: CpState.rollingScrollDuration,
                    curve: Curves.easeIn,
                  );
                },
                child: widget.leftTabBuilder?.call(index, _indexLeft == index),
              );
            },
            itemCount: _tabs.length,
          ),
        ],
      ),
    );
  }

  // 右侧项目栏 - GridView 版本
  Widget _buildRightItemGridView() {
    // 触发重构时需要重新计算各 GridView 的高度以便计算偏移量
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _spaceHeight = constraints.maxHeight;
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, tabIndex) {
            final itemList = widget.rightDatasGetter?.call(tabIndex) ?? [];
            return Column(
              children: [
                widget.rightSectionHeaderBuilder?.call(tabIndex) ??
                    const SizedBox(),
                GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: _gridViewVPadding)
                      .copyWith(top: tabIndex == 0 ? 0 : _gridViewVPadding),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount,
                    mainAxisSpacing: _mainAxisSpacing,
                    crossAxisSpacing: _crossAxisSpacing,
                    childAspectRatio: _childAspectRatio,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        if (_gridItemHeight == 0) {
                          _gridItemHeight = constraints.maxHeight;
                          _calculateStepOffsets();
                        }
                        return widget.rightItemBuilder?.call(tabIndex, index) ??
                            const SizedBox();
                      },
                    );
                  },
                ),
                // 最后一个需要补齐高度，否则左侧不能滑动到最后一个
                if (tabIndex == _tabs.length - 1)
                  SizedBox(
                    height: _lastGridDiffHeight,
                  ),
              ],
            );
          },
          itemCount: _tabs.length,
          controller: _rightScrollController,
        );
      },
    );
  }
}
