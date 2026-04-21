
import 'package:flutter/material.dart';

class GroupBetSwitchButton extends StatelessWidget {
  const GroupBetSwitchButton({super.key, required this.currentIndex, required this.onToggle, required this.titles, required this.itemWidth, required this.borderRadius, required this.itemHeight});

  final double borderRadius;
  final int currentIndex;
  final double itemHeight;
  final double itemWidth;
  final Function(int) onToggle;
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F6),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: titles.map((e) {
          final index = titles.indexOf(e);
          return GestureDetector(
            onTap: () {
              onToggle(index);
            },
            child: Container(
              alignment: Alignment.center,
              width: itemWidth,
              decoration: BoxDecoration(
                color: currentIndex == index ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius - 2)
              ),
              child: Text(
                e,
                style: TextStyle(
                  color: currentIndex == index ? Color(0xFF179CFF) : Color(0xFF949AB6),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
