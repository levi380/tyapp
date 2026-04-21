import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/settled_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/widgets/bet_dialog_head_view.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/widgets/bet_tab_filter_view.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../services/models/res/get_h5_order_list_entity.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_enum.dart';
import '../../widgets/date_picker/show_time_bottom.dart';
import '../unsettled_bets/widgets/bets_loading/bets_loading_view.dart';
import '../unsettled_bets/widgets/bookin_bet_filter_view.dart';
import '../unsettled_bets/widgets/item/order/order_champion_item.dart';
import '../unsettled_bets/widgets/item/order/order_individually_item.dart';
import '../unsettled_bets/widgets/item/order/order_merge_together_item.dart';
import '../unsettled_bets/widgets/no_data_hints/no_data_hints_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 已结算列表视图层】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能，展示已结算的投注信息，包括筛选和数据列表。
    - `logic`：获取与该页面相关的逻辑控制器 `SettledBetsLogic` 的实例。
    - `state`：获取当前状态。
    - _buildCloseButton()创建一个关闭按钮，点击后关闭对话框。
    - _body()构建主体内容，包含时间筛选和数据视图。
    - 功能,_dataView()
    - 根据加载状态展示不同的视图：
    - 加载中：显示加载视图。
    - 无数据：显示无数据提示。
    - 有数据：显示数据列表。
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
class SettledBetsPage extends StatefulWidget {
  const SettledBetsPage({Key? key}) : super(key: key);

  @override
  State<SettledBetsPage> createState() => _SettledBetsPageState();
}

class _SettledBetsPageState extends State<SettledBetsPage> {
  final logic = Get.find<SettledBetsLogic>();
  final state = Get
      .find<SettledBetsLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.topCenter,
      insetPadding: EdgeInsets.fromLTRB(
        48.w,
        isIPad ? 80.h : 40.h,
        48.w,
        0.h,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        0,
      ),
      titlePadding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        0,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: _buildCloseButton(),
      content: _body(),
    );
  }

  ///关闭按钮
  Widget _buildCloseButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        Bus.getInstance().emit(EventType.tyCloseDialog);
      },
      child: Row(
        children: [
          const Spacer(),
          Container(
            height: isIPad ? 30.w : 28.w,
            width: isIPad ? 30.w : 28.w,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white.withAlpha(85)
                  : Colors.white.withValues(alpha: 0.30000001192092896),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: const Icon(
              Icons.close_outlined,
              color: Colors.white,
              size: 20,
            ),
          )
        ],
      ),
    ).marginOnly(bottom: 10.h);
  }

  Widget _body() {
    return GetBuilder<SettledBetsLogic>(
      builder: (logic) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            color: context.isDarkMode
                ? const Color(0xff1E2029)
                : const Color(0xFFF2F2F6),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          width: 400.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                    () =>
                    BetTabFilterView(
                      selectType: logic.selectType.value,
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
              Obx(

                ///冠军赛事类型（ 全部赛事 ,冠军赛事）
                    () =>
                    BookinBetFilterView(
                      type: logic.ChampionshipEventType.value,
                      onChanged: (int value) {
                        logic.setChampionshipEventType(value);
                      },
                    ),
              ),
              _dataView()
            ],
          ),
        );
      },
    );
  }

  _dataView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BetDialogHeadView(
          statistics: logic.statistics,
        ),
        Container(
          child: logic.loading
              ? const BetsLoadingView()
              : logic.listData.isEmpty
              ? const NoDataHintsView(
            type: 3,
          )
              : getListView(),
        ),
      ],
    );
  }

  Widget getListView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints:
          BoxConstraints(maxHeight: isIPad ? 630.h : 490.h, minHeight: 8.h),
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
    GetH5OrderListDataRecordxData data = logic.listData[index];
    String seriesType = data.seriesType;
    int matchType = data.matchType ?? 0;
    if (seriesType == "1" || seriesType == "100") {
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
      ///多串一
      item = OrderMergeTogetherItem(
        type: 1,
        index: index,
        data: data,
        onTap: () => logic.onTextExpand(index),
      );
    }
    return item;
  }


  @override
  void dispose() {
    Get.delete<SettledBetsLogic>();
    super.dispose();
  }
}
