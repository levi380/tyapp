import 'dart:math';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/event_bus.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TurntableWidget extends StatefulWidget {
  /// 奖品数量
  final int itemCount;

  /// 点击开始抽奖（必须返回 prizeIndex）
  final Future<int> Function() onSpin;

  /// 动画结束回调
  final ValueChanged<int>? onFinish;

  /// 转盘大小
  final double size;

  /// 礼物名字列表
  final List<String>? prizeNames;

  /// 礼物图片列表（网络图片URL）
  final List<String>? prizeImages;

  const TurntableWidget({
    super.key,
    required this.itemCount,
    required this.onSpin,
    this.onFinish,
    this.size = 300,
    this.prizeNames,
    this.prizeImages,
  });

  @override
  State<TurntableWidget> createState() => _TurntableWidgetState();
}

class _TurntableWidgetState extends State<TurntableWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double _currentAngle = 0;
  bool _isSpinning = false;
  int? _currentPrizeIndex;

  double get _anglePerItem => 2 * pi / widget.itemCount;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _controller.addListener(() {
      setState(() {
        _currentAngle = _animation.value;
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isSpinning = false;
        // 动画结束后，确保角度精确对应目标奖品
        if (_currentPrizeIndex != null) {
          // 计算目标角度：让扇形中心对准指针
          final double targetAngle = _correctedAngle(_currentPrizeIndex!);

          // 归一化目标角度到 0-2π 范围
          double normalizedTargetAngle = targetAngle % (2 * pi);
          if (normalizedTargetAngle < 0) {
            normalizedTargetAngle += 2 * pi;
          }

          // 归一化当前角度
          double normalizedCurrentAngle = _currentAngle % (2 * pi);
          if (normalizedCurrentAngle < 0) {
            normalizedCurrentAngle += 2 * pi;
          }

          debugPrint('动画结束: prizeIndex=${_currentPrizeIndex}');
          debugPrint(
              '  当前角度: ${(normalizedCurrentAngle * 180 / pi).toStringAsFixed(2)}°');
          debugPrint(
              '  目标角度: ${(normalizedTargetAngle * 180 / pi).toStringAsFixed(2)}°');
          debugPrint(
              '  角度差: ${((normalizedCurrentAngle - normalizedTargetAngle).abs() * 180 / pi).toStringAsFixed(2)}°');

          // 直接使用目标角度，确保精确对应
          setState(() {
            _currentAngle = normalizedTargetAngle;
          });

          widget.onFinish?.call(_currentPrizeIndex!);
        }
      }
    });
  }

  /// prizeIndex → 目标角度（指针朝上，顺时针）
  /// 转盘顺时针旋转，指针固定在顶部（-π/2 或 3π/2）
  /// 要让 index 的扇形中心对准指针，转盘需要旋转的角度
  double _correctedAngle(int index) {
    // 每个扇形的中心角度（相对于转盘初始位置，从右侧0°开始）
    final double sectorCenterAngle = index * _anglePerItem + _anglePerItem / 2;

    // 指针在顶部（-π/2 或 3π/2 = 270°）
    // Transform.rotate 顺时针旋转（正角度），转盘旋转后，扇形中心位置 = sectorCenterAngle + rotationAngle
    // 要让这个位置等于 -π/2（或 3π/2），所以：rotationAngle = -π/2 - sectorCenterAngle
    // 归一化到 0-2π：rotationAngle = 3π/2 - sectorCenterAngle
    // 修正：差了2.5个item，需要加上这个偏移
    double targetAngle = 3 * pi / 2 - sectorCenterAngle + 2.5 * _anglePerItem;

    // 归一化到 0-2π 范围
    targetAngle = targetAngle % (2 * pi);
    if (targetAngle < 0) {
      targetAngle += 2 * pi;
    }

    debugPrint('_correctedAngle: index=$index');
    debugPrint(
        '  sectorCenter=${(sectorCenterAngle * 180 / pi).toStringAsFixed(2)}°');
    debugPrint('  target=${(targetAngle * 180 / pi).toStringAsFixed(2)}°');
    final double finalPosition = (sectorCenterAngle + targetAngle) % (2 * pi);
    debugPrint(
        '  验证: sectorCenter(${(sectorCenterAngle * 180 / pi).toStringAsFixed(2)}°) + target(${(targetAngle * 180 / pi).toStringAsFixed(2)}°) = ${(finalPosition * 180 / pi).toStringAsFixed(2)}° (应该是270°或-90°)');

    return targetAngle;
  }

  Future<void> _startSpin() async {
    if (UserService.to.state.isVisitor) {
      EventBus.emit(EventType.goToLogin);
      return;
    }
    if (_isSpinning) return;
    _isSpinning = true;

    try {
      final int prizeIndex = await widget.onSpin();
      _currentPrizeIndex = prizeIndex;

      const int rounds = 6;
      // 计算目标角度（相对于初始位置）
      final double targetAngle = _correctedAngle(prizeIndex);

      // 归一化当前角度到 0-2π 范围
      double normalizedCurrentAngle = _currentAngle % (2 * pi);
      if (normalizedCurrentAngle < 0) {
        normalizedCurrentAngle += 2 * pi;
      }

      // 计算需要旋转的角度增量
      // 如果目标角度小于当前角度，需要多转一圈
      double angleDelta = targetAngle - normalizedCurrentAngle;
      if (angleDelta < 0) {
        angleDelta += 2 * pi;
      }

      // 加上多转的圈数
      final double endAngle = rounds * 2 * pi + angleDelta;

      _animation = Tween<double>(
        begin: _currentAngle,
        end: _currentAngle + endAngle,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ),
      );

      _controller.forward(from: 0);
    } catch (e) {
      _isSpinning = false;
      debugPrint('spin error: $e');
    }
  }

  /// 构建礼物项
  Widget _buildGiftItem(int index) {
    // 计算每个礼物的角度（每个扇形的中心角度）
    final angle = index * _anglePerItem + _anglePerItem / 2;
    // 礼物距离中心的距离（转盘半径的 0.25 倍）
    final radius = widget.size * 0.28;
    // 计算礼物的位置
    final x = radius * cos(angle - pi / 2);
    final y = radius * sin(angle - pi / 2);
    // 礼物名字
    final prizeName =
        widget.prizeNames != null && index < widget.prizeNames!.length
            ? widget.prizeNames![index]
            : '';

    // 礼物图片URL
    final prizeImageUrl =
        widget.prizeImages != null && index < widget.prizeImages!.length
            ? widget.prizeImages![index]
            : null;

    // 图片宽度和高度
    final imageWidth = 27.r;
    final imageHeight = 35.r;
    final spacing = 14.r;
    final textHeight = 14.r; // 文字高度估算

    // 计算文字的实际宽度
    final textStyle = TextStyle(
      color: Color(0xFF854417),
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    );
    final textPainter = TextPainter(
      text: TextSpan(text: prizeName, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    // 设置最大宽度限制，模拟实际显示时的截断
    textPainter.layout(maxWidth: double.infinity);
    final textWidth = textPainter.width;

    // 使用文字和图片中较大的宽度来居中
    final maxWidth = textWidth > imageWidth ? textWidth : imageWidth;
    final totalHeight = textHeight + spacing + imageHeight;

    return Positioned(
      left: widget.size / 2 + x - maxWidth / 2,
      top: widget.size / 2 + y - totalHeight / 2,
      child: Transform.rotate(
        angle: angle,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              prizeName,
              style: textStyle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: spacing),
            prizeImageUrl != null && prizeImageUrl.isNotEmpty
                ? SKNetworkImage(
                    imageUrl: prizeImageUrl,
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.contain,
                    placeholderType: 1,
                  )
                : Image.asset(
                    Assets.activityGift,
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.contain,
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// 转盘
          Transform.rotate(
            angle: _currentAngle,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  Assets.activityBgDisk,
                  width: widget.size,
                  height: widget.size,
                  fit: BoxFit.contain,
                ),
                // 10个礼物图片
                ...List.generate(
                  widget.itemCount,
                  (index) => _buildGiftItem(index),
                ),
              ],
            ),
          ),

          /// 点击按钮
          Positioned(
            left: widget.size / 2 - 44.r,
            top: widget.size / 2 - 53.r - 10.r,
            child: GestureDetector(
              onTap: _startSpin,
              child: Container(
                width: 88.r,
                height: 106.r,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.activityBgPointer),
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 20.r),
                  child: Text(
                    '立即\n抽奖',
                    style: TextStyle(
                      color: Color(0xFFFCE9CC),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
