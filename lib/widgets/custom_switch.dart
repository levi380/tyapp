import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final Widget? activeIcon;
  final Widget? inactiveIcon;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 45,
    this.height = 24,
    this.activeColor = const Color(0xFF4D95FE),
    this.inactiveColor = const Color(0xFFEAEAEE),
    this.thumbColor = Colors.white,
    this.activeIcon,
    this.inactiveIcon,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: widget.value ? widget.activeColor : widget.inactiveColor,
          borderRadius: BorderRadius.circular(widget.height / 2),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment:
                  widget.value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: widget.height - 6,
                height: widget.height - 6,
                decoration: BoxDecoration(
                  color: widget.thumbColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 9.r,
                        color: Colors.black.withAlpha(80)),
                  ],
                ),
                child: Container(
                  width: 20.r,
                  height: 20.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 9.r,
                          color: Colors.black.withAlpha(80)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
