import 'dart:convert';
import 'dart:math' as math;

import 'package:easy_refresh/easy_refresh.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/resp_redeem_record.dart';
import 'package:filbet/http/entity/resp_winner_record.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/activity/model/config_model.dart';
import 'package:filbet/src/activity/model/promo_report_model.dart';
import 'package:filbet/src/deposit_activity/views/first_deposit_model.dart';
import 'package:filbet/src/mine/transactionRecord/models/trade_dict.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/filter/filter_model.dart';
import 'package:get/get.dart';
import 'package:filbet/http/http_client.dart';

class MatchBettingHisController extends GetxController {
  final List<SubFilterModel> dateList = [
    SubFilterModel(name: 'today'.tr, value: '1'),
//    SubFilterModel(name: 'yesterday'.tr, value: '2'),
    SubFilterModel(name: 'last_7_days'.tr, value: '7'),
    SubFilterModel(name: 'last_30_days'.tr, value: '30'),
    SubFilterModel(name: 'all'.tr, value: '0'),
  ];

  final records = <RedeemRecordModel>[].obs;
  String currencyStr = "102";

  final tradeDictList = <TradeDict>[].obs;

  int type = 0; // 全部为1
  int initialIndex = 0; // 初始化tabIndex
  int welfaredType = 1; //  默认 待领取

  String? id;
  RxInt gameTime = 0.obs;
  RxString mainTeamName = "".obs;
  RxString visitingTeamName = "".obs;
  RxList<PromoReportModel> list = RxList.empty();
  RxList<PromoReportModel> originalList = RxList.empty();

  final RxList<FilterModel> selectDate = <FilterModel>[].obs;

  final RxList<FilterModel> selectList = <FilterModel>[].obs;
  final RxList<FilterModel> filterModelList = <FilterModel>[].obs;

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String startTimestamp = "";
  String endTimestamp = "";
  RxString typeStr = "全部".obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments.containsKey('id')) {
      id = Get.arguments['id'];
    }
    if (Get.arguments != null && Get.arguments.containsKey('gameTime')) {
      gameTime.value = Get.arguments['gameTime'] ?? 0;
    }
    if (Get.arguments != null && Get.arguments.containsKey('mainTeamName')) {
      mainTeamName.value = Get.arguments['mainTeamName'] ?? 0;
    }
    if (Get.arguments != null &&
        Get.arguments.containsKey('visitingTeamName')) {
      visitingTeamName.value = Get.arguments['visitingTeamName'] ?? 0;
    }
    _promoReportList();

    final timeRange = getTimeRangeFromDateValue("5");
    if (startTimestamp != timeRange.start || endTimestamp != timeRange.end) {
      setTimeRange(timeRange.start, timeRange.end);
    }

    selectDate.value = [
      FilterModel(
        type: FilterType.date,
        title:
            'currently_only_supports_querying_transaction_records_for_the_past_m_months'
                .tr
                .replaceAll("{m}", "2"),
        list: dateList,
        currentModel: dateList[3],
        selectIndex: 3,
        selectModel: dateList[3],
      ),
    ];

    tradeDictList.value = [
      TradeDict(
        type: 0,
        name: "全部",
      ),
      TradeDict(
        type: 1,
        name: "竞猜",
      ),
      // TradeDict(
      //   type: 2,
      //   name: "赛事",
      // )
    ];
    if (tradeDictList.isNotEmpty) {
      tradeDictList[0].isSelected = true;
      tradeDictList[0].bottomSelected = true;
    }
  }

  ///状态筛选数据
  void filterListByState() {
    TradeDict? selectedTradeDict;
    for (var item in tradeDictList) {
      item.isSelected = item.bottomSelected;
      if (item.isSelected) {
        selectedTradeDict = item;
        break;
      }
    }
    if (selectedTradeDict==null) {
      typeStr.value = "全部";
      list.value = originalList;
    } else {
      var t = selectedTradeDict.type;
      typeStr.value = selectedTradeDict.name??"";
      if(t==0){
        list.value = originalList;
      }else{
        list.value = originalList.where((e) => e.activeType == t).toList();
      }
    }
  }

  ///根据时间筛选数据
  void filterListByTime(int startTime,int endTime,{bool isQuryAll = false}) {
    if(isQuryAll){
      //查全部时间
      list.value = originalList;
    }else{
      list.value = originalList.where((e) {
        final t = e.submitAt!;
        if (startTime != null && t < startTime) return false;
        if (endTime != null && t > endTime) return false;
        return true;
      }).toList();
    }

  }

  Future<void> _promoReportList() async {
    var response = await HttpClient.post(Api.activityWinnerRecord,
        data: {'id': id ?? "", 'ty': "5"});
    if (response.status == false) {
      throw response.error!;
    }
    Map riddle = response.data["riddle"];
    riddle.forEach((key, value) {
      List<dynamic> data = value ?? [];
      var tempList =
          data.map((e) => PromoReportModel.fromJson(Map.from(e))).toList();
      list.addAll(tempList);
    });
    Map contest = response.data["contest"];
    contest.forEach((key, value) {
      List<dynamic> data = value ?? [];
      var tempList =
          data.map((e) => PromoReportModel.fromJson(Map.from(e))).toList();
      list.addAll(tempList);
    });

    //保存原始数据
    originalList.clear();
    originalList.addAll(list);
  }

  void resetInvalidSelections(List<FilterModel> filters) {
    for (var filter in filters) {
      if (filter.selectModel != null &&
          filter.selectModel!.value != filter.currentModel.value) {
        filter.selectModel = filter.currentModel;
        filter.selectIndex = filter.list?.indexOf(filter.currentModel) ?? 0;
      }
    }
  }

  // 根据日期筛选值获取时间范围
  ({String start, String end}) getTimeRangeFromDateValue(String dateValue) {
    return getTimeRangeByType(dateValue);
  }

  // 设置时间范围
  void setTimeRange(
    String startTimestamp,
    String endTimestamp,
  ) {
    this.startTimestamp = startTimestamp;
    this.endTimestamp = endTimestamp;
  }

  applyFilters() {
    // _fetchData(true);
  }
}
