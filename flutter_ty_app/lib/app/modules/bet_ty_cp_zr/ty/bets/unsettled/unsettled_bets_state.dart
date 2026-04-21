
import 'dart:core';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../services/models/res/get_cashout_max_amount_list_entity.dart';
import '../../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../../services/models/res/get_match_limit_info_by_mids_entity.dart';
import '../../../../login/login_head_import.dart';

class UnsettledBetsState {
  /// UI界面展示使用
  var startTime = "".obs;

  /// UI界面展示使用
  var endTime = "".obs;

  ///默认获取当天零点时间戳(网络请求使用)
  var startTimestamp = "";

  ///默认获取当前时间戳(网络请求使用)
  var endTimestamp = "";

  /// c1:今日 2:昨日 3:近7日 4:近30日,5:自定义(自己定义的不传5，传起始时间戳和结束时间)
  var selectType = 0.obs;

  ///开启自定义时间
  var openSelectTypeTime = false.obs;

  ///记录上一次的（0:全部 1:今日 2:昨日 3:近7日 ）
  // var lastSelectType = -1;

  ///冠军赛事类型（ 0:全部赛事 1:冠军赛事）
  var ChampionshipEventType = 0;

  ///网络请求翻页
  var page = 1;

  ///未结算注单统计
  List<String> statistics = ['0', '0.00', '0.00'];

  ///请求数据条数
  final int size = 300;

  ///  排序方式 1投注时间,2 结算时间
  final int orderBy = 1;

  ///  提前结算的轮训，赛事比分时间的轮训
  Timer? _timer, _matchLimitInfoByMidsTimer;

  ///数据列表
  List<GetH5OrderListDataRecordxData> listData = [];

  ///提前结算列表数据
  List<GetCashoutMaxAmountListData> maxAmountListData = [];

  /// 赛事阶段比分列表
  RxList<GetMatchLimitInfoByMidsDataData> matchInfoList =
      <GetMatchLimitInfoByMidsDataData>[].obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  ///加载展示
  bool loading = true;

  /// settleSwitch                    足球提前结算开关
  bool settleSwitch = false;

  /// settleSwitchBasket              篮球提前结算开关
  bool settleSwitchBasket = false;

  /// sysBookedSettleSwitch           系统预约提前结算开关
  bool sysBookedSettleSwitch = false;

  /// sysPartSettleSwitch             系统部分提前结算开关
  bool sysPartSettleSwitch = false;

  /// bookedSettleSwitchFootball      预约提前结算开关-足球
  bool bookedSettleSwitchFootball = false;

  /// bookedSettleSwitchBasketball    预约提前结算开关-篮球
  bool bookedSettleSwitchBasketball = false;

  /// partSettleSwitchFootball        部分提前结算开关-足球
  bool partSettleSwitchFootball = false;

  /// partSettleSwitchBasketball      部分提前结算开关-篮球
  bool partSettleSwitchBasketball = false;
}
