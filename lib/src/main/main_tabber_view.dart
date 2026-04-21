import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainTabbarView extends GetView<MainController> {
  const MainTabbarView({super.key});

  static const int _tabCount = 4;
  static const Color _borderColor = Color(0xFFFFFFFF);
  static const List<Color> _gradientColors = [
    Color(0xFFEDF3FA),
    Color(0xFFDDE6F4),
    Color(0xFFE5EFFF),
  ];

  /// 凸起高度（不用半圆，只做一小段弧）
  static const double _bumpHeight = 16;

  Widget _bottomNavigationBar(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final bumpH = _bumpHeight.r.toDouble();
    final barBodyHeight = 56.r + bottomPadding;
    final totalHeight =
        bumpH + barBodyHeight; // 保证为 double，避免 Positioned 布局时 null
    return Obx(() {
      final currentIndex = controller.currentIndex;
      // 只占用 barBodyHeight，凸起向上溢出不占布局，让 PageView 子页面可铺满
      return SizedBox(
        height: barBodyHeight,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: -bumpH,
              left: 0,
              right: 0,
              height: totalHeight,
              child: CustomPaint(
                painter: _BarBackgroundPainter(
                  gradientColors: _gradientColors,
                  borderColor: _borderColor,
                  bumpHeight: bumpH,
                  selectedIndex: currentIndex,
                  itemCount: _tabCount,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: Row(
                  children: List.generate(
                    _tabCount,
                    (index) => Expanded(
                      child: _navItem(index),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _navItem(int index) {
    final isSelected = controller.currentIndex == index;
    final iconSize = isSelected ? 36.r : 20.r;
    final iconPath =
        isSelected ? controller.sicons[index] : controller.icons[index];
    final content = InkWell(
      onTap: () => controller.jumpToPage(index),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: OverflowBox(
          alignment: Alignment.bottomCenter,
          maxHeight: 72.r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
            isSelected
                ? TweenAnimationBuilder<double>(
                    key: ValueKey('selected-$index'),
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutBack,
                    builder: (context, value, child) {
                      final clamped = value.clamp(0.0, 1.0);
                      return Transform.scale(
                        scale: value,
                        child: Opacity(
                          opacity: clamped,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      width: iconSize,
                      height: iconSize,
                      alignment: Alignment.center,
                      child: Image.asset(
                        iconPath,
                      ),
                    ),
                  )
                : index == 3
                    ? Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: iconSize,
                            height: iconSize,
                            alignment: Alignment.center,
                            child: Image.asset(
                              iconPath,
                            ),
                          ),
                          Positioned(
                            top: -1.r,
                            right: -4.r,
                            child: Obx(() {
                              if (UserService.to.state.totalUnread.value <= 0) {
                                return const SizedBox.shrink();
                              }
                              return Container(
                                width: 6.r,
                                height: 6.r,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFDB6372),
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                          ),
                        ],
                      )
                    : Container(
                        width: iconSize,
                        height: iconSize,
                        alignment: Alignment.center,
                        child: Image.asset(
                          iconPath,
                        ),
                      ),
            SizedBox(height: 2.r),
            Text(
              controller.titles[index],
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF303442)
                    : const Color(0xff8395AC),
              ),
            ),
          ],
          ),
        ),
      ),
    );
    return Container(
      height: 56.r,
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 8.r),
      child: content,
    );
  }

  ///安卓返回桌面不退出app
  Future<bool> _andrpidExitApp() async {
    if (Platform.isAndroid) {
      AndroidIntent intent = const AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        _andrpidExitApp();
      },
      child: Scaffold(
        extendBody: true,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: controller.pages,
        ),
        bottomNavigationBar: _bottomNavigationBar(context),
      ),
    );
  }
}

/// 绘制带选中项顶部一小段凸起的底部栏背景（渐变 + 白边 + 内阴影）
class _BarBackgroundPainter extends CustomPainter {
  _BarBackgroundPainter({
    required this.gradientColors,
    required this.borderColor,
    required this.bumpHeight,
    required this.selectedIndex,
    required this.itemCount,
  });

  final List<Color> gradientColors;
  final Color borderColor;
  final double bumpHeight;
  final int selectedIndex;
  final int itemCount;

  Path _buildPath(Size size) {
    final w = size.width;
    final h = size.height;
    const cornerRadius = 16.0;
    final itemWidth = w / itemCount;
    final centerX = itemWidth * selectedIndex + itemWidth / 2;
    final topY = bumpHeight;
    final bumpHalfWidth = itemWidth * 0.2;
    final bumpLeft = centerX - bumpHalfWidth;
    final bumpRight = centerX + bumpHalfWidth;

    final path = Path();
    path.moveTo(0, h);
    path.lineTo(0, topY + cornerRadius);
    path.quadraticBezierTo(0, topY, cornerRadius, topY);
    if (bumpLeft > cornerRadius) {
      path.lineTo(bumpLeft, topY);
    }
    path.quadraticBezierTo(centerX, topY - bumpHeight, bumpRight, topY);
    if (bumpRight < w - cornerRadius) {
      path.lineTo(w - cornerRadius, topY);
    }
    path.quadraticBezierTo(w, topY, w, topY + cornerRadius);
    path.lineTo(w, h);
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);
    final pathBounds = path.getBounds();

    // 1. 渐变背景：用形状边界做 shader，使三色准确对应顶部/中/底部
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: gradientColors,
      stops: const [0.0, 0.8, 1.0],
    );
    canvas.drawPath(
      path,
      Paint()
        ..shader = gradient.createShader(pathBounds)
        ..style = PaintingStyle.fill,
    );

    // 2. 内阴影：Color(0xE5FFFFFF)，offset(0,4)，blur 4
    canvas.save();
    canvas.clipPath(path);
    canvas.translate(0, 4);
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xE5FFFFFF)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
        ..style = PaintingStyle.stroke,
    );
    canvas.restore();

    // 3. 白边
    canvas.drawPath(
      path,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant _BarBackgroundPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.bumpHeight != bumpHeight ||
        oldDelegate.itemCount != itemCount ||
        oldDelegate.gradientColors != gradientColors ||
        oldDelegate.borderColor != borderColor;
  }
}
