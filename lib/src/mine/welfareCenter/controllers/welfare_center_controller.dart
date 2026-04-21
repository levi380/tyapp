import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/mine/welfareCenter/models/tab_item_model.dart';
import 'package:filbet/src/mine/welfareCenter/views/bottom_platform_wallet_reward.dart';
import 'package:filbet/src/mine/welfareCenter/views/diglog_rewrd.dart';
import 'package:filbet/src/mine/welfareCenter/welfare_item_model.dart';
import 'package:filbet/utils/app_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:filbet/common/currency.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/http/http_client.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:filbet/utils/time_util.dart';
import 'dart:async';
import 'package:filbet/widgets/filter/filter_model.dart';
import 'package:filbet/services/user/user_service.dart';

class WelfareCenterController extends GetXBaseController
    with GetTickerProviderStateMixin {
  final records = <WelfareItemModel>[].obs;
  RxInt total = 0.obs;
  RxString receivedAmount = "0.0".obs; // 已经领取的总金额
  RxString canReceiveAmount = "0.0".obs; // 待领取的总金额
  RxString totalamount = "0.0".obs;
  List<ItemModel> typeList = [];
  String startTimestamp = "";
  String endTimestamp = "";
  late Timer _timer;
  final List<SubFilterModel> currencyList = [];

  final List<SubFilterModel> dateList = [
    SubFilterModel(name: 'today'.tr, value: '1'),
//    SubFilterModel(name: 'yesterday'.tr, value: '2'),
    SubFilterModel(name: 'last_7_days'.tr, value: '7'),
    SubFilterModel(name: 'last_30_days'.tr, value: '30'),
    SubFilterModel(name: 'all'.tr, value: '5'),
  ];

  List<SubFilterModel> welfareList = [
    SubFilterModel(name: 'allBenefits'.tr, value: '0'),
  ];

  final List<SubFilterModel> statusList = [
    // SubFilterModel(
    //     showName: 'all_statuses'.tr, name: 'all_statuses'.tr, value: '0'),
    SubFilterModel(name: 'to_receive'.tr, value: '1'),
    SubFilterModel(name: 'received'.tr, value: '2'),
    SubFilterModel(name: 'expired'.tr, value: '3'),
    SubFilterModel(name: '处理中'.tr, value: '4'),
    SubFilterModel(name: '领取失败'.tr, value: '5'),
  ];

  // 筛选参数
  Currency currency = Currency.rmb;
  String currencyStr = "101";
  final RxList<FilterModel> filterModelList = <FilterModel>[].obs;
  final RxList<FilterModel> selectList = <FilterModel>[].obs;

  final RxList<FilterModel> selectDate = <FilterModel>[].obs;

  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  ///筛选类型下标
  final RxInt filterTypeIndex = (-1).obs;

  int welfaredType = 1; //  默认 待领取
  int type = 0; // 全部为1
  int initialIndex = 0; // 初始化tabIndex

  late TabController tabController;
  final tabMenus = [TabItemModel(name: '福利记录'), TabItemModel(name: '兑奖记录')];
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments.containsKey('tabIndex')) {
      initialIndex = Get.arguments['tabIndex'];
    }

    tabController = TabController(
        length: tabMenus.length, vsync: this, initialIndex: initialIndex);
    currency = UserService.to.state.currencyType;
    currencyStr = currency.code;

    currencyList.addAll(GlobalService.to.state.currencyConfig.map(
      (currency) {
        return SubFilterModel(
          name: currency.abbr.toLowerCase().tr,
          value: currency.code,
        );
      },
    ).toList());

    final timeRange = getTimeRangeFromDateValue("5");
    if (startTimestamp != timeRange.start || endTimestamp != timeRange.end) {
      setTimeRange(timeRange.start, timeRange.end);
    }
    _fetchtype();
    configpopupKeys();
    _startTimer();
  }

  //
  int findCurrencyIndex(String value) {
    return currencyList.indexWhere((e) => e.value == value);
  }

  @override
  void onReady() {
    super.onReady();
    fetchDataloading();
  }

  Future<void> fetchDataloading() async {
    await fetchHandler(
      _fetchData(true),
      onSuccess: (token) async {},
      onError: (exception) {},
      loading: true,
    );
  }

  //领取确认弹窗
  void showConfirmBottomSheet(WelfareItemModel item) {
    if (item.walletType == 2) {
      Get.bottomSheet(
        BottomPlatformWalletReward(item: item),
      );
    } else {
      Get.bottomSheet(
        DialogrewrdView(item: item),
      );
    }
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
    filterModelList.value = [
      if (currencyList.length > 1)
        FilterModel(
          type: FilterType.currency,
          title: 'walletCurrency'.tr,
          list: currencyList,
          currentModel: currencyList[findCurrencyIndex(currency.code)],
          selectModel: currencyList[findCurrencyIndex(currency.code)],
        ),
      FilterModel(
        type: FilterType.tradeActivity,
        title: '类型筛选'.tr,
        list: welfareList,
        currentModel: welfareList[0],
        selectModel: welfareList[0],
      ),
      // 订单状态
      FilterModel(
        type: FilterType.status,
        title: '状态筛选'.tr,
        list: statusList,
        currentModel: statusList[0],
        selectModel: statusList[0],
      ),
    ];
    selectList.value = filterModelList;

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

  void setBetRecordType(int welfaredType) {
    this.welfaredType = welfaredType;
  }

  // 根据日期筛选值获取时间范围
  ({String start, String end}) getTimeRangeFromDateValue(String dateValue) {
    return getTimeRangeByType(dateValue);
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

  applyFilters() {
    _fetchData(true);
  }

  _fetchtype() async {
    final response = await HttpClient.get(
      Api.welfaretypelist,
    );

    if (response.status == false) {
      return;
    }

    List<dynamic> rawList = response.data["types"] ?? [];

    //   List<dynamic> rawList = res.data["data"] ?? [];
    typeList = rawList
        .map((e) => ItemModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    if (typeList.isNotEmpty) {
      List<SubFilterModel> arr = typeList.map((e) {
        return SubFilterModel(
            name: e.name == "全部红利" ? "全部" : e.name, value: e.type.toString());
      }).toList();

      welfareList = arr;
      configpopupKeys();
    }
  }

  _fetchData(bool isRefresh, {Function(bool hasMore)? onSuccess}) async {
    try {
      print("object123456 ${selectDate.first.currentModel.value}");
      Map<String, dynamic> queryParameters = {
        // 'page_size': kPaginationSize,
        if (selectDate.first.selectModel?.value != '5')
          'start_at': startTimestamp,
        if (selectDate.first.selectModel?.value != '5') 'end_at': endTimestamp,
        'currency': int.parse(currencyStr),
        // if (cash_type.isNotEmpty) 'cash_type': cash_type,
        // if (business_type.isNotEmpty && business_type != "business_type")
        //   'business_type': business_type,
      };

      if (isRefresh == false) {
        queryParameters['cur'] = records.last.id;
      }

      queryParameters['type'] = type;

      queryParameters['status'] = welfaredType;

      final response =
          await HttpClient.post(Api.welfareList, data: queryParameters);

      if (response.status == false) {
        records.value = [];
        onSuccess?.call(false);
        return;
      }

      // final convert = compose(
      //   TransactionRecordModel.fromJson,
      //   Map<String, dynamic>.from,
      // );
      // convert(response.data);

      List<dynamic> rawList = response.data["d"] ?? [];

      //   List<dynamic> rawList = res.data["data"] ?? [];
      List<WelfareItemModel> transactions = rawList
          .map((e) => WelfareItemModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      if (isRefresh == false) {
        records.addAll(transactions);

        // transacationRecordItemListGroupedByBetTimeInDay.value =
        //     groupedBetRecordItemByBetTimeWithAllRecords(records);
      } else {
        total.value = response.data["t"] ?? 0;
        receivedAmount.value = response.data["received_amount"] ?? "";
        canReceiveAmount.value = response.data["can_receive_amount"] ?? "";
        records.value = transactions;

        totalamount.value = response.data['total_amount']?.toString() ?? '0.00';

        // transacationRecordItemListGroupedByBetTimeInDay.value =
        //     groupedBetRecordItemByBetTimeWithAllRecords(records);
      }

      update();

      bool hasMore = records.length < total.value;

      onSuccess?.call(hasMore);
    } catch (e) {
      e.printError();
    }
  }

  symbol(int currency) {
    switch (currency) {
      case 101:
        return '¥';
      case 102:
        return '\$';
      case 103:
        return '₫';
      case 100:
        return 'u';

      case 104:
        return 'HK';
      case 105:
        return '₩';
      case 106:
        return 'Rp';
      case 107:
        return '฿';
      case 108:
        return '\$';
      case 109:
        return 'R';
      case 110:
        return '₹';
      case 111:
        return '₱';
      default:
        return '\$';
    }
  }

  symbolbance(WelfareItemModel item) {
    if (currency.code == "101") {
      return currency.symbol +
          "${(double.parse(item.amount ?? "0") * double.parse(item.rateCny ?? "0")).toStringAsFixed(2)}";
    }
    if (currency.code == "102") {
      return currency.symbol +
          "${(double.parse(item.amount ?? "0") * double.parse(item.rateUsd ?? "0")).toStringAsFixed(2)}";
    }
    if (currency.code == "103") {
      return currency.symbol +
          "${(double.parse(item.amount ?? "0") * double.parse(item.rateVnd ?? "0")).toStringAsFixed(2)}";
    }
    return "";
  }

  ///进入详情页
  // void jumpToDetail(BetRecordItem item) {
  //   Get.toNamed(
  //     Routes.BET_RECORD_DETAIL,
  //     arguments: {'betRecordItem': item, 'currency': currency},
  //   );
  // }

  Future<void> memberinsert(WelfareItemModel item, {String? platformId}) async {
    await fetchHandler(
      _memberinsert(item, platformId),
      onSuccess: (token) async {
        applyFilters();
      },
      onError: (exception) {},
      loading: true,
    );
  }

  _memberinsert(WelfareItemModel item, String? platformId) async {
    try {
      var res = await HttpClient.post(Api.memberinsert, data: {
        'id': item.id,
        if (platformId != null) 'wallet_platoform_id': platformId,
      });

      // homeModel = HomeModel.fromJson(Map<String, dynamic>.from(res.data));
      if (res.status == true) {
        AppUtils.showToast("领取成功".tr);
      }
    } catch (e) {
      AppUtils.showToast("领取失败".tr);
      e.printError();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      update(["time"]);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool isAreAllZero(String content) {
    return double.tryParse(content.replaceAll(RegExp(r'[^0-9\.]'), '')) == 0;
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
}
