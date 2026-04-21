import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/settled_bets_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../routes/route_manager.dart';
import '../../services/api/bet_api.dart';
import '../../services/models/res/get_h5_order_list_entity.dart';
import '../../services/models/res/get_pre_settle_order_detail_entity.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_enum.dart';
import '../../utils/sport.dart';
import '../login/login_head_import.dart';
import 'package:flutter_ty_app/app/widgets/date_picker/show_time_bottom.dart';

import '../unsettled_bets/utils/betsUtils.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 已结算列表主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能,管理已结算投注页面的数据状态和逻辑，包括数据请求、筛选和分页加载。
    - `state`：表示当前的状态。
    - `listData`：存储已结算投注的数据列表。
    - `loading`：指示数据是否正在加载。
    - `startTime` 和 `endTime`：用于界面展示的开始和结束时间。
    - `startTimestamp` 和 `endTimestamp`：用于网络请求的时间戳。
    - `selectType`：选择的时间类型（如今日、昨日等）。
    - `openSelectTypeTime`：指示是否开启自定义时间选择。
    - `lastSelectType`：记录上一次选择的时间类型。
    - `page`：当前请求的页码。
    - `size`：请求数据的条数。
    - `statistics`：已结算注单的统计数据。
    - `refreshController`：用于处理下拉刷新和上拉加载的控制器。
    - onReady()页面准备就绪时调用，默认加载接口。
    - onClose()页面关闭时调用，释放资源。
    - setSelectType()设置时间类型，并清除相关数据，重新请求数据。
    - showTime()显示自定义时间选择器，并处理时间选择结果。
    - getH5OrderList()请求已结算投注列表数据，并更新 `listData` 和 `statistics`。
    - onLoadMore()加载更多数据，处理分页请求。
    - onTextExpand()切换指定数据项的展开状态。
    - onPreSettleExpand()切换提前结算的展开状态，并请求相关数据。
    - 包含组件隐藏显示、接口请求、临时开关等参数
    - 注单状态监听bug，监听提前结算，赛事详情
    - 注单已结算-注单单号，注单时间，注单详情，注单投注额，注单状态
    - 注单已结算-单关，冠军，串关列表
    - 注单已结算-全部，今日，昨日，一周，自定义
    - 注单已结算-提前兑现，列表
    】】】
 *
 */
class SettledBetsLogic extends GetxController {
  final SettledBetsState state = SettledBetsState();
  List<GetH5OrderListDataRecordxData> listData = [];

  ///加载展示
  var loading = true;

  /// UI界面展示使用
  var startTime = "".obs;

  /// UI界面展示使用
  var endTime = "".obs;

  ///默认获取当天零点时间戳(网络请求使用)
  var startTimestamp = "";

  ///默认获取当前时间戳(网络请求使用)
  var endTimestamp = "";

  /// 1:今日 2:昨日 3:近7日 4:近30日,5:自定义
  var selectType = 1.obs;

  ///开启自定义时间
  var openSelectTypeTime = false.obs;

  ///记录上一次的（1:今日 2:昨日 3:近7日 4:全部 ）
  // var lastSelectType = -1;

  ///冠军赛事类型（ 0:全部赛事 1:冠军赛事）
  var ChampionshipEventType = 0.obs;

  ///网络请求翻页
  var page = 1;

  ///请求数据条数
  final int size = 300;

  ///  排序方式 1投注时间,2 结算时间
  final int orderBy = 2;

  ///已结算注单统计
  List<String> statistics = ['0', '0.00', '0.00'];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onReady() {
    super.onReady();
    //默认加载接口
    getH5OrderList();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  ///赛事
  setChampionshipEventType(int type) {
    ChampionshipEventType.value = type;
    // openSelectTypeTime.value = (selectType.value == 5);

    ///切换时间清除就数据
    listData.clear();

    ///重制统计数据
    statistics = ['0', '0.00', '0.00'];

    if (selectType.value != 5) {
      loading = true;
      update();
      getH5OrderList();
    } else {
      loading = false;
      update();
      showTime(Get.context!, 5);
    }
  }

  setSelectType(int type) {
    ///防止多次点击
    if (type != 5 && type == selectType.value) {
      return;
    }
    if (type != 5) {
      startTimestamp = "";
      endTimestamp = "";
      startTime.value = "";
      endTime.value = "";
    }
    selectType.value = type;
    openSelectTypeTime.value = false;

    ///切换时间清除就数据
    listData.clear();

    ///重制统计数据
    statistics = ['0', '0.00', '0.00'];
    loading = true;
    update();
    getH5OrderList();
  }

  ///自定义时间控件
  void showTime(BuildContext context, int type) {
    // lastSelectType = selectType.value;
    selectType.value = type;
    openSelectTypeTime.value = true;

    showTimeBottom.showModalBottom(
      context,
      onDateTimeChanged: (date) {
        ///开始时间
        startTime.value = DateUtil.formatDateMs(
          date[0].millisecondsSinceEpoch,
          format: DateFormats.y_mo_d,
        ).toString();
        startTimestamp = date[0].millisecondsSinceEpoch.toString();

        ///结束时间
        endTime.value = DateUtil.formatDateMs(
          date[1].millisecondsSinceEpoch,
          format: DateFormats.y_mo_d,
        ).toString();

        ///如果结束时间是今天 那么取当前时间戳而不是当天的零点
        if (DateTime.now().difference(date[1]).inDays == 0) {
          endTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
        } else {
          endTimestamp = date[1].millisecondsSinceEpoch.toString();
        }

        setSelectType(type);
      },
      // cancel: (dynamic) {
      //   selectType.value = lastSelectType;
      // },
    );
  }

  ///请求列表数据
  Future<void> getH5OrderList() async {
    ///当使用时间选择的时候不能传timeType这个参数给后台
    final GetH5OrderListEntity res;

    if (selectType.value != 5) {
      res = await BetApi.instance().getH5OrderList('1', '',
          timeType: selectType.value == 4 ? 3 : selectType.value,

          ///已结注单30天的记录业务后台不支持，30天跟查7天一样的传参，其实就是查7天,优化单94134有注明
          page: page,
          size: size,
          outright: ChampionshipEventType.value);
    } else {
      res = await BetApi.instance().getH5OrderList('1', '',
          beginTime: startTimestamp,
          endTime: endTimestamp,
          page: page,
          size: size,
          orderBy: orderBy,
          outright: ChampionshipEventType.value);
    }
    String code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "0000000") {
      GetH5OrderListData data = res.data;

      ///已结注单统计数据
      statistics[0] = data.total;
      statistics[1] = data.betTotalAmount;
      statistics[2] = data.profit;

      ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
      if (data.record != null && data.record!.isNotEmpty) {
        Map<String, GetH5OrderListDataRecordx?> record = data.record ?? {};
        List<MapEntry<String, GetH5OrderListDataRecordx?>> entries =
            record.entries.toList();
        Map<String, GetH5OrderListDataRecordx?> reversedMap =
            Map.fromEntries(entries);

        ///便利map，把数据全部房在一起。
        reversedMap.forEach((key, value) {
          listData.addAll(value!.data);
        });
      }
    }
    loading = false;
    update();
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

  /*
  用来跳转赛事详情的
   */
  getExistMatchResult(
      String matchId, String playOptionsId, int sportId, String time,
      {String dataSourceCode = ""}) async {
    ///vr体育6种，vr足球，vr篮球 vr赛狗，vr赛马，vr摩托车，vr泥地摩托车
    ///vr不支持跳转赛事详情
    if ([1001, 1004, 1009, 1010, 1011, 1002].contains(sportId)) {
      //  ToastUtils.show("vr赛事");
      return;
    }

    ///电子赛事也不支持跳转(预约中和已失效，没有电子赛事)
    if (dataSourceCode.isNotEmpty) {
      if (["RC", "C01", "OD"].contains(dataSourceCode)) {
        //  ToastUtils.show("电子赛事");
        return;
      }
    }

    ///来判断赛事，开赛有没超过15天，超过15天不允许跳转赛事详情
    if (BetsUtils.isOver15Days(time)) {
      // ToastUtils.show("当前赛事超过开赛15天");
      return;
    }

    ///获取赛事状态
    final res =
        await BetApi.instance().existMatchResult(matchId, playOptionsId);

    ///判断code == "0000000"就是成功拿到数据
    if (res.code == "0000000") {
      ///赛事没有结束才可以跳详情
      if (!res.data.matchEnd) {
        //确保当前界面存在
        if (isClosed) {
          return;
        }
        // 关闭当前界面
        Bus.getInstance().emit(EventType.tyCloseDialog);
        Get.back();

        ///跳转赛事详情
        RouteManager.goMatchDetail(
            mid: matchId,
            csid: sportId.toString(),
            isESports: [
              SportData.sportCsid_100,
              SportData.sportCsid_101,
              SportData.sportCsid_102,
              SportData.sportCsid_103,
              SportData.sportCsid_104,
              SportData.sportCsid_105,
            ].contains(sportId));
      }
    }
  }
}
