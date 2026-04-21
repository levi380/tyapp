import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../widgets/date_picker/show_time_bottom.dart';
import '../widgets/await_bet_dialog_head_view.dart';
import '../widgets/bet_time_filter_view.dart';
import '../widgets/bets_loading/bets_loading_view.dart';
import '../widgets/bookin_bet_filter_view.dart';
import '../widgets/item/order/order_champion_item.dart';
import '../widgets/item/order/order_individually_item.dart';
import '../widgets/item/order/order_merge_together_item.dart';
import '../widgets/no_data_hints/no_data_hints_view.dart';
import 'await_bets_logic.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结注单(未结算)视图层】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示正在等待的投注，包括日期筛选和列表展示。
    - `key`：可选的键，用于标识此组件。
    - `final logic`：获取 `AwaitBetsLogic` 的实例，用于管理状态和逻辑。
    - _dataView()根据加载状态显示不同的视图：加载中、无数据或数据列表。
    - getListView()创建一个列表显示未结算的投注，包含统计信息和具体投注项。
    - getItem()根据数据类型返回不同的投注项视图（冠军、单关、串关等）。
    - _body()返回一个包含列表的视图，支持上拉加载。
    - 主要是APP体育注单-未结注单-未结算列表展示
    - 主要是APP体育注单-未结注单-未结算数据加载框展示
    - 主要是APP体育注单-未结注单-未结算无数据展示
    - 主要是APP体育注单-未结注单-未结算，单关，冠军，串关列表
    】】】
 *
 */
class AwaitBetsPage extends StatelessWidget {
  AwaitBetsPage({Key? key}) : super(key: key);

  final logic = Get.find<AwaitBetsLogic>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          ///冠军赛事类型（ 全部赛事 ,冠军赛事）
          () => BookinBetFilterView(
            type: logic.ChampionshipEventType.value,
            onChanged: (int value) {
              logic.setChampionshipEventType(value);
            },
          ),
        ),
        Obx(
          ///日期选择空间（全部，今天，昨天，一周）
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
    return GetBuilder<AwaitBetsLogic>(
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///统计订单数量
            AwaitBetDialogHeadView(
              statistics: logic.statistics,
            ),
            Container(
              child: logic.loading

                  ///加载页面
                  ? const BetsLoadingView()
                  : logic.listData.isEmpty

                      ///无数据页面
                      ? const NoDataHintsView(
                          type: 0,
                        )

                      ///列表页面
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
          ///适配列表长度
          constraints:
              BoxConstraints(maxHeight: isIPad ? 620.h : 480.h, minHeight: 8.h),
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

  /**
   * 列表条目
   */
  Widget getItem(int index) {
    Widget item = Container();

    GetH5OrderListDataRecordxData data = logic.listData[index];
    String seriesType = data.seriesType;

    ///1是单关和冠军，100自选波胆
    if (seriesType == "1" || seriesType == "100") {
      int matchType = data.matchType ?? 0;
      if (matchType == 3) {
        ///冠军
        item = OrderChampionItem(
          type: 0,
          index: index,
          data: data,
        );
      } else {
        ///单关
        item = OrderIndividuallyItem(
          type: 0,
          index: index,
          data: data,
        );
      }
    } else {
      ///各种串关
      item = OrderMergeTogetherItem(
        type: 0,
        index: index,
        data: data,
        onTap: () => logic.onTextExpand(index),
      );
    }
    return item;
  }
}
