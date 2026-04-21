import 'package:easy_refresh/easy_refresh.dart';
import 'package:filbet/common/currency.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/accountChangeRecord/account_change_record_model.dart';
import 'package:filbet/src/mine/accountChangeRecord/controllers/account_change_record_controller.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_decoration.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/empty_view.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:filbet/widgets/skEasyRefresh.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/themes/app_newcolor.dart';

import 'package:filbet/widgets/filter/filter_bottom_sheet.dart';
import 'package:filbet/widgets/filter/filterBar.dart';
import 'package:filbet/widgets/filter/filter_model.dart';
import 'package:filbet/widgets/filter/date_range_picker.dart';

class AccountChangeRecordView extends GetView<AccountChangeRecordController> {
  const AccountChangeRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: Color(0xffF2F2F6),
      appBar: CustomAppbar.normalTitle(
        title: 'deposit_record'.tr,
        bgColor: appnewColors.bg1,
      ),
      body: PopScope(
        onPopInvokedWithResult: (didPop, _) {},
        child: _buildPageWithTabbar(),
      ),
    );
  }

  Widget _buildPageWithTabbar() {
    return Obx(() {
      return Column(
        children: [
          _buildTypeTabbar(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildPageWidget(type: AccountChangeType.deposit, tabIndex: 0),
                _buildPageWidget(type: AccountChangeType.withdraw, tabIndex: 1),
              ],
            ),
          ),
        ],
      );
    });
  }

  ///存/取tabbar
  Widget _buildTypeTabbar() {
    return Container(
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        border: Border(
          bottom: BorderSide(
            color: appnewColors.colorLine, // 颜色
            width: 1.0, // 粗细
          ),
        ),
      ),
      height: 46,
      child: TabBar(
        controller: controller.tabController,
        isScrollable: false,
        tabs: List.generate(controller.tabTypeList.length, (index) {
          Map<String, dynamic> itemMap = controller.tabTypeList[index];
          String title = itemMap['title'];
          return Tab(
            child: SizedBox(height: 20.h, child: Text(title)),
          );
        }),
        unselectedLabelStyle: TextStyle(
            color: appnewColors.text2,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400),
        labelStyle: TextStyle(
            color: appnewColors.text1,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500),
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        indicatorPadding: EdgeInsets.zero,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(2.r),
          borderSide: BorderSide(width: 2, color: appnewColors.bg),
          insets: EdgeInsets.symmetric(horizontal: 30.w), // 控制宽度
        ),
      ),
    );
  }

  Widget _buildPageWidget({
    required AccountChangeType type,
    required int tabIndex,
  }) {
    List<_AccountChangeRecordListItem> list = [];
    if (type == AccountChangeType.deposit) {
      list = controller.allDepositRecords.value
          .map((item) => _AccountChangeRecordListItem(
                id: item.id,
                title: item.frontChannelName,
                datetime: item.createdAt.toFormattedTimeString(),
                amount: item.orderStatus == AccountChangeOrderStatus.success
                    ? item.actualAmountWithCurrenySymbol
                    : item.amountWithUSDTSymbol,
                orderStatus: item.orderStatus,
                item: item,
              ))
          .toList();
    } else {
      list = controller.allWithdrawRecords.value
          .map((item) {
            return _AccountChangeRecordListItem(
              id: item.id,
              title: item.accountName,
              datetime: item.createdAt.toFormattedTimeString(),
              amount: item.amountWithSymbol,
              orderStatus: item.orderStatus,
              item: item,
            );
      })
          .toList();
    }

    return Container(
      // padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        children: [
          _buildFilterWidget(type: type, tabIndex: tabIndex),

          ///列表空数据
          if (list.isEmpty)
            Expanded(
                child: EmptyView(
                  iconWidth: 160.w,
                  iconHeight: 160.w,
              top: 96.h,
              state: EmptyState.noDeposit,
            ))
          else
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  bottom: ScreenUtil().bottomBarHeight,
                  left: 14.w,
                  right: 14.w,
                ),
                // padding: EdgeInsets.only(
                //   top: 5.w,
                // ),
                // // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(14.r),
                //   color: appnewColors.bg1,
                // ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: EasyRefreshConfig.build(
                    controller: type == AccountChangeType.deposit
                        ? controller.depositEasyRefreshController
                        : controller.withdrawEasyRefreshController,
                    childBuilder: (_, physics) {
                      return CustomScrollView(
                        physics: physics,
                        slivers: [
                          _buildRecordDateListWidget(type: type, items: list)
                        ],
                      );
                    },
                    onRefresh: () async {
                      controller.resetAndLoadData();
                    },
                    onLoad: () async {
                      controller.loadMoreData();
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  ///币种/全部场馆/全部状态/日期筛选
  Widget _buildFilterWidget(
      {required AccountChangeType type, required int tabIndex}) {
    // Map<String, dynamic> typeMap = controller.tabTypeList[tabIndex];
    // RxList<FilterModel> filterList = typeMap['filterModelList'];
    return Column(
      children: [
        Obx(() {
          return FilterBar(
            filters: tabIndex == 0
                ? controller.select1List.value
                : controller.select2List.value,
            onTapFilter: () {
              Get.bottomSheet(
                FilterBottomSheet(
                  filters: tabIndex == 0
                      ? controller.filterModelList1.value
                      : controller.filterModelList2.value,
                  onConfirm: (selectedFilters) {
                    _updateControllerFromFilterList(selectedFilters);
                  },
                ),
                isScrollControlled: true,
              ).whenComplete(() {
                controller.resetInvalidSelections(tabIndex == 0
                    ? controller.filterModelList1.value
                    : controller.filterModelList2.value);
              });
            },
          );
        }),
        Container(
          // color: appnewColors.bg1,
          padding: EdgeInsets.only(top: 10.w),
          margin: EdgeInsets.only(bottom: 10.w),
          child: Obx(() {
            return GestureDetector(
              onTap: () async {
                Get.bottomSheet(
                  isDismissible: true, // ✅ 允许点击背景关闭

                  DateRangePicker(
                    // isPrimary: false,
                    filterModel: tabIndex == 0
                        ? controller.select1Date.first
                        : controller.select2Date.first,
                    onConfirm: (value) {
                      // print("用户选中: ${value.name}, value=${value.value}");

                      if (tabIndex == 0) {
                        controller.select1Date.clear();
                        controller.select1Date.value = [value];
                      } else {
                        controller.select2Date.clear();
                        controller.select2Date.value = [value];
                      }

                      _updateControllerFromdate(value);
                    },
                    cancel: (value) {},
                  ),
                  isScrollControlled: true,
                ).whenComplete(() {
                  controller.resetInvalidSelections(tabIndex == 0
                      ? controller.select1Date
                      : controller.select2Date);
                });
                ;
              },
              child: Container(
                margin: EdgeInsets.only(left: 14.w),
                child: Row(
                  children: [
                    Text(
                      tabIndex == 0
                          ? controller.select1Date.first.currentModel.name
                          : controller.select2Date.first.currentModel.name,
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
        )
      ],
    );
  }

  void _updateControllerFromdate(FilterModel model) {
    bool hasChanges = false;

    if (controller.index == 0) {
      final value = model.currentModel.value;
      if (value.contains('/')) {
        // 范围: start/end
        List<String> parts = value.split('/');
        if (parts.length >= 2) {
          controller.setTimeRangeType(parts.first, parts.last);
          hasChanges = true;
        }
      } else {
        // 单日期: 昨天、今天、近7天
        final timeRange = controller.getTimeRangeFromDateValue(value);
        if (controller.dstartTimestamp != timeRange.start ||
            controller.dendTimestamp != timeRange.end) {
          controller.setTimeRangeType(timeRange.start, timeRange.end);
          hasChanges = true;
        }
      }
    } else {
      final value = model.currentModel.value;
      if (value.contains('/')) {
        // 范围: start/end
        List<String> parts = value.split('/');
        if (parts.length >= 2) {
          controller.setTimeRangeType(parts.first, parts.last);
          hasChanges = true;
        }
      } else {
        // 单日期: 昨天、今天、近7天
        final timeRange = controller.getTimeRangeFromDateValue(value);
        if (controller.wstartTimestamp != timeRange.start ||
            controller.wendTimestamp != timeRange.end) {
          controller.setTimeRangeType(timeRange.start, timeRange.end);
          hasChanges = true;
        }
      }
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

          final currency =
              Currency.values.firstWhereOrNull((c) => c.code == currencyCode);
          if (controller.index == 0) {
            if (controller.depositCurrency != currency) {
              controller.setCurrency(currency);
              hasChanges = true;
            }
          } else {
            if (controller.withdrawCurrency != currency) {
              controller.setCurrency(currency);
              hasChanges = true;
            }
          }
          break;

        /// 状态筛选
        case FilterType.status:
          final statusValue = model.currentModel.value;
          final statusId = int.tryParse(statusValue) ?? 0;
          if (controller.index == 0) {
            if (controller.depositStatusId != statusId) {
              controller.setStatusId(statusId);
              hasChanges = true;
            }
          } else {
            if (controller.withdrawStatusId != statusId) {
              controller.setStatusId(statusId);
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
      if (controller.index == 0) {
        controller.select1List.value = models;
      } else {
        controller.select2List.value = models;
      }

      controller.applyFilters();
    }
  }

  // ///币种/全部场馆/全部状态/日期筛选每个item
  // Widget _buildFilterItem({
  //   required int index,
  //   required AccountChangeType type,
  //   required int tabIndex,
  //   required FilterModel filterModel,
  //   required bool isLast,
  // }) {
  //   Map<String, dynamic> typeMap = controller.tabTypeList[tabIndex];
  //   RxList<FilterModel> filterList = typeMap['filterModelList'];
  //   RxInt filterTypeIndex = typeMap['filterTypeIndex'];

  //   String titleName = '';
  //   final currentModel = filterModel.currentModel;
  //   final subFilterModel = currentModel.filterModel;
  //   if (subFilterModel != null) {
  //     final subCurrent = subFilterModel.currentModel;
  //     titleName =
  //         (subCurrent.showName != null && subCurrent.showName!.isNotEmpty)
  //             ? subCurrent.showName!
  //             : subCurrent.name;
  //   } else {
  //     titleName =
  //         (currentModel.showName != null && currentModel.showName!.isNotEmpty)
  //             ? currentModel.showName!
  //             : currentModel.name;
  //   }
  //   return InkWell(
  //     onTap: () {
  //       PopupDrawerFilter filterMenu = PopupDrawerFilter(
  //         context: Get.context!,
  //         vsync: controller.vsync,
  //         onShow: () {
  //           filterTypeIndex.value = index;
  //         },
  //         onDismiss: () {
  //           filterTypeIndex.value = -1;
  //         },
  //         onChanged: (model) {
  //           filterTypeIndex.value = -1;
  //           filterList[index] = model;

  //           _updateControllerFromFilterList(model, index);
  //         },
  //       );
  //       controller.filterMenu = filterMenu;
  //       filterMenu.show(
  //         widgetKey: type == AccountChangeType.deposit
  //             ? controller.depositPopupKeys[index]
  //             : controller.withdrawPopupKeys[index],
  //         filterModel: filterModel,
  //         bottom: 14.h,
  //       );
  //     },
  //     child: Container(
  //       key: type == AccountChangeType.deposit
  //           ? controller.depositPopupKeys[index]
  //           : controller.withdrawPopupKeys[index],
  //       alignment: Alignment.center,
  //       padding: EdgeInsets.symmetric(vertical: 6.h),
  //       decoration: BoxDecoration(
  //         color: filterTypeIndex.value == index
  //             ? appColors.mainColor
  //             : appColors.white,
  //         borderRadius: BorderRadius.circular(6.r),
  //       ),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             titleName,
  //             style: filterTypeIndex.value == index
  //                 ? appColors.textWhiteStyle_12_500
  //                 : appColors.textSecond2Style_12_500,
  //           ),
  //           SizedBox(width: 2.w),
  //           SvgPicture.asset(
  //             Assets.imagesFilterDownArrow,
  //             width: 16.w,
  //             height: 16.w,
  //             colorFilter: ColorFilter.mode(
  //               filterTypeIndex.value == index
  //                   ? appColors.white
  //                   : appColors.textSecond2Color,
  //               BlendMode.srcIn,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  ///交易记录以日期为范围的List Item
  Widget _buildRecordDateListWidget({
    required AccountChangeType type,
    required List<_AccountChangeRecordListItem> items,
  }) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        //  addAutomaticKeepAlives: false,
        (ctx, index) {
          final isFirst = index == 0;
          final isLast = index == items.length - 1;
          return _buildBetRecordItem(type, items[index], isFirst, isLast);
        },
        childCount: items.length,
      ),
    );
  }

  ///交易记录item
  Widget _buildBetRecordItem(
    AccountChangeType type,
    _AccountChangeRecordListItem item,
    bool isFirst,
    bool isLast,
  ) {
    TextStyle style = item.orderStatus == AccountChangeOrderStatus.success
        ? TextStyle(
            color: appnewColors.tip2,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500)
        : item.orderStatus == AccountChangeOrderStatus.failed
            ? TextStyle(
                color: appnewColors.tip1,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500)
            : TextStyle(
                color: appnewColors.tip3,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500);
    return InkWell(
      onTap: () {
        controller.jumpToDetail(type, item.item);
      },
      child: Container(
        // margin: EdgeInsets.only(left: 10.w, right: 10.w),
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
              flex: 3,
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
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                              color: appnewColors.text1,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          item.datetime,
                          style: TextStyle(
                              color: appnewColors.text2,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///存款金额+账变余额
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20.h,
                    child: Text(
                      textAlign: TextAlign.right,
                      item.amount,
                      style: TextStyle(
                          color: appnewColors.text1,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 20.h,
                    child: Text(
                      textAlign: TextAlign.right,
                      item.item.orderStatus.name,
                      style: style,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _updateControllerFromFilterList(FilterModel model, int index) {
  //   bool hasChanges = false;

  //   // 币种筛选
  //   if (model.type == FilterType.currency) {
  //     final currencyCode = model.currentModel.value;

  //     final currency =
  //         Currency.values.firstWhereOrNull((c) => c.code == currencyCode);
  //     if (controller.index == 0) {
  //       if (controller.depositCurrency != currency) {
  //         controller.setCurrency(currency);
  //         hasChanges = true;
  //       }
  //     } else {
  //       if (controller.withdrawCurrency != currency) {
  //         controller.setCurrency(currency);
  //         hasChanges = true;
  //       }
  //     }
  //   }

  //   // 状态筛选
  //   else if (model.type == FilterType.status) {
  //     final statusValue = model.currentModel.value;
  //     final statusId = int.tryParse(statusValue) ?? 0;
  //     if (controller.index == 0) {
  //       if (controller.depositStatusId != statusId) {
  //         controller.setStatusId(statusId);
  //         hasChanges = true;
  //       }
  //     } else {
  //       if (controller.withdrawStatusId != statusId) {
  //         controller.setStatusId(statusId);
  //         hasChanges = true;
  //       }
  //     }
  //   }

  //   // 日期筛选
  //   else if (model.type == FilterType.date) {
  //     final dateValue = model.currentModel.value;
  //     if (controller.index == 0) {
  //       if (controller.depositRangeType != dateValue) {
  //         controller.setTimeRangeType(dateValue);
  //         hasChanges = true;
  //       }
  //     } else {
  //       if (controller.withdrawRangeType != dateValue) {
  //         controller.setTimeRangeType(dateValue);
  //         hasChanges = true;
  //       }
  //     }
  //   }

  //   // 只有当确实有变化时才应用筛选
  //   if (hasChanges) {
  //     controller.applyFilters();
  //   }
  // }
}

// 仅用于显示
class _AccountChangeRecordListItem {
  final String id;
  final String title;
  final String datetime;
  final String amount;
  final AccountChangeOrderStatus orderStatus;
  final AccountChangeRecordBaseItem item;

  _AccountChangeRecordListItem({
    required this.id,
    required this.title,
    required this.datetime,
    required this.amount,
    required this.orderStatus,
    required this.item,
  });
}
