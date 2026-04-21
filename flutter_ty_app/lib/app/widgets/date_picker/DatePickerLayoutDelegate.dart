
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
const double _kDatePickerPadSize = 12.0;

class DatePickerLayoutDelegate extends MultiChildLayoutDelegate {
 DatePickerLayoutDelegate({
    required this.columnWidths,
    required this.textDirectionFactor,
    required this.maxWidth,
  });

  // The list containing widths of all columns.
  final List<double> columnWidths;

  // textDirectionFactor is 1 if text is written left to right, and -1 if right to left.
  final int textDirectionFactor;

  // The max width the children should reach to avoid bending outwards.
  final double maxWidth;

 static double getColumnWidth(
     PickerColumnType columnType,
     CupertinoLocalizations localizations,
     BuildContext context,
     bool showDayOfWeek, {
       bool standaloneMonth = false,
     }) {
   String longestText = '';

   switch (columnType) {
     case PickerColumnType.date:
     // Measuring the length of all possible date is impossible, so here
     // just some dates are measured.
       for (int i = 1; i <= 12; i++) {
         // An arbitrary date.
         final String date =
         localizations.datePickerMediumDate(DateTime(2018, i, 25));
         if (longestText.length < date.length) {
           longestText = date;
         }
       }
     case PickerColumnType.hour:
       for (int i = 0; i < 24; i++) {
         final String hour = localizations.datePickerHour(i);
         if (longestText.length < hour.length) {
           longestText = hour;
         }
       }
     case PickerColumnType.minute:
       for (int i = 0; i < 60; i++) {
         final String minute = localizations.datePickerMinute(i);
         if (longestText.length < minute.length) {
           longestText = minute;
         }
       }
     case PickerColumnType.dayPeriod:
       longestText =
       localizations.anteMeridiemAbbreviation.length > localizations.postMeridiemAbbreviation.length
           ? localizations.anteMeridiemAbbreviation
           : localizations.postMeridiemAbbreviation;
     case PickerColumnType.dayOfMonth:
       int longestDayOfMonth = 1;
       for (int i = 1; i <=31; i++) {
         final String dayOfMonth = localizations.datePickerDayOfMonth(i);
         if (longestText.length < dayOfMonth.length) {
           longestText = dayOfMonth;
           longestDayOfMonth = i;
         }
       }
       if (showDayOfWeek) {
         for (int wd = 1; wd < DateTime.daysPerWeek; wd++) {
           final String dayOfMonth = localizations.datePickerDayOfMonth(longestDayOfMonth, wd);
           if (longestText.length < dayOfMonth.length) {
             longestText = dayOfMonth;
           }
         }
       }
     case PickerColumnType.month:
       for (int i = 1; i <= 12; i++) {
         final String month = standaloneMonth
             ? localizations.datePickerStandaloneMonth(i)
             : localizations.datePickerMonth(i);
         if (longestText.length < month.length) {
           longestText = month;
         }
       }
     case PickerColumnType.year:
       longestText = localizations.datePickerYear(2018);
   }

   assert(longestText != '', 'column type is not appropriate');

   return TextPainter.computeMaxIntrinsicWidth(
     text: TextSpan(
       style: themeTextStyle(context),
       text: longestText,
     ),
     textDirection: Directionality.of(context),
   );
 }
  @override
  void performLayout(Size size) {
    double remainingWidth = maxWidth < size.width ? maxWidth : size.width;

    double currentHorizontalOffset = (size.width - remainingWidth) / 2;

    for (int i = 0; i < columnWidths.length; i++) {
      remainingWidth -= columnWidths[i] + _kDatePickerPadSize * 2;
    }

    for (int i = 0; i < columnWidths.length; i++) {
      final int index = textDirectionFactor == 1 ? i : columnWidths.length - i - 1;

      double childWidth = columnWidths[index] + _kDatePickerPadSize * 2;
      if (index == 0 || index == columnWidths.length - 1) {
        childWidth += remainingWidth / 2;
      }

      // We can't actually assert here because it would break things badly for
      // semantics, which will expect that we laid things out here.
      assert(() {
        if (childWidth < 0) {
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: FlutterError(
                'Insufficient horizontal space to render the '
                    'CupertinoDatePicker because the parent is too narrow at '
                    '${size.width}px.\n'
                    'An additional ${-remainingWidth}px is needed to avoid '
                    'overlapping columns.',
              ),
            ),
          );
        }
        return true;
      }());
      layoutChild(index, BoxConstraints.tight(Size(math.max(0.0, childWidth), size.height)));
      positionChild(index, Offset(currentHorizontalOffset, 0.0));

      currentHorizontalOffset += childWidth;
    }
  }

  @override
  bool shouldRelayout(DatePickerLayoutDelegate oldDelegate) {
    return columnWidths != oldDelegate.columnWidths
        || textDirectionFactor != oldDelegate.textDirectionFactor;
  }

}

TextStyle themeTextStyle(BuildContext context, { bool isValid = true }) {
  final TextStyle style = CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle;
  return isValid
      ? style.copyWith(color: CupertinoDynamicColor.maybeResolve(style.color, context))
      : style.copyWith(color: CupertinoDynamicColor.resolve(inactiveGray, context));
}

/**单独定制*/
 CupertinoDynamicColor inactiveGray = CupertinoDynamicColor.withBrightness(
  debugLabel: 'inactiveGray',
  color: Color(0xFFffffff),
  darkColor:  Color(0xFF1E2029),
);


 void animateColumnControllerToItem(FixedExtentScrollController controller, int targetItem) {
  controller.animateToItem(
    targetItem,
    curve: Curves.easeInOut,
    duration: const Duration(milliseconds: 200),
  );
}
// Different types of column in CupertinoDatePicker.
 enum PickerColumnType {
  // Day of month column in date mode.
  dayOfMonth,
  // Month column in date mode.
  month,
  // Year column in date mode.
  year,
  // Medium date column in dateAndTime mode.
  date,
  // Hour column in time and dateAndTime mode.
  hour,
  // minute column in time and dateAndTime mode.
  minute,
  // AM/PM column in time and dateAndTime mode.
  dayPeriod,
}
enum CupertinoTimerPickerMode {
  hm,
  ms,
  hms,
}

