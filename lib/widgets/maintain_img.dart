import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaintainImg extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  const MaintainImg({super.key, this.height, this.width, this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.maxFinite,
      height: height ?? double.maxFinite,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xff1D2534).withAlpha((0.8 * 255).toInt()),
          borderRadius: BorderRadius.circular(radius ?? 5.r)),
      child: Image.asset(
        'assets/images/game/maintain_icon.png',
        width: 31.r,
        height: 30.r,
        fit: BoxFit.fill,
      ),
    );
  }
}
