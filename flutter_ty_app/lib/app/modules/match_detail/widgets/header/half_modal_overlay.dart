import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/bus/bus.dart';
// import '../../../../utils/bus/event_bus.dart';
import '../../../../utils/bus/event_enum.dart';

class HalfModalController {
  bool _isOpened = false;

  // 是否已打开
  bool get isOpened => _isOpened;

  void _markOpened() => _isOpened = true;
  void _markClosed() => _isOpened = false;

  // 关闭方法
  VoidCallback? _closeFn;

  void close() {
    _closeFn?.call();
  }

  // 内部关闭函数
  void _bindClose(VoidCallback fn) {
    _closeFn = () {
      fn();
      _markClosed();
    };
  }
}


HalfModalController showHalfModal({
  required BuildContext context,
  required Widget child,
  double topHeight = 300.0,
}) {
  final controller = HalfModalController();
  controller._markOpened(); // 立即标记为打开

  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => HalfModalOverlay(
      child: child,
      topHeight: topHeight,
      onClosed: () {
        overlayEntry.remove();
        controller._markClosed(); // 关闭后更新状态
      },
    ),
  );

  // 关闭函数
  controller._bindClose(() {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
      controller._markClosed();
    }
  });

  Overlay.of(context).insert(overlayEntry);
  return controller;
}

class HalfModalOverlay extends StatefulWidget {
  final Widget child;
  final double topHeight;
  final VoidCallback onClosed;

  const HalfModalOverlay({
    super.key,
    required this.child,
    required this.topHeight,
    required this.onClosed,
  });

  @override
  State<HalfModalOverlay> createState() => _HalfModalOverlayState();
}

class _HalfModalOverlayState extends State<HalfModalOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late bool isPlayingAnimation;

  @override
  void initState() {
    isPlayingAnimation = false;
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();

    Bus.getInstance().on(EventType.matchDetailIsPlayingAnimation, (value) {
      print(value);
      if (value == true) {
        setState(() {
          isPlayingAnimation = true;
        });
      }else{
        isPlayingAnimation = false;
      }
    });
  }

  @override
  void dispose() {
    Bus.getInstance().off(EventType.matchDetailIsPlayingAnimation);
    _controller.dispose();
    super.dispose();
  }

  void _close() {
    Bus.getInstance().emit(EventType.matchDetailMatchListClosed);
    _controller.reverse().then((_) {
      widget.onClosed();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final effectiveTopHeight = widget.topHeight + MediaQuery.of(context).padding.top;
    final bottomHeight = screenHeight - effectiveTopHeight;
    double hh = bottomHeight;
    if (isPlayingAnimation == true){
      hh = bottomHeight + 20.h;
    }else{
      hh = bottomHeight;
    }

    return GestureDetector(
      onTap: _close,
      child: Stack(
        children: [
          // 上半部分：固定高度 + 穿透点击
          IgnorePointer(
            ignoring: true,
            child: Container(
              height: effectiveTopHeight,
              color: Colors.transparent,
            ),
          ),

          // 下半部分
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return FractionalTranslation(
                  translation: Offset(0, _animation.value),
                  child: SizedBox(
                    height: hh,
                    child: widget.child
                    // Material(
                    //   color: Colors.white,
                    //   child: widget.child,
                    // ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}