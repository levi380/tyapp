import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/widgets/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:get/get.dart';

enum FilterType {
  ///币种
  currency,

  ///场馆类型
  game,

  ///状态
  status,

  ///交易类型--有二级分类
  transaction,

  ///日期
  date,

  ///红利--有二级分类
  welfare,

  ///交易类型子级 -存款
  tradeDeposit,

  ///交易类型子级 -取款
  tradeWithdrawal,

  ///交易类型子级 -场馆游戏
  tradeGame,

  ///交易类型子级 -返水
  tradeRebate,

  ///交易类型子级 -活动
  tradeActivity,

  ///交易类型子级 -调整
  tradeAdjust,

  ///红利子级 -返水
  welfareRebate,

  ///红利子级 -活动
  welfareActivity;
}

class FilterModel {
  ///里面筛选列表头部标题
  final String title;

  ///1级分类
  List<SubFilterModel>? list;

  ///类型 1/2级 用作判断
  FilterType type;

  ///点击确认按钮后的模型
  SubFilterModel currentModel;

  ///选中的模型 但是未点确定按钮
  SubFilterModel? selectModel;
  int selectIndex;
  FilterModel({
    required this.type,
    required this.title,
    required this.currentModel,
    this.selectModel,
    this.list,
    this.selectIndex = 0,
  });
}

class SubFilterModel {
  ///筛选显示的名称 ?? name 为空则显示name 用于'全部' 显示成'全部类型'
  final String? showName;

  ///名称
  String name;

  ///值 传递给后台的
  String value;

  ///子级
  final FilterModel? filterModel; //子级
  SubFilterModel(
      {required this.name,
      required this.value,
      this.filterModel,
      this.showName});
}

class PopupDrawerFilter {
  final VoidCallback? onDismiss;
  final VoidCallback? onShow;
  final ValueChanged<FilterModel>? onChanged;

  final ValueChanged<({String start, String end})>? daatonChanged;
  OverlayEntry? _entry;
  BuildContext context;
  bool? isShowDate;

  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late final TickerProvider _tickerProvider;

//  late final List _tickerProvider;
  bool _isShow = false;
  bool get isShow => _isShow;

  PopupDrawerFilter({
    required this.context,
    required TickerProvider vsync,
    this.onDismiss,
    this.daatonChanged,
    this.onShow,
    this.onChanged,
    this.isShowDate = false,
  }) {
    _tickerProvider = vsync;
    _animationController = AnimationController(
      vsync: _tickerProvider,
      duration: const Duration(milliseconds: 400),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
  }
  void show(
      {required FilterModel filterModel,
      Rect? rect,
      GlobalKey? widgetKey,
      double? bottom}) {
    assert(
      rect != null || widgetKey != null,
      "尺寸和key不能同时为空",
    );
    final attachRect = rect ?? getWidgetGlobalRect(widgetKey!);

    // print('!!!!!!!${attachRect}');
    _entry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(builder: (context, setState) {
            ///看是否有二级分类 并且选中的模型里面是否有二级分类数组
            FilterModel? secondFilterModel;
            if (filterModel.list != null &&
                filterModel.selectModel?.filterModel != null) {
              secondFilterModel = filterModel.selectModel?.filterModel;
            }
            return Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    closePopup(filterModel);
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(top: attachRect.bottom + (bottom ?? 0)),
                    color: Colors.black.withValues(alpha: 0.1),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: attachRect.bottom + (bottom ?? 0),
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: _animation.value,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      width: 1.sw,
                      padding: EdgeInsets.only(
                          left: 10.w, right: 10.w, bottom: 10.h),
                      constraints: BoxConstraints(
                        maxHeight: 1.sh -
                            (attachRect.bottom +
                                (bottom ?? 0) +
                                60.h), // 控制最大弹窗高度
                      ),
                      decoration: BoxDecoration(
                        color: appColors.bgColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.r),
                          bottomRight: Radius.circular(10.r),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 14.w, right: 13.w, bottom: 20.h),
                        decoration: BoxDecoration(
                          color: appColors.filterBgColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildFilterListWidget(
                                  filterModel: filterModel,
                                  setState: setState,
                                  isShowDate: isShowDate ?? false),

                              ///时间筛选显示日期选择滚轮

                              if (isShowDate == true &&
                                  filterModel.type == FilterType.date)
                                // _buildDatePickerWidget(filterModel),
                                DateRangePickerWidget(
                                  filterModel: filterModel,
                                  onChange: (type) {
                                    setState(() {});
                                  },
                                ),

                              ///如果是交易类型有二级分类
                              if (filterModel.list != null &&
                                  secondFilterModel != null)
                                _buildFilterListWidget(
                                    isLevelOne: false,
                                    isShowDate: isShowDate ?? false,
                                    filterModel: secondFilterModel,
                                    setState: setState),

                              ///按钮 交易类型有重置按钮
                              _buildButtonWidget(
                                  filterModel: filterModel,
                                  isShowReset:
                                      filterModel.selectModel?.filterModel !=
                                          null,
                                  setState: setState),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );

    Overlay.of(context).insert(_entry!);
    _isShow = true;
    onShow?.call();
    _animationController.forward();
  }

  ///分类列表
  Widget _buildFilterListWidget(
      {required FilterModel filterModel,
      required StateSetter setState,
      required bool isShowDate,
      bool isLevelOne = true}) {
    int row = 3;
    if (filterModel.type == FilterType.date) {
      row = 4;
    }
    int length = filterModel.list?.length ?? 0;
    if (filterModel.type == FilterType.date) {
      if (isShowDate == true) {
        length = length - 1;
      }
    }

    double itemWidth = (1.sw - 24.w - 23.w - 20.w * (row - 1)) / row;
    double itemHeight = 30.h;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 37.h,
          child: Text(
            maxLines: 2,
            textAlign: TextAlign.center,
            filterModel.title,
            style: appColors.textSecondStyle_12,
          ),
        ),
        Container(
          child: Wrap(
            spacing: 20.w, //横向
            runSpacing: 10.h, //纵向
            alignment: WrapAlignment.start,
            children: List.generate(
              length,
              (index) {
                SubFilterModel? subFilterModel = filterModel.list?[index];
                bool isActive =
                    (subFilterModel?.value == filterModel.selectModel?.value);
                return GestureDetector(
                  onTap: () {
                    if (filterModel.list != null) {
                      setState(() {
                        for (SubFilterModel tempSubFilterModel
                            in (filterModel.list ?? [])) {
                          tempSubFilterModel.filterModel?.selectModel =
                              tempSubFilterModel.filterModel?.currentModel;
                        }
                        if (isLevelOne) {}
                        filterModel.selectIndex = index;
                        filterModel.selectModel = filterModel.list![index];
                        print(
                            '!!!!${filterModel.selectModel?.name}---${index}');
                      });
                    }
                  },
                  child: Container(
                    width: itemWidth,
                    height: itemHeight,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isActive ? appColors.mainColor : appColors.white,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      subFilterModel?.name ?? '',
                      style: isActive
                          ? appColors.textWhiteStyle_12_500
                          : appColors.textSecond2Style_12_500,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonWidget(
      {required FilterModel filterModel,
      bool isShowReset = false,
      required StateSetter setState}) {
    if (isShowReset) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBtnWidget(
            title: 'reset'.tr,
            isActive: false,
            callBack: () {
              setState(() {
                ///重置到点击确认按钮之前
                filterModel.selectModel = filterModel.currentModel;
              });
            },
          ),
          SizedBox(width: 20.w),
          _buildBtnWidget(
            title: 'confirm'.tr,
            isActive: true,
            callBack: () {
              if (filterModel.selectModel != null) {
                if (filterModel.list != null) {
                  for (var i = 0; i < (filterModel.list ?? []).length; i++) {
                    SubFilterModel tempSubFilterModel = filterModel.list![i];
                    if (i != filterModel.selectIndex) {
                      tempSubFilterModel.filterModel?.selectModel =
                          filterModel.list![0];
                      tempSubFilterModel.filterModel?.currentModel =
                          filterModel.list![0];
                      //        (tempSubFilterModel.filterModel?.currentModel)!;
                    } else {
                      tempSubFilterModel.filterModel?.currentModel =
                          (tempSubFilterModel.filterModel?.selectModel)!;
                    }
                  }
                  filterModel.currentModel = filterModel.selectModel!;
                }
                if (onChanged != null) {
                  onChanged!(filterModel);
                }
                dismiss();
              }
            },
          ),
        ],
      );
    } else {
      return _buildBtnWidget(
        title: 'confirm'.tr,
        isActive: true,
        callBack: () {
          if (filterModel.selectModel != null) {
            filterModel.currentModel = filterModel.selectModel!;
          }
          if (onChanged != null) {
            onChanged!(filterModel);
          }
          dismiss();
        },
      );
    }
  }

//   /// 起止日期选择组件
// Widget _buildDatePickerWidget(FilterModel filterModel) {
//   final nowDate = DateTime.now();
//   final limitMinDate = nowDate.subtract(Duration(days: 60));

//   DateTime? selectedStartDate;
//   DateTime? selectedEndDate;

//   return Container(
//     margin: EdgeInsets.only(top: 10.h),
//     padding: EdgeInsets.only(left: 12.w, top: 4.h, bottom: 4.h, right: 6.w),
//     decoration: BoxDecoration(
//       color: appColors.white,
//       borderRadius: BorderRadius.circular(8.r),
//     ),
//     child: Row(
//       children: [
//         /// 起止标题
//         Container(
//           width: 38.w,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(height: 6.h),
//               Text('起', style: appColors.textSecondStyle_12),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 15.h),
//                 child: Image.asset(
//                   Assets.popupDottedLine,
//                   width: 2.w,
//                   height: 34,
//                 ),
//               ),
//               Text('止', style: appColors.textSecondStyle_12),
//               SizedBox(height: 6.h),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Column(
//             children: [
//               // 开始日期选择器
//               DatePickerWidget(
//                 pickerWidth: 1.sw - 40.w - 85.w,
//                 pickerHeight: 60.h,
//                 initialDate: nowDate,
//                 maxDate: nowDate,
//                 limitMinDate: limitMinDate,
//                 limitMaxDate: nowDate,
//                 onConfirm: (date) {
//                   if (selectedEndDate != null && date.isAfter(selectedEndDate!)) {
//                     print("❌ 开始日期不能晚于结束日期");
//                     // 可弹 Toast 或提示框
//                     return;
//                   }

//                   selectedStartDate = date;
//                   final startStr = formatDateTimeToString(date);
//                   final endStr = selectedEndDate != null
//                       ? formatDateTimeToString(selectedEndDate!)
//                       : formatDateTimeToString(nowDate);

//                   filterModel.selectModel = SubFilterModel(
//                     name: "",
//                     value: "",
//                     start: startStr,
//                     end: endStr,
//                   );

//                   print('✅ 起始时间设置成功: $startStr');
//                 },
//               ),
//               // 分割线
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 4.h),
//                 width: 1.sw,
//                 height: 1.h,
//                 color: Color(0xFFEEEEEE),
//               ),
//               // 结束日期选择器
//               DatePickerWidget(
//                 pickerWidth: 1.sw - 40.w - 85.w,
//                 pickerHeight: 60.h,
//                 initialDate: nowDate,
//                 maxDate: nowDate,
//                 limitMinDate: limitMinDate,
//                 limitMaxDate: nowDate,
//                 onConfirm: (date) {
//                   if (selectedStartDate != null && date.isBefore(selectedStartDate!)) {
//                     print("❌ 结束日期不能早于开始日期");
//                     return;
//                   }

//                   selectedEndDate = date;
//                   final startStr = selectedStartDate != null
//                       ? formatDateTimeToString(selectedStartDate!)
//                       : formatDateTimeToString(nowDate);
//                   final endStr = formatDateTimeToString(date);

//                   filterModel.selectModel = SubFilterModel(
//                     name: "",
//                     value: "",
//                     start: startStr,
//                     end: endStr,
//                   );

//                   print('✅ 截止时间设置成功: $endStr');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

  ///按钮
  Widget _buildBtnWidget(
      {String title = 'confirm',
      bool isActive = false,
      double? top,
      VoidCallback? callBack}) {
        title= title.tr;
    return GestureDetector(
      onTap: () {
        if (callBack != null) {
          callBack.call();
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: top ?? 20.h),
        width: 96.w,
        height: 30.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? appColors.mainColor : appColors.white,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          title,
          style: isActive
              ? appColors.textWhiteStyle_12_500
              : appColors.textSecond2Style_12_500,
        ),
      ),
    );
  }

  ///关闭弹窗不恢复选择状态
  void closePopup(FilterModel filterModel) {
    if (!_isShow) return;
    if (filterModel.selectModel != null) {
      if (filterModel.list != null) {
        for (SubFilterModel tempSubFilterModel in (filterModel.list ?? [])) {
          tempSubFilterModel.filterModel?.selectModel =
              (tempSubFilterModel.filterModel?.currentModel)!;
        }
      }
      filterModel.selectModel = filterModel.currentModel;
    }
    dismiss();
  }

  ///销毁关闭页面
  void dismiss() {
    if (!_isShow) return;
    _isShow = false; // Prevent reentrancy
    _animationController.reverse().then((_) {
      if (_entry != null) {
        _entry!.remove();
        _entry = null;
      }
      onDismiss?.call();
    });
  }

  void dispose() {
    if (!_isShow && _entry == null) {
      _animationController.dispose();
      return;
    }
    _isShow = false;
    _animationController.dispose();
    if (_entry != null) {
      _entry!.remove();
      _entry = null;
    }
    onDismiss?.call();
  }

  ///获取绑定key控件的位置
  Rect getWidgetGlobalRect(GlobalKey key) {
    assert(key.currentContext != null, '');

    RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  /// 计算布局位置 根据 contentWidth contentHeight
//Size _screenSize = window.physicalSize / window.devicePixelRatio;
  //  LayoutP layoutp = _calculateOffset(
//       context,
//       attachRect,
//       200,
//       200,
//     );
  // LayoutP _calculateOffset(
  //     BuildContext context,
  //     Rect attachRect,
  //     double contentWidth,
  //     double contentHeight,
  //     ) {
  //   double dx = attachRect.left + attachRect.width / 2.0 - contentWidth / 2.0;
  //   if (dx < 10.0) {
  //     dx = 10.0;
  //   }
  //
  //   if (dx + contentWidth > _screenSize.width && dx > 10.0) {
  //     double tempDx = _screenSize.width - contentWidth - 10;
  //     if (tempDx > 10) {
  //       dx = tempDx;
  //     }
  //   }
  //
  //   double dy = attachRect.top - contentHeight;
  //   bool isDown = false;
  //   if (dy <= MediaQuery.of(context).padding.top + 10) {
  //     // The have not enough space above, show menu under the widget.
  //     dy = attachRect.height + attachRect.top;
  //     isDown = false;
  //   } else {
  //     isDown = true;
  //   }
  //
  //   return LayoutP(
  //     width: contentWidth,
  //     height: contentHeight,
  //     attachRect: attachRect,
  //     offset: Offset(dx, dy),
  //     isDown: isDown,
  //   );
  // }
}

class DateRangePickerWidget extends StatefulWidget {
  final FilterModel filterModel;
  final void Function(int? type)? onChange;
  const DateRangePickerWidget(
      {super.key, required this.filterModel, this.onChange});

  @override
  State<DateRangePickerWidget> createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  final now = DateTime.now();

  late final nowDate;
  late final endnowDate;
  late final DateTime limitMinDate;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    super.initState();
    nowDate = DateTime(now.year, now.month, now.day);
    limitMinDate = nowDate.subtract(Duration(days: 60));
    endnowDate = nowDate
        .add(const Duration(days: 1))
        .subtract(const Duration(milliseconds: 1));
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


bool isSameDayRange(DateTime aStart, DateTime aEnd, DateTime bStart, DateTime bEnd) {
  return isSameDay(aStart, bStart) && isSameDay(aEnd, bEnd);
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
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

  @override
  Widget build(BuildContext context) {
    if (widget.filterModel.selectIndex < 4) {
      final result = getQuickRangeDates(widget.filterModel.selectIndex);
      selectedStartDate = result['startDate'];
      selectedEndDate = result['endDate'];
    } else {
      List<String> parts = widget.filterModel.currentModel.value.split('/');
      if (parts.length == 2) {
        selectedStartDate = DateTime.parse(parts.first);
        selectedEndDate = DateTime.parse(parts.last);
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.only(left: 12.w, top: 4.h, bottom: 4.h, right: 6.w),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          /// 起止标题
          Container(
            width: 38.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 6.h),
                Text('start'.tr, style: appColors.textSecondStyle_12),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.h),
                  child: Image.asset(
                    Assets.popupDottedLine,
                    width: 2.w,
                    height: 34,
                  ),
                ),
                Text('end'.tr, style: appColors.textSecondStyle_12),
                SizedBox(height: 6.h),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                /// 开始日期选择器
                DatePickerWidget(
                  pickerWidth: 1.sw - 40.w - 85.w,
                  pickerHeight: 60.h,
                  initialDate: selectedStartDate ?? nowDate,
                  limitMinDate: limitMinDate,
                  limitMaxDate: selectedEndDate, // 限制最大为当前已选结束时间
                  onConfirm: (date) {
                    setState(() {
                      selectedStartDate = date;

                      final startStr = formatDateTimeToString(date);
                      final endStr = selectedEndDate != null
                          ? formatDateTimeToString(selectedEndDate!)
                          : formatDateTimeToString(nowDate);

                      final startnameStr = formatDatemmddToString(date);
                      final endnameStr = selectedEndDate != null
                          ? formatDatemmddToString(selectedEndDate!)
                          : formatDatemmddToString(nowDate);

                      final type = matchQuickRangeType(
                          selectedStartDate!, selectedEndDate!);

                      if (type != null) {
                        // 属于快捷选项之一
                        widget.filterModel.selectIndex = type;
                        widget.filterModel.selectModel =
                            widget.filterModel.list![type];
                        widget.onChange?.call(type);
                      } else {
                        widget.filterModel.selectIndex =
                            widget.filterModel.list!.length - 1;

                        widget.filterModel.list![widget.filterModel.selectIndex]
                            .value = startStr + "/" + endStr;
                        widget.filterModel.list![widget.filterModel.selectIndex]
                            .name = startnameStr + "-" + endnameStr;
                        widget.filterModel.selectModel = widget
                            .filterModel.list![widget.filterModel.selectIndex];
                      }
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.h),
                  width: 1.sw,
                  height: 1.h,
                  color: const Color(0xFFEEEEEE),
                ),

                /// 结束日期选择器
                DatePickerWidget(
                  pickerWidth: 1.sw - 40.w - 85.w,
                  pickerHeight: 60.h,
                  initialDate: selectedEndDate ?? endnowDate,
                  limitMinDate: selectedStartDate, // 限制最小为当前已选开始时间
                  limitMaxDate: nowDate,
                  onConfirm: (date) {
                    setState(() {
                      selectedEndDate = date
                          .add(const Duration(days: 1))
                          .subtract(const Duration(milliseconds: 1));

                      final startStr = selectedStartDate != null
                          ? formatDateTimeToString(selectedStartDate!)
                          : formatDateTimeToString(limitMinDate);
                      final endStr = formatDateTimeToString(selectedEndDate!);

                      final startnameStr = selectedStartDate != null
                          ? formatDatemmddToString(selectedStartDate!)
                          : formatDatemmddToString(limitMinDate);
                      final endnameStr =
                          formatDatemmddToString(selectedEndDate!);
                      final type = matchQuickRangeType(
                          selectedStartDate!, selectedEndDate!);
                      if (type != null) {
                        // 属于快捷选项之一
                        widget.filterModel.selectIndex = type;
                        widget.filterModel.selectModel =
                            widget.filterModel.list![type];
                        widget.onChange?.call(type);
                      } else {
                        widget.filterModel.selectIndex =
                            widget.filterModel.list!.length - 1;

                        widget.filterModel.list![widget.filterModel.selectIndex]
                            .value = startStr + "/" + endStr;
                        widget.filterModel.list![widget.filterModel.selectIndex]
                            .name = startnameStr + "-" + endnameStr;
                        widget.filterModel.selectModel = widget
                            .filterModel.list![widget.filterModel.selectIndex];
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
