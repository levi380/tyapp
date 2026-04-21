import 'package:filbet/common/currency.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/home/platform_name_model.dart';
import 'package:filbet/src/mine/betRecord/bet_record_model.dart';
import 'package:filbet/src/mine/betRecord/controllers/bet_record_controller.dart';
import 'package:filbet/src/mine/transactionRecord/models/trade_dict.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/bottom_sheet/bottom_trade_dict.dart';
import 'package:filbet/widgets/empty_view.dart';
import 'package:filbet/widgets/filter/filter_top_bar.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/services/global/global_service.dart';
import 'dart:convert';
import 'package:filbet/widgets/skEasyRefresh.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/themes/app_newcolor.dart';

import 'package:filbet/widgets/filter/filter_bottom_sheet.dart';
import 'package:filbet/widgets/filter/filterBar.dart';
import 'package:filbet/widgets/filter/filter_model.dart';
import 'package:filbet/widgets/filter/date_range_picker.dart';

import 'custom_expansion_tile.dart';
import 'coustom_sports.dart';
import 'package:filbet/utils/base_util.dart';

class BetRecordView extends GetView<BetRecordController> {
  const BetRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: Color(0xffF2F2F6),
      appBar: CustomAppbar.normalTitle(
        title: 'bet_record'.tr,
        bgColor: appnewColors.bg1,
      ),
      body: _buildPageWidget(),
    );
  }

  ///页面
  Widget _buildPageWidget() {
    return Container(
      child: Obx(() {
        return Column(
          children: [
            _buildFilterBar(),
            SizedBox(
              height: 10.h,
            ),

            _buildFilterDate(),
            if (!controller.isEmpty) _buildBetInfoWidget(),

            ///列表空数据
            if (controller.isEmpty)
              Expanded(
                child: EmptyView(
                  top: 70.h,
                  iconWidth: 160.w,
                  iconHeight: 160.w,
                  state: EmptyState.noBet,
                ),
              )
            else
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: ScreenUtil().bottomBarHeight,
                    left: 14.w,
                    right: 14.w,
                  ),
                  padding: EdgeInsets.only(
                    top: 5.w,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: EasyRefreshConfig.build(
                      controller: controller.easyRefreshController,
                      // header: commonHeader,
                      childBuilder: (context, physics) {
                        return CustomScrollView(physics: physics, slivers: [
                          _buildRecordDateListWidget(
                              items: controller.records.value)
                        ]);
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
              ),
          ],
        );
      }),
    );
  }

  Widget _buildFilterDate() {
    return Obx(() {
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
          ;
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
              Spacer(),
              // if (controller.records.value.isNotEmpty)
              //   InkWell(
              //     onTap: () {
              //       controller.expanded.refresh();
              //     },
              //     child: Container(
              //       margin: EdgeInsets.only(right: 14.w),
              //       padding: EdgeInsets.only(right: 5.w),
              //       child: Text("collapseAll".tr,
              //           style: TextStyle(
              //             fontSize: 12.sp,
              //             fontWeight: FontWeight.w400,
              //             color: appnewColors.text1,
              //           )),
              //     ),
              //   )
            ],
          ),
        ),
      );
    });
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
            isScrollControlled: true,
            BottomTradeDict(
              title: '场馆筛选'.tr,
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

  ///投注信息
  Widget _buildBetInfoWidget() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBetInfoItem(
              'total_bet_orders'.tr, controller.total.toString(), 0),
          _buildBetInfoItem(
              'total_valid_bet_amt'.tr,
              (double.tryParse(controller.totalBet.value) ?? 0)
                  .toStringAsFixed(2),
              1),
          _buildBetInfoItem(
              'total_win'.tr,
              controller.replaceStr(
                  (double.tryParse(controller.totalWin.value) ?? 0)
                      .toStringAsFixed(2),
                  controller.currency.symbol),
              2),
        ],
      ),
    );
  }

  ///投注信息item
  Widget _buildBetInfoItem(String title, String number, int index) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: appnewColors.text2,
              fontSize: 12.sp,
            ),
          ),
          Text(
            number,
            style: TextStyle(
                color: index == 2
                    ? controller.isAreAllZero(number)
                        ? appnewColors.text1
                        : number.startsWith("+")
                            ? appnewColors.tip2
                            : appnewColors.text1
                    : appnewColors.text1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  ///投注记录以日期为范围的List Item
  Widget _buildRecordDateListWidget({
    required List<BetRecordItem> items,
  }) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        //  addAutomaticKeepAlives: false,
        (ctx, index) {
          return _buildBetRecordItem(item: items[index]);
        },
        childCount: items.length,
      ),
    );
  }

  ///投注记录item
  Widget _buildBetRecordItem({
    required BetRecordItem item,
  }) {
    final symbol = controller.currency.symbol;
    String betAmount =
        (item.betAmount.isEmpty ? '--' : item.betAmount.toFixed2());

    final isSettlement = double.tryParse(item.netAmount) != null;
    final isPositive = double.tryParse(item.netAmount) != null &&
        double.parse(item.netAmount) > 0;

    String name = platformName(item.platformId);

    return Obx(
      () => CustomExpansionTile(
        initiallyExpanded: controller.expanded.value,
        header: InkWell(
          onTap: () {
            controller.jumpToDetail(item);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 12.r, right: 12.r, top: 12.r),
            child: Row(
              children: [
                ///图标+标题
                Flexible(
                  child: Row(
                    children: [
                      // Image.asset(Assets.recordTempImg,
                      //     height: 16.w, width: 16.w),

                      SKNetworkImage(
                        imageUrl: Api.imageurl +
                            "/game/platform/icon/${item.platformId}.webp"
                                "",
                        width: 16.r,
                        height: 16.r,
                      ),

                      SizedBox(width: 6.r),
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                              color: appnewColors.text1,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),

                ///状态
                // Container(
                //   alignment: Alignment.centerRight,
                //   constraints: BoxConstraints(
                //     minWidth: 80.w,
                //   ),
                //   child: Text(
                //     item.betRecordType.name,
                //     style: item.betRecordType == BetRecordType.settled
                //         ? TextStyle(
                //             color: appnewColors.tip2,
                //             fontSize: 12.sp,
                //             fontWeight: FontWeight.w500)
                //         : TextStyle(
                //             color: appnewColors.tip3,
                //             fontSize: 12.sp,
                //             fontWeight: FontWeight.w500),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        headercontent: InkWell(
          onTap: () {
            controller.jumpToDetail(item);
          },
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 11.h),
            padding: EdgeInsets.only(left: 34.r, right: 11.w),
            child: _itemgameNamewWidget(item),
          ),
        ),
        expandedContent: InkWell(
          onTap: () {
            controller.jumpToDetail(item);
          },
          child: Column(
            children: [
              _expandedContentWidget(item),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120.r,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "投注额",
                          style: TextStyle(
                              color: appnewColors.text2,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          betAmount,
                          style: TextStyle(
                              color: appnewColors.textMain,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  ///输赢金额
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '输/赢',
                        style: TextStyle(
                            color: appnewColors.text2,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: isSettlement
                                  ? (isPositive
                                      ? '+$symbol${item.netAmount.toFixed2()}'
                                      : '${controller.replaceStr(item.netAmount.toFixed2(), symbol)}')
                                  : '--',
                              style: isPositive
                                  ? TextStyle(
                                      color: appnewColors.tip2,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500)
                                  : TextStyle(
                                      color: appnewColors.tip1,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///时间
                    Container(
                      height: 20.h,
                      // width: 65.w,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        formatTimestampToTime(item.betTime),
                        style: TextStyle(
                            color: appnewColors.text2,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      height: 20.h,
                      child: Row(
                        children: [
                          Text(
                            '单号：${item.bill_no_hash}',
                            style: TextStyle(
                                color: appnewColors.text2,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          InkWell(
                            onTap: () {
                              AppUtils.copy(item.bill_no_hash);
                            },
                            child: Container(
                              padding: EdgeInsets.all(4.r),
                              child: Image.asset(
                                Assets.recordBetCopy,
                                width: 9.w,
                                height: 9.w,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _expandedContentWidget(BetRecordItem item) {
    // if (item.gameType == "4") {
    //   List<dynamic> detailList = json.decode(item.detail);
    //
    //   if (detailList.isEmpty) {
    //     return Container(
    //       constraints: BoxConstraints(
    //         minHeight: 32.h,
    //       ),
    //       margin: EdgeInsets.only(bottom: 10.h),
    //       padding:
    //           EdgeInsets.only(left: 15.w, top: 7.h, bottom: 7.h, right: 11.w),
    //       decoration: BoxDecoration(
    //         color: Color(0xffF2F1F7),
    //         borderRadius: BorderRadius.circular(8.r),
    //       ),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Flexible(
    //             child: Text(
    //               gameName(item),
    //               style: TextStyle(
    //                   color: appnewColors.text1,
    //                   fontSize: 14.sp,
    //                   fontWeight: FontWeight.w500),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   }
    //   // 如果只取第一个元素
    //   Map<String, dynamic> detail = detailList[0];
    //   if (detail.isEmpty) {
    //     return Container(
    //       constraints: BoxConstraints(
    //         minHeight: 32.h,
    //       ),
    //       margin: EdgeInsets.only(bottom: 10.h),
    //       padding:
    //           EdgeInsets.only(left: 15.w, top: 7.h, bottom: 7.h, right: 11.w),
    //       decoration: BoxDecoration(
    //         color: Color(0xffF2F1F7),
    //         borderRadius: BorderRadius.circular(8.r),
    //       ),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Flexible(
    //             child: Text(
    //               gameName(item),
    //               style: TextStyle(
    //                   color: appnewColors.text1,
    //                   fontSize: 14.sp,
    //                   fontWeight: FontWeight.w500),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   }
    //
    //   return coustomSports(
    //     detailList: json.decode(item.detail),
    //   );
    // }

    return Container(
      constraints: BoxConstraints(
        minHeight: 32.h,
      ),
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.only(left: 15.w, top: 7.h, bottom: 7.h, right: 11.w),
      decoration: BoxDecoration(
        color: Color(0xffF2F1F7),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Center(
              child: Text(
                gameName(item),
                style: TextStyle(
                    color: appnewColors.text1,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemgameNamewWidget(BetRecordItem item) {
    // if (item.gameType == "4") {
    //   List<dynamic> detailList = json.decode(item.detail);
    //
    //   if (detailList.isEmpty) {
    //     return Text(
    //       gameName(item),
    //       style: TextStyle(
    //           color: appnewColors.text2,
    //           fontSize: 12.sp,
    //           fontWeight: FontWeight.w400),
    //     );
    //   }
    //   // 如果只取第一个元素
    //   Map<String, dynamic> detail = detailList[0];
    //   if (detail.isEmpty) {
    //     return Text(
    //       gameName(item),
    //       style: TextStyle(
    //           color: appnewColors.text2,
    //           fontSize: 12.sp,
    //           fontWeight: FontWeight.w400),
    //     );
    //   }
    //
    //   return Container(
    //     padding: EdgeInsets.only(left: 6.w),
    //     // width: 65.w,
    //     alignment: Alignment.centerLeft,
    //     child: Column(
    //         // mainAxisAlignment: MainAxisAlignment.center,
    //         // crossAxisAlignment: CrossAxisAlignment.start,
    //         children: detailList.map((item) {
    //       final betType = item["bet_type"] ?? "";
    //       final competition = item["competition_name"] ?? "";
    //       final favTeam = item["fav_team"] ?? "";
    //       final odds = item["odds"] ?? "";
    //
    //       final desc = "$betType$competition$favTeam@$odds";
    //       return Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 4),
    //         child: Row(
    //           children: [
    //             Container(
    //               width: 3.w,
    //               height: 20.w,
    //               color: appnewColors.bg,
    //             ),
    //             const SizedBox(width: 8),
    //             Expanded(
    //               child: Text(
    //                 desc,
    //                 style: TextStyle(
    //                     color: appnewColors.text2,
    //                     fontSize: 12.sp,
    //                     fontWeight: FontWeight.w500),
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     }).toList()),
    //   );
    // }

    return Text(
      gameName(item),
      style: TextStyle(
          color: appnewColors.text2,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400),
    );
  }

  platformName(String pid) {
    for (PlatFormNameModel element
        in GlobalService.to.state.allPlatformNameConfig) {
      print('element.platformId = ${element.id} (${pid})');
      if (element.id == pid) {
        return element.name ?? "";
      }
    }
    return "";
  }

  itemgameName(BetRecordItem item) {
    if (item.gameType == "4") {
      // List<dynamic> detailList = json.decode(item.detail);

      // if (detailList.isEmpty) {
      //   return item.gameName;
      // }
      // // 如果只取第一个元素
      // Map<String, dynamic> detail = detailList[0];
      // if (detail.isEmpty) {
      //   return item.gameName;
      // }
      return item.gameName;
    }

    if (item.gameType == "1") {
      return item.gameName;
    }

    return "";
  }

  gameName(BetRecordItem item) {
    // if (item.gameType == "4") {
    //   List<dynamic> detailList = json.decode(item.detail);
    //
    //   if (detailList.isEmpty) {
    //     return item.gameName;
    //   }
    //   // 如果只取第一个元素
    //   Map<String, dynamic> detail = detailList[0];
    //   if (detail.isEmpty) {
    //     return item.gameName;
    //   }
    //   return item.gameName;
    // }
    //
    // if (item.gameType == "1") {
    //   if (item.detail == "[]") {
    //     return "";
    //   }
    //
    //   Map<String, dynamic> detail = json.decode(item.detail);
    //   if (detail.isEmpty) {
    //     return "";
    //   }
    //
    //   return "${detail["bet_area"] ?? ""}" +
    //       " " +
    //       "${detail["table_code"] ?? ""}";
    // }

    return item.gameName;
  }

  amountStr(item) {
    String text =
        "${(double.tryParse(item.amount ?? 0.toString()) ?? 0).abs().toStringAsFixed(2)}"
            .strforcurry();
    if ((double.tryParse(item.amount ?? 0.toString()) ?? 0) > 0) {
      text = "+ " + text;
    } else {
      text = "- " + text;
    }

    return text;
  }
}
