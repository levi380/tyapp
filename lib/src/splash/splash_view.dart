import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:filbet/src/splash/splash_controlle.dart';
import 'package:filbet/src/splash/widgets/custom_linear_progress.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.splashType == SplashType.single
        ? _buildSinglePhotoView(context)
        : _buildMultiPhotoView();
  }

  Widget _buildSingleBase({
    required double statusBarHeight,
    Widget? image,
  }) {
    return Stack(
      children: [
        const Positioned.fill(
          child: ColoredBox(
            color: Color(0xFFFFFFFF),
          ),
        ),
        if (image != null) Positioned.fill(child: image),
        Positioned(
          top: statusBarHeight + 24.h,
          right: 20.w,
          child: Obx(() {
            // 进度加载时不显示倒计时；进度完成、进度条消失后再显示
            if (SplashController.to.initAppProgress.value < 1.0 ||
                controller.splashModel.value == null) {
              return const SizedBox.shrink();
            }
            return _buildCountdownButton();
          }),
        ),
        Positioned(
          bottom: 144.r,
          left: 0,
          right: 0,
          child: Center(
            child: Obx(() {
              if (SplashController.to.initAppProgress.value >= 1.0) {
                return const SizedBox.shrink();
              }
              return CustomLinearProgress(
                value: SplashController.to.initAppProgress.value,
                progressText: SplashController.to.domainTip.value,
              );
            }),
          ),
        ),
        versionView(),
      ],
    );
  }

  Widget _buildSinglePhotoView(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Obx(() {
      return FutureBuilder<String?>(
        future: controller.imageForSinglePhotoViewUrl,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return _buildSingleBase(statusBarHeight: statusBarHeight);
          }
          final url = snapshot.data!;
          if (url.contains("default")) {
            return _buildSingleBase(
              statusBarHeight: statusBarHeight,
              image: Image.asset(url, fit: BoxFit.fitWidth),
            );
          }

          final file = File(url);
          if (!file.existsSync()) {
            return _buildSingleBase(statusBarHeight: statusBarHeight);
          }

          return _buildSingleBase(
            statusBarHeight: statusBarHeight,
            image: Image(image: FileImage(file), fit: BoxFit.fitWidth),
          );
        },
      );
    });
  }

  Widget _buildMultiPhotoView() {
    return Obx(() {
      final model = controller.splashModel.value;
      if (model == null) {
        return const SizedBox.shrink();
      }
      final allImages = model.getDownloadedImagePaths();
      return Stack(
        children: [
          Positioned.fill(
            child: Container(color: Color(0xFFFFFFFF)),
          ),
          FutureBuilder(
            future: allImages,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return SizedBox();
              }
              final allImages = snapshot.data!;
              return Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: allImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final provider = FileImage(File(allImages[index]));
                      return Image(
                        image: provider,
                        fit: BoxFit.fitWidth,
                      );
                    },
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      height: double.infinity,
                      // autoPlay: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        controller.currentIndex.value = index;
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 140.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CustomPageIndicator(
                        activeIndex: controller.currentIndex.value,
                        itemCount: allImages.length,
                        dotHeight: 2.h,
                        dotWidth: 12.w,
                      ),
                    ),
                  ),
                  if (controller.currentIndex.value == allImages.length - 1 &&
                      SplashController.to.initAppProgress.value >= 1.0)
                    Positioned(
                      bottom: 60.h,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: buildEntryButton(),
                      ),
                    )
                ],
              );
            },
          ),
          // 进度条（initApp 完成前显示）
          Positioned(
            bottom: 110.h,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(() {
                if (SplashController.to.initAppProgress.value >= 1.0) {
                  return const SizedBox.shrink();
                }
                return CustomLinearProgress(
                  value: SplashController.to.initAppProgress.value,
                  progressText: SplashController.to.domainTip.value,
                );
              }),
            ),
          ),
          versionView(),
        ],
      );
    });
  }

  Widget _buildCountdownButton() {
    return Container(
      width: 70.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: Color(0xFF3B5078).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
          width: 1.w,
        ),
      ),
      child: GestureDetector(
        onTap: () async {
          await SplashController.to.startMain();
        },
        child: Center(child: Obx(
          () {
            return Text(
              "${'skip'.tr} ${SplashController.to.remaining}s",
              style: const TextStyle(color: Colors.white),
            );
          },
        )),
      ),
    );
  }

  Widget buildEntryButton() {
    return SizedBox(
      width: 240.w,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () async {
          await controller.startMain();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: appnewColors.bg,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'tryNow'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Positioned versionView() {
    return Positioned(
      bottom: 30.h,
      left: 0,
      right: 0,
      child: Obx(() {
        return Text(
          controller.appVersion.value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF79839D),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        );
      }),
    );
  }
}

class CustomPageIndicator extends StatelessWidget {
  /// 当前激活页面的索引
  final int activeIndex;

  /// 页面总数
  final int itemCount;

  /// 指示器的高度
  final double dotHeight;

  /// 指示器的宽度
  final double dotWidth;

  /// 指示器之间的间距
  final double spacing;

  /// 激活状态的颜色
  final Color activeColor;

  /// 未激活状态的颜色
  final Color inactiveColor;

  final bool? showShadow;

  const CustomPageIndicator({
    super.key,
    required this.activeIndex,
    required this.itemCount,
    // 默认值保持不变，以匹配之前的样式
    this.dotHeight = 10.0,
    this.dotWidth = 22.0,
    this.spacing = 16.0,
    this.showShadow = true,
    this.activeColor = const Color(0xFFBDE0FE),
    this.inactiveColor = const Color(0xFF344054),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return _buildIndicatorDot(index);
      }),
    );
  }

  /// 构建单个指示器点
  Widget _buildIndicatorDot(int index) {
    // 判断当前点是否是激活状态，逻辑从对比内部状态 _currentPage
    // 变成了对比外部传入的 activeIndex
    final bool isActive = (index == activeIndex);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: spacing / 2),
      // 不再需要 AnimatedContainer，因为父组件的 setState 会触发整个重建
      // 但为了保留平滑的动画效果，我们依然可以使用它。
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: dotHeight,
        width: dotWidth,
        decoration: BoxDecoration(
          color: isActive ? activeColor : inactiveColor,
          borderRadius: BorderRadius.circular(dotHeight / 2),
          boxShadow: showShadow == true
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}
