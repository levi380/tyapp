import 'dart:async';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'filter_model.dart';
import 'custom_choice_chip.dart';
import 'package:get/get.dart';

enum PickerPosition {
  left,
  center,
  right,
}

typedef DateRangeChanged = void Function(
    FilterModel? value, List<DateTime> dateTimes);

class DateRangeBottomPicker extends StatefulWidget {
  final FilterModel filterModel;
  final DateRangeChanged onConfirm;
  final bool? isPrimary; // 自定义属性，默认 false
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  DateRangeBottomPicker({
    super.key,
    required this.filterModel,
    required this.onConfirm,
    this.selectedStartDate,
    this.selectedEndDate,
    this.isPrimary = true,
  });

  @override
  State<DateRangeBottomPicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangeBottomPicker> {
  late DateTime now;
  late DateTime minDate;
  late DateTime startDate;
  late DateTime endDate;

  List<int> years = [];
  List<int> months = [];
  List<int> days = [];

  bool isStartDateFocus = false;
  bool isEndDateFocus = false;

  // 保存当前选中的年份和月份（用于日期选择器回调）
  int _currentSelectedYear = 0;
  int _currentSelectedMonth = 0;

  // 为每个 picker 创建独立的 ScrollController
  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;

  // 用于防抖的 Timer
  Timer? _dayUpdateTimer;

  @override
  void initState() {
    super.initState();
    _initializeDates();

    // 动态生成年份、月份和日期
    years = _getYears();
    months = _getMonths(startDate.year);
    days = _getDays(startDate.year, startDate.month);

    // 初始化 ScrollController
    yearController = FixedExtentScrollController(
      initialItem:
          years.contains(startDate.year) ? years.indexOf(startDate.year) : 0,
    );
    monthController = FixedExtentScrollController(
      initialItem: months.contains(startDate.month)
          ? months.indexOf(startDate.month)
          : 0,
    );
    dayController = FixedExtentScrollController(
      initialItem:
          days.contains(startDate.day) ? days.indexOf(startDate.day) : 0,
    );

    // 初始化当前选中的年份和月份
    _currentSelectedYear = startDate.year;
    _currentSelectedMonth = startDate.month;
  }

  void _initializeDates() {
    now = DateTime.now();
    minDate = now.subtract(const Duration(days: 120));
    if (widget.selectedStartDate != null && widget.selectedEndDate != null) {
      startDate = widget.selectedStartDate!;
      endDate = widget.selectedEndDate!;
      isStartDateFocus = true;
    } else {
      // 默认选择今天
      startDate = DateTime(now.year, now.month, now.day);
      endDate = startDate;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dayUpdateTimer?.cancel();
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) => "${date.year}-${date.month}-${date.day}";

  // 构建日期选择按钮
  Widget _buildDateButton(
      DateTime date, bool isStartDate, ValueChanged<void> onTap) {
    final isSelected = isStartDate ? isStartDateFocus : isEndDateFocus;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(null),
        child: Column(
          children: [
            Text(
              _formatDate(date),
              style: TextStyle(
                color: isSelected ? appnewColors.bg : appnewColors.text3,
                fontSize: 16.sp,
              ),
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
    FixedExtentScrollController scrollController,
  ) {
    BorderRadius bs = BorderRadius.only();
    if (type == PickerPosition.left) {
      bs = BorderRadius.only(
        topLeft: Radius.circular(8), // 左上角
        bottomLeft: Radius.circular(8), // 左下角
      );
    } else if (type == PickerPosition.right) {
      bs = BorderRadius.only(
        topRight: Radius.circular(8), // 右上角
        bottomRight: Radius.circular(8), // 右下角
      );
    }
    return Expanded(
      child: CupertinoPicker(
        scrollController: scrollController,
        selectionOverlay: Container(
          decoration: BoxDecoration(
              borderRadius: bs,
              color: appnewColors.bg11.withOpacity(0.2) // 半透明背景
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

  // 同步 picker 位置到指定日期
  void _syncPickersToDate(DateTime date) {
    // 对于结束日期，需要提取日期部分（因为 endDate 包含结束时间）
    DateTime dateToSync =
        isEndDateFocus ? DateTime(date.year, date.month, date.day) : date;

    // 更新当前选中的年份和月份
    _currentSelectedYear = dateToSync.year;
    _currentSelectedMonth = dateToSync.month;

    // 更新年份列表（如果需要）
    years = _getYears();

    // 更新月份列表
    months = _getMonths(dateToSync.year);

    // 更新日期列表
    days = _getDays(dateToSync.year, dateToSync.month);

    // 更新 picker 位置
    int yearIndex = years.indexOf(dateToSync.year);
    if (yearIndex >= 0 && yearIndex < years.length) {
      yearController.jumpToItem(yearIndex);
    }

    int monthIndex = months.indexOf(dateToSync.month);
    if (monthIndex >= 0 && monthIndex < months.length) {
      monthController.jumpToItem(monthIndex);
    }

    int dayIndex = days.indexOf(dateToSync.day);
    if (dayIndex >= 0 && dayIndex < days.length) {
      dayController.jumpToItem(dayIndex);
    }
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

    if (isStartDateFocus) {
      startDate = startOfDay(newDate);
      // 如果结束日期早于新的开始日期，修正结束日期
      if (endDate.isBefore(startDate)) {
        endDate = startDate
            .add(const Duration(days: 1))
            .subtract(const Duration(milliseconds: 1));
      }
    } else if (isEndDateFocus) {
      // 创建新的结束日期（包含当天结束时间）
      // 直接使用传入的 year, month, day，不要使用被限制的 newDate
      DateTime targetDate = DateTime(year, month, day);

      // 确保不早于最小日期
      if (targetDate.isBefore(minDate)) {
        targetDate = minDate;
      }

      // 确保不晚于当前日期
      if (targetDate.isAfter(now)) {
        targetDate = now;
      }

      // 创建新的结束日期（包含当天结束时间）
      DateTime newEndDate = targetDate
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));

      // 确保结束日期不晚于当前日期
      if (newEndDate.isAfter(now)) {
        newEndDate = now;
      }

      // 如果结束日期早于开始日期，调整开始日期为结束日期减一天
      if (newEndDate.isBefore(startDate)) {
        DateTime newEndDateDay =
            DateTime(newEndDate.year, newEndDate.month, newEndDate.day);
        startDate = newEndDateDay.subtract(const Duration(days: 1));
        // 确保开始日期不早于最小日期
        if (startDate.isBefore(minDate)) {
          startDate = startOfDay(minDate);
        }
      }

      endDate = newEndDate;
      print('更新 endDate 前: $endDate'); // 调试信息
      print(
          '新的 endDate: $newEndDate, year=$year, month=$month, day=$day, targetDate=$targetDate'); // 调试信息
      print(
          '更新 endDate 后: $endDate, startDate: $startDate, isEndDateFocus: $isEndDateFocus'); // 调试信息
    }

    // 更新日期选择器的可用天数列表
    DateTime currentDate = isStartDateFocus ? startDate : endDate;
    setState(() {
      days = _getDays(currentDate.year, currentDate.month);
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
              children: widget.filterModel.list!.map((sub) {
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
                        isStartDateFocus = false;
                        isEndDateFocus = false;
                        widget.filterModel.selectModel = sub;
                        widget.filterModel.selectIndex =
                            widget.filterModel.list!.indexOf(sub);
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
                      isStartDateFocus = true;
                      isEndDateFocus = false;
                      // 更新 picker 显示为开始日期
                      _syncPickersToDate(startDate);
                    });
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "to".tr,
                      style:
                          TextStyle(color: appnewColors.text1, fontSize: 16.sp),
                    ),
                  ),
                  _buildDateButton(endDate, false, (_) {
                    setState(() {
                      isStartDateFocus = false;
                      isEndDateFocus = true;
                      // 更新 picker 显示为结束日期
                      _syncPickersToDate(endDate);
                    });
                  }),
                ],
              ),
            if (widget.isPrimary == true)
              // 自定义选择器
              Expanded(
                child: Row(
                  children: [
                    // 年份选择器
                    _buildCupertinoPicker<int>(
                      years,
                      isStartDateFocus ? startDate.year : endDate.year,
                      (year) => Text(
                        "$year${"year".tr}",
                        style: TextStyle(
                            fontSize: 20.sp, color: Color(0xff11183C)),
                      ),
                      PickerPosition.left,
                      (index) {
                        setState(() {
                          int newYear = years[index];
                          _currentSelectedYear = newYear; // 保存当前选中的年份
                          DateTime currentDate =
                              isStartDateFocus ? startDate : endDate;
                          // 对于结束日期，提取日期部分
                          if (isEndDateFocus) {
                            currentDate = DateTime(currentDate.year,
                                currentDate.month, currentDate.day);
                          }

                          // 更新月份列表以反映所选年份的有效月份范围
                          months = _getMonths(newYear);

                          // 确保月份有效
                          int validMonth = currentDate.month;
                          if (validMonth < months.first) {
                            validMonth = months.first;
                          } else if (validMonth > months.last) {
                            validMonth = months.last;
                          }

                          // 更新天数列表以反映所选年月的有效天数范围
                          days = _getDays(newYear, validMonth);

                          // 确保日期有效
                          int validDay = currentDate.day;

                          // 检查日期是否在新年月的有效范围内
                          if (validDay < days.first) {
                            validDay = days.first;
                          } else if (validDay > days.last) {
                            validDay = days.last;
                          }

                          // 先更新日期
                          _updateDateSelection(newYear, validMonth, validDay);

                          // 获取更新后的实际日期（因为 _updateDateSelection 可能会调整日期）
                          DateTime actualDate =
                              isStartDateFocus ? startDate : endDate;
                          // 对于结束日期，提取日期部分
                          if (isEndDateFocus) {
                            actualDate = DateTime(actualDate.year,
                                actualDate.month, actualDate.day);
                          }

                          // 如果日期被调整了，需要重新计算月份和日期
                          if (actualDate.year != newYear ||
                              actualDate.month != validMonth) {
                            months = _getMonths(actualDate.year);
                            days = _getDays(actualDate.year, actualDate.month);
                            validMonth = actualDate.month;
                            validDay = actualDate.day;
                          } else if (actualDate.day != validDay) {
                            days = _getDays(actualDate.year, actualDate.month);
                            validDay = actualDate.day;
                          }

                          // 更新月份 picker 的滚动位置
                          int monthIndex = months.indexOf(validMonth);
                          if (monthIndex >= 0 && monthIndex < months.length) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) {
                                monthController.jumpToItem(monthIndex);
                              }
                            });
                          }

                          // 更新日期 picker 的滚动位置
                          int dayIndex = days.indexOf(validDay);
                          if (dayIndex >= 0 && dayIndex < days.length) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) {
                                dayController.jumpToItem(dayIndex);
                              }
                            });
                          }
                        });
                      },
                      yearController,
                    ),
                    if (widget.isPrimary == true)
                      // 月份选择器
                      _buildCupertinoPicker<int>(
                        months,
                        isStartDateFocus ? startDate.month : endDate.month,
                        (month) => Text(
                          "$month${"month".tr}",
                          style: TextStyle(
                              fontSize: 20.sp, color: Color(0xff11183C)),
                        ),
                        PickerPosition.center,
                        (index) {
                          setState(() {
                            int newMonth = months[index];
                            _currentSelectedMonth = newMonth; // 保存当前选中的月份
                            DateTime currentDate =
                                isStartDateFocus ? startDate : endDate;
                            // 对于结束日期，提取日期部分
                            if (isEndDateFocus) {
                              currentDate = DateTime(currentDate.year,
                                  currentDate.month, currentDate.day);
                            }

                            // 更新月份并确保日期有效
                            int validDay = currentDate.day;

                            // 更新天数列表
                            days = _getDays(currentDate.year, newMonth);

                            // 检查日期是否在新月份的有效范围内
                            if (validDay < days.first) {
                              validDay = days.first;
                            } else if (validDay > days.last) {
                              validDay = days.last;
                            }

                            // 先更新日期
                            _updateDateSelection(
                                currentDate.year, newMonth, validDay);

                            // 获取更新后的实际日期
                            DateTime actualDate =
                                isStartDateFocus ? startDate : endDate;
                            if (isEndDateFocus) {
                              actualDate = DateTime(actualDate.year,
                                  actualDate.month, actualDate.day);
                            }

                            // 如果日期被调整了，重新计算
                            if (actualDate.day != validDay) {
                              days =
                                  _getDays(actualDate.year, actualDate.month);
                              validDay = actualDate.day;
                            }

                            // 更新日期 picker 的滚动位置
                            int dayIndex = days.indexOf(validDay);
                            if (dayIndex >= 0 && dayIndex < days.length) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (mounted) {
                                  dayController.jumpToItem(dayIndex);
                                }
                              });
                            }
                          });
                        },
                        monthController,
                      ),
                    if (widget.isPrimary == true)
                      // 日期选择器
                      Builder(
                        builder: (context) {
                          // 获取当前应该显示的日期
                          DateTime currentDisplayDate = isStartDateFocus
                              ? startDate
                              : DateTime(
                                  endDate.year, endDate.month, endDate.day);

                          // 确保日期在 days 列表中
                          int displayDay = currentDisplayDate.day;
                          if (!days.contains(displayDay)) {
                            if (days.isNotEmpty) {
                              displayDay = days.first;
                            }
                          }

                          return _buildCupertinoPicker<int>(
                            days,
                            displayDay,
                            (day) => Text(
                              "$day${"ontherday".tr}",
                              style: TextStyle(
                                  fontSize: 20.sp, color: Color(0xff11183C)),
                            ),
                            PickerPosition.right,
                            (index) {
                              // 取消之前的定时器
                              _dayUpdateTimer?.cancel();

                              // 立即更新
                              if (mounted &&
                                  index >= 0 &&
                                  index < days.length) {
                                int selectedDay = days[index];

                                // 使用保存的当前选中的年份和月份
                                int year = _currentSelectedYear;
                                int month = _currentSelectedMonth;

                                print(
                                    '日期选择器回调: index=$index, year=$year, month=$month, day=$selectedDay, isEndDateFocus=$isEndDateFocus'); // 调试信息
                                print('更新前 endDate: $endDate'); // 调试信息

                                setState(() {
                                  _updateDateSelection(
                                      year, month, selectedDay);
                                });

                                print('更新后 endDate: $endDate'); // 调试信息
                              }
                            },
                            dayController,
                          );
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
                            if (isStartDateFocus || isEndDateFocus) {
                              widget.onConfirm(null, [startDate, endDate]);
                            } else {
                              widget.onConfirm(
                                  widget.filterModel, [startDate, endDate]);
                            }
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
    final isSelected = widget.filterModel.selectModel?.value != null;
    if (isSelected) {
      return true;
    }
    if (widget.selectedEndDate != null && widget.selectedStartDate != null) {
      return true;
    }

    return false;
  }
}
