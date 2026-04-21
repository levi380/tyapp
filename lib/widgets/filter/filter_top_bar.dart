import 'package:filbet/src/mine/transactionRecord/models/trade_dict.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

typedef FilterCallBack = Function(TradeDict tradeDict);

class FilterTopBar extends StatefulWidget {
  final List<TradeDict> filters;
  final FilterCallBack filterCallBack;
  final VoidCallback onTapFilter;

  const FilterTopBar({
    super.key,
    required this.filters,
    required this.filterCallBack,
    required this.onTapFilter,
  });

  @override
  State<FilterTopBar> createState() => _FilterTopBarState();
}

class _FilterTopBarState extends State<FilterTopBar> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _itemKeys = {};
  int? _lastSelectedIndex;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    // 为每个条目创建 GlobalKey
    _updateKeys();
    // 在下一帧滚动到选中的条目
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedItem();
    });
  }

  void _updateKeys() {
    _itemKeys.clear();
    for (int i = 0; i < widget.filters.length; i++) {
      _itemKeys[i] = GlobalKey();
    }
  }

  @override
  void didUpdateWidget(FilterTopBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filters.length != oldWidget.filters.length) {
      _updateKeys();
    }
  }

  int _getSelectedIndex() {
    return widget.filters.indexWhere((filter) => filter.isSelected);
  }

  void _scheduleScroll() {
    if (_isScrolling) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_isScrolling) {
        _scrollToSelectedItem();
      }
    });
  }

  void _scrollToSelectedItem() {
    if (_isScrolling) return;

    final selectedIndex = _getSelectedIndex();
    if (selectedIndex < 0 || 
        selectedIndex >= _itemKeys.length || 
        selectedIndex == _lastSelectedIndex) {
      return;
    }

    _lastSelectedIndex = selectedIndex;

    if (!_scrollController.hasClients) return;

    final key = _itemKeys[selectedIndex];
    final itemContext = key?.currentContext;
    if (itemContext == null) return;

    _isScrolling = true;
    Scrollable.ensureVisible(
      itemContext,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      alignment: 0.0,
    ).whenComplete(() {
      _isScrolling = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_itemKeys.length != widget.filters.length) {
      _updateKeys();
    }

    final currentSelectedIndex = _getSelectedIndex();
    if (currentSelectedIndex >= 0 && 
        currentSelectedIndex != _lastSelectedIndex) {
      _scheduleScroll();
    }

    return Container(
      height: 44.r,
      color: appnewColors.bg1,
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      child: Row(
        children: [
          /// 左边已选条件标签
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.filters.asMap().entries.map((entry) {
                  final index = entry.key;
                  final filter = entry.value;
                  final text = filter.name ?? '';
                  return InkWell(
                    key: _itemKeys[index],
                    onTap: () {
                      widget.filterCallBack(filter);
                      _scheduleScroll();
                    },
                    child: Container(
                      height: 28.r,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 4.r),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: filter.isSelected
                            ? appnewColors.bg1
                            : appnewColors.bg5,
                        border: filter.isSelected
                            ? Border.all(color: appnewColors.bg)
                            : null,
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: filter.isSelected
                              ? appnewColors.textBlue
                              : appnewColors.textMain,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(width: 10.r),

          /// 右边筛选按钮
          GestureDetector(
            onTap: () {
              widget.onTapFilter();
            },
            child: Row(
              children: [
                Text(
                  "filter".tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Image.asset(
                  Assets.loginArrowDown,
                  width: 14.r,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
