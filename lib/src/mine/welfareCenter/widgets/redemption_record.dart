import 'package:common_utils/common_utils.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/resp_redeem_record.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/src/mine/welfareCenter/controllers/redemption_record_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/empty_view.dart';
import 'package:filbet/widgets/filter/date_range_picker.dart';
import 'package:filbet/widgets/filter/filterBar.dart';
import 'package:filbet/widgets/filter/filter_bottom_sheet.dart';
import 'package:filbet/widgets/filter/filter_model.dart';
import 'package:filbet/widgets/skEasyRefresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RedemptionRecord extends GetView<RedemptionRecordController> {
  const RedemptionRecord({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RedemptionRecordController());
    return Column(
      children: [
        _buildFilterBar(),
        _buildFilterDate(),

        ///列表空数据

        Obx(() {
          print("object123456 ${controller.records.length}");
          if (controller.records.isEmpty) {
            return Expanded(
                child: EmptyView(top: 100.h, state: EmptyState.noWelfare));
          } else {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  bottom: ScreenUtil().bottomBarHeight,
                  left: 16.r,
                  right: 16.r,
                  top: 16.r,
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
                  ),
                ),
              ),
            );
          }
        })
      ],
    );
  }

  Widget _buildFilterBar() {
    return Obx(() {
      return FilterBar(
        filters: controller.selectList.value,
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

  Widget _buildFilterDate() {
    return Container(
      margin: EdgeInsets.only(top: 10.r),
      child: Obx(() {
        return GestureDetector(
          onTap: () async {
            Get.bottomSheet(
              isDismissible: true, // ✅ 允许点击背景关闭
              DateRangePicker(
                filterModel: controller.selectDate.first,
                onConfirm: (value) {
                  // print("用户选中: ${value.name}, value=${value.value}");
                  controller.selectDate.clear();
                  controller.selectDate.value = [value];
                  _updateControllerFromdate(value);
                },
                cancel: (value) {},
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
                  controller.selectDate.first.currentModel.name,
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
      }),
    );
  }

  Widget _buildRecordDateListWidget() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) {
          final isFirst = index == 0;
          final isLast = index == controller.records.length - 1;
          var model = controller.records[index];
          return recordItem(model, isFirst, isLast);
        },
        childCount: controller.records.length,
      ),
    );
  }

  Widget recordItem(RedeemRecordModel item, bool isFirst, bool isLast) {
    int statusType = item.status?.toInt() ?? 0;
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.REDEMPTION_DETAIL, arguments: {
          'model': item,
        });
      },
      child: Container(
        height: 68.r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: isFirst ? Radius.circular(16.r) : Radius.zero,
            bottom: isLast ? Radius.circular(16.r) : Radius.zero,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.mineIconPrize,
                      width: 33.r,
                      height: 33.r,
                    ),
                    SizedBox(width: 6.r),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.prizeName ?? "",
                          style: TextStyle(
                              color: appnewColors.textMain,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          formatDateTimeToString(
                            DateTime.fromMillisecondsSinceEpoch(
                                item.claimedAt?.toInt() ?? 0),
                          ),
                          style: TextStyle(
                              color: Color(0xFF56555D),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          controller.convertTypeName(statusType),
                          style: TextStyle(
                              color: statusType == 6
                                  ? appnewColors.text14
                                  : statusType == 7
                                      ? appnewColors.textRed
                                      : appnewColors.textSecond,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          item.prizeType ?? "",
                          style: TextStyle(
                            color: appnewColors.textMain,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 6.r),
                    Image.asset(
                      Assets.mineIconArrowRight,
                      width: 15.r,
                      height: 15.r,
                    ),
                  ],
                ),
              ),
            ),
            if (!isLast)
              Container(
                margin: EdgeInsets.only(left: 16.r + 33.r + 6.r),
                color: appnewColors.colorLine,
                height: 1,
              ),
          ],
        ),
      ),
    );
  }

  void _updateControllerFromFilterList(List<FilterModel> models) {
    bool hasChanges = false;

    for (var model in models) {
      switch (model.type) {
        /// 状态筛选
        case FilterType.status:
          final statusValue = int.tryParse(model.currentModel.value);
          if (statusValue != null && controller.welfareType != statusValue) {
            controller.welfareType = statusValue;
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
      controller.applyFilter();
    }
  }

  void _updateControllerFromdate(FilterModel model) {
    bool hasChanges = false;

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

    if (hasChanges) {
      controller.applyFilter();
    }
  }
}
