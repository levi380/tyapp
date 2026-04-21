import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/welfareCenter/welfare_item_model.dart';
import 'package:filbet/src/mine/welfareCenter/widgets/redemption_record.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/utils/string_utils.dart';
import 'package:filbet/widgets/filter/date_range_bottom_picker.dart';

import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../controllers/welfare_center_controller.dart';
import 'package:filbet/widgets/empty_view.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/skEasyRefresh.dart';

import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/filter/filter_bottom_sheet.dart';
import 'package:filbet/widgets/filter/filterBar.dart';
import 'package:filbet/widgets/filter/filter_model.dart';
import 'package:filbet/widgets/filter/date_range_picker.dart';

class WelfareCenterView extends GetView<WelfareCenterController> {
  const WelfareCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: Color(0xffF8F8FF),
      appBar: CustomAppbar.normalTitle(
        title: 'welfare_center'.tr,
        bgColor: appnewColors.bg1,
      ),
      body: Column(
        children: [
          buildTypeTabBar(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                buildWelfareWidget(),
                RedemptionRecord(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///页面
  Widget buildWelfareWidget() {
    return Container(child: Obx(() {
      return Column(
        children: [
          _buildInfoWidget(),
          _buildFilterbar(),
//
          SizedBox(
            height: 10.h,
          ),

          _buildFilterDate(),
          SizedBox(
            height: 10.h,
          ),

          ///列表空数据
          if (controller.records.isEmpty)
            Expanded(child: EmptyView(top: 100.h, state: EmptyState.noWelfare))
          else
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  bottom: ScreenUtil().bottomBarHeight,
                  left: 14.w,
                  right: 14.w,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: EasyRefreshConfig.build(
                      controller: controller.easyRefreshController,
                      // header: commonHeader,
                      childBuilder: (context, physics) {
                        return CustomScrollView(
                          physics: physics,
                          slivers: [_buildRecordDateListWidget()],
                        );
                      },
                      onRefresh: () async {
                        // 下拉刷新逻辑
                        await controller.fetchData(isRefresh: true);
                      },
                      onLoad: () async {
                        // 上拉加载逻辑（非必须，按需启用）
                        await controller.fetchData();
                      },
                    )),
              ),
            ),
        ],
      );
    }));
  }

  Widget buildTypeTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: appnewColors.bg1,
      ),
      height: 35.r,
      child: TabBar(
        controller: controller.tabController,
        isScrollable: false,
        tabs: List.generate(controller.tabMenus.length, (index) {
          var item = controller.tabMenus[index];
          String title = item.name ?? '';
          return Tab(child: Text(title));
        }),
        unselectedLabelStyle: TextStyle(
            color: appnewColors.text2,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400),
        labelStyle: TextStyle(
            color: appnewColors.textBlue,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500),
        dividerColor: Colors.transparent,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 8.r),
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.vertical(top: Radius.circular(3.r)),
          borderSide: BorderSide(width: 3.r, color: appnewColors.bg),
          insets: EdgeInsets.symmetric(horizontal: 5.w), // 控制宽度
        ),
      ),
    );
  }

  Widget _buildFilterDate() {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          Get.bottomSheet(
            isDismissible: true, // ✅ 允许点击背景关闭

            DateRangeBottomPicker(
              filterModel: controller.selectDate.first,
              selectedStartDate: controller.selectedStartDate,
              selectedEndDate: controller.selectedEndDate,
              onConfirm: (value, dateTimes) {
                print("object123456 ");
                if (value != null) {
                  controller.selectedStartDate = null;
                  controller.selectedEndDate = null;
                  controller.selectDate.first.currentModel = value.selectModel!;
                  controller.selectDate.refresh();
                  _updateControllerFormDate(controller.selectDate.first);
                } else {
                  controller.selectDate.first.selectModel = null;
                  _updateDate(dateTimes);
                }
              },
            ),
            isScrollControlled: true,
          ).whenComplete(() {
            controller.resetInvalidSelections(controller.selectDate.value);
          });
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
          Get.bottomSheet(
            FilterBottomSheet(
              filters: controller.filterModelList.value,
              onConfirm: (selectedFilters) {
                _updateControllerFromFilterList(selectedFilters);
              },
            ),
            isScrollControlled: true,
          ).whenComplete(() {
            controller.resetInvalidSelections(controller.filterModelList.value);
          });
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

  // void _updateControllerFromFilterList(FilterModel model, int index) {
  //   bool hasChanges = false;

  //   // 币种筛选
  //   if (model.type == FilterType.currency) {
  //     final currencyCode = model.currentModel.value;
  //     controller.currencyStr = currencyCode;
  //     hasChanges = true;
  //   }

  //   // 场馆类型筛选
  //   else if (model.type == FilterType.tradeActivity) {
  //     controller.type = int.parse(model.currentModel.value);
  //     hasChanges = true;
  //   }

  //   // 状态筛选
  //   else if (model.type == FilterType.status) {
  //     controller.welfaredType = int.parse(model.currentModel.value);
  //     hasChanges = true;
  //   }

  //   // 日期筛选
  //   else if (model.type == FilterType.date) {
  //     final value = model.currentModel.value;

  //     if (value.contains('/')) {
  //       List<String> parts = value.split('/');
  //       if (parts.length >= 2) {
  //         controller.setTimeRange(parts.first, parts.last);
  //         hasChanges = true;
  //       }
  //     } else {
  //       final dateValue = value;
  //       final timeRange = controller.getTimeRangeFromDateValue(dateValue);

  //       if (controller.startTimestamp != timeRange.start ||
  //           controller.endTimestamp != timeRange.end) {
  //         controller.setTimeRange(timeRange.start, timeRange.end);
  //         hasChanges = true;
  //       }
  //     }
  //   }

  //   // 只有当确实有变化时才应用筛选
  //   if (hasChanges) {
  //     controller.applyFilters();
  //   }
  // }

  ///笔数/总金额 信息
  Widget _buildInfoWidget() {
    return Obx(() {
      return Container(
        height: 52.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: appnewColors.bg1,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBetInfoItem('待领取 (元)'.tr,
                toStringAsFixed2(controller.canReceiveAmount.value), 0),
            _buildBetInfoItem('累计领取 (元)'.tr,
                toStringAsFixed2(controller.receivedAmount.value), 0),
          ],
        ),
      );
    });
  }

  ///投注信息item
  Widget _buildBetInfoItem(String title, String number, int index) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style: TextStyle(
                  color: appnewColors.text2,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500)),
          Text(
            number,
            style: TextStyle(
                color: index == 1
                    ? controller.isAreAllZero(number)
                        ? appnewColors.text1
                        : appnewColors.tip2
                    : appnewColors.text1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  ///红利记录以日期为范围的List Item
  Widget _buildRecordDateListWidget() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        //  addAutomaticKeepAlives: false,
        (ctx, index) {
          final isFirst = index == 0;
          final isLast = index == controller.records.length - 1;
          return _buildRecordItem01(controller.records[index], isFirst, isLast);
        },
        childCount: controller.records.length,
      ),
    );
  }

  Widget _buildRecordItem01(WelfareItemModel item, bool isFirst, bool isLast) {
    int statusType = item.status ?? 0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.name ?? "",
                  style: TextStyle(
                      color: appnewColors.text1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500)),
              if (item.content?.isNotEmpty == true)
                InkWell(
                  onTap: () {
                    Get.dialog(
                      SkBaseDialog(
                        title: item.name ?? "",
                        showDeleteBtn: false,
                        showDeleteBtnType: '1',
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(20.r),
                              child: Text(
                                item.content ?? "",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    height: 1.5,
                                    color: appnewColors.text1),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back(); // 关闭弹窗
                              },
                              child: Container(
                                height: 40.r,
                                margin: EdgeInsets.all(21.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: appnewColors.bgBlue,
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                child: Text(
                                  "confirm".tr,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontFamily: 'Outfit',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 4.w),
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: appnewColors.bg22,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Icon(
                      Icons.question_mark_outlined,
                      size: 10.w,
                      color: Colors.white,
                    ),
                  ),
                ),
              Spacer(),

              ///未领取
              if (statusType == 1 && isExpired(item.expiredAt ?? 0) == false)
                InkWell(
                  onTap: () {
                    controller.showConfirmBottomSheet(item);
                  },
                  child: Container(
                    height: 25.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: appnewColors.bg,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text('claim_now'.tr,
                        style: TextStyle(
                            color: appnewColors.text4, fontSize: 12.sp)),
                  ),
                )
              else
                Container(
                    height: 25.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: Color(0xffBBC1CB),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                        textAlign: TextAlign.right,
                        isExpired(item.expiredAt ?? 0) == false
                            ? 'received'.tr
                            : 'expired'.tr,
                        style: TextStyle(
                            color: appnewColors.text4, fontSize: 12.sp))),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(height: 1, color: appnewColors.bg21),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "红利金额：",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: appnewColors.text26),
                    ),
                    Text(
                      textAlign: TextAlign.right,
                      // "${(double.tryParse(item.amount ?? 0.toString()) ?? 0).toStringAsFixed(2)}" +
                      //     controller.symbol(item.currency ?? 0),
                      "${(double.tryParse(item.amount ?? 0.toString()) ?? 0).toStringAsFixed(2)} 元",
                      style: TextStyle(
                          color: (statusType == 1 &&
                                  isExpired(item.expiredAt ?? 0) == false)
                              ? appnewColors.tip2
                              : appnewColors.text2,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  children: [
                    // if ((item.expiredAt ?? 0) <= 0)
                    //   Text(
                    //     formatTimestampToTime01(item.createdAt),
                    //     style: TextStyle(color: appnewColors.text1, fontSize: 14.sp, fontWeight: FontWeight.w500),
                    //   ),
                    if ((item.expiredAt ?? 0) > 0)
                      GetBuilder<WelfareCenterController>(
                          id: "time",
                          builder: (logic) {
                            int expiredAt = item.expiredAt ?? 0;
                            int timestamp =
                                DateTime.now().millisecondsSinceEpoch;
                            Duration diff =
                                DateTime.fromMillisecondsSinceEpoch(expiredAt)
                                    .difference(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            timestamp));

                            String appendTime = "";
                            if (diff.isNegative) {
                              appendTime = "";
                            }

                            final days = diff.inDays;
                            final hours = diff.inHours % 24;
                            final minutes = diff.inMinutes % 60;
                            final inSeconds = diff.inSeconds % 60;

                            appendTime =
                                '还剩${days}${"day".tr}${hours < 10 ? "0$hours" : hours}:${minutes < 10 ? "0$minutes" : minutes}:${inSeconds < 10 ? "0$inSeconds" : inSeconds}';

                            return Text(statusType == 1 ? appendTime : "--",
                                style: statusType == 1
                                    ? isExpired(item.expiredAt ?? 0) == false
                                        ? isLessThan3Days(
                                                    item.expiredAt ?? 0) ==
                                                true
                                            ? TextStyle(
                                                color: appnewColors.tip1,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500)
                                            : TextStyle(
                                                color: appnewColors.text2,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500)
                                        : TextStyle(
                                            color: appnewColors.text2,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500)
                                    : TextStyle(
                                        color: appnewColors.text2,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500));
                          }),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Row(
              children: [
                Text(
                  "订单号：",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: appnewColors.text26),
                ),
                Text(
                  item.id ?? "",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: appnewColors.text1),
                ),
                SizedBox(width: 5.w),
                GestureDetector(
                  onTap: () {
                    AppUtils.copy(item.id ?? "");
                  },
                  child: Image.asset(
                    Assets.imagesCopy,
                    width: 14.w,
                    height: 14.h,
                    color: Color(0xff6C6C88),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: appnewColors.bg21),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Row(
              children: [
                Text(
                  "时间：",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: appnewColors.text26),
                ),
                Text(
                  formatTimestampToTime01(item.createdAt),
                  style: TextStyle(
                      color: appnewColors.text1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///红利记录item
  Widget _buildRecordItem(WelfareItemModel item, bool isFirst, bool isLast) {
    ///TODO 调试状态UI
    int statusType = item.status ?? 0;

    ///0 1 2 0.未领取  1.没领取 2.已领取
    print('${statusType}');
    return InkWell(
      onTap: () {
        if (statusType == 0) {}
      },
      child: Container(
        // height: 80.w,
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
            color: appnewColors.bg1,
            borderRadius: BorderRadius.vertical(
              top: isFirst ? Radius.circular(14.r) : Radius.zero,
              bottom: isLast ? Radius.circular(14.r) : Radius.zero,
            ),
            border: Border(
              bottom: BorderSide(
                color: appnewColors.colorLine, // 颜色
                width: 1.0, // 粗细
              ),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///图标+标题+时间
            Flexible(
              flex: 4,
              child: Row(
                children: [
                  Container(
                    height: 36.w,
                    width: 36.w,
                    decoration: BoxDecoration(
                      color: Color(0xffEDEDED),
                      borderRadius: BorderRadius.circular(36.w / 2),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(Assets.mineWelfareItemIcon,
                        height: 24.w, width: 24.w),
                  ),

                  SizedBox(width: 10.w),

                  ///标题+时间
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.name ?? "",
                            style: TextStyle(
                                color: Color(0xff11183C),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500)),
                        Text(
                          formatTimestampToTime(item.createdAt),
                          style: TextStyle(
                              color: appnewColors.text2,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 1.h),
                        if ((item.expiredAt ?? 0) > 0)
                          GetBuilder<WelfareCenterController>(
                              id: "time",
                              builder: (logic) {
                                return Text(
                                    statusType == 1
                                        ? formatTimestampLastToTime(
                                            item.expiredAt ?? 0)
                                        : "--",
                                    style: statusType == 1
                                        ? isExpired(item.expiredAt ?? 0) ==
                                                false
                                            ? isLessThan3Days(
                                                        item.expiredAt ?? 0) ==
                                                    true
                                                ? TextStyle(
                                                    color: appnewColors.tip1,
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500)
                                                : TextStyle(
                                                    color: appnewColors.text2,
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500)
                                            : TextStyle(
                                                color: appnewColors.text2,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w500)
                                        : TextStyle(
                                            color: appnewColors.text2,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500));
                              }),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///存款金额+账变余额
            Flexible(
              flex: 2,
              child: Container(
                constraints: BoxConstraints(minHeight: 50.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        textAlign: TextAlign.right,
                        controller.symbol(item.currency ?? 0) +
                            "${(double.tryParse(item.amount ?? 0.toString()) ?? 0).toStringAsFixed(2)}",
                        style: TextStyle(
                            color: (statusType == 1 &&
                                    isExpired(item.expiredAt ?? 0) == false)
                                ? appnewColors.tip2
                                : appnewColors.text2,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 12.h),

                    ///未领取
                    if (statusType == 1 &&
                        isExpired(item.expiredAt ?? 0) == false)
                      InkWell(
                        onTap: () {
                          controller.showConfirmBottomSheet(item);
                        },
                        child: Container(
                          height: 25.w,
                          padding: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            color: appnewColors.bg,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text('claim_now'.tr,
                              style: TextStyle(
                                  color: appnewColors.text4, fontSize: 12.sp)),
                        ),
                      )
                    else
                      Container(
                          height: 25.w,
                          padding: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            color: Color(0xffBBC1CB),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                              textAlign: TextAlign.right,
                              isExpired(item.expiredAt ?? 0) == false
                                  ? 'received'.tr
                                  : 'expired'.tr,
                              style: TextStyle(
                                  color: appnewColors.text4, fontSize: 12.sp))),

                    ///已领取/已过期
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
