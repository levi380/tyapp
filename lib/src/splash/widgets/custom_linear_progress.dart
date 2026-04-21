import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomLinearProgress extends StatelessWidget {
  const CustomLinearProgress({
    super.key,
    this.value = 0,
    this.progressText = '',
  });

  /// 0.0 ~ 1.0
  final double value;
  final String progressText;

  @override
  Widget build(BuildContext context) {
    final progress = value.clamp(0.0, 1.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.r),
          child: Text(
            progressText,
            style: TextStyle(
              color: appnewColors.textSecond,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _ProgressBar(value: progress),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    final progress = value.clamp(0.0, 1.0);
    final inset = 1.r; // 避开边框
    final thumbSize = 20.r;

    return Container(
      height: 10.r,
      width: Get.width - 30.r,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFAFCFF),
            Color(0xFFECF3FF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x80D9E9FA),
            offset: Offset(-4, -4),
            blurRadius: 4,
          )
        ],
        border: Border.all(color: Color(0xFFFFFFFF), width: 1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final innerWidth =
              (constraints.maxWidth - inset * 2).clamp(0.0, double.infinity);
          final innerHeight =
              (constraints.maxHeight - inset * 2).clamp(0.0, double.infinity);
          final progressWidth = innerWidth * progress;

          final thumbLeft = (inset + progressWidth - thumbSize / 2)
              .clamp(inset, inset + innerWidth - thumbSize);

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // 进度条（蓝色渐变）
              Positioned(
                left: inset,
                top: inset,
                width: progressWidth,
                height: innerHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2F80FF),
                        Color(0xFF38C9FF),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),

              // 进度头部图片
              Positioned(
                left: thumbLeft,
                top: (constraints.maxHeight - thumbSize) / 2,
                width: thumbSize,
                height: thumbSize,
                child: Image.asset(
                  Assets.imagesProgressBar,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
