import 'package:flutter/material.dart';

class GameContainerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color borderColor;
  final Widget? child;

  const GameContainerWidget(
      {super.key,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.child,
      this.borderColor = const Color(0xffE9E9E9)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     // color: Colors.white.withOpacity(0.25),
          //     // color: PageStyle.c_E6E8EF..withOpacity(0.25),
          //     spreadRadius: 0,
          //     blurRadius: 3,
          //     offset: const Offset(0, 0), // changes position of shadow
          //   ),
          // ]
          ),
      child: child,
    );
  }
}
