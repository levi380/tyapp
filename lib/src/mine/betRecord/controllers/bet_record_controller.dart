import 'package:filbet/common/currency.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/mine/betRecord/bet_record_model.dart';
import 'package:filbet/src/mine/transactionRecord/models/trade_dict.dart';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:filbet/services/global/global_service.dart';

import 'package:filbet/api/api.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/src/mine/betRecord/bet_record_model.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/filter/filter_model.dart';
import 'package:filbet/services/user/user_service.dart';

enum BetRecordType {
  unsettled,
  settled,
  cancel,
  unavailable;

  int get code {
    switch (this) {
      case BetRecordType.unsettled:
        return 0;
      case BetRecordType.settled:
        return 1;
      case BetRecordType.cancel:
        return 2;
      case BetRecordType.unavailable:
        return 3;
    }
  }

  String get value => code.toString();

  static BetRecordType fromCode(int code) {
    switch (code) {
      case 0:
        return BetRecordType.unsettled;
      case 1:
        return BetRecordType.settled;
      case 2:
        return BetRecordType.cancel;
      case 3:
        return BetRecordType.unavailable;
      default:
        throw ArgumentError('Invalid BetRecordType code: $code');
    }
  }

  String get name {
    switch (this) {
      case BetRecordType.unsettled:
        return 'unsettled'.tr;
      case BetRecordType.settled:
        return 'settled'.tr;
      case BetRecordType.cancel:
        return 'canceled'.tr;
      case BetRecordType.unavailable:
        return 'invalid'.tr;
    }
  }
}

class BetRecordController extends GetXBaseController
    with GetTickerProviderStateMixin {
  RxList<BetRecordItem> records = <BetRecordItem>[].obs;

  bool get isEmpty {
    return records.value.isEmpty;
  }

  RxInt total = 0.obs;
  RxString totalWin = "0.0".obs;
  RxString totalBet = "0.0".obs;

  String startTimestamp = "";
  String endTimestamp = "";

  final List<SubFilterModel> currencyList = [];

  RxBool expanded = true.obs;
  final List<SubFilterModel> dateList = [
    SubFilterModel(name: 'today'.tr, value: '1'),
    SubFilterModel(name: 'yesterday'.tr, value: '2'),
    SubFilterModel(name: 'last_7_days'.tr, value: '7'),
    SubFilterModel(name: 'last_30_days'.tr, value: '30'),
//    SubFilterModel(name: '', value: '5'),
  ];

  final tradeDictList = <TradeDict>[].obs;
  final tradeTopDictList = <TradeDict>[].obs;

  // 筛选参数
  Currency currency = Currency.rmb;

  final RxList<FilterModel> selectDate = <FilterModel>[].obs;

  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void onInit() {
    super.onInit();

    currencyList.addAll(GlobalService.to.state.currencyConfig.map(
      (currency) {
        return SubFilterModel(
          name: currency.abbr.toLowerCase().tr,
          value: currency.abbr,
        );
      },
    ).toList());
    currency = UserService.to.state.currencyType;

    final timeRange = getTimeRangeFromDateValue("1");
    if (startTimestamp != timeRange.start || endTimestamp != timeRange.end) {
      setTimeRange(timeRange.start, timeRange.end);
    }
    configpopupKeys();
  }

  @override
  void onReady() {
    super.onReady();
    queryFilterDictionary();
  }

  void changeTopDict(TradeDict model) {
    if (model.isSelected) {
      return;
    }
    for (var item in tradeDictList) {
      item.isSelected = false;
      item.bottomSelected = false;
    }
    model.isSelected = true;
    model.bottomSelected = true;
    tradeDictList.refresh();
    tradeTopDictList.refresh();
    fetchDataLoading();
  }

  void changeBottomDict() {
    for (var item in tradeDictList) {
      item.isSelected = item.bottomSelected;
      if (item.isSelected && !tradeTopDictList.contains(item)) {
        tradeTopDictList.add(item);
      }
    }
    tradeDictList.refresh();
    tradeTopDictList.refresh();
    fetchDataLoading();
  }

  //
  int findCurrencyIndex(String value) {
    return currencyList.indexWhere((e) => e.value == value);
  }

  // 设置货币类型
  void setCurrency(Currency currency) {
    this.currency = currency;
  }

  void queryFilterDictionary() async {
    if (GlobalService.to.state.allPlatformNameConfig.isEmpty) {
      await GlobalService.to.getHomeNewGames();
    }
    for (var platform in GlobalService.to.state.allPlatformNameConfig) {
      tradeDictList.add(TradeDict(
          name: platform.name, type: num.tryParse(platform.id ?? '')));
    }
    tradeDictList.insert(0, TradeDict(name: '全部'));
    if (tradeDictList.isNotEmpty) {
      tradeDictList[0].isSelected = true;
      tradeDictList[0].bottomSelected = true;
      tradeTopDictList.value = tradeDictList;
    }
    fetchDataLoading();
  }

  Future<void> fetchDataLoading() async {
    await fetchHandler(
      _fetchData(true),
      onSuccess: (token) async {},
      onError: (exception) {},
      loading: true,
    );
  }

  // 设置时间范围
  void setTimeRange(
    String startTimestamp,
    String endTimestamp,
  ) {
    this.startTimestamp = startTimestamp;
    this.endTimestamp = endTimestamp;
  }

  configpopupKeys() {
    selectDate.value = [
      FilterModel(
        type: FilterType.date,
        title:
            'currently_only_supports_querying_transaction_records_for_the_past_m_months'
                .tr
                .replaceAll("{m}", "2"),
        list: dateList,
        currentModel: dateList[0],
        selectIndex: 0,
        selectModel: dateList[0],
      ),
    ];
  }

  // 根据日期筛选值获取时间范围
  ({String start, String end}) getTimeRangeFromDateValue(String dateValue) {
    return getTimeRangeByType(dateValue);
  }

  // 按照投注时间分组 - 基于累积的所有记录
  List<List<BetRecordItem>> groupedBetRecordItemByBetTimeWithAllRecords(
      List<BetRecordItem> allRecords) {
    // 按照投注时间分组
    if (allRecords.isEmpty) {
      return [];
    }

    final Map<int, List<BetRecordItem>> groupedRecords = {};
    for (var item in allRecords) {
      final dateKey = item.betTime ~/ 86400000; // 按天分组
      groupedRecords.putIfAbsent(dateKey, () => []).add(item);
    }

    // 按日期倒序排列
    final sortedKeys = groupedRecords.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    return sortedKeys.map((key) => groupedRecords[key]!).toList();
  }

  fetchData({bool isRefresh = false}) async {
    if (GlobalService.to.state.allPlatformNameConfig.isNotEmpty) {
      await GlobalService.to.platformListNew();
    }
    _fetchData(
      isRefresh,
      onSuccess: (hasMore) {
        if (isRefresh) {
          easyRefreshController.finishRefresh();
          easyRefreshController.resetFooter();
        } else {
          easyRefreshController.finishLoad(
              hasMore ? IndicatorResult.success : IndicatorResult.noMore);
        }
      },
    );
  }

  applyFilters() {
    _fetchData(true);
  }

  _fetchData(bool isRefresh, {Function(bool hasMore)? onSuccess}) async {
    try {
      Map<String, dynamic> queryParameters = {
        'page_size': kPaginationSize,
        'start_at': startTimestamp,
        'end_at': endTimestamp,
        'currency': int.parse(currency.code),
        if (convertType() != null) 'platform_id': convertType()
      };

      if (isRefresh == false) {
        queryParameters['cur'] = records.last.id;
      }
      final response =
          await HttpClient.get(Api.betList, queryParameters: queryParameters);

      if (response.status == false) {
        records.value = [];
        onSuccess?.call(false);
        return;
      }

      List<dynamic> rawList = response.data["d"] ?? [];

      //   List<dynamic> rawList = res.data["data"] ?? [];
      List<BetRecordItem> transactions = rawList
          .map((e) => BetRecordItem.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      if (isRefresh == false) {
        records.addAll(transactions);
      } else {
        total.value = response.data["t"] ?? 0;
        records.value = transactions;

        totalWin.value = response.data['wt']?.toString() ?? '0.00';
        totalBet.value = response.data['bt']?.toString() ?? '0.00';
      }

      update();

      bool hasMore = records.length < total.value;

      onSuccess?.call(hasMore);
    } catch (e) {
      e.printError();
    }
  }

  ///进入详情页
  void jumpToDetail(BetRecordItem item) {
    Get.toNamed(
      Routes.BET_RECORD_DETAIL,
      arguments: {'betRecordItem': item, 'currency': currency},
    );
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

  String replaceStr(String str, String symbol) {
    symbol = '';
    if (isAreAllZero(str)) return str;
    if (str.startsWith("-")) {
      return str.replaceFirst("-", "-$symbol");
    } else {
      return "+$symbol$str";
    }
  }

  bool isAreAllZero(String content) {
    return double.tryParse(content.replaceAll(RegExp(r'[^0-9\.]'), '')) == 0;
  }

  String? convertType() {
    return tradeDictList.firstWhere((item) => item.isSelected).type?.toString();
  }
}
