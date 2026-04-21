import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../../../services/models/res/all_order_list_entity.dart';
import '../../../services/models/res/cp_order_list_entity.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../services/models/res/get_order_list_zr_entity.dart';
import '../../home/models/refresh_status.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育类型注单State】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 体育注单控制类。获取体育注单数据，处理提前结算
    】】】
 *
 */
class BetRecordState {
  /// 刷新中
  RefreshStatus refreshStatus = RefreshStatus.isLoading;
  String? errorMsg ;

  int orderType = 0;
  int orderStatus = 0;
  int timeType = 1;

  /// UI界面展示使用
  var startTimeUi = "";
  /// UI界面展示使用
  var endTimeUi = "";
  ///默认获取当天零点时间戳(网络请求使用)
  String startTime = "";
  ///默认获取当前时间戳(网络请求使用)
  String endTime = "";

  bool isExapndedAll = false;
  Set<String> expanedSet = {};
  Set<String> mixExpanedSet = {};

  List<AllOrderListList> dataList = [];
  List<CpOrderListList> cpDataList = [];
  List<GetOrderListZrDataList> zrDataList = [];
  List<GetH5OrderListDataRecordxData> tyDataList = [];
  int pageIndex = 1;
  int pageSize = 999;

  ///网络请求翻页
  var page = 1;

  ///请求数据条数
  final int size = 300;

  final ScrollController scrollController = ScrollController();
  ui.Image? sliderBlockImage;

  BetRecordState() {
    ///Initialize variables
  }
}