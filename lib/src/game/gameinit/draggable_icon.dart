import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DraggableIcon extends StatefulWidget {
  final Widget child;
  final double childSize;
  final Offset initOffset;
  final double padding;
  DraggableIcon({
    super.key,
    required this.child,
    required this.childSize,
    this.initOffset = Offset.zero,
    this.padding = 10,
  });

  @override
  State<DraggableIcon> createState() => _DraggableIconState();
}

class _DraggableIconState extends State<DraggableIcon> {
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();

    _onDragEnd(widget.initOffset);
  }

  double get childSize => widget.childSize;

  void _onDragEnd(Offset offset) {
    double dx = offset.dx;
    double dy = offset.dy;

    EdgeInsets viewPadding = Get.mediaQuery.viewPadding;

    ///水平方向
    dx = max(dx - viewPadding.left, widget.padding);

    double maxDx = Get.width -
        childSize -
        viewPadding.right -
        viewPadding.left -
        widget.padding;

    if (dx > maxDx) {
      dx = maxDx;
    }

    ///垂直方向
    dy = max(dy - viewPadding.top, widget.padding);

    double maxDy = Get.height -
        childSize -
        viewPadding.bottom -
        viewPadding.top -
        widget.padding;

    if (dy > maxDy) {
      dy = maxDy;
    }

    if (mounted) {
      setState(() {
        _offset = Offset(dx, dy);
      });
    }
  }

  @override
  void didUpdateWidget(covariant DraggableIcon oldWidget) {
    _onDragEnd(widget.initOffset);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            left: _offset.dx,
            top: _offset.dy,
            child: Draggable(
              feedback: widget.child,
              onDragEnd: (details) {
                _onDragEnd(details.offset);
              },
              childWhenDragging: const SizedBox.shrink(),
              child: ScaleTransitionWidget(child: widget.child),
            )),
      ],
    );
  }
}

class OrientationWidget extends StatelessWidget {
  final Widget child;
  final double childSize;
  const OrientationWidget({
    super.key,
    required this.child,
    required this.childSize,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      Offset offset = Offset(Get.width, 0);

      return DraggableIcon(
        childSize: childSize,
        initOffset: offset,
        child: child,
      );
    });
  }
}

class ScaleTransitionWidget extends StatefulWidget {
  final Widget child;
  const ScaleTransitionWidget({
    super.key,
    required this.child,
  });

  @override
  State<ScaleTransitionWidget> createState() => _ScaleTransitionWidgetState();
}

class _ScaleTransitionWidgetState extends State<ScaleTransitionWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _animation = Tween(begin: 0.8, end: 1.2).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus state) {
        if (state == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (state == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.child);
  }
}
