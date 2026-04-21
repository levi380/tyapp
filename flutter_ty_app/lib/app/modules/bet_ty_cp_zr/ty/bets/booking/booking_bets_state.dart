import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';


class BookingBetsState {
  ///注单类型（ 0:预约 1:失效）
  var betsTypes = 0;

  List<GetH5PreBetOrderlistDataRecordxData> listData = [];
  ScrollController scrollController = ScrollController();

  //加载展示
  bool loading = true;

  RefreshController refreshController = RefreshController(
      initialRefresh: false);

  /// UI界面展示使用
  var startTime = "".obs;

  /// UI界面展示使用
  var endTime = "".obs;

  ///默认获取当天零点时间戳(网络请求使用)
  var startTimestamp = "";

  ///默认获取当前时间戳(网络请求使用)
  var endTimestamp = "";

  /// 0:全部 1:今日 2:昨日 3:近7日 4:近30日,5:自定义(自己定义的不传5，传起始时间戳和结束时间)
  var selectType = 0.obs;

  ///开启自定义时间
  var openSelectTypeTime = false.obs;

  ///记录上一次的（0:全部 1:今日 2:昨日 3:近7日）
  // var lastSelectType = -1;

  ///网络请求翻页
  var page = 1;

  ///注单统计
  List<String> statistics = ['0', '0.00', '0.00'];

  ///请求数据条数
  final int size = 300;

  ///开启提示
  var isOpenTips = false.obs;

}
