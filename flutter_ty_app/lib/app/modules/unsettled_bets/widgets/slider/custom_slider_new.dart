import 'dart:ui' as ui;

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../information_view.dart' show InformationView;

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 自定义部分提前兑现滑块选择器(带游标)Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于选择一个范围内的数值，支持自定义样式、颜色和图像，适用于需要滑动选择的场景。
    - `CustomSlider`：接收多个参数，包括当前值、最小值、最大值、图像偏移量等，以便于灵活配置。
    - 使用 `StatefulWidget` 和 `_CustomSliderState` 管理组件状态，支持异步加载图像。
    - 在 `initState` 中异步加载图像，并在加载完成后更新状态。
    - 使用 `SliderTheme` 自定义滑块的外观，包括滑块形状、轨道颜色、轨道渐变等。
    - `CustomSliderTrackShape` 用于绘制滑块的轨道，支持渐变和边框样式。
    - 通过 `onChanged` 回调函数传递当前值，支持实时更新。
    - 使用 `CustomPaint` 绘制当前值、最小值和最大值，支持根据主题调整颜色和样式。
    】】】
 *
 */

class CustomSliderNew extends StatefulWidget {
  final double thumbWidth;
  final double thumbHeight;
  final double? trackHeight;
  final Gradient? activeTrackGradient;
  final Gradient? inactiveTrackGradient;
  final Color? inactiveTrackColor;
  final Color? activeTrackColor;
  final double? trackBorder;
  final Color? trackBorderColor;
  final double value;
  final ValueChanged<double>? onChanged;
  ///最小金额和最大金额
  final String minAmount,maxAmount;

  /// 最小百分百值
  final double min;
  /// 最大百分比值
  final double max;

  /// 滑块偏移量 比如阴影导致滑块实际偏大
  final double imageThumbOffset;

  final ui.Image? image;

  const CustomSliderNew({
    super.key,
    required this.value,
    required this.minAmount,
    required this.maxAmount,
    required this.min,
    required this.max,
    required this.imageThumbOffset,
    this.activeTrackGradient,
    this.thumbWidth = 10,
    this.thumbHeight = 10,
    this.trackHeight,
    this.inactiveTrackColor,
    this.inactiveTrackGradient,
    this.trackBorder,
    this.trackBorderColor,
    this.activeTrackColor,
    this.onChanged,
    this.image,
  });

  @override
  State<CustomSliderNew> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSliderNew> {
  ImageThumbShape? myShape;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  _loadImage() async {
    if (widget.image != null) {
      myShape = ImageThumbShape(
          image: widget.image!,
          offset: widget.imageThumbOffset,
          width: widget.thumbWidth,
          height: widget.thumbHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            thumbShape: myShape,
            trackHeight: widget.trackHeight,
            trackShape: CustomSliderTrackShape(
              activeTrackGradient: widget.activeTrackGradient,
              inactiveTrackGradient: widget.inactiveTrackGradient,
              activeTrackColor: widget.activeTrackColor,
              inactiveTrackColor: widget.inactiveTrackColor,
              trackBorder: widget.trackBorder,
              trackBorderColor: widget.trackBorderColor,
            ),
            // 刻度线形状
            tickMarkShape: SliderTickMarkShape.noTickMark,
            // 拖动时的阴影
            overlayColor: Colors.transparent,
          ),
          child: Slider(
            value: widget.value,
            min: widget.min,
            max: widget.max,
            onChanged: (val) {
              if (widget.onChanged != null) {
                widget.onChanged!(val);
              }
            },
          ),
        ),

        /// 底部文字
        InformationView(
                top: 0,
                information: widget.minAmount,
                outcome: widget.maxAmount,
                titleColorType: 2,
                InformationColorType: 2)
            .marginSymmetric(
          horizontal: 10.w,
        ),
      ],
    );
  }
}

/// 自定义trackshape
class CustomSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  CustomSliderTrackShape({
    required this.activeTrackGradient,
    this.inactiveTrackGradient,
    this.trackBorder,
    this.trackBorderColor,
    this.inactiveTrackColor,
    this.activeTrackColor,
  });

  final Gradient? activeTrackGradient;
  final Gradient? inactiveTrackGradient;
  final double? trackBorder;
  final Color? trackBorderColor;
  final Color? inactiveTrackColor;
  final Color? activeTrackColor;

  @override
  void paint(
    PaintingContext context,
    ui.Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required ui.TextDirection textDirection,
    required ui.Offset thumbCenter,
    ui.Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    double additionalActiveTrackHeight = 0,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor, end: Colors.white);

    final Paint activePaint = Paint();

    if (activeTrackGradient != null) {
      activePaint.shader = activeTrackGradient!.createShader(trackRect);
      activePaint.color = activeTrackColorTween.evaluate(enableAnimation)!;
    } else if (activeTrackColor != null) {
      activePaint.color = activeTrackColor!;
    } else {
      activePaint.color = Colors.blue;
    }

    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: inactiveTrackGradient != null
            ? Colors.white
            : sliderTheme.inactiveTrackColor);
    final Paint inactivePaint = Paint();
    if (inactiveTrackGradient != null) {
      inactivePaint.shader = inactiveTrackGradient!.createShader(trackRect);
      inactivePaint.color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    } else if (inactiveTrackColor != null) {
      inactivePaint.color = inactiveTrackColor!;
    } else {
      inactivePaint.color = Colors.white;
    }
    final canvas = context.canvas;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius =
        Radius.circular((trackRect.height + additionalActiveTrackHeight) / 2);

    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
    if (trackBorder != null || trackBorderColor != null) {
      final strokePaint = Paint()
        ..color = trackBorderColor ?? Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = trackBorder != null
            ? trackBorder! < trackRect.height / 2
                ? trackBorder!
                : trackRect.height / 2
            : 1
        ..strokeCap = StrokeCap.round;
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
              trackRect.left, trackRect.top, trackRect.right, trackRect.bottom,
              topLeft: trackRadius,
              bottomLeft: trackRadius,
              bottomRight: trackRadius,
              topRight: trackRadius),
          strokePaint);
    }
  }
}

class ImageThumbShape extends SliderComponentShape {
  ui.Image image;

  /// 偏移量
  double offset;
  double width;
  double height;

  ImageThumbShape(
      {required this.image,
      required this.offset,
      required this.width,
      required this.height});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(0, 0);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    // final imageWidth = image.width;
    // final imageHeight = image.height;
    double x = center.dx - (width / 2);

    /// 最小值滑块对齐最右边刻度 最大值滑块对齐最左边刻度
    // if (value <= 0) {
    //   x = center.dx - offset;
    // } else if (value >= 1) {
    //   x = center.dx - width / 2 + offset;
    // }

    // Offset imageOffset = Offset(x, center.dy - (imageHeight / 2));
    Paint paint = Paint()..filterQuality = FilterQuality.high;
    // 绘制图像，并指定绘制区域的大小和位置
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      // 源图像区域
      Rect.fromLTWH(x, center.dy - (height / 2), width, height), // 目标绘制区域
      paint,
    );
    // canvas.drawImage(image, imageOffset, paint);
  }
}
