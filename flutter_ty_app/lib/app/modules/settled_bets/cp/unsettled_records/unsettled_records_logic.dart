import '../../../../services/api/bet_api.dart';
import '../../../../services/models/res/api_res.dart';
import '../../../../services/models/res/get_order_cp_list_entry_entity.dart';
import '../../../login/login_head_import.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/widgets/date_picker/show_time_bottom.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注记录控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能，是一个用于管理未结算投注记录的控制器，继承自 `GetxController`。它负责处理与未结算记录相关的状态、数据请求和逻辑。
    - 属性
    - timeType: 当前时间类型（1: 今日, 2: 昨日, 3: 近7日, 5: 自定义）。
    - ticketResult: 票据结果（字符串）。
    - seriesCode: 系列代码（字符串）。
    - ballList: 球的状态列表（布尔值列表）。
    - startTime: 开始时间（可观察字符串）。
    - endTime: 结束时间（可观察字符串）。
    - loading: 加载状态（布尔值）。
    - settled: 结算状态（0: 未结算, 1: 已结算）。
    - orderListItemList: 存储订单项的列表（`GetOrderCpListEntryList` 类型）。
    - orderCpListData: 存储订单数据的对象（`GetOrderCpListEntryEntity` 类型）。
    - pageIndex: 当前页索引（整数）。
    - pageSize: 每页大小（整数）。
    - orderStatus: 订单状态（整数）。
    - startTimestamp: 默认获取当天零点时间戳（字符串）。
    - endTimestamp: 默认获取当前时间戳（字符串）。
    - total: 总投注数量（数字）。
    - totalBetAmount: 总投注额（数字）。
    - totalCanWinAmount: 总可赢金额（数字）。
    - totalWinAmount: 总中奖金额（数字）。
    - onReady()在控制器准备好时调用，触发数据加载。
    - setType() 设置时间类型并清除之前的数据，调用数据请求方法。
    - showTime() 显示时间选择控件，允许用户选择自定义时间范围。
    - getH5OrderList() 异步请求未结算订单列表数据，处理响应并更新状态。
    - onClose() 关闭控制器时调用，可以在此处释放资源。
    】】】
 *
 */
class UnsettledRecordsLogic extends GetxController {
  /// 1:今日 2:昨日 3:近7日 5:自定义
  var timeType = 1.obs;
  String ticketResult = "";
  String seriesCode = "";
  List<bool> ballList = [];

  /// UI界面展示使用
  var startTime = "".obs;

  /// UI界面展示使用
  var endTime = "".obs;

  ///加载展示
  bool loading = true;

  /**
   * 0:未结算
   * 1:已结算
   */
  int settled = 0;

  List<GetOrderCpListEntryList> orderListItemList = [];
  GetOrderCpListEntryEntity? orderCpListData;
  int pageIndex = 1;
  int pageSize = 999;
  int orderStatus = 0;

  //  ScrollController scrollController = ScrollController();

  ///默认获取当天零点时间戳(网络请求使用)
  String startTimestamp = "";

  ///默认获取当前时间戳(网络请求使用)
  String endTimestamp = "";

  /// 总投注数量
  num total = 0;

  /// 总投注额
  num totalBetAmount = 0;

  /// 总投注数量
  num totalCanWinAmount = 0;

  /// 总中奖金额
  num totalWinAmount = 0;

  ///构造方法传值
  UnsettledRecordsLogic(this.settled);

  @override
  void onReady() {
    super.onReady();
    getH5OrderList();
  }

  setType(int timeType, {bool isStart = false}) {
    ///防止重复点击
    if (!isStart) {
      if (timeType != 5 && this.timeType.value == timeType) {
        return;
      }
    }
    if (timeType != 5) {
      startTimestamp = "";
      endTimestamp = "";
      startTime.value = "";
      endTime.value = "";
    }

    this.timeType.value = timeType;

    orderListItemList.clear();
    loading = true;
    update();
    getH5OrderList(timeType: timeType);
  }

  ///自定义时间控件
  void showTime(BuildContext context, int timeType) {
    startTimestamp = DateUtil.formatDateMs(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .millisecondsSinceEpoch,
      format: DateFormats.y_mo_d,
    ).toString();
    endTimestamp = DateUtil.formatDateMs(
      DateTime.now().millisecondsSinceEpoch,
      format: DateFormats.y_mo_d,
    );

    showTimeBottom.showModalBottom(context, onDateTimeChanged: (date) {
      ///开始时间
      startTime.value = DateUtil.formatDateMs(
        date[0].millisecondsSinceEpoch,
        format: DateFormats.y_mo_d,
      ).toString();
      startTimestamp = date[0].millisecondsSinceEpoch.toString();

      setType(timeType);

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
      setType(timeType);
    });
  }

  ///请求列表数据
  Future<void> getH5OrderList({
    bool? chaseFlag,
    int? page,
    int? size,
    int? timeType,
    String? startTime,
    String? endTime,
  }) async {
    ApiRes<GetOrderCpListEntryEntity> res = ApiRes();
    try {
      res = await BetApi.instance().getCpOrderCpListData(
          chaseFlag ?? false,
          page ?? 1,
          settled,
          size ?? 999,
          timeType,
          startTime ?? startTimestamp,
          endTime ?? endTimestamp);
    } catch (e) {

      loading = false;
      update(["totalAmountUnsettlementBetsView", "UnsettledRecordsLogicBody"]);
    }
    String? code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "200" || code == '0000000') {
      GetOrderCpListEntryEntity? data = res.data;
      if (data != null) {
        if (data.list != null) {
          orderListItemList = data.list!;
        }
        total = data.total ?? 0;
        totalBetAmount = data.totalBetAmount ?? 0;
        totalCanWinAmount = data.totalCanWinAmount ?? 0;
        totalWinAmount = data.totalWinAmount ?? 0;
        update(
            ["totalAmountUnsettlementBetsView", "UnsettledRecordsLogicBody"]);
      }
    } else {}
    loading = false;
    update(["totalAmountUnsettlementBetsView", "UnsettledRecordsLogicBody"]);
  }

  ///请求列表数据

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
