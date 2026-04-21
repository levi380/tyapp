import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/export.dart';

/// 可嵌入页面的年月日滚轮选择器，与CustomDatePicker逻辑一致，复用高亮逻辑和结构
/// date_picker_widget
class DatePickerWidget extends StatefulWidget {
  final DateTime initialDate;
  final DateTime? highlightDate;
  final ValueChanged<DateTime>? onConfirm;
  final double? pickerWidth;
  final double? pickerHeight;

  /// 最小可选日期，显示范围
  final DateTime? minDate;

  /// 最大可选日期，显示范围
  final DateTime? maxDate;

  /// 最小限制日期，回滚限制
  final DateTime? limitMinDate;

  /// 最大限制日期，回滚限制
  final DateTime? limitMaxDate;

  /// 是否启用minDate/maxDate对年月日展示范围的限制，默认false
  final bool restrictToRange;

  const DatePickerWidget({
    Key? key,
    required this.initialDate,
    this.highlightDate,
    this.onConfirm,
    this.pickerWidth,
    this.pickerHeight,
    this.minDate,
    this.maxDate,
    this.limitMinDate,
    this.limitMaxDate,
    this.restrictToRange = false,
  }) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late int selectedYear;
  late int selectedMonth;
  late int selectedDay;

  FixedExtentScrollController? yearController;
  FixedExtentScrollController? monthController;
  FixedExtentScrollController? dayController;

  late int startYear;
  late int endYear;
  late double pickerWidth;
  late double pickerHeight;

  DateTime? _currentDate;

  @override
  void initState() {
    super.initState();
    pickerWidth = widget.pickerWidth ?? 212.w;
    pickerHeight = widget.pickerHeight ?? 49.w;
    _initDate(widget.initialDate);
  }

  @override
  void didUpdateWidget(covariant DatePickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialDate != oldWidget.initialDate) {
      // 销毁旧 controller
      yearController?.dispose();
      monthController?.dispose();
      dayController?.dispose();

      // 更新日期
      _initDate(widget.initialDate);

      // 创建新的 controller 并跳转到正确位置
      _initControllers();

      // 更新 UI（如果没有 setState 会不触发 rebuild）
      setState(() {});
    }
  }

  void _initControllers() {
    yearController =
        FixedExtentScrollController(initialItem: selectedYear - startYear);
    monthController =
        FixedExtentScrollController(initialItem: selectedMonth - 1);
    dayController = FixedExtentScrollController(initialItem: selectedDay - 1);
  }

  void _initDate(DateTime date) {
    final min = widget.minDate;
    final max = widget.maxDate;

    _currentDate = date;

    if (min != null && max != null && min.isAfter(max)) {
      startYear = 1975;
      endYear = 2100;
    } else {
      startYear = min?.year ?? 1975;
      endYear = max?.year ?? 2100;
    }

    DateTime adjustedDate = date;
    if (min != null && adjustedDate.isBefore(min)) {
      adjustedDate = min;
    } else if (max != null && adjustedDate.isAfter(max)) {
      adjustedDate = max;
    }

    selectedYear = adjustedDate.year;
    selectedMonth = adjustedDate.month;
    selectedDay = adjustedDate.day;

    // 初始化滚轮控制器，如果已存在则更新位置
    if (yearController == null) {
      yearController = FixedExtentScrollController();
    }
    if (monthController == null) {
      monthController = FixedExtentScrollController();
    }
    if (dayController == null) {
      dayController = FixedExtentScrollController();
    }

    Future.microtask(() {
      yearController?.jumpToItem(selectedYear - startYear);
      monthController?.jumpToItem(selectedMonth - 1);
      dayController?.jumpToItem(selectedDay - 1);
    });
  }

  @override
  void dispose() {
    yearController?.dispose();
    monthController?.dispose();
    dayController?.dispose();
    super.dispose();
  }

  int daysInMonth(int year, int month) {
    if (month == 12) {
      return DateTime(year + 1, 1, 0).day;
    }
    return DateTime(year, month + 1, 0).day;
  }

  void _onSelected() {
    final date = DateTime(selectedYear, selectedMonth, selectedDay);
    if (widget.limitMinDate != null && date.isBefore(widget.limitMinDate!)) {
      final limited = widget.limitMinDate!;
      selectedYear = limited.year;
      selectedMonth = limited.month;
      selectedDay = limited.day;
      yearController!.animateToItem(selectedYear - startYear,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      monthController!.animateToItem(selectedMonth - 1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      dayController!.animateToItem(selectedDay - 1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      return;
    }
    if (widget.limitMaxDate != null && date.isAfter(widget.limitMaxDate!)) {
      final limited = widget.limitMaxDate!;
      selectedYear = limited.year;
      selectedMonth = limited.month;
      selectedDay = limited.day;
      yearController!.animateToItem(selectedYear - startYear,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      monthController!.animateToItem(selectedMonth - 1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      dayController!.animateToItem(selectedDay - 1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      return;
    }
    widget.onConfirm?.call(date);
  }

  @override
  Widget build(BuildContext context) {
    // 高亮逻辑与CustomDatePicker一致
    final highlight = widget.highlightDate;
    final textStyle = TextStyle(fontSize: 10.sp, color: Color(0xFFBBBBBB));
    final selectedStyle = TextStyle(
        fontSize: 12.sp, color: Color(0xFF191C20), fontWeight: FontWeight.w400);

    print("$selectedYear $selectedMonth $selectedDay");
    // 兼容嵌入式使用，外部包裹宽度
    return SizedBox(
      height: pickerHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///年
          SizedBox(
            width: pickerWidth / 3,
            child: CupertinoPicker(
               key: ValueKey(yearController.hashCode),
              scrollController: yearController,
              itemExtent: pickerHeight / 3,
              onSelectedItemChanged: (idx) {
                setState(() {
                  selectedYear = startYear + idx;
                  final maxDay = daysInMonth(selectedYear, selectedMonth);
                  if (selectedDay > maxDay) {
                    selectedDay = maxDay;
                    dayController!.jumpToItem(selectedDay - 1);
                  }
                  _onSelected();
                });
              },
              children: List.generate(
                endYear - startYear + 1,
                (i) {
                  int year = startYear + i;
                  bool isHighlight =
                      highlight != null && year == highlight.year;
                  return Center(
                    child: Text(
                      '$year年',
                      style: (year == selectedYear)
                          ? selectedStyle
                          : (isHighlight
                              ? selectedStyle.copyWith(color: Colors.red)
                              : textStyle),
                    ),
                  );
                },
              ),
            ),
          ),

          ///月
          SizedBox(
            width: pickerWidth / 3,
            child: Builder(
              builder: (context) {
                final monthList = widget.restrictToRange
                    ? List.generate(
                        ((widget.maxDate != null &&
                                    selectedYear == widget.maxDate!.year
                                ? widget.maxDate!.month
                                : 12) -
                            (widget.minDate != null &&
                                    selectedYear == widget.minDate!.year
                                ? widget.minDate!.month
                                : 1) +
                            1),
                        (i) =>
                            (widget.minDate != null &&
                                    selectedYear == widget.minDate!.year
                                ? widget.minDate!.month
                                : 1) +
                            i,
                      )
                    : List.generate(12, (i) => i + 1);
                return CupertinoPicker(
                    key: ValueKey(monthController.hashCode),
                  scrollController: monthController,
                  itemExtent: pickerHeight / 3,
                  onSelectedItemChanged: (idx) {
                    setState(() {
                      selectedMonth = monthList[idx];
                      final maxDay = daysInMonth(selectedYear, selectedMonth);
                      if (selectedDay > maxDay) {
                        selectedDay = maxDay;
                        dayController!.jumpToItem(selectedDay - 1);
                      }
                      _onSelected();
                    });
                  },
                  children: monthList.map((m) {
                    bool isHighlight =
                        highlight != null && m == highlight.month;
                    return Center(
                      child: Text(
                        '$m月',
                        style: (m == selectedMonth)
                            ? selectedStyle
                            : (isHighlight
                                ? selectedStyle.copyWith(color: Colors.red)
                                : textStyle),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),

          ///日
          SizedBox(
            width: pickerWidth / 3,
            child: Builder(
              builder: (context) {
                final maxDayOfMonth = daysInMonth(selectedYear, selectedMonth);
                final dayList = widget.restrictToRange
                    ? List.generate(
                        ((widget.maxDate != null &&
                                    selectedYear == widget.maxDate!.year &&
                                    selectedMonth == widget.maxDate!.month
                                ? widget.maxDate!.day
                                : maxDayOfMonth) -
                            (widget.minDate != null &&
                                    selectedYear == widget.minDate!.year &&
                                    selectedMonth == widget.minDate!.month
                                ? widget.minDate!.day
                                : 1) +
                            1),
                        (i) =>
                            (widget.minDate != null &&
                                    selectedYear == widget.minDate!.year &&
                                    selectedMonth == widget.minDate!.month
                                ? widget.minDate!.day
                                : 1) +
                            i,
                      )
                    : List.generate(maxDayOfMonth, (i) => i + 1);
                return CupertinoPicker(
                     key: ValueKey(dayController.hashCode),
                  scrollController: dayController,
                  itemExtent: pickerHeight / 3,
                  onSelectedItemChanged: (idx) {
                    setState(() {
                      selectedDay = dayList[idx];
                      _onSelected();
                    });
                  },
                  children: dayList.map((d) {
                    bool isHighlight = highlight != null && d == highlight.day;
                    return Center(
                      child: Text(
                        '$d'+"ontherday".tr,
                        style: (d == selectedDay)
                            ? selectedStyle
                            : (isHighlight
                                ? selectedStyle.copyWith(color: Colors.red)
                                : textStyle),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
