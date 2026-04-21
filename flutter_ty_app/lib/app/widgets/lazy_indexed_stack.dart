import 'package:flutter/material.dart';

import 'keep_alive_wrapper.dart';

/// IndexedStack 实现懒加载
class LazyIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;

  const LazyIndexedStack({
    super.key,
    required this.index,
    required this.children,
  });

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late List<bool> _shouldBuild;

  @override
  void initState() {
    super.initState();
    _shouldBuild = List<bool>.filled(widget.children.length, false);
    if (widget.index < widget.children.length) {
      _shouldBuild[widget.index] = true;
    }
  }

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果 children 长度发生变化，调整 _shouldBuild 的长度
    if (widget.children.length != _shouldBuild.length) {
      final newShouldBuild = List<bool>.filled(widget.children.length, false);

      // 保留原有的值
      for (int i = 0;
          i < _shouldBuild.length && i < newShouldBuild.length;
          i++) {
        newShouldBuild[i] = _shouldBuild[i];
      }

      _shouldBuild = newShouldBuild;
    }

    // 标记当前索引为需要构建
    if (widget.index < _shouldBuild.length) {
      _shouldBuild[widget.index] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(widget.children.length, (i) {
        final shouldDisplay = widget.index == i;
        return Offstage(
          offstage: !shouldDisplay,
          child: i < _shouldBuild.length && _shouldBuild[i]
              ? KeepAliveWrapper(child: widget.children[i])
              : const SizedBox.shrink(),
        );
      }),
    );
  }
}
