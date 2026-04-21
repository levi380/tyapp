
import '../../../../services/api/bet_api.dart';
import '../../../../services/models/res/cp_order_list_entity.dart';
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
    【【【 AUTO_PARAGRAPH_TITLE 追号记录控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能管理与追号记录相关的数据状态和逻辑，包括数据请求、时间选择和统计信息
    - `settled`：记录状态（0: 未结算, 1: 已结算）。
    - `type`：时间类型（1: 今日, 2: 昨日, 3: 近7日, 5: 自定义）。
    - `startTime` 和 `endTime`：用于 UI 展示的开始和结束时间。
    - `startTimestamp` 和 `endTimestamp`：用于网络请求的时间戳。
    - `page`：网络请求的页码。
    - `size`：请求数据的条数（默认为 999）。
    - `loading`：指示数据是否正在加载。
    - `statistics`：统计数据列表。
    - `list`：存储追号记录数据。
    - this.settled：构造方法初始化时传入的结算状态。
    - setType() 设置时间类型并清除相关数据，重新请求数据。：
    - showTime() 显示自定义时间选择器，并处理时间选择结果。
    - onReady() 页面准备就绪时调用，默认加载数据。
    - getChaseOrderList() 请求追号记录数据，并更新 `list` 和 `statistics`。
    - onClose() 页面关闭时调用，释放资源。
    】】】
 *
 */
class AdditionalRecordsLogic extends GetxController {
  /**
   * 0:未结算
   * 1:已结算
   */
  late int settled = 0;

  /// 1:今日 2:昨日 3:近7日 5:自定义
  var type = 1.obs;

  /// UI界面展示使用
  var startTime = "".obs;

  /// UI界面展示使用
  var endTime = "".obs;

  ///默认获取当天零点时间戳(网络请求使用)
  String startTimestamp = "";

  ///默认获取当前时间戳(网络请求使用)
  String endTimestamp = "";

  ///网络请求翻页
  var page = 1;

  ///请求数据条数
  final int size = 999;

  ///加载展示
  bool loading = true;

  ///统计数据
  List<double> statistics = [];

  ///列表数据
  List<CpOrderListList> list = [];

  ///构造方法传值
  AdditionalRecordsLogic(this.settled);

  setType(int type, {bool isStart = false}) {
    ///防止重复点击
    if (!isStart) {
      if (type != 5 && this.type.value == type) {
        return;
      }
    }

    if (type != 5) {
      startTimestamp = "";
      endTimestamp = "";
      startTime.value = "";
      endTime.value = "";
    }

    this.type.value = type;

    ///切换时间清除就数据
    list.clear();
    statistics = List<double>.filled(
      4,
      0,
    );
    loading = true;
    update();
    getChaseOrderList();
  }

  ///自定义时间控件
  void showTime(BuildContext context, int type) {
    ///开始时间
    startTimestamp = DateUtil.formatDateMs(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).millisecondsSinceEpoch,
      format: DateFormats.y_mo_d,
    ).toString();

    ///结束时间
    endTimestamp = DateUtil.formatDateMs(
      DateTime.now().millisecondsSinceEpoch,
      format: DateFormats.y_mo_d,
    );
    showTimeBottom.showModalBottom(context, onDateTimeChanged: (date) {
      ///开始时间
      startTime.value = DateUtil.formatDateMs(date[0].millisecondsSinceEpoch,
              format: DateFormats.y_mo_d,  )
          .toString();
      startTimestamp = date[0].millisecondsSinceEpoch.toString();

      ///结束时间
      endTime.value = DateUtil.formatDateMs(date[1].millisecondsSinceEpoch,
              format: DateFormats.y_mo_d,  )
          .toString();

      ///如果结束时间是今天 那么取当前时间戳而不是当天的零点
      if (DateTime.now().difference(date[1]).inDays == 0) {
        endTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
      } else {
        endTimestamp = date[1].millisecondsSinceEpoch.toString();
      }
      setType(type);
    });
  }

  @override
  void onReady() {
    setType(
      1,
      isStart: true,
    );
    super.onReady();
  }

  ///追号记录
  Future<void> getChaseOrderList() async {
    final res = await BetApi.instance().getChaseOrderList(
        false, page, settled, size, type.value, startTimestamp, endTimestamp);
    String? code = res.code;

    ///判断code == "200"就是成功拿到数据
    if (code == "200") {
      list = res.data!.list;
      statistics[0] = res.data!.total;
      statistics[1] = res.data!.totalBetAmount;
      statistics[2] = res.data!.totalValidBetAmount;
      statistics[3] = res.data!.totalWinAmount;
    }
    loading = false;
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
