import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletInfoText extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Widget info;
  final bool isNextLine;
  final double? sizedBoxHeight;

  const WalletInfoText({
    super.key,
    required this.title,
    required this.info,
    this.isNextLine = false,
    this.titleColor,
    this.sizedBoxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveTitleColor = titleColor ?? appnewColors.text2;

    // 检查title是否是英文，如果是英文，则替换使用英文的冒号，如果是中文，则替换使用中文的冒号。
    String displayTitle;
    if (RegExp(r'^[a-zA-Z]+$').hasMatch(title)) {
      displayTitle = title.replaceAll('：', ':');
    } else {
      displayTitle = title.replaceAll(':', '：');
    }

    if (isNextLine) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayTitle,
            style: TextStyle(
              color: effectiveTitleColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: sizedBoxHeight ?? 10.h),
          info,
        ],
      );
    }

    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                displayTitle,
                style: TextStyle(
                  color: effectiveTitleColor,
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight, // 👉 第二列靠右
              child: info,
            ),
          ],
        ),
      ],
    );
  }
}