import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/item/pre/pre_champion_item.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/item/pre/pre_individually_item.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/widgets/Lapse_bet_head_view.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/widgets/bookin_bet_dialog_head_view.dart';
import 'package:get/get.dart';
import '../../../../../../generated/locales.g.dart';
import '../../../../../../main.dart';
import '../../../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../../../unsettled_bets/widgets/bets_loading/bets_loading_view.dart';

import '../../../../unsettled_bets/widgets/no_data_hints/no_data_hints_view.dart';
import '../widgets/booking_bet_filter_view.dart';
import 'booking_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/widgets/bet_time_filter_view.dart';
import '../../../../../widgets/date_picker/show_time_bottom.dart';

class BookingBetsPage extends StatelessWidget {
  BookingBetsPage({Key? key}) : super(key: key);

  final logic = Get.find<BookingBetsLogic>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingBetsLogic>(
      builder: (logic) {
        return Container(
          padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: ShapeDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.04)
                      : const Color(0xFFF8F9FA),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha: 0.04)
                          : Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 20,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    ///预约，失效选择器.
                    BookingBetFilterView(
                      selectType: logic.state.betsTypes,
                      onChanged: (int value) {
                        logic.setBetsTypes(value);
                      },
                    ),
                    Obx(

                      ///日期选择空间（全部，今天，昨天，一周）
                          () =>
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                child: BetTimeFilteringView(
                                  type: logic.state.selectType.value,
                                  openSelectTypeTime:
                                  logic.state.openSelectTypeTime.value,
                                  onChanged: (int value) {
                                    showTimeBottom.resetinitTime();
                                    if (value != 5) {
                                      logic.setSelectType(value);
                                    } else {
                                      logic.showTime(context, value);
                                    }
                                  },
                                  startTime: logic.state.startTime.value,
                                  endTime: logic.state.endTime.value,
                                ),
                              ),
                              if (logic.state.betsTypes == 0 &&
                                  logic.state.isOpenTips.value)
                                _descriptionBox(context),
                            ],
                          ).marginSymmetric(horizontal: 8.h),
                    ),

                    ///注单统计
                    _statisticsBetsView(),
                  ],
                ),
              ).marginOnly(bottom: 10.h),
              _dataView(),
            ],
          ),
        );
      },
    );
  }

  /*
  *提示框
   */
  _descriptionBox(BuildContext context) {
    return Positioned(
      right: 0.w,
      bottom: 0.h,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black
              .withValues(alpha: context.isDarkMode ? 0.95 : 0.9), // 图标颜色
          borderRadius: BorderRadius.all(
            Radius.circular(
              5.r,
            ),
          ),
        ),
        height: 24.h,
        alignment: Alignment.center,
        child: Text(
          LocaleKeys.app_subject_to_actual_odds.tr,
          style: TextStyle(
            color:
            Colors.white.withValues(alpha: context.isDarkMode ? 0.95 : 0.8),
            fontSize: 12.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          ),
          // maxLines: 1,
          //  overflow: TextOverflow.ellipsis,
        ).marginOnly(
          left: 5.w,
          right: 5.w,
        ),
      ),
    );
  }

  /**
   * 统计注单
   */
  _statisticsBetsView() {
    Widget widget = Container();
    if (logic.state.betsTypes == 0) {
      widget = Obx(
            () =>

        ///预约统计订单数量
        BookinBetDialogHeadView(
          statistics: logic.state.statistics,
          isOpenTips: logic.state.isOpenTips.value,
          onTap: () {
            logic.setIsOpenTips();
          },
        ).marginSymmetric(horizontal: 8.h),
      );
    } else {
      ///失效统计订单数量
      widget = LapseBetHeadView(
        statistics: logic.state.statistics,
        betsTypes: logic.state.betsTypes,
        isOpenTips: logic.state.isOpenTips.value,
        onTap: () {
          logic.setIsOpenTips();
        },
      ).marginSymmetric(horizontal: 8.h);
    }
    return widget;
  }

  _dataView() {
    if (logic.state.loading) {
      ///加载中
      return const BetsLoadingView();
    } else if (logic.state.listData.isEmpty) {
      ///无数据
      return NoDataHintsView(
        type: logic.state.betsTypes == 0 ? 1 : 2,
      );
    }

    ///列表数据
    return getListView();
  }

  Widget getListView() {
    return ConstrainedBox(

      ///适配列表长度
      constraints:
      BoxConstraints(maxHeight: isIPad ? 620.h : 480.h, minHeight: 8.h),
      child: ListView.builder(
        itemCount: logic.state.listData.length,
        controller: logic.state.scrollController,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return getItem(index);
        },
      ),
    );
  }

  ///添加item
  Widget getItem(int index) {
    Widget item = Container();
    GetH5PreBetOrderlistDataRecordxData data = logic.state.listData[index];
    String seriesType = data.seriesType;

    ///1是单关和冠军，100自选波胆
    if (seriesType == "1" || seriesType == "100") {
      int matchType = data.matchType ?? 0;

      ///冠军
      if (matchType == 3) {
        item = PreChampionItem(
          type: logic.state.betsTypes,
          index: index,
          data: data,
        );
      } else {
        ///单关
        item = PreIndividuallyItem(
          type: logic.state.betsTypes,
          index: index,
          data: data,
        );
      }
    }
    return item;
  }
}
