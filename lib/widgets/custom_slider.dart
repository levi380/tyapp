import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSlider extends StatefulWidget {
  final double sliderWidth;
  final double trackHeight;
  final double value; // 进度值，范围 0.0 - 1.0
  final ValueChanged<double>? onChanged; // 可选，保留兼容性

  CustomSlider({
    required this.sliderWidth,
    required this.trackHeight,
    required this.value,
    this.onChanged,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(CustomSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation =
          Tween<double>(begin: oldWidget.value, end: widget.value).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 确保 value 在有效范围内
    final double progressValue = widget.value.clamp(0.0, 1.0);

    return Container(
      width: widget.sliderWidth,
      height: widget.trackHeight + 6.h,
      child: Stack(
        children: [
          // 背景轨道
          Positioned(
            top: 3.h,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFC7D0FF),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.trackHeight / 2),
                ),
              ),
              height: widget.trackHeight,
              width: widget.sliderWidth,
            ),
          ),
          // 进度条
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final double currentProgress = _animation.value.clamp(0.0, 1.0);
              final double progressWidth = widget.sliderWidth * currentProgress;

              // 计算 thumb 位置（居中在进度条末端）
              final double thumbSize = 22.r;
              final double thumbLeft = progressWidth - thumbSize / 2;
              final double clampedThumbLeft = thumbLeft.clamp(
                0.0,
                widget.sliderWidth - thumbSize,
              );

              return Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  // 进度条填充
                  Positioned(
                    top: 3.h,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF7A8BAD),
                        borderRadius: BorderRadius.all(
                          Radius.circular(widget.trackHeight / 2),
                        ),
                      ),
                      height: widget.trackHeight,
                      width: progressWidth,
                    ),
                  ),
                  // 进度指示器（thumb）
                  Positioned(
                    left: clampedThumbLeft,
                    child: Image.asset(
                      Assets.mineIcSliderThumb,
                      width: thumbSize,
                      height: thumbSize,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
