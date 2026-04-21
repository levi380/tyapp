import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/settled/settled_bets_state.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../../services/api/bet_api.dart';
import '../../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../../widgets/date_picker/show_time_bottom.dart';
import 'dart:core';
import 'package:flutter_ty_app/app/services/models/res/get_pre_settle_order_detail_entity.dart';
import 'package:common_utils/common_utils.dart';

class SettledBetsLogic extends GetxController {
  final SettledBetsState state = SettledBetsState();

  @override
  void onReady() {
    super.onReady();
    //默认加载接口
    getH5OrderList();
  }

  @override
  void onClose() {
    state.refreshController.dispose();
    super.onClose();
  }

  ///赛事
  setChampionshipEventType(int type) {
    state.ChampionshipEventType = type;
    // openSelectTypeTime.value = (selectType.value == 5);

    ///切换时间清除就数据
    state.listData.clear();

    ///重制统计数据
    state.statistics = ['0', '0.00', '0.00'];

    if (state.selectType.value != 5) {
      state.loading = true;
      update();
      getH5OrderList();
    } else {
      state.loading = false;
      update();
      showTime(Get.context!, 5);
    }
  }

  setSelectType(int type,
      {String temporaryStartTime = "", String temporaryEndTime = ""}) {
    ///防止多次点击
    if (type != 5 && type == state.selectType.value) {
      return;
    }
    if (type != 5) {
      state.startTimestamp = "";
      state.endTimestamp = "";
      state.startTime.value = "";
      state.endTime.value = "";
    } else {
      if (temporaryStartTime.isNotEmpty && temporaryEndTime.isNotEmpty) {
        ///开始时间
        state.startTime.value = temporaryStartTime;

        ///结束时间
        state.endTime.value = temporaryEndTime;
      }
    }
    state.selectType.value = type;
    state.openSelectTypeTime.value = false;

    ///切换时间清除就数据
    state.listData.clear();

    ///重制统计数据
    state.statistics = ['0', '0.00', '0.00'];
    state.loading = true;
    update();
    getH5OrderList();
  }

  ///自定义时间控件
  void showTime(BuildContext context, int type) {
    // lastSelectType = selectType.value;
    //  selectType.value = type;
    state.openSelectTypeTime.value = true;

    String temporaryStartTime = "";
    String temporaryEndTime = "";
    showTimeBottom.showModalBottom(
      context,
      onDateTimeChanged: (date) {
        ///开始时间
        temporaryStartTime = DateUtil.formatDateMs(
                date[0].millisecondsSinceEpoch,
                format: DateFormats.y_mo_d,)
            .toString();

        ///结束时间
        temporaryEndTime = DateUtil.formatDateMs(date[1].millisecondsSinceEpoch,
                format: DateFormats.y_mo_d)
            .toString();

        state.startTimestamp = date[0].millisecondsSinceEpoch.toString();

        ///如果结束时间是今天 那么取当前时间戳而不是当天的零点
        if (DateTime.now().difference(date[1]).inDays == 0) {
          state.endTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
        } else {
          state.endTimestamp = date[1].millisecondsSinceEpoch.toString();
        }

        setSelectType(type,
            temporaryStartTime: temporaryStartTime,
            temporaryEndTime: temporaryEndTime);
      },
    );
  }

  ///请求列表数据
  Future<void> getH5OrderList() async {
    ///当使用时间选择的时候不能传timeType这个参数给后台
    final GetH5OrderListEntity res;

    if (state.selectType.value != 5) {
      res = await BetApi.instance().getH5OrderList('1', '',
          timeType: state.selectType.value == 4 ? 3 : state.selectType.value,

          ///已结注单30天的记录业务后台不支持，30天跟查7天一样的传参，其实就是查7天,优化单94134有注明
          page: state.page,
          size: state.size,
          outright: state.ChampionshipEventType);
    } else {
      res = await BetApi.instance().getH5OrderList('1', '',
          beginTime: state.startTimestamp,
          endTime: state.endTimestamp,
          page: state.page,
          size: state.size,
          orderBy: state.orderBy,
          outright: state.ChampionshipEventType);
    }
    String code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "0000000") {
      GetH5OrderListData data = res.data;

      ///已结注单统计数据
      state.statistics[0] = data.total;
      state.statistics[1] = data.betTotalAmount;
      state.statistics[2] = data.profit;

      ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
      if (data.record != null && data.record!.isNotEmpty) {
        Map<String, GetH5OrderListDataRecordx?> record = data.record ?? {};
        List<MapEntry<String, GetH5OrderListDataRecordx?>> entries =
            record.entries.toList();
        Map<String, GetH5OrderListDataRecordx?> reversedMap =
            Map.fromEntries(entries);

        ///便利map，把数据全部房在一起。
        reversedMap.forEach((key, value) {
          state.listData.addAll(value!.data);
        });
      }
    }
    state.loading = false;
    update();
  }

  ///串关折叠
  onTextExpand(int index) {
    state.listData[index].isExpand.value =
        !state.listData[index].isExpand.value;
  }

  ///提前结算折叠
  onPreSettleExpand(int index) async {
    bool preSettleExpand = state.listData[index].preSettleExpand.value;

    ///收起折叠
    if (preSettleExpand) {
      state.listData[index].preSettleExpand.value = false;

      ///打开折叠
    } else {
      GetPreSettleOrderDetailEntity res = await BetApi.instance()
          .getPreSettleOrderDetail(state.listData[index].orderNo);
      if (res.code == "0000000") {
        if (res.data.isNotEmpty) {
          late List<GetPreSettleOrderDetailData> data = res.data;
          state.listData[index].preSettleExpand.value = true;
          state.listData[index].data = data;
        }
      }
    }
  }
}
