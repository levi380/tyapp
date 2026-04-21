
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RotatingIcon extends StatefulWidget {
  final String icon;
  final bool isRotating;

  const RotatingIcon({
    required this.icon,
    required this.isRotating,
  });

  @override
  State<RotatingIcon> createState() => _RotatingIconState();
}

class _RotatingIconState extends State<RotatingIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(RotatingIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRotating && !oldWidget.isRotating) {
      _controller.repeat();
    } else if (!widget.isRotating && oldWidget.isRotating) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Image.asset(
        widget.icon,
        width: 12.r,
        height: 12.r,
      ),
    );
  }
}