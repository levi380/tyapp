// lib/custom_date_picker.dart (颜色渐变版)

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/export.dart';

// 枚举保持不变
enum CustomerDatePickerMode {
  year,
  yearMonth,
  yearMonthDay,
}

class CustomDatePicker extends StatefulWidget {
  // ... 构造函数和属性不变 ...
  const CustomDatePicker(
      {super.key,
      required this.mode,
      required this.initialDate,
      required this.maxDate,
      this.onChange});

  final CustomerDatePickerMode mode;
  final DateTime initialDate;
  final DateTime maxDate;
  final void Function(DateTime date)? onChange;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  // ... initState 和所有逻辑函数都保持不变 ...
  late List<int> _years;
  late List<int> _months;
  late List<int> _days;
  late int _selectedYearIndex;
  late int _selectedMonthIndex;
  late int _selectedDayIndex;
  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;

  @override
  void initState() {
    super.initState();

    _updateYears();
    _selectedYearIndex = _years.indexOf(widget.initialDate.year);
    if (_selectedYearIndex == -1) _selectedYearIndex = _years.length - 1;

    _updateMonths();
    _selectedMonthIndex = _months.indexOf(widget.initialDate.month);
    if (_selectedMonthIndex == -1) _selectedMonthIndex = _months.length - 1;

    _updateDays();
    _selectedDayIndex = _days.indexOf(widget.initialDate.day);
    if (_selectedDayIndex == -1) _selectedDayIndex = _days.length - 1;

    _yearController =
        FixedExtentScrollController(initialItem: _selectedYearIndex);
    _monthController =
        FixedExtentScrollController(initialItem: _selectedMonthIndex);
    _dayController =
        FixedExtentScrollController(initialItem: _selectedDayIndex);
  }

  void _updateYears() {
    // 从1950年到当前时间的18年前
    int startYear = 1950;
    DateTime now = DateTime.now();
    // 精确计算18年前的日期
    DateTime eighteenYearsAgo = DateTime(now.year - 18, now.month, now.day);
    int endYear = eighteenYearsAgo.year;

    // 如果widget.maxDate指定的年份更早，则使用更早的年份
    if (widget.maxDate.year < endYear) {
      endYear = widget.maxDate.year;
    }

    int yearCount = endYear - startYear + 1;
    _years = List.generate(yearCount, (index) => startYear + index);
  }

  void _updateMonths() {
    int currentYear = _years[_selectedYearIndex];

    // 精确计算18年前的日期
    DateTime now = DateTime.now();
    DateTime eighteenYearsAgo = DateTime(now.year - 18, now.month, now.day);

    // 如果当前选择的年份是18年前的年份，需要限制月份
    if (currentYear == eighteenYearsAgo.year) {
      _months = List.generate(eighteenYearsAgo.month, (index) => index + 1);
    } else if (currentYear == widget.maxDate.year) {
      // 如果当前年份是widget.maxDate指定的年份
      _months = List.generate(widget.maxDate.month, (index) => index + 1);
    } else {
      // 其他年份显示全部12个月
      _months = List.generate(12, (index) => index + 1);
    }
  }

  void _updateDays() {
    int currentYear = _years[_selectedYearIndex];
    if (_selectedMonthIndex >= _months.length) {
      _selectedMonthIndex = _months.length - 1;
    }
    int currentMonth = _months[_selectedMonthIndex];
    int daysInMonth = DateTime(currentYear, currentMonth + 1, 0).day;

    // 精确计算18年前的日期
    DateTime now = DateTime.now();
    DateTime eighteenYearsAgo = DateTime(now.year - 18, now.month, now.day);

    // 如果当前选择的年月是18年前的年月，需要限制日期
    if (currentYear == eighteenYearsAgo.year &&
        currentMonth == eighteenYearsAgo.month) {
      daysInMonth = eighteenYearsAgo.day;
    } else if (currentYear == widget.maxDate.year &&
        currentMonth == widget.maxDate.month) {
      // 如果当前年月是widget.maxDate指定的年月
      daysInMonth = widget.maxDate.day;
    }

    _days = List.generate(daysInMonth, (index) => index + 1);
  }

  @override
  Widget build(BuildContext context) {
    // ... build 方法不变 ...
    double itemHeight = 30.w;
    return Container(
      height: 180.w,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: itemHeight,
                  margin: EdgeInsets.symmetric(horizontal: 16.0.w),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                ),
                _buildPickers(itemHeight),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickers(double itemHeight) {
    // ... _buildPickers 方法不变 ...
    List<Widget> pickers = [];
    pickers.add(_buildPicker(
      itemHeight: itemHeight,
      controller: _yearController,
      data: _years,
      unitStr: "year".tr,
      selectedIndex: _selectedYearIndex,
      onChanged: (index) {
        setState(() {
          _selectedYearIndex = index;
          _updateMonths();
          _selectedMonthIndex = min(_selectedMonthIndex, _months.length - 1);
          _updateDays();
          _selectedDayIndex = min(_selectedDayIndex, _days.length - 1);
        });

        widget.onChange?.call(DateTime(
          _years[_selectedYearIndex],
          _months.isNotEmpty ? _months[_selectedMonthIndex] : 1,
          _days.isNotEmpty ? _days[_selectedDayIndex] : 1,
        ));
      },
    ));
    if (widget.mode == CustomerDatePickerMode.yearMonth ||
        widget.mode == CustomerDatePickerMode.yearMonthDay) {
      pickers.add(_buildPicker(
        itemHeight: itemHeight,
        controller: _monthController,
        data: _months,
        unitStr: "month".tr,
        selectedIndex: _selectedMonthIndex,
        onChanged: (index) {
          setState(() {
            _selectedMonthIndex = index;
            _updateDays();
            _selectedDayIndex = min(_selectedDayIndex, _days.length - 1);
          });
          widget.onChange?.call(DateTime(
            _years[_selectedYearIndex],
            _months.isNotEmpty ? _months[_selectedMonthIndex] : 1,
            _days.isNotEmpty ? _days[_selectedDayIndex] : 1,
          ));
        },
        isMonth: true,
      ));
    }
    if (widget.mode == CustomerDatePickerMode.yearMonthDay) {
      pickers.add(_buildPicker(
        itemHeight: itemHeight,
        controller: _dayController,
        data: _days,
        unitStr: "ontherday".tr,
        selectedIndex: _selectedDayIndex,
        onChanged: (index) {
          setState(() {
            _selectedDayIndex = index;
          });

          widget.onChange?.call(DateTime(
            _years[_selectedYearIndex],
            _months.isNotEmpty ? _months[_selectedMonthIndex] : 1,
            _days.isNotEmpty ? _days[_selectedDayIndex] : 1,
          ));
        },
      ));
    }
    return Row(children: pickers);
  }

  // <<< 主要修改在这里：根据与选中项的距离来决定样式
  Widget _buildPicker({
    required double itemHeight,
    required FixedExtentScrollController controller,
    required List<int> data,
    required int selectedIndex,
    required ValueChanged<int> onChanged,
    required String unitStr,
    bool isMonth = false,
  }) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: itemHeight,
        onSelectedItemChanged: onChanged,
        diameterRatio: 1000,
        perspective: 0.0001,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: data.length,
          builder: (context, index) {
            final int distance = (index - selectedIndex).abs();
            Color textColor;
            FontWeight fontWeight = FontWeight.normal;

            // 根据距离设置不同的颜色和字重
            switch (distance) {
              case 0: // 选中的项目
                textColor = Colors.black;
                break;
              case 1: // 相邻的项目
                textColor = Colors.grey[600]!;
                break;
              case 2: // 再远一点的项目
                textColor = Colors.grey[400]!;
                break;
              default: // 更远的项目
                textColor = Colors.grey[300]!;
                break;
            }

            final String text = isMonth
                ? data[index].toString().padLeft(2, '0')
                : data[index].toString();

            return Center(
              child: Text(
                "$text$unitStr",
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: fontWeight,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ... _buildHeader 和 dispose 方法保持不变 ...
  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }
}

// ... showCustomDatePicker 函数保持不变 ...
Future<DateTime?> showCustomDatePicker(
  BuildContext context, {
  CustomerDatePickerMode mode = CustomerDatePickerMode.yearMonth,
  required DateTime initialDate,
  DateTime? maxDate,
}) {
  // 精确计算18年前的日期作为默认最大日期
  DateTime now = DateTime.now();
  DateTime defaultMaxDate = DateTime(now.year - 18, now.month, now.day);

  return showModalBottomSheet<DateTime>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return CustomDatePicker(
        mode: mode,
        initialDate: initialDate,
        maxDate: maxDate ?? defaultMaxDate,
      );
    },
  );
}
