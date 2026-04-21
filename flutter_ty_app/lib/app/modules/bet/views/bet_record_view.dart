import 'package:flutter_ty_app/app/modules/bet/controllers/bet_ty_logic.dart';
import 'package:flutter_ty_app/app/modules/bet/extensions/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/models/res/all_order_list_entity.dart';
import '../../../services/models/res/cp_order_list_entity.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../services/models/res/get_order_list_zr_entity.dart';
import '../../../widgets/empty/no_data.dart';
import '../../home/models/refresh_status.dart' as HomeRefreshStatus;
import '../../home/views/skeleton_match_listView.dart';
import '../widgets/footer_view.dart';
import '../controllers/bet_record_controller.dart';
import '../controllers/bet_record_state.dart';
import '../widgets/bet_date_widget.dart';
import '../widgets/bet_switch_widget.dart';
import '../widgets/betitem_cp_mix.dart';
import '../widgets/betitem_cp_single.dart';
import '../widgets/betitem_all_mix.dart';
import '../widgets/betitem_all_single.dart';
import '../widgets/betitem_ty_mix.dart';
import '../widgets/betitem_ty_single.dart';
import '../widgets/betitem_zr_mix.dart';
import '../widgets/betitem_zr_single.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 注单中心Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 注单类型切换；显示注单列表
    】】】
 *
 */
class BetRecordView extends GetView<BetRecordController> {
  const BetRecordView({Key? key}) : super(key: key);

  BetRecordState get state => BetRecordController.to.state;

  Widget _buildBetContent(BetRecordController controller) {
    if (state.refreshStatus == HomeRefreshStatus.RefreshStatus.isLoading) {
      ///刷新loading 骨架图
      return SkeletonMatchListView(
        isNews: !TyHomeController.to.homeState.isProfess,
      );
    } else if (state.refreshStatus ==
        HomeRefreshStatus.RefreshStatus.loadSuccess) {
      if (state.orderType == 3) {
        return _buildCpContent(controller);
      } else if (state.orderType == 2) {
        return _buildZrContent(controller);
      } else if (state.orderType == 1) {
        return _buildTyContent(controller);
      }
      return ListView.builder(
        itemCount: state.dataList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          AllOrderListList orderItem = state.dataList[index];
          Widget itemWidget;
          bool isExpand = (state.isExapndedAll &&
                  !state.expanedSet.contains(orderItem.orderNo)) ||
              (!state.isExapndedAll &&
                  state.expanedSet.contains(orderItem.orderNo));
          if (orderItem.orderType == 'TY') {
            if (orderItem.orderMixExtendVOList.length == 1) {
              itemWidget = BetItemAllSingle(
                orderItem,
                isExpand,
                index < state.tyDataList.length
                    ? state.tyDataList[index]
                    : null,
                index,
              );
            } else {
              itemWidget = BetItemAllMix(
                orderItem,
                isExpand,
                index < state.tyDataList.length
                    ? state.tyDataList[index]
                    : null,
                state.mixExpanedSet.contains(orderItem.orderNo),
                index,
              );
            }
          } else if (orderItem.orderType == 'ZR') {
            itemWidget = BetItemZrMix(
              orderItem,
              isExpand,
              state.mixExpanedSet.contains(orderItem.orderNo),
            );
          } else if (orderItem.orderType == 'CP' ||
              orderItem.orderType == 'CP2') {
            // 未结算CP 追号中CP2
            itemWidget = BetItemCpMix(
              orderItem,
              isExpand,
              state.mixExpanedSet.contains(orderItem.orderNo),
            );
          } else {
            itemWidget = Container(
              height: 20.h,
            );
          }
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 0),
            child: itemWidget,
          );
        },
      );
    } else if (state.refreshStatus ==
        HomeRefreshStatus.RefreshStatus.loadNoData) {
      return NoData(
        content: LocaleKeys.common_no_data.tr,
        top: 80.h,
      );
    } else {
      return NoData(
        content: state.errorMsg ?? LocaleKeys.common_no_network.tr,
        top: 80.h,
      );
    }
  }

  Widget _buildCpContent(BetRecordController controller) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: state.cpDataList.length,
      itemBuilder: (BuildContext context, int index) {
        CpOrderListList orderItem = state.cpDataList[index];
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 0),
          child: BetItemCpSingle(orderItem),
        );
      },
    );
  }

  Widget _buildZrContent(BetRecordController controller) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: state.zrDataList.length,
      itemBuilder: (BuildContext context, int index) {
        GetOrderListZrDataList orderItem = state.zrDataList[index];
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 0),
          child: BetItemZrSingle(orderItem),
        );
      },
    );
  }

  Widget _buildTyContent(BetRecordController controller) {
    return SmartRefresher(
      //不允许下拉刷新
      enablePullDown: false,
      //允许上拉加载
      enablePullUp: false,
      // enablePullUp: state.tyDataList.isNotEmpty,
      controller: controller.betTylogic.refreshController,
      onLoading: controller.betTylogic.onLoadMore,
      footer: const FooterView(),
      child: ListView.builder(
        itemCount: state.tyDataList.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          GetH5OrderListDataRecordxData orderItem = state.tyDataList[index];
          bool isExpand = (state.isExapndedAll &&
                  !state.expanedSet.contains(orderItem.orderNo)) ||
              (!state.isExapndedAll &&
                  state.expanedSet.contains(orderItem.orderNo));
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 0),
            child: orderItem.detailList.length > 1
                ? BetItemTyMix(orderItem, isExpand,
                    state.mixExpanedSet.contains(orderItem.orderNo),index)
                : BetItemTySingle(orderItem, isExpand, index),
          );
        },
      ), //列表组件
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GetBuilder<BetRecordController>(
      init: BetRecordController(),
      builder: (logic) {
        return Column(
          children: [
            BetSwitchWidget(),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 4.h),
                decoration: BoxDecoration(
                  color: themeData.betRecordViewBackgroundColor,
                ),
                child: Column(
                  children: [
                    BetDateWidget(),
                    Expanded(
                      child: _buildBetContent(logic),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
