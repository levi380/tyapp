import 'dart:core';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../services/api/bet_api.dart';
import '../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../services/models/res/get_pre_settle_order_detail_entity.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-998323de-6c52-4771-a2e1-96f8fe57bb0f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果已结算列表主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能,管理已结算投注页面的数据状态和逻辑，包括数据请求、筛选和分页加载。
    - `state`：表示当前的状态。
    - `listData`：存储已结算投注的数据列表。
    - onReady()页面准备就绪时调用，默认加载接口。
    - onClose()页面关闭时调用，释放资源。
    - onTextExpand()切换指定数据项的展开状态。
    - onPreSettleExpand()切换提前结算的展开状态，并请求相关数据。
    - 注单状态监听bug，监听提前结算，赛事详情
    - 注单已结算-注单单号，注单时间，注单详情，注单投注额，注单状态
    - 注单已结算-单关，冠军，串关列表
    - 注单已结算-提前兑现，列表
    】】】
 *
 */

class ResultsSettledBetsLogic extends GetxController {
  ///数据列表
  List<GetH5OrderListDataRecordxData> listData = [];

  ///传数据过去
  setData(List<GetH5OrderListDataRecordxData> getH5orderList) {
    listData = getH5orderList;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<ResultsSettledBetsLogic>();
  }

  ///串关折叠
  onTextExpand(int index) {
    listData[index].isExpand.value = !listData[index].isExpand.value;
  }

  ///提前结算折叠
  onPreSettleExpand(int index) async {
    bool preSettleExpand = listData[index].preSettleExpand.value;

    ///收起折叠
    if (preSettleExpand) {
      listData[index].preSettleExpand.value = false;

      ///打开折叠
    } else {
      GetPreSettleOrderDetailEntity res = await BetApi.instance()
          .getPreSettleOrderDetail(listData[index].orderNo);
      if (res.code == "0000000") {
        if (res.data.isNotEmpty) {
          late List<GetPreSettleOrderDetailData> data = res.data;
          listData[index].preSettleExpand.value = true;
          listData[index].data = data;
        }
      }
    }
  }
}
