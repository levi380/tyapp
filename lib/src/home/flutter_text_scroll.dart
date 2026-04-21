import 'dart:async';
import 'package:flutter/material.dart';

/// 连续闭环垂直滚动（像传送带）
/// 支持 upward 向上 / 向下滚动
class VerticalMarqueeLoop extends StatefulWidget {
  final List<String> texts;
  final double speed; // 滚动速度(px/s)
  final double height;
  final TextStyle? style;
  final bool upward; // true=向上滚, false=向下滚

  const VerticalMarqueeLoop({
    super.key,
    required this.texts,
    this.speed = 30,
    this.height = 20,
    this.style,
    this.upward = true,
  });

  @override
  State<VerticalMarqueeLoop> createState() => _VerticalMarqueeLoopState();
}

class _VerticalMarqueeLoopState extends State<VerticalMarqueeLoop> {
  final ScrollController _controller = ScrollController();
  double offset = 0;
  Timer? _timer;

  double get direction => widget.upward ? 1 : -1;

  @override
  void initState() {
    super.initState();
    if (widget.texts.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startLoop();
      });
    }
  }

  void _startLoop() {
    _timer?.cancel();
    const frame = Duration(milliseconds: 16); // ~60fps
    _timer = Timer.periodic(frame, (timer) {
      if (!_controller.hasClients) return;
      final delta = widget.speed * direction * (frame.inMilliseconds / 1000.0);
      offset += delta;

      final maxScrollExtent = _controller.position.maxScrollExtent;

      if (widget.upward) {
        // 向上滚到底部 -> 回顶
        if (offset >= maxScrollExtent) offset = 0;
      } else {
        // 向下滚到顶 -> 回底
        if (offset <= 0) offset = maxScrollExtent;
      }

      _controller.jumpTo(offset.clamp(0, maxScrollExtent));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 为了实现闭环滚动，列表需要重复两份数据
    final texts = [...widget.texts, ...widget.texts];

    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: texts.length,
        itemBuilder: (_, i) => SizedBox(
          height: widget.height,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              texts[i % widget.texts.length],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: widget.style ?? const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}