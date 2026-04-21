import 'package:flutter/material.dart';

class GlowingIcon extends StatelessWidget {
  final double size;
  final Widget icon;
  final Color? glowColor;

  const GlowingIcon({
    super.key,
    required this.size,
    required this.icon,
    this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    Color outerGlowColor = glowColor ?? Color(0xFFBFE5FF);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Layer 1: The outermost, subtle glow effect
          // 第1层：最外层的微光效果
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: outerGlowColor,
            ),
          ),
          icon,
        ],
      ),
    );
  }
}
