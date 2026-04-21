import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'filter_model.dart';
import 'custom_choice_chip.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:get/get.dart';

enum PickerPosition {
  left,
  center,
  right,
}

// 日期选择类型枚举
enum DateSelectType {
  none(-1), // 没有选中
  startDate(0), // 开始日期
  endDate(1); // 结束日期

  final int value;

  const DateSelectType(this.value);
}

// 快捷日期范围类型枚举
enum QuickDateRangeType {
  today(0), // 今日
  yesterday(1), // 昨日
  last7Days(2), // 近7日
  last30Days(3); // 近30日

  final int value;

  const QuickDateRangeType(this.value);
}

class DateRangePicker extends StatefulWidget {
  final FilterModel filterModel;
  final ValueChanged<FilterModel> onConfirm;
  final ValueChanged cancel;
  final bool? isPrimary; // 自定义属性，默认 false

  const DateRangePicker({
    Key? key,
    required this.filterModel,
    required this.onConfirm,
    required this.cancel,
    this.isPrimary = true,
  }) : super(key: key);

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  late DateTime now;
  late DateTime minDate;
  late DateTime startDate;
  late DateTime endDate;

  late SubFilterModel selectedModel;

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  // 使用枚举替代魔法数字
  DateSelectType selectType = DateSelectType.none;

  List<int> years = [];
  List<int> months = [];
  List<int> days = [];

  @override
  void initState() {
    super.initState();
    _initializeDates();
    _initializeSelectedModel();

    // 动态生成年份、月份和日期
    years = _getYears();

    months = _getMonths(startDate.year);
    days = _getDays(startDate.year, startDate.month);
  }

  void _initializeDates() {
    now = DateTime.now();
    minDate = now.subtract(const Duration(days: 60));
    // 默认选择今天
    startDate = DateTime(now.year, now.month, now.day);
    endDate = startDate;
  }

  void _initializeSelectedModel() {
    selectedModel =
        widget.filterModel.selectModel ?? widget.filterModel.currentModel;

    // 根据选择的索引更新日期范围
    if (widget.filterModel.selectIndex < 4) {
      updateDateRangeByType(widget.filterModel.selectIndex);
    } else {
      final dateParts = widget.filterModel.currentModel.value.split('/');
      if (dateParts.length == 2) {
        try {
          startDate = DateTime.parse(dateParts.first);
          endDate = DateTime.parse(dateParts.last);
          selectedStartDate = startDate;
          selectedEndDate = endDate;
          selectType = DateSelectType.startDate;
        } catch (e) {
          // 如果解析失败，保持当前日期
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 日期比较辅助方法
  bool isSameDayRange(
      DateTime aStart, DateTime aEnd, DateTime bStart, DateTime bEnd) {
    return isSameDay(aStart, bStart) && isSameDay(aEnd, bEnd);
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void updateDateRangeByType(int type) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (type) {
      case 0: // 今日
        startDate = today;
        endDate = today
            .add(const Duration(days: 1))
            .subtract(const Duration(milliseconds: 1));
        break;
      case 1: // 昨日
        startDate = today.subtract(const Duration(days: 1));
        endDate = today.subtract(const Duration(milliseconds: 1));
        break;
      case 2: // 近7日
        startDate = today.subtract(const Duration(days: 7));
        endDate = today
            .add(const Duration(days: 1))
            .subtract(const Duration(milliseconds: 1));
        break;
      case 3: // 近30日
        startDate = today.subtract(const Duration(days: 30));
        endDate = today
            .add(const Duration(days: 1))
            .subtract(const Duration(milliseconds: 1));
        break;
      default: // 默认近7日
        startDate = today.subtract(const Duration(days: 1));
        endDate = today
            .add(const Duration(days: 1))
            .subtract(const Duration(milliseconds: 1));
    }
  }

  String _formatDate(DateTime date) => "${date.year}-${date.month}-${date.day}";

  // 构建日期选择按钮
  Widget _buildDateButton(
      DateTime date, bool isStartDate, ValueChanged<void> onTap) {
    final isSelected = isStartDate
        ? selectType == DateSelectType.startDate
        : selectType == DateSelectType.endDate;
    final hasSelectedDate =
        isStartDate ? selectedStartDate != null : selectedEndDate != null;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(null),
        child: Column(
          children: [
            Text(
              _formatDate(date),
              style: TextStyle(
                  color: isSelected
                      ? appnewColors.bg
                      : hasSelectedDate
                          ? appnewColors.text1
                          : appnewColors.text3,
                  fontSize: 16.sp),
            ),
            Divider(
              thickness: 1,
              color: isSelected ? appnewColors.bg : appnewColors.text3,
            ),
          ],
        ),
      ),
    );
  }

  // 构建CupertinoPicker
  Widget _buildCupertinoPicker<T>(
    List<T> items,
    T initialValue,
    Widget Function(T) itemBuilder,
    PickerPosition type,
    ValueChanged<int> onSelectedItemChanged,
  ) {
    final initialIndex = items.indexOf(initialValue);

    BorderRadius bs = BorderRadius.only();
    if (type == PickerPosition.left) {
      bs = BorderRadius.only(
        topLeft: Radius.circular(8), // 左上角
        bottomLeft: Radius.circular(8), // 左下角
      );
    } else if (type == PickerPosition.right) {
      bs = BorderRadius.only(
        topRight: Radius.circular(8), // 左上角
        bottomRight: Radius.circular(8), // 左下角
      );
    }
    return Expanded(
      child: CupertinoPicker(
        // backgroundColor: appnewColors.bg, // 设置背景色
        scrollController: FixedExtentScrollController(
          initialItem: initialIndex >= 0 ? initialIndex : 0,
        ),

        selectionOverlay: Container(
          decoration: BoxDecoration(
              borderRadius: bs, color: appnewColors.bg11.withOpacity(0.2) // 半透明背景
              ),
        ),
        itemExtent: 30,
        onSelectedItemChanged: onSelectedItemChanged,
        children: items.map(itemBuilder).toList(),
      ),
    );
  }

  DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // 更新日期选择器状态
  void _updateDateSelection(int year, int month, int day) {
    // 确保日期在允许的范围内
    DateTime newDate = DateTime(year, month, day);

    // 确保不早于最小日期
    if (newDate.isBefore(minDate)) {
      newDate = minDate;
    }

    // 确保不晚于当前日期
    if (newDate.isAfter(now)) {
      newDate = now;
    }

    if (selectType == DateSelectType.startDate) {
      selectedStartDate = startOfDay(newDate);
      startDate = selectedStartDate!;

      // 如果结束日期早于新的开始日期，修正结束日期
      if (selectedEndDate != null && selectedEndDate!.isBefore(startDate)) {
        selectedEndDate = startDate;
        endDate = selectedEndDate!;
      }
    } else if (selectType == DateSelectType.endDate) {
      // 创建新的结束日期（包含当天结束时间）
      DateTime newEndDate = newDate
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));

      // 确保结束日期不早于开始日期
      if (newEndDate.isBefore(startDate)) {
        newEndDate = startDate
            .add(const Duration(days: 1))
            .subtract(const Duration(milliseconds: 1));
      }

      selectedEndDate = newEndDate;
      endDate = selectedEndDate!;
    }

    // 更新日期选择器的可用天数列表
    setState(() {
      days = _getDays(startDate.year, startDate.month);
    });
  }

  List<int> _getYears() {
    return List.generate(
      now.year - minDate.year + 1,
      (i) => minDate.year + i,
    );
  }

  List<int> _getMonths(int year) {
    int startMonth = (year == minDate.year) ? minDate.month : 1;
    int endMonth = (year == now.year) ? now.month : 12;
    return List.generate(endMonth - startMonth + 1, (i) => startMonth + i);
  }

  List<int> _getDays(int year, int month) {
    final lastDay = DateTime(year, month + 1, 0).day;
    int startDay = 1;
    int endDay = lastDay;

    // 限制开始
    if (year == minDate.year && month == minDate.month) {
      startDay = minDate.day;
    }
    // 限制结束
    if (year == now.year && month == now.month) {
      endDay = now.day;
    }

    return List.generate(endDay - startDay + 1, (i) => startDay + i);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isPrimary == true ? 489.w : 200.w,
      padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Padding(
              padding: EdgeInsets.only(bottom: 16.w),
              child: Text(
                "dateFilter".tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: appnewColors.textMain,
                ),
              ),
            ),

            // 快捷按钮（来自 filterModel.list）
            Wrap(
              spacing: 9,
              runSpacing: 9,
              children: widget.filterModel.list!
                  .where((sub) =>
                      sub.value == '1' ||
                      sub.value == '2' ||
                      sub.value == '7' ||
                      sub.value == '30') // 使用函数式编程过滤掉值为'5'的项
                  .map((sub) {
                final isSelected =
                    widget.filterModel.selectModel?.value == sub.value;

                return SizedBox(
                  width: (MediaQuery.of(context).size.width -
                          2 * 16.w -
                          2 * 9 -
                          10.w) /
                      4,
                  child: CustomChoiceChip(
                    label: sub.showName ?? sub.name,
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        widget.filterModel.selectModel = sub;
                        widget.filterModel.selectIndex =
                            widget.filterModel.list!.indexOf(sub);
                        updateDateRangeByType(widget.filterModel.selectIndex);
                        selectType = DateSelectType.none;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            if (widget.isPrimary == true)
              Padding(
                padding: EdgeInsets.only(bottom: 6.w, top: 10.w),
                child: Text(
                  "custom".tr,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: appnewColors.text1),
                ),
              ),
            //
            if (widget.isPrimary == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDateButton(startDate, true, (_) {
                    setState(() {
                      widget.filterModel.selectIndex = 4;
                      widget.filterModel.selectModel =
                          widget.filterModel.list!.last;
                      selectType = DateSelectType.startDate;
                      selectedStartDate = startDate;
                      selectedEndDate = endDate;
                    });
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text("to".tr,
                        style: TextStyle(
                            color: selectType == DateSelectType.none
                                ? appnewColors.text3
                                : appnewColors.text1,
                            fontSize: 16.sp)),
                  ),
                  _buildDateButton(endDate, false, (_) {
                    setState(() {
                      widget.filterModel.selectIndex = 4;
                      widget.filterModel.selectModel =
                          widget.filterModel.list!.last;
                      selectType = DateSelectType.endDate;
                      selectedStartDate = startDate;
                      selectedEndDate = endDate;
                    });
                  }),
                ],
              ),
            if (widget.isPrimary == true)
              // 提示
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  widget.filterModel.title,
                  style: TextStyle(fontSize: 10.sp, color: appnewColors.text3),
                ),
              ),
            if (widget.isPrimary == true)
              // 自定义选择器
              Expanded(
                child: Row(
                  children: [
                    // 年份选择器
                    _buildCupertinoPicker<int>(
                      years,
                      startDate.year,
                      (year) => Text(
                        "$year" + "year".tr,
                        style: TextStyle(
                            fontSize: 20.sp, color: Color(0xff11183C)),
                      ),
                      PickerPosition.left,
                      (index) {
                        setState(() {
                          int newYear = years[index];

                          // 更新月份列表以反映所选年份的有效月份范围
                          months = _getMonths(newYear);

                          // 确保月份有效
                          int validMonth = startDate.month;
                          if (validMonth < months.first) {
                            validMonth = months.first;
                          } else if (validMonth > months.last) {
                            validMonth = months.last;
                          }

                          // 更新天数列表以反映所选年月的有效天数范围
                          days = _getDays(newYear, validMonth);

                          // 确保日期有效
                          int validDay = startDate.day;
                          int maxDaysInMonth =
                              DateTime(newYear, validMonth + 1, 0).day;

                          if (validDay > maxDaysInMonth) {
                            validDay = maxDaysInMonth;
                          }

                          if (selectType != DateSelectType.none) {
                            _updateDateSelection(newYear, validMonth, validDay);
                          } else {
                            // 更新日期但不触发范围验证
                            startDate = DateTime(newYear, validMonth, validDay);
                            endDate = startDate;
                          }
                        });
                      },
                    ),
                    if (widget.isPrimary == true)
                      // 月份选择器
                      _buildCupertinoPicker<int>(
                        months,
                        startDate.month,
                        (month) => Text(
                          "$month" + "month".tr,
                          style: TextStyle(
                              fontSize: 20.sp, color: Color(0xff11183C)),
                        ),
                        PickerPosition.center,
                        (index) {
                          setState(() {
                            int newMonth = months[index];

                            // 更新月份并确保日期有效
                            int validDay = startDate.day;
                            int maxDaysInMonth =
                                DateTime(startDate.year, newMonth + 1, 0).day;

                            if (validDay > maxDaysInMonth) {
                              validDay = maxDaysInMonth;
                            }

                            if (selectType != DateSelectType.none) {
                              _updateDateSelection(
                                  startDate.year, newMonth, validDay);
                            }

                            // 更新天数列表
                            days = _getDays(startDate.year, newMonth);
                          });
                        },
                      ),
                    if (widget.isPrimary == true)
                      // 日期选择器
                      _buildCupertinoPicker<int>(
                        days,
                        startDate.day,
                        (day) => Text(
                          "$day" + "ontherday".tr,
                          style: TextStyle(
                              fontSize: 20.sp, color: Color(0xff11183C)),
                        ),
                        PickerPosition.right,
                        (index) {
                          setState(() {
                            int selectedDay = days[index];

                            if (selectType != DateSelectType.none) {
                              _updateDateSelection(
                                  startDate.year, startDate.month, selectedDay);
                            } else {
                              // 更新日期但不触发范围验证
                              startDate = DateTime(
                                  startDate.year, startDate.month, selectedDay);
                              endDate = startDate;
                            }
                          });
                        },
                      ),
                  ],
                ),
              ),

            /// 底部按钮
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: appnewColors.bg, width: 1), // 边框颜色和宽度
                      foregroundColor: appnewColors.bg, // 文字颜色
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // 圆角
                      ),
                      // 内边距
                    ),
                    onPressed: () {
                      widget.cancel;
                      Get.back();
                    },
                    child: Text(
                      "cancel".tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey; // 禁用时背景色
                        }
                        return appnewColors.bg; // 默认背景色
                      }),
                      foregroundColor:
                          MaterialStateProperty.all(appnewColors.text4), // 文字颜色
                    ),
                    onPressed: _isValid()
                        ? () {
                            if (selectType == DateSelectType.none) {
                              widget.filterModel.currentModel =
                                  widget.filterModel.selectModel!;
                              widget.onConfirm(widget.filterModel);
                            } else {
                              final startStr =
                                  formatDateTimeToString(selectedStartDate!);

                              final endStr =
                                  formatDateTimeToString(selectedEndDate!);

                              final startnameStr =
                                  formatDatemmddToString(selectedStartDate!);

                              final endnameStr =
                                  formatDatemmddToString(selectedEndDate!);
                              final type = matchQuickRangeType(
                                  selectedStartDate!, selectedEndDate!);
                              if (type != null) {
                                // 属于快捷选项之一
                                widget.filterModel.selectIndex = type;
                                widget.filterModel.currentModel =
                                    widget.filterModel.list![type];
                                widget.filterModel.selectModel =
                                    widget.filterModel.list![type];
                                widget.onConfirm(widget.filterModel);
                              } else {
                                widget.filterModel.selectIndex =
                                    widget.filterModel.list!.length - 1;

                                widget
                                    .filterModel
                                    .list![widget.filterModel.selectIndex]
                                    .value = startStr + "/" + endStr;
                                widget
                                    .filterModel
                                    .list![widget.filterModel.selectIndex]
                                    .name = startnameStr + "-" + endnameStr;
                                widget.filterModel.currentModel = widget
                                    .filterModel
                                    .list![widget.filterModel.selectIndex];

                                widget.filterModel.currentModel = widget
                                    .filterModel
                                    .list![widget.filterModel.selectIndex];
                                widget.onConfirm(widget.filterModel);
                              }
                            }
                            // 再次检查并修正日期范围

                            Get.back();
                          }
                        : null,
                    child: Text(
                      "confirm".tr,
                      style:
                          TextStyle(fontSize: 14.sp, color: appnewColors.text4),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).padding.bottom), // 底部安全区
          ],
        ),
      ),
    );
  }

  int? matchQuickRangeType(DateTime startDate, DateTime endDate) {
    for (int type = 0; type <= 3; type++) {
      final quickRange = getQuickRangeDates(type);
      final quickStart = quickRange['startDate']!;
      final quickEnd = quickRange['endDate']!;

      // 精确匹配到秒
      if (isSameDayRange(startDate, endDate, quickStart, quickEnd)) {
        return type;
      }
    }

    // 不匹配任何快捷项
    return null;
  }

  Map<String, DateTime?> getQuickRangeDates(int type) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    late DateTime? startDate;
    late DateTime? endDate;

    switch (type) {
      case 0: // 今日
        startDate = today;
        endDate = today
            .add(const Duration(days: 1))
            .subtract(const Duration(milliseconds: 1));
        break;
      case 1: // 昨日
        startDate = today.subtract(const Duration(days: 1));
        endDate = today.subtract(const Duration(milliseconds: 1));
        break;
      case 2: // 近7日
        startDate = today.subtract(const Duration(days: 7));
        endDate = today
            .add(const Duration(days: 1))
            .subtract(const Duration(milliseconds: 1));
        break;
      case 3: // 近30日
        startDate = today.subtract(const Duration(days: 30));
        endDate = today
            .add(const Duration(days: 1))
            .subtract(const Duration(milliseconds: 1));
        break;
      default: // 默认近7日
        startDate = today.subtract(const Duration(days: 1));
        endDate = today
            .add(const Duration(days: 1))
            .subtract(const Duration(milliseconds: 1));
    }

    return {
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  bool _isValid() {
    // 开始日期必须 >= 最小日期
    if (selectType == DateSelectType.none) {
      return true;
    }
    if (selectedEndDate != null && selectedStartDate != null) {
      return true;
    }

    return false;
  }
}
