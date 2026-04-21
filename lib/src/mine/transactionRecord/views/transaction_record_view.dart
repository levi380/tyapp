import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/transactionRecord/controllers/transaction_record_controller.dart';
import 'package:filbet/src/mine/transactionRecord/models/trade_dict.dart';
import 'package:filbet/src/mine/transactionRecord/models/trade_record_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/bottom_sheet/bottom_trade_dict.dart';
import 'package:filbet/widgets/empty_view.dart';
import 'package:filbet/widgets/filter/filter_top_bar.dart';

import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:filbet/widgets/skEasyRefresh.dart';
import 'package:filbet/widgets/custom_scffold.dart';

import 'package:filbet/widgets/filter/filter_model.dart';
import 'package:filbet/widgets/filter/date_range_picker.dart';
import 'package:filbet/utils/base_util.dart';

class TransactionRecordView extends GetView<TransactionRecordController> {
  const TransactionRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: Color(0xFFF7F9FE),
      appBar: CustomAppbar.normalTitle(
        title: 'trade_record'.tr,
        bgColor: appnewColors.bg1,
      ),
      body: _buildPageWidget(),
    );
  }

  ///页面
  Widget _buildPageWidget() {
    return Column(
      children: [
        _buildFilterBar(),
        contentView(),
      ],
    );
  }

  Widget contentView() {
    return Expanded(
      child: Container(
        color: Color(0xFFF2F2F6),
        margin: EdgeInsets.symmetric(horizontal: 14.r),
        child: Column(
          children: [
            _buildFilterDate(),
            dataView(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDate() {
    return Container(
      height: 56.r,
      margin: EdgeInsets.only(top: 8.r),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.r))),
      child: GestureDetector(
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
        child: Obx(() {
          return Container(
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
          );
        }),
      ),
    );
  }

  Widget dataView() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
            left: 14.r,
            right: 14.r,
            bottom: ScreenUtil().bottomBarHeight + 12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.r),
          ),
        ),
        child: EasyRefreshConfig.build(
            controller: controller.easyRefreshController,
            childBuilder: (context, physics) {
              return Obx(() {
                if (controller.records.isEmpty) {
                  return SingleChildScrollView(
                    physics: physics,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: EmptyView(
                        top: 110.w,
                        iconWidth: 160.w,
                        iconHeight: 160.w,
                        state: EmptyState.noTransaction,
                      ),
                    ),
                  );
                }
                return CustomScrollView(
                  physics: physics,
                  slivers: [
                    _buildRecordDateListWidget(controller.records),
                  ],
                );
              });
            },
            onRefresh: () async {
              await controller.fetchData(isRefresh: true);
            },
            onLoad: () async {
              await controller.fetchData(isRefresh: false);
            },
          ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Obx(() {
      return FilterTopBar(
        filters: controller.tradeTopDictList.value,
        filterCallBack: (TradeDict item) {
          controller.changeTopDict(item);
        },
        onTapFilter: () {
          Get.bottomSheet(
            BottomTradeDict(
              filters: controller.tradeDictList,
              onConfirm: () {
                controller.changeBottomDict();
              },
            ),
          );
        },
      );
    });
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
      controller.applyFilters();
    }
  }

  List<String> mergeSubFilterValueStrings(List<SubFilterModel>? list) {
    if (list == null) return [];

    final Set<String> result = {};

    for (final item in list) {
      final value = item.value;
      if (value == null || value.isEmpty) continue;

      final parts = value.split(',');
      for (final part in parts) {
        final clean = part.trim();
        if (clean.isNotEmpty) result.add(clean);
      }
    }

    return result.toList()..sort();
  }

  String joinSubFilterValues(List<SubFilterModel>? list) {
    final merged = mergeSubFilterValueStrings(list);
    return merged.join(',');
  }

  ///交易记录以日期为范围的List Item
  Widget _buildRecordDateListWidget(List<TradeRecordModel> items) {
    final firstOne = items.first;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) {
          final isFirst = index == 0;
          final isLast = index == items.length - 1;
          return _buildBetRecordItem(items[index], isFirst, isLast);
        },
        childCount: items.length,
      ),
    );
  }

  ///交易记录item
  Widget _buildBetRecordItem(TradeRecordModel item, bool isFirst, bool isLast) {
    return InkWell(
      onTap: () {
        controller.jumpToDetail(item);
      },
      child: Container(
        height: 68.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: appnewColors.bg1,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.r),
                child: Row(
                  children: [
                    Container(
                      height: 33.r,
                      width: 33.r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xffEDEDED),
                        borderRadius: BorderRadius.circular(36.w / 2),
                      ),
                      child: Image.asset(Assets.mineWelfareItemIcon,
                          height: 20.w, width: 20.w),
                    ),
                    SizedBox(width: 8.r),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.subTypeName ?? '',
                          style: TextStyle(
                              color: Color(0xff11183C),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          (item.createdAt?.toInt() ?? 0)
                              .toFormattedDateTimeString(),
                          style: TextStyle(
                              color: appnewColors.text2,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 20.h,
                            child: Text(
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis, // 超出部分省略
                              item.statusName ?? '',
                              style: TextStyle(
                                  color: convertColor(item.status),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            height: 20.h,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              amountStr(item),
                              style: TextStyle(
                                  color: appnewColors.textMain,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 3.r,
                    ),
                    Image.asset(
                      Assets.mineIconArrowR,
                      width: 14.r,
                      height: 14.r,
                      color: appnewColors.textThird,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 51.r),
              color: Color(0xFFFBFBFB),
              height: 1,
            )
          ],
        ),
      ),
    );
  }

  amountStr(item) {
    String text =
        "${(double.tryParse(item.amount ?? 0.toString()) ?? 0).abs().toStringAsFixed(2)}"
            .strforcurry();
    // if ((double.tryParse(item.amount ?? 0.toString()) ?? 0) > 0) {
    //   text = "+ " + text;
    // } else {
    //   text = "- " + text;
    // }

    return text;
  }

  double truncateTo2(double value) {
    return (value * 100).truncateToDouble() / 100;
  }

  Color convertColor(num? status) {
    Color textColor = appnewColors.textSecond;
    if (controller.selectedTradeDict?.type == 2) {
      if (status == 2) {
        textColor = appnewColors.text14;
      } else if (status == 3) {
        textColor = appnewColors.textRed;
      }
    } else if (controller.selectedTradeDict?.type == 4) {
      if (status == 2) {
        textColor = appnewColors.text14;
      } else if (status == 3) {
        textColor = appnewColors.textRed;
      }
    } else if (controller.selectedTradeDict?.type == 5) {
      if (status == 1) {
        textColor = appnewColors.text14;
      } else if (status == 2) {
        textColor = appnewColors.textRed;
      }
    } else if (controller.selectedTradeDict?.type == 6) {
      if (status == 6) {
        textColor = appnewColors.text14;
      } else if (status == 5) {
        textColor = appnewColors.textRed;
      }
    } else if (controller.selectedTradeDict?.type == 7) {
      if (status == 6) {
        textColor = appnewColors.text14;
      } else if (status == 5) {
        textColor = appnewColors.textRed;
      }
    } else if (controller.selectedTradeDict?.type == 8) {
      if (status == 2) {
        textColor = appnewColors.text14;
      } else if (status == 3) {
        textColor = appnewColors.textRed;
      }
    }
    return textColor;
  }
}
