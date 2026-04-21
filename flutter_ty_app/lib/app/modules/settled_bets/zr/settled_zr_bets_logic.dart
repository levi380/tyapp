import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/res/get_order_list_zr_entity.dart';
import '../../../services/models/res/round_video_entity.dart';
import '../../../utils/DateTimeUtils.dart';
import '../settled_bets_state.dart';
import 'package:flutter_ty_app/app/widgets/date_picker/show_time_bottom.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-bd58c8a0-e850-406d-82ea-e9d19c8f5403-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结算/已结算注单逻辑 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    ## SettledZrBetsLogic描述
    负责处理彩票真人投注结算的逻辑，包括数据请求、状态管理和时间选择。

    ## 属性
    - `state`: `SettledBetsState` 实例，保存投注状态。
    - `listData`: 存储订单列表数据。
    - `zrdata`: 单个订单数据。
    - `roundVideoData`: 存储视频回放数据。
    - `page`: 当前请求的页码，默认为 1。
    - `size`: 每次请求的数据条数，默认为 999。
    - `loading`: 加载状态，默认为 `true`。
    - `BetsType`: 真人时间类型，默认为 1。
    - `settled`: 结算状态，0 表示未结算，1 表示已结算。
    - `startTime`: 默认开始时间，获取过去 30 天的零点时间戳。
    - `endTime`: 默认结束时间，获取当前时间戳。
    - `startDateTime`: 滑动选中的开始日期。
    - `endDateTime`: 滑动选中的结束日期。
    - `startTime2`: 自定义开始时间。
    - `endTime2`: 自定义结束时间。
    - `refreshController`: 刷新控制器实例，初始不刷新。

    ## 方法

    ### 1. `onInit`
    - 初始化时调用的生命周期方法。

    ### 2. `onReady`
    - 准备就绪时调用，触发数据请求 `getZrOrderList`。

    ### 3. `onClose`
    - 关闭时调用，释放 `refreshController` 资源。

    ### 4. `setType`
    - 设置投注类型并更新状态。

    ### 5. `setTime`
    - 设置自定义开始和结束时间。

    ### 6. `showTime`
    - 显示时间选择控件，更新开始和结束时间。

    ### 7. `getZrOrderList`
    - 请求订单列表数据，并更新 `listData` 和 `loading` 状态。

    ### 8. `getRoundsVideoPath`
    - 请求视频回放数据。

    ### 9. `onLoadMore`
    - 加载更多数据，处理分页请求。

    ### 10. `leftRadius`
    - 根据投注类型返回左边距。

    ### 11. `rightRadius`
    - 根据投注类型返回右边距。

    ### 12. `formatBetStatus`
    - 格式化投注状态消息。

    ### 13. `getWinner`
    - 根据分数计算赢家，并返回相应消息。

    ### 14. `getScore`
    - 根据玩家类型返回对应的分数。

    ### 15. `getHand`
    - 解析扑克牌字符串，返回玩家的手牌。

    ### 16. `div`
    - 返回分割线组件，样式根据主题变化。

    】】】
 *
 */

class SettledZrBetsLogic extends GetxController {
  final SettledBetsState state = SettledBetsState();

  List<GetOrderListZrDataList> listData = [];
  late GetOrderListZrData zrdata;
  late List<RoundVideoData> roundVideoData = [];

  ///网络请求翻页
  var page = 1;

  ///请求数据条数
  final int size = 999;

  //加载展示
  bool loading = true;

  ///真人时间类型
  int BetsType = 1;

  /// settled 0 未结算  1 已结
  int settled = 0;

  SettledZrBetsLogic(this.settled);

  ///自定义开始结束时间

  ///默认获取当天零点时间戳
  String startTime = DateUtil.formatDateMs(
    DateTimeUtils.addDays(DateTime.now(), -30).millisecondsSinceEpoch,
    format: DateFormats.y_mo_d,
  ).toString();

  ///默认获取当前时间戳
  String endTime = DateUtil.formatDateMs(
    DateTime.now().millisecondsSinceEpoch,
    format: DateFormats.y_mo_d,
  ).toString();

  ///滑动选中的开始日期
  DateTime? startDateTime = DateTimeUtils.addDays(DateTime.now(), -30);

  ///滑动选中的结束日期
  DateTime? endDateTime = DateTime.now();

  ///开始时间
  String startTime2 = "";

  ///结束时间
  String endTime2 = "";

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getZrOrderList();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  setType(int type) {
    BetsType = type;
    update();
    getZrOrderList();
  }

  setTime(
    String startTime,
    String endTime,
  ) {
    this.startTime = startTime;
    this.endTime = endTime;
  }

  ///自定义时间控件
  void showTime(BuildContext context, int type) {
    showTimeBottom.showModalBottom(context, onDateTimeChanged: (date) {
      ///开始时间
      startTime2 = DateUtil.formatDateMs(
        date[0].millisecondsSinceEpoch,
        format: DateFormats.y_mo_d,
      ).toString();

      ///结束时间
      endTime2 = DateUtil.formatDateMs(
        date[1].millisecondsSinceEpoch,
        format: DateFormats.y_mo_d,
      ).toString();
      print("endDateTime:${endTime2}");

      ///如果结束时间是今天 那么取当前时间戳而不是当天的零点
      setTime(
          date[0].millisecondsSinceEpoch.toString(),
          DateTime.now().difference(date[1]).inDays == 0
              ? DateTime.now().millisecondsSinceEpoch.toString()
              : date[1].millisecondsSinceEpoch.toString());
      setType(type);
    });
  }

  ///请求列表数据
  Future<void> getZrOrderList() async {
    ///传参
    final res = await BetApi.instance().getOrderListZrSettled(
        BetsType == 5 ? endTime : "",
        BetsType == 5 ? startTime : "",
        settled,
        BetsType,
        page,
        size);
    String code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "200") {
      zrdata = res.data;
      listData = zrdata.list;
    }
    loading = false;
    update();
  }

  ///视频回放
  Future<void> getRoundsVideoPath(List<String> roundNo) async {
    ///传参
    await BetApi.instance().getRoundsVideoPath(roundNo).then((value) {
      if (value.code == "200") {
        roundVideoData = value.data;
      }
    });
  }

  onLoadMore() async {
    if (listData.isEmpty) {
      refreshController.loadComplete();
      return;
    }
    final res = await BetApi.instance().getOrderListZrSettled(
        endTime, startTime, settled, BetsType, page, size);
    String code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "200") {
      GetOrderListZrData data = res.data;
      listData.addAll(data.list);
      refreshController.loadComplete();
    } else {
      refreshController.loadComplete();
    }
    update();
  }

  ///未选择左边距
  double leftRadius(int type) {
    switch (type) {
      case 1:
        return 0;
      case 2:
        return BetsType == 1 ? 10 : 0;
      case 3:
        return BetsType == 2 ? 10 : 0;
      case 5:
        return BetsType == 3 ? 10 : 0;
      default:
        return 0;
    }
  }

  ///未选择右边距
  double rightRadius(int type) {
    switch (type) {
      case 1:
        return BetsType == 2 ? 10 : 0;
      case 2:
        return BetsType == 3 ? 10 : 0;
      case 3:
        return BetsType == 5 ? 10 : 0;
      case 5:
        return 0;
      default:
        return 0;
    }
  }

  /*状态区分*/
  String formatBetStatus(int status) {
    switch (status) {
      case 0:
        return LocaleKeys.zr_cp_Lottery_Bet_Slips_not_paid.tr;
      case 1:
        return LocaleKeys.zr_cp_Lottery_Bet_Slips_distributed.tr;
      case 2:
        return "";
      case 3:
        return "";
      default:
        return "";
    }
  }

  /*
  *输赢分类
  * */
  String getWinner(String str) {
    List<String> arr = str.split(';');
    int bScore = int.parse(arr[0].split(':')[1]);
    int pScore = int.parse(arr[1].split(':')[1]);
    if (pScore == bScore) {
      return LocaleKeys.zr_cp_footer_menu_zr_zrtext_4_contents9.tr;
    } else if (pScore > bScore) {
      return '${LocaleKeys.zr_cp_footer_menu_zr_zrtext_4_contents4.tr}${LocaleKeys.bet_record_bet_win.tr}';
    } else {
      return '${LocaleKeys.zr_cp_footer_menu_zr_zrtext_4_contents6.tr}${LocaleKeys.bet_record_bet_win.tr}';
    }
  }

  String getScore(String str, String player) {
    // 将输入字符串按分号分割成列表
    List<String> arr = str.split(';');
    // 根据传入的player参数返回不同的分数
    if (player == 'player') {
      return arr[1];
    }
    return arr[0];
  }

  /*扑克牌截取分类*/
  List<String> getHand(String? s, String player) {
    if (s == null) return [];
    List<String> arr = s.split(';');
    String str = '';
    if (player == 'player') {
      str = arr[1].substring(2);
    } else {
      str = arr[0].substring(2);
    }
    final cardRegex = RegExp(r'[♠♣♥♦](10|[2-9JQKA])');
    List<String> parsedCards = [];
    Iterable<Match> matches = cardRegex.allMatches(str);
    for (Match match in matches) {
      String result = match
          .group(0)!
          .replaceAll('♠', 'spades_')
          .replaceAll('♣', 'plum_')
          .replaceAll('♥', 'hearts_')
          .replaceAll('♦', 'cube_');
      parsedCards.add(result);
    }
    return parsedCards;
  }
}
