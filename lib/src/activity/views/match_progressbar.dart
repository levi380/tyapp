import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchProgressBar extends StatelessWidget {
  /// 进度：0.0 ～ 1.0
  final double progress;

  /// 圆角
  final double radius;

  const MatchProgressBar({
    super.key,
    required this.progress,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: 10.w,
        width: double.infinity,
        color: Color(0xffDB6372),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: Color(0xff4C96FF),
                    borderRadius: BorderRadius.circular(radius),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
