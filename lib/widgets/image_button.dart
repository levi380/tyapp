import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  const ImageButton(
      {super.key,
      required this.imgStrRes,
      this.imgHeight,
      this.imgWidth,
      this.onTap,
      this.alignment = Alignment.center,
      this.padding = EdgeInsets.zero,
      // this.isInk = true,
      this.width,
      this.height,
      this.package,
      this.color,
      this.fit = BoxFit.fill});
  final Function()? onTap;
  final double? imgWidth;
  final double? imgHeight;
  final String imgStrRes;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  // final bool isInk;
  final double? width;
  final double? height;
  final String? package;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        margin: padding,
        child: Image.asset(
          imgStrRes,
          width: imgWidth,
          height: imgHeight,
          alignment: alignment,
          package: package,
          color: color,
          fit: fit,
        ),
      ),
    );
  }
}
