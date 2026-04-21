import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/lapse_bet_dialog_head_view.dart'
    show LapseBetDialogHeadView;
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../../widgets/date_picker/show_time_bottom.dart';
import '../widgets/bet_time_filter_view.dart';
import '../widgets/bets_loading/bets_loading_view.dart';
import '../widgets/item/pre/pre_champion_item.dart';
import '../widgets/item/pre/pre_individually_item.dart';
import '../widgets/no_data_hints/no_data_hints_view.dart';
import 'lapse_bets_logic.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结注单(已失效)视图层】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能展示预约投注的用户界面，包含时间筛选和数据列表展示。
    - 主要是APP体育注单-未结注单-已失效列表展示
    - 主要是APP体育注单-未结注单-已失效数据加载框展示
    - 主要是APP体育注单-未结注单-已失效无数据展示
    - 主要是APP体育注单-未结注单-已失效，单关列表
    - _dataView()根据加载状态展示不同的视图：
    - 加载中：显示加载视图。
    - 无数据：显示无数据提示。
    - 有数据：显示数据列表。
    - getListView()创建一个列表视图，用于展示预约投注的数据。
    - getItem()根据索引返回相应的列表项，如果数据项的 `seriesType` 为 "1"，则返回单个项的视图。
    】】】
 *
 */
class LapseBetsPage extends StatelessWidget {
  LapseBetsPage({Key? key}) : super(key: key);

  final logic = Get.find<LapseBetsLogic>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => BetTimeFilteringView(
            type: logic.selectType.value,
            openSelectTypeTime: logic.openSelectTypeTime.value,
            onChanged: (int value) {
              showTimeBottom.resetinitTime();
              if (value != 5) {
                logic.setSelectType(value);
              } else {
                logic.showTime(context, value);
              }
            },
            startTime: logic.startTime.value,
            endTime: logic.endTime.value,
          ),
        ),
        _dataView(),
      ],
    );
  }

  _dataView() {
    return GetBuilder<LapseBetsLogic>(
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///统计订单数量
            LapseBetDialogHeadView(
              statistics: logic.statistics,
            ),
            Container(
              child: logic.loading
                  ? const BetsLoadingView()
                  : logic.listData.isEmpty
                      ? const NoDataHintsView(
                          type: 2,
                        )
                      : getListView(),
            ),
          ],
        );
      },
    );
  }

  Widget getListView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: isIPad ? 650.h : 520.h, minHeight: 8.h),
          child: ListView.builder(
            itemCount: logic.listData.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return getItem(index);
            },
          ),
        ),
      ],
    );
  }

  ///添加item
  Widget getItem(int index) {
    Widget item = Container();
    GetH5PreBetOrderlistDataRecordxData data = logic.listData[index];
    String seriesType = data.seriesType;

    ///1是单关和冠军，100自选波胆
    if (seriesType == "1" || seriesType == "100") {
      int matchType = data.matchType ?? 0;

      ///冠军
      if (matchType == 3) {
        item = PreChampionItem(
          type: 1,
          index: index,
          data: data,
        );
      } else {
        ///单关
        item = PreIndividuallyItem(
          index: index,
          data: data,
          type: 1,
        );
      }
    }
    return item;
  }
}
