import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget header; // 外部传进来的头部
  final Widget expandedContent; // 外部传进来的展开区域
  final bool initiallyExpanded; // 初始是否展开
  final Widget headercontent; // 外部传进来的头部
  const CustomExpansionTile({
    super.key,
    required this.header,
    required this.expandedContent,
    required this.headercontent,
    this.initiallyExpanded = false,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  void didUpdateWidget(covariant CustomExpansionTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      _expanded = widget.initiallyExpanded;
    });
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 3.w, bottom: 3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // 头部（点击可展开/收起）
          Row(
            children: [
              Expanded(child: widget.header), // 外部传入的 header
              InkWell(
                onTap: _toggle,
                child: Container(
                  height: 20.h,
                  padding: EdgeInsets.only(left: 6.w, right: 16.r),
                  alignment: Alignment.center,
                  child: _expanded
                      ? Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.grey,
                        )
                      : Text(
                          '查看详情 >',
                          style: TextStyle(
                              color: appnewColors.textBlue,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                ),
              ),
            ],
          ),

          _expanded == false ? widget.headercontent : const SizedBox.shrink(),
          // 展开区域
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.all(12.0),
              child: widget.expandedContent,
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
