import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bet_order_queue.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注通知浮窗】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要实现内容：
    1、点击穿透，不影响底下页面交互
    2、SafeArea，正确显示位置
    3、显示时做淡入动画
    】】】
 *
 */
class BetOrderToast extends StatelessWidget {
  const BetOrderToast({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final child = BetOrderQueue.to.currentToast.value;
      if (child == null) return const SizedBox.shrink();
      return Positioned.fill(
        child: IgnorePointer(
          ignoring: false,
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: _FadeSlideIn(
                key: ValueKey(child.hashCode),
                child: child,
                duration: const Duration(milliseconds: 260),
              ),
            ),
          ),
        ),
      );
    });
  }
}

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注通知浮窗】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 实现谈入效果
    】】】
 *
 */
class _FadeSlideIn extends StatefulWidget {
  const _FadeSlideIn({super.key, required this.child, this.duration = const Duration(milliseconds: 260)});

  final Widget child;
  final Duration duration;

  @override
  State<_FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<_FadeSlideIn> {
  double _opacity = 0.0;
  Offset _offset = const Offset(0, -0.06);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _opacity = 1.0;
        _offset = Offset.zero;
      });
    });
  }

  @override
  void didUpdateWidget(covariant _FadeSlideIn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      // 重置再触发动画
      _opacity = 0.0;
      _offset = const Offset(0, -0.06);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {
          _opacity = 1.0;
          _offset = Offset.zero;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: widget.duration,
      curve: Curves.easeOut,
      opacity: _opacity,
      child: AnimatedSlide(
        duration: widget.duration,
        curve: Curves.easeOut,
        offset: _offset,
        child: widget.child,
      ),
    );
  }
}