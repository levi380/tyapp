import 'package:flutter_ty_app/app/modules/result/results_details/results_settled_bets/item/order_champion_item.dart';
import 'package:flutter_ty_app/app/modules/result/results_details/results_settled_bets/item/order_merge_together_item.dart';
import 'package:flutter_ty_app/app/modules/result/results_details/results_settled_bets/results_settled_bets_logic.dart';
import '../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../login/login_head_import.dart';
import 'item/order_individually_item.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-998323de-6c52-4771-a2e1-96f8fe57bb0f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果已结算列表视图层】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能，展示已结算的投注信息，包括筛选和数据列表。
    - `logic`：获取与该页面相关的逻辑控制器 `SettledBetsLogic` 的实例。
    - `state`：获取当前状态。
    - _buildCloseButton()创建一个关闭按钮，点击后关闭对话框。
    - _body()构建主体内容，包含时间筛选和数据视图。
    - 功能,_dataView()
    - getListView()创建一个列表视图，用于展示已结算的投注数据。
    - getItem()根据索引返回相应的列表项，处理不同的 `seriesType` 和 `matchType`。
    - dispose()在页面销毁时删除 `SettledBetsLogic` 实例。
    - 主要是APP体育注单-已结算列表展示
    - 主要是APP体育注单-已结算数据加载框展示
    - 主要是APP体育注单-已结算无数据展示
    - 主要是APP体育注单-已结算，单关列表
    - 主要是APP体育注单-已结算，提前兑现列表
    】】】
 *
 */
class ResultsSettledBetsPage extends StatelessWidget {
  ResultsSettledBetsPage({
    super.key,
    required this.data,
  });

  final List<GetH5OrderListDataRecordxData> data;
  final logic = Get.find<ResultsSettledBetsLogic>();

  @override
  Widget build(BuildContext context) {
    ///传数据过去
    logic.setData(data);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _dataView(),
      ],
    );
  }

  _dataView() {
    return GetBuilder<ResultsSettledBetsLogic>(
      builder: (logic) {
        return Expanded(
          child: logic.listData.isEmpty ? Container() : getListView(),
        );
      },
    );
  }

  ///注单列表
  Widget getListView() {
    return ListView.builder(
      itemCount: data.length,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return getItem(index).marginOnly(
          top: index == 0 ? 10.h : 0.h,
          left: 10.h,
          right: 10.h,
        );
      },
    );
  }

  ///注单条目
  Widget getItem(int index) {
    Widget widget = Container();
    GetH5OrderListDataRecordxData data = logic.listData[index];
    String seriesType = data.seriesType;

    ///1是单关和冠军，100自选波胆
    if (seriesType == "1" || seriesType == "100") {
      int matchType = data.matchType ?? 0;
      if (matchType == 3) {
        ///冠军
        widget = OrderChampionItem(
          index: index,
          data: data,
        );
      } else {
        ///单关
        widget = OrderIndividuallyItem(
          index: index,
          data: data,
        );
      }
    } else {
      ///各种串关
      widget = OrderMergeTogetherItem(
        index: index,
        data: data,
        onTap: () => logic.onTextExpand(index),
      );
    }

    return widget;
  }
}
