import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BadgeTab extends StatelessWidget {
  final String text;
  final String? badgeText;
  final bool showDot;

  const BadgeTab({
    super.key,
    required this.text,
    this.badgeText,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Text(text),
        if (showDot || badgeText != null)
          Positioned(
            right: -18,
            top: -8,
            child: Container(
              padding: badgeText != null
                  ? const EdgeInsets.symmetric(horizontal: 5)
                  : EdgeInsets.zero,
              width: showDot ? 8 : null,
              height: showDot ? 8 : 16,
              constraints: const BoxConstraints(minWidth: 16),
              decoration: BoxDecoration(
                color: Color(0xFFFF7255),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: badgeText != null
                  ? Text(
                      badgeText!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    )
                  : null,
            ),
          ),
      ],
    );
  }
}
