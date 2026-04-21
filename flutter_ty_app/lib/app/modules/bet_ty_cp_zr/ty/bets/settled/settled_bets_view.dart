import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/widgets/settled_bet_head_view.dart';

import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/widgets/bet_time_filter_view.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/widgets/routine_bet_filter_view.dart';
import 'package:get/get.dart';
import '../../../../../../main.dart';
import '../../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../unsettled_bets/widgets/bets_loading/bets_loading_view.dart';
import '../../../../unsettled_bets/widgets/no_data_hints/no_data_hints_view.dart';
import '../item/order/order_champion_item.dart';
import '../item/order/order_individually_item.dart';
import '../item/order/order_merge_together_item.dart';
import 'settled_bets_logic.dart';
import '../../../../../widgets/date_picker/show_time_bottom.dart';

class SettledBetsPage extends StatelessWidget {
  SettledBetsPage({Key? key}) : super(key: key);

  final logic = Get.find<SettledBetsLogic>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettledBetsLogic>(
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
                    ///赛事选择器
                    RoutineBetFilterView(
                      selectType: logic.state.ChampionshipEventType,
                      onChanged: (int value) {
                        logic.setChampionshipEventType(value);
                      },
                    ),

                    ///时间选择器
                    BetTimeFilteringView(
                      type: logic.state.selectType.value,
                      openSelectTypeTime: logic.state.openSelectTypeTime.value,
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
                    ).marginSymmetric(horizontal: 8.h),

                    ///统计订单数量
                    SettledBetHeadView(
                      statistics: logic.state.statistics,
                    ).marginSymmetric(horizontal: 8.h),
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

  _dataView() {
    if (logic.state.loading) {
      ///加载中
      return const BetsLoadingView();
    } else if (logic.state.listData.isEmpty) {
      ///无数据
      return const NoDataHintsView(
        type: 3,
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

  Widget getItem(int index) {
    Widget item = Container();

    GetH5OrderListDataRecordxData data = logic.state.listData[index];
    String seriesType = data.seriesType;

    ///1是单关和冠军，100自选波胆
    if (seriesType == "1" || seriesType == "100") {
      int matchType = data.matchType ?? 0;
      if (matchType == 3) {
        ///冠军
        item = OrderChampionItem(
          type: 1,
          index: index,
          data: data,
        );
      } else {
        ///单关
        item = OrderIndividuallyItem(
          type: 1,
          index: index,
          data: data,
        );
      }
    } else {
      ///各种串关
      item = OrderMergeTogetherItem(
        type: 1,
        index: index,
        data: data,
        onTap: () => logic.onTextExpand(index),
      );
    }
    return item;
  }
}
