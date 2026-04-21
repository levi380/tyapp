import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/activity/controllers/match_betting_his_controller.dart';
import 'package:filbet/src/activity/model/promo_report_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/bottom_sheet/bottom_trade_dict.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/empty_view.dart';
import 'package:filbet/widgets/filter/date_range_bottom_picker.dart';
import 'package:filbet/widgets/filter/filterBar.dart';
import 'package:filbet/widgets/filter/filter_model.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///赛事竞猜活动记录
class MatchBettingHistory extends GetView<MatchBettingHisController> {
  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg4,
      appBar: CustomAppbar.normalTitle(
        bgColor: appnewColors.bg1,
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              child: Image.asset(
                Assets.activityMatchSearch,
                width: 15.w,
                height: 15.w,
              ),
            ),
            onTap: () {},
          )
        ],
        title: '竞猜记录',
      ),
      body: Column(
        children: [
          _buildSelectType(),
          // _buildTotalData(),
          // _buildFilterbar(),
          _buildFilterDate(),
          SizedBox(height: 12.h),
          Expanded(
            child: _buildListView(),
          )
        ],
      ),
    );
  }

  ///筛选tab
  Widget _buildSelectType() {
    return Container(
      decoration: BoxDecoration(
        color: appnewColors.bg1,
      ),
      padding: EdgeInsets.only(left: 20.w, bottom: 5.w),
      child: Obx(() => Row(
            children: [
              tabTypeItem(controller.typeStr.value, () {
                selectTypeDialog();
              }),
              SizedBox(
                width: 10.w,
              ),
              tabTypeItem(controller.dateList.last.name, () {
                selectTimeDialog();
              }),
              Expanded(child: SizedBox()),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(right: 15.w),
                  child: Row(
                    children: [
                      Text(
                        "筛选",
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset(
                        Assets.activityMatchArrow,
                        width: 8.w,
                        height: 4.w,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  selectTypeDialog();
                },
              )
            ],
          )),
    );
  }

  Widget tabTypeItem(String name, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
            color: Color(0xffF8F8FF),
            borderRadius: BorderRadius.circular(19.w)),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5.w),
              child: Text(
                name,
                style: TextStyle(color: Color(0xff6C6C89), fontSize: 14.sp),
              ),
            ),
            Image.asset(
              Assets.activityMatchArrow,
              width: 8.w,
              height: 4.w,
            )
          ],
        ),
      ),
    );
  }

  ///数据总揽
  Widget _buildTotalData() {
    return Container(
      padding: EdgeInsets.only(left: 20.w, top: 5.w, bottom: 5.w),
      child: Row(
        children: [
          _dataText(
            "竞猜提交：200",
          ),
          SizedBox(
            width: 10.w,
          ),
          _dataText(
            "竞猜成功：100",
          ),
          SizedBox(
            width: 10.w,
          ),
          _dataText(
            "礼金：999.00",
          ),
        ],
      ),
    );
  }

  Widget _dataText(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
            color: Color(0xff6C6C89),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildListView() {
    return Obx(() {
      if (controller.list.isEmpty) {
        return Column(
          children: [
            SizedBox(
              height: 100.w,
            ),
            EmptyView()
          ],
        );
      }
      return ListView.builder(
          itemCount: controller.list.length,
          itemBuilder: (BuildContext context, int index) {
            var item = controller.list[index];
            return _buildListItem(index, item);
          });
    });
  }

  Widget _buildListItem(int index, PromoReportModel item) {
    // List<Widget> listWidget = [];
    //
    // //添加标题
    // listWidget.add(
    //   Container(
    //     child: Text(
    //       "7月13日",
    //       style: TextStyle(color: Color(0xff1D1D1F), fontSize: 16.sp, fontWeight: FontWeight.w400),
    //     ),
    //   ),
    // );
    //
    // //添加赛事
    // listWidget.add(_matchResultItem(1));
    // listWidget.add(_matchResultItem(2));
    // listWidget.add(_matchResultItem(3));

    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      width: 1.sw,
      child: _matchResultItem(index, item),
    );
  }

  Widget _matchResultItem(int index, PromoReportModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.w)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Text(
                  item.title ?? "",
                  style: TextStyle(
                      color: Color(0xff1D1D1F),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  (item.payoutStatus ?? 1) == 2
                      ? "竞猜成功  礼金：${item.payoutAmount}元"
                      : "未派彩",
                  style: TextStyle(
                      color: Color(0xff12D775),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ))
            ],
          ),
          Container(
            width: 1.sw,
            margin: EdgeInsets.symmetric(vertical: 5.w),
            height: 0.7.w,
            color: Color(0xffEEEEEE),
          ),
          Container(
            child: Row(
              children: [
                Image.asset(
                  Assets.activityMatchTeamCup,
                  width: 14.w,
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 3.w),
                  child: Text(
                    item.contestName ?? "",
                    style: TextStyle(
                        color: Color(0xff778CA4),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(left: 3.w),
                  child: Text(
                    "比赛时间：${formatTimestampToTime02(controller.gameTime.value)}",
                    style: TextStyle(
                        color: Color(0xff778CA4),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 1.sw,
            margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
            height: 0.7.w,
            color: Color(0xffEEEEEE),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 2.w,
                      color: Color(0xff4C96FF),
                      height: 15.w,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.w),
                      child: Text(
                        "${controller.mainTeamName.value} VS ${controller.visitingTeamName.value}",
                        style: TextStyle(
                            color: Color(0xff1D1D1F),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 3.w),
                        child: Text(
                          "竞猜赛果: ",
                          style: TextStyle(
                              color: Color(0xff6c6c89),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3.w),
                        child: Text(
                          item.result ?? "",
                          style: TextStyle(
                              color: Color(0xff4C96FF),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 3.w),
                        child: Text(
                          "提交赛果: ",
                          style: TextStyle(
                              color: Color(0xff6c6c89),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3.w),
                        child: Text(
                          item.submitResult ?? "",
                          style: TextStyle(
                              color: Color(0xff6c6c89),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1.sw,
            margin: EdgeInsets.symmetric(vertical: 5.w),
            height: 0.7.w,
            color: Color(0xffEEEEEE),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 3.w),
            child: Text(
              "提交时间：${formatTimestampToTime02(item.submitAt ?? 0)}",
              style: TextStyle(
                  color: Color(0xff778CA4),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilterDate() {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          selectTimeDialog();
        },
        child: Container(
          margin: EdgeInsets.only(left: 14.w),
          child: Row(
            children: [
              Text(
                controller.selectedStartDate == null
                    ? controller.selectDate.first.currentModel.name
                    : '${formatddDateTimeToString(controller.selectedStartDate!)}'
                        '至${formatddDateTimeToString(controller.selectedEndDate!)}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Image.asset(
                Assets.loginArrowDown,
                width: 14.r,
              ),
            ],
          ),
        ),
      );
    });
  }

  void selectTimeDialog() {
    Get.bottomSheet(
      isDismissible: true, // ✅ 允许点击背景关闭
      DateRangeBottomPicker(
        filterModel: controller.selectDate.first,
        selectedStartDate: controller.selectedStartDate,
        selectedEndDate: controller.selectedEndDate,
        onConfirm: (value, dateTimes) {
          if (value != null) {
            controller.selectedStartDate = null;
            controller.selectedEndDate = null;
            controller.selectDate.first.currentModel = value.selectModel!;
            controller.selectDate.refresh();
            _updateControllerFormDate(controller.selectDate.first);
            print("筛选数据1===${value.selectModel?.value}");
            if (value.selectModel?.value == "0") {
              //查全部时间
              controller.filterListByTime(0, 0, isQuryAll: true);
            } else {
              //当前时间倒推一定时间范围查询
              final now = DateTime.now();
              if (value.selectModel?.value == "1") {
                //今天
                controller.filterListByTime(
                    now.millisecondsSinceEpoch, now.millisecondsSinceEpoch);
              } else if (value.selectModel?.value == "7") {
                //7天
                final sevenDaysAgo = now.subtract(const Duration(days: 7));
                controller.filterListByTime(sevenDaysAgo.millisecondsSinceEpoch,
                    now.millisecondsSinceEpoch);
              } else if (value.selectModel?.value == "30") {
                //30天
                final thirtyDaysAgo = now.subtract(const Duration(days: 30));
                controller.filterListByTime(
                    thirtyDaysAgo.millisecondsSinceEpoch,
                    now.millisecondsSinceEpoch);
              }
            }
          } else {
            controller.selectDate.first.selectModel = null;
            print(
                "筛选数据2===${dateTimes[0].millisecondsSinceEpoch}===${dateTimes[1].millisecondsSinceEpoch}");
            controller.filterListByTime(dateTimes[0].millisecondsSinceEpoch,
                dateTimes[1].millisecondsSinceEpoch);
            _updateDate(dateTimes);
          }
        },
      ),
      isScrollControlled: true,
    ).whenComplete(() {
      controller.resetInvalidSelections(controller.selectDate.value);
    });
  }

  void selectTypeDialog() {
    Get.bottomSheet(
      BottomTradeDict(
        title: "状态",
        filters: controller.tradeDictList,
        onConfirm: () {
          controller.filterListByState();
        },
      ),
    );
  }

  void _updateControllerFormDate(FilterModel model) {
    bool hasChanges = false;
    final value = model.currentModel.value;
    final timeRange = controller.getTimeRangeFromDateValue(value);
    if (controller.startTimestamp != timeRange.start ||
        controller.endTimestamp != timeRange.end) {
      controller.setTimeRange(timeRange.start, timeRange.end);
      hasChanges = true;
    }

    if (hasChanges) {
      controller.applyFilters();
    }
  }

  void _updateDate(List<DateTime> dateTimes) {
    bool hasChanges = false;
    controller.selectedStartDate = dateTimes[0];
    controller.selectedEndDate = dateTimes[1];
    String start = formatDateTimeToString(dateTimes[0]);
    String end = formatDateTimeToString(
        dateTimes[1].add(Duration(days: 1)).subtract(Duration(seconds: 1)));
    if (controller.startTimestamp != start || controller.endTimestamp != end) {
      controller.setTimeRange(start, end);
      hasChanges = true;
    }

    if (hasChanges) {
      controller.applyFilters();
    }
  }

  Widget _buildFilterbar() {
    return Obx(() {
      // 过滤订单状态
      var list = controller.selectList.value
          .where((e) => e.type != FilterType.status)
          .toList();
      return FilterBar(
        // filters: controller.selectList.value,
        filters: list,
        onTapFilter: () {
          selectTypeDialog();
          // Get.bottomSheet(
          //   FilterBottomSheet(
          //     filters: controller.filterModelList.value,
          //     onConfirm: (selectedFilters) {
          //       _updateControllerFromFilterList(selectedFilters);
          //     },
          //   ),
          //   isScrollControlled: true,
          // ).whenComplete(() {
          //   controller.resetInvalidSelections(controller.filterModelList.value);
          // });
        },
        textColor: appnewColors.textBlue,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: appnewColors.bgBlue, width: 1.w),
        ),
      );
    });
  }

  void _updateControllerFromFilterList(List<FilterModel> models) {
    bool hasChanges = false;

    for (var model in models) {
      switch (model.type) {
        /// 币种筛选
        case FilterType.currency:
          final currencyCode = model.currentModel.value;
          if (controller.currencyStr != currencyCode) {
            controller.currencyStr = currencyCode;
            hasChanges = true;
          }
          break;

        /// 交易类型（活动）
        case FilterType.tradeActivity:
          final typeValue = int.tryParse(model.currentModel.value);
          if (typeValue != null && controller.type != typeValue) {
            controller.type = typeValue;
            hasChanges = true;
          }
          break;

        /// 状态筛选
        case FilterType.status:
          final statusValue = int.tryParse(model.currentModel.value);
          if (statusValue != null && controller.welfaredType != statusValue) {
            controller.welfaredType = statusValue;
            hasChanges = true;
          }
          break;

        /// 日期筛选
        case FilterType.date:
          final value = model.currentModel.value;
          if (value.contains('/')) {
            // 范围: start/end
            List<String> parts = value.split('/');
            if (parts.length >= 2) {
              controller.setTimeRange(parts.first, parts.last);
              hasChanges = true;
            }
          } else {
            // 单日期: 昨天、今天、近7天
            final timeRange = controller.getTimeRangeFromDateValue(value);
            if (controller.startTimestamp != timeRange.start ||
                controller.endTimestamp != timeRange.end) {
              controller.setTimeRange(timeRange.start, timeRange.end);
              hasChanges = true;
            }
          }
          break;

        default:
          break;
      }
    }

    /// 只有当确实有变化时才应用筛选
    if (hasChanges) {
      controller.selectList.value = models;
      controller.applyFilters();
    }
  }
}
