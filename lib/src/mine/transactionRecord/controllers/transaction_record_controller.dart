import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/mine/transactionRecord/models/trade_dict.dart';
import 'package:filbet/src/mine/transactionRecord/models/trade_record_model.dart';

import 'package:get/get.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/filter/filter_model.dart';

class TransactionRecordController extends GetXBaseController
    with GetTickerProviderStateMixin {
  static TransactionRecordController get to => Get.find();
  final tradeDictList = <TradeDict>[].obs;
  final tradeTopDictList = <TradeDict>[].obs;
  final records = <TradeRecordModel>[].obs;
  final List<SubFilterModel> dateList = [
    SubFilterModel(name: 'today'.tr, value: '1'),
    SubFilterModel(name: 'yesterday'.tr, value: '2'),
    SubFilterModel(name: 'last_7_days'.tr, value: '7'),
    SubFilterModel(name: 'last_30_days'.tr, value: '30'),
    //   SubFilterModel(name: '', value: '5'),
  ];
  final RxList<FilterModel> selectDate = <FilterModel>[].obs;

  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  String startTimestamp = "";
  String endTimestamp = "";
  int total = 0;
  int page = 1;

  TradeDict? selectedTradeDict; //选择的类型

  @override
  void onInit() {
    super.onInit();
    final timeRange = getTimeRangeFromDateValue("1");
    if (startTimestamp != timeRange.start || endTimestamp != timeRange.end) {
      setTimeRange(timeRange.start, timeRange.end);
    }
    configPopupKeys();
  }

  @override
  void onReady() {
    super.onReady();
    getFilterDictionary();
  }

  void configPopupKeys() {
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
    selectedTradeDict = model;
    tradeDictList.refresh();
    tradeTopDictList.refresh();
    fetchDataLoading();
  }

  void changeBottomDict() {
    for (var item in tradeDictList) {
      item.isSelected = item.bottomSelected;
      if (item.isSelected) {
        selectedTradeDict = item;
      }
      if (item.isSelected && !tradeTopDictList.contains(item)) {
        tradeTopDictList.add(item);
      }
    }
    tradeDictList.refresh();
    tradeTopDictList.refresh();
    fetchDataLoading();
  }

  ///跳转详情页面
  void jumpToDetail(TradeRecordModel item) {
    Get.toNamed(Routes.TRANSACTION_RECORD_DETAIL,
            arguments: {"item": item, 'tradeDict': selectedTradeDict})
        ?.then((onValue) {
      if (onValue is bool && onValue) {
        fetchDataLoading();
      }
    });
  }

  Future<void> fetchDataLoading() async {
    await fetchHandler(
      _fetchData(true),
      onSuccess: (token) async {},
      onError: (exception) {},
      loading: true,
    );
  }

  List<List<TradeRecordModel>> groupedItemsByDate(
      List<TradeRecordModel> originalList) {
    // 按照投注时间分组
    if (originalList.isEmpty) {
      return [];
    }

    final Map<int, List<TradeRecordModel>> groupedList = {};
    for (var item in originalList) {
      final dateKey = (item.createdAt?.toInt() ?? 0) ~/ 86400000; // 按天分组
      groupedList.putIfAbsent(dateKey, () => []).add(item);
    }

    // 按日期倒序排列
    final sortedKeys = groupedList.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    final grouped = sortedKeys.map((key) => groupedList[key]!).toList();
    return grouped;
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

  void applyFilters() {
    _fetchData(true);
  }

  void getFilterDictionary() async {
    final response = await HttpClient.get(Api.transactionDict);
    if (response.status == false) {
      return;
    }
    if (response.data is List) {
      List<dynamic> rawList = response.data ?? [];
      List<TradeDict> list = rawList
          .map((e) => TradeDict.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      if (list.isNotEmpty) {
        tradeDictList.addAll(list);
        if (tradeDictList.length >= 3) {
          tradeDictList[0].isSelected = true;
          tradeDictList[0].bottomSelected = true;
          selectedTradeDict = tradeDictList[0];
          tradeTopDictList.value = tradeDictList.sublist(0, 3);
        }
        fetchDataLoading();
      }
    } else {
      throw Exception('Invalid response format');
    }
  }

  fetchData({bool isRefresh = false}) {
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

  _fetchData(bool isRefresh, {Function(bool hasMore)? onSuccess}) async {
    try {
      if (isRefresh) {
        page = 1;
        // 切换类型/时间或下拉刷新时重置 footer，避免仍显示上一次的「没有更多」
        easyRefreshController.resetFooter();
      }
      Map<String, dynamic> queryParameters = {
        'page': page,
        'page_size': kPaginationSize,
        'start_at': startTimestamp,
        'end_at': endTimestamp,
        'type': convertType(),
      };
      final response =
          await HttpClient.post(Api.transactionList, data: queryParameters);

      if (response.status == false) {
        if (isRefresh) records.value = [];
        onSuccess?.call(false);
        return;
      }
      List<dynamic> rawList = response.data["data"] ?? [];
      List<TradeRecordModel> transactions =
          rawList.map((e) => TradeRecordModel.fromJson(e)).toList();

      if (isRefresh) {
        total = response.data["t"] ?? 0;
        records.value = transactions;
        // 刷新完成后下一页为 2，避免上拉加载更多时再次请求第 1 页导致重复
        page = 2;
      } else {
        records.addAll(transactions);
        total = response.data["t"] ?? total;
        page++;
      }

      update();

      bool hasMore = records.length < total;

      onSuccess?.call(hasMore);
    } catch (e) {
      e.printError();
      onSuccess?.call(false);
    }
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

  int convertType() {
    return tradeDictList.firstWhere((item) => item.isSelected).type?.toInt() ??
        0;
  }
}
