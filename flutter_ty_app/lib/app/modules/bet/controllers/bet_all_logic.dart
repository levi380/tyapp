import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/models/res/all_order_list_entity.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../home/models/refresh_status.dart';
import '../service/bet_record_service.dart';
import 'bet_record_controller.dart';
import 'bet_record_state.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 全部类型注单Logic】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 全部注单控制类。根据全部注单数据，筛选出体育注单数据，然后使用BetTyLogic来处理提前结算逻辑
    】】】
 *
 */
class BetAllLogic extends GetxController {
  BetRecordState get state => BetRecordController.to.state;
  BetRecordService get service => BetRecordController.to.service;

  Future<void> fetchData() async {
      state.tyDataList.clear();

      ApiRes<AllOrderListEntity> res;
      try {
        res = await service.getTYZRCPOrderList(
            state.orderStatus,
            state.pageIndex,
            state.pageSize,
            state.timeType,
            state.startTime,
            state.endTime
        );
        state.dataList.clear();
        if (res.success) {
          state.dataList = res.data?.list ?? [];
          state.refreshStatus =
          state.dataList.isEmpty ? RefreshStatus.loadNoData : RefreshStatus
              .loadSuccess;

          checkPollingData();
        } else {
          state.errorMsg = res.msg ?? res.code;
          state.refreshStatus = RefreshStatus.loadFailed;
        }
      } catch (e) {
        AppLogger.debug('fetchData error: $e');
        state.dataList.clear();
        state.errorMsg = LocaleKeys.common_no_network.tr;
        state.refreshStatus = RefreshStatus.loadFailed;
      }
      BetRecordController.to.update();
  }


  checkPollingData(){
    state.dataList.forEach((element) {
      GetH5OrderListDataRecordxData h5OrderListDataRecordxData = GetH5OrderListDataRecordxData();
      h5OrderListDataRecordxData.orderNo = element.orderNo;
      h5OrderListDataRecordxData.orderStatus = '';
      h5OrderListDataRecordxData.detailList = [];
      if(element.orderType == 'TY'){
        if(element.orderMixExtendVOList.length == 1){
          h5OrderListDataRecordxData.preSettle = element.orderCashOutInVO!.preSettle;
          h5OrderListDataRecordxData.orderStatus = element.orderStatus.toString();
          h5OrderListDataRecordxData.orderAmountTotal = double.tryParse(element.betAmount)??0;
          h5OrderListDataRecordxData.preSettleBetAmount = element.orderCashOutInVO!.preSettleBetAmount;
          h5OrderListDataRecordxData.seriesType = '1';//单关
          h5OrderListDataRecordxData.marketType=element.orderMixExtendVOList[0].marketType;
          h5OrderListDataRecordxData.preBetAmount= element.orderCashOutInVO!.preBetAmount;
          GetH5OrderListDataRecordxDataDetailList h5OrderListDataRecordxDatadetailList = GetH5OrderListDataRecordxDataDetailList();
          h5OrderListDataRecordxDatadetailList.matchId =element.orderMixExtendVOList[0].matchId;
          h5OrderListDataRecordxDatadetailList.playId =element.orderMixExtendVOList[0].playId;
          h5OrderListDataRecordxDatadetailList.playOptionsId=element.orderMixExtendVOList[0].playOptionsId;
          h5OrderListDataRecordxDatadetailList.sportId = element.orderMixExtendVOList[0].sportId;
          h5OrderListDataRecordxDatadetailList.oddFinally=element.orderMixExtendVOList[0].odds;
          h5OrderListDataRecordxDatadetailList.playOptions = element.orderMixExtendVOList[0].playOptions;
          h5OrderListDataRecordxData.detailList = [h5OrderListDataRecordxDatadetailList];
        }else{
          h5OrderListDataRecordxData.preSettle = element.orderCashOutInVO!.preSettle;
          h5OrderListDataRecordxData.orderStatus = element.orderStatus.toString();
          h5OrderListDataRecordxData.orderAmountTotal = double.tryParse(element.betAmount)??0;
          h5OrderListDataRecordxData.preSettleBetAmount = element.orderCashOutInVO!.preSettleBetAmount;
          h5OrderListDataRecordxData.seriesType = '2';//串关
          h5OrderListDataRecordxData.marketType=element.orderMixExtendVOList.safeFirst?.marketType??"";
          h5OrderListDataRecordxData.preBetAmount= element.orderCashOutInVO!.preBetAmount;
          for(AllOrderListListOrderMixExtendVOList allOrderListListOrderMixExtendVOList in element.orderMixExtendVOList){
            GetH5OrderListDataRecordxDataDetailList h5OrderListDataRecordxDatadetailList = GetH5OrderListDataRecordxDataDetailList();
            h5OrderListDataRecordxDatadetailList.matchId = allOrderListListOrderMixExtendVOList.matchId;
            h5OrderListDataRecordxDatadetailList.playId = allOrderListListOrderMixExtendVOList.playId;
            h5OrderListDataRecordxDatadetailList.playOptionsId= allOrderListListOrderMixExtendVOList.playOptionsId;
            h5OrderListDataRecordxDatadetailList.sportId = allOrderListListOrderMixExtendVOList.sportId;
            h5OrderListDataRecordxDatadetailList.oddFinally= allOrderListListOrderMixExtendVOList.odds;
            h5OrderListDataRecordxDatadetailList.playOptions = allOrderListListOrderMixExtendVOList.playOptions;
            h5OrderListDataRecordxData.detailList.add(h5OrderListDataRecordxDatadetailList);
          }
        }
      }else{
        h5OrderListDataRecordxData.seriesType = '0';
      }
      state.tyDataList.add(h5OrderListDataRecordxData);
    });
    BetRecordController.to.betTylogic.checkPollingData();
  }
}
