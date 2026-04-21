import 'package:easy_refresh/easy_refresh.dart';
import 'package:filbet/common/currency.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/http_exceptions.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/mine/accountChangeRecord/account_change_record_model.dart';
import 'package:filbet/src/mine/accountChangeRecord/account_change_service.dart';
import 'package:filbet/utils/records_util.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/filter/filter_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountChangeRecordController extends GetXBaseController
    with GetTickerProviderStateMixin {
  final AccountChangeService accountChangeService =
      Get.find<AccountChangeService>();

  final int initialIndex;
  final List<Currency> availableCurrency;

  AccountChangeRecordController({
    required this.initialIndex,
    required Currency currency,
    required this.availableCurrency,
  })  : depositCurrency = currency,
        withdrawCurrency = currency,
        super();

  // 筛选参数，分别为存款和取款tab独立管理
  Currency? depositCurrency;
  int depositStatusId = 0;

  Currency? withdrawCurrency;
  int withdrawStatusId = 0;

  final EasyRefreshController depositEasyRefreshController =
      EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );

  final EasyRefreshController withdrawEasyRefreshController =
      EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );

  String depositCur = '';
  String withdrawCur = '';

  bool depositHasNoMoreData = true;
  bool withdrawHasNoMoreData = true;

  // 分别管理存款和提现的所有记录
  RxList<AccountChangeRecordDepositItem> allDepositRecords =
      <AccountChangeRecordDepositItem>[].obs;
  RxList<AccountChangeRecordWithdrawItem> allWithdrawRecords =
      <AccountChangeRecordWithdrawItem>[].obs;

  // TabController相关
  int get index => tabController.index;

  final Rxn<AccountChangeRecordDepositModel> lastFetchDepositModel =
      Rxn<AccountChangeRecordDepositModel>();

  final Rxn<AccountChangeRecordWithdrawModel> lastFetchWithdrawModel =
      Rxn<AccountChangeRecordWithdrawModel>();

  bool get isEmpty {
    return lastFetchDepositModel.value == null ||
        lastFetchDepositModel.value!.d.isEmpty;
  }

  late TabController tabController;

  final List<SubFilterModel> statusList = [
    SubFilterModel(showName: 'all_statuses'.tr, name: 'all'.tr, value: '0'),
    SubFilterModel(name: 'processing'.tr, value: '1'),
    SubFilterModel(name: 'success'.tr, value: '2'),
    SubFilterModel(name: 'fail'.tr, value: '3'),
  ];

  final List<SubFilterModel> dateList = [
    SubFilterModel(name: 'today'.tr, value: '1'),
    SubFilterModel(name: 'yesterday'.tr, value: '2'),
    SubFilterModel(name: 'last_7_days'.tr, value: '7'),
    SubFilterModel(name: 'last_30_days'.tr, value: '30'),
  ];

  RxList<FilterModel> filterModelList1 = <FilterModel>[].obs;
  RxList<FilterModel> filterModelList2 = <FilterModel>[].obs;
  final RxList<FilterModel> select1List = <FilterModel>[].obs;

  final RxList<FilterModel> select1Date = <FilterModel>[].obs;

  final RxList<FilterModel> select2List = <FilterModel>[].obs;

  final RxList<FilterModel> select2Date = <FilterModel>[].obs;
  final List tabTypeList = [
    {
      'title': 'deposit'.tr,
      'type': AccountChangeType.deposit,
      'filterModelList': <FilterModel>[].obs,
    },
    {
      'title': 'withdraw'.tr,
      'type': AccountChangeType.withdraw,
      'filterModelList': <FilterModel>[].obs,
    },
  ];

  late TickerProvider vsync;

  bool isLoadingMore = false;
  String dstartTimestamp = '';
  String dendTimestamp = '';
  String wstartTimestamp = '';
  String wendTimestamp = '';

  @override
  void onInit() {
    super.onInit();

    final List<SubFilterModel> currencyList = availableCurrency.map(
      (currency) {
        return SubFilterModel(
          name: currency.abbr.toLowerCase().tr,
          value: currency.code,
        );
      },
    ).toList();

    final currentModel1 = currencyList.firstWhere((item) {
      return item.value == depositCurrency?.code;
    }, orElse: () => currencyList[0]);

    final selectModel1 = currencyList.firstWhere((item) {
      return item.value == depositCurrency?.code;
    }, orElse: () => currencyList[0]);

    final timeRange = getTimeRangeFromDateValue("3");

    wstartTimestamp = timeRange.start;
    wendTimestamp = timeRange.end;
    dstartTimestamp = timeRange.start;
    dendTimestamp = timeRange.end;
    filterModelList1.value = [
      if (currencyList.length > 1)
        FilterModel(
          type: FilterType.currency,
          title: 'currency'.tr,
          list: currencyList,
          currentModel: currentModel1,
          selectModel: selectModel1,
        ),
      FilterModel(
        type: FilterType.status,
        title: 'status'.tr,
        list: statusList,
        currentModel: statusList[0],
        selectModel: statusList[0],
      ),
    ].obs;

    final currentModel2 = currencyList.firstWhere((item) {
      return item.value == depositCurrency?.code;
    }, orElse: () => currencyList[0]);

    final selectModel2 = currencyList.firstWhere((item) {
      return item.value == depositCurrency?.code;
    }, orElse: () => currencyList[0]);

    filterModelList2.value = [
      if (currencyList.length > 1)
        FilterModel(
          type: FilterType.currency,
          title: 'currency'.tr,
          list: currencyList,
          currentModel: currentModel2,
          selectModel: selectModel2,
        ),
      FilterModel(
        type: FilterType.status,
        title: 'status'.tr,
        list: statusList,
        currentModel: statusList[0],
        selectModel: statusList[0],
      ),
    ].obs;

    select1Date.value = [
      FilterModel(
        type: FilterType.date,
        title: 'query_limit_30_days'.tr,
        list: dateList,
        currentModel: dateList[2],
        selectModel: dateList[2],
      ),
    ];

    select2Date.value = [
      FilterModel(
        type: FilterType.date,
        title: 'query_limit_30_days'.tr,
        list: dateList,
        currentModel: dateList[2],
        selectModel: dateList[2],
      ),
    ];
    select1List.value = filterModelList1;
    select2List.value = filterModelList2;
    _setupTabController();

    // 设置初始tab index
    if (tabController.length > initialIndex && initialIndex >= 0) {
      tabController.index = initialIndex;
    }
  }

  // 根据日期筛选值获取时间范围
  ({String start, String end}) getTimeRangeFromDateValue(String dateValue) {
    return getTimeRangeByType(dateValue);
  }

  ///进入详情页
  void jumpToDetail(AccountChangeType type, AccountChangeRecordBaseItem item) {
    if (type == AccountChangeType.deposit) {
     
      if (item != null) {
        Get.toNamed(Routes.ACCOUNT_CHANGE_RECORD_DETAIL, arguments: {
          'item': item,
          'type': type,
        });
      }
    } else {
      
      if (item != null) {
        Get.toNamed(Routes.ACCOUNT_CHANGE_RECORD_DETAIL, arguments: {
          'item': item,
          'type': type,
        });
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    firstLoadData();
  }

  @override
  void onClose() {
    // 彻底销毁filterMenu，确保其AnimationController已释放，防止Ticker泄漏

    tabController.dispose();
    super.onClose();
  }

  // 设置货币类型
  void setCurrency(Currency? currency) {
    if (index == 0) {
      depositCurrency = currency;
    } else {
      withdrawCurrency = currency;
    }
    resetAndLoadData();
  }

  // 设置状态ID
  void setStatusId(int statusId) {
    if (index == 0) {
      depositStatusId = statusId;
    } else {
      withdrawStatusId = statusId;
    }
    resetAndLoadData();
  }

  // 设置时间范围
  void setTimeRangeType(String startTimestamp, String endTimestamp) {
    if (index == 0) {
      dstartTimestamp = startTimestamp;
      dendTimestamp = endTimestamp;
    } else {
      wstartTimestamp = startTimestamp;
      wendTimestamp = endTimestamp;
    }
    resetAndLoadData();
  }

  // 首次加载数据
  void firstLoadData() {
    final firstLoad = Future.wait([
      getDepositRecord(depositCurrency, dstartTimestamp, dendTimestamp, depositStatusId),
      getWithdrawRecord(withdrawCurrency, wstartTimestamp, wendTimestamp, withdrawStatusId),
    ]);

    fetchHandler(
      firstLoad,
      onError: toastError,
      loading: true,
    );
  }

  // 应用筛选器
  void applyFilters() {
    resetAndLoadData();
  }

  // 重置并加载数据
  Future<void> resetAndLoadData() async {
    final isDeposit = index == 0;
    final clearRecords =
        isDeposit ? allDepositRecords.clear : allWithdrawRecords.clear;
    final getRecords = isDeposit
        ? () => getDepositRecord(
            depositCurrency, dstartTimestamp, dendTimestamp, depositStatusId)
        : () => getWithdrawRecord(
            withdrawCurrency, wstartTimestamp, wendTimestamp, withdrawStatusId);
    final controller = isDeposit
        ? depositEasyRefreshController
        : withdrawEasyRefreshController;
    final hasNoMoreData =
        isDeposit ? depositHasNoMoreData : withdrawHasNoMoreData;

    clearRecords();
    await getRecords();
    controller.finishRefresh();
    controller.resetFooter();
    if (hasNoMoreData) {
      controller.finishLoad(IndicatorResult.noMore);
    }
  }

  // 加载更多数据
  void loadMoreData() async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    try {
      if (index == 0) {
        if (depositHasNoMoreData) return;
        await getDepositRecord(
          depositCurrency,
          dstartTimestamp,
          dendTimestamp,
          depositStatusId,
          cur: depositCur,
        );
        depositEasyRefreshController.finishLoad(
          depositHasNoMoreData
              ? IndicatorResult.noMore
              : IndicatorResult.success,
        );
      } else {
        if (withdrawHasNoMoreData) return;
        await getWithdrawRecord(
          withdrawCurrency,
          wstartTimestamp,
          wendTimestamp,
          withdrawStatusId,
          cur: withdrawCur,
        );
        withdrawEasyRefreshController.finishLoad(
          withdrawHasNoMoreData
              ? IndicatorResult.noMore
              : IndicatorResult.success,
        );
      }
    } catch (_) {
      if (index == 0) {
        depositEasyRefreshController.finishLoad(IndicatorResult.fail);
      } else {
        withdrawEasyRefreshController.finishLoad(IndicatorResult.fail);
      }
    } finally {
      isLoadingMore = false;
    }
  }

  // 获取存款记录
  Future<void> getDepositRecord(
    Currency? depositCurrency,
    String startTimestamp,
    String endTimestamp,
    int orderStatus, {
    String? cur,
  }) async {
    try {
      final model = await accountChangeService.getAccountChangeDepositModel(
        startAt: startTimestamp,
        endAt: endTimestamp,
        currency: depositCurrency,
        orderStatus: orderStatus,
        cur: cur,
      );

      lastFetchDepositModel.value = model;

      if (cur != null && cur.isNotEmpty) {
        // 追加数据
        allDepositRecords.addAll(model.d);
      } else {
        // 首次加载或刷新，覆盖数据
        allDepositRecords
          ..clear()
          ..addAll(model.d);
      }

      depositCur = model.d.lastOrNull?.id ?? '';
      depositHasNoMoreData = model.t < kPaginationSize;
    } on HttpException catch (e) {
      toastError(e);
    } catch (_) {}
  }

  // 获取提现记录
  Future<void> getWithdrawRecord(
    Currency? withdrawCurrency,
    String startTimestamp,
    String endTimestamp,
    int orderStatus, {
    String? cur,
  }) async {
    try {
      final model = await accountChangeService.getAccountChangeWithdrawModel(
        startAt: startTimestamp,
        endAt: endTimestamp,
        currency: withdrawCurrency,
        orderStatus: orderStatus,
        cur: cur,
      );

      lastFetchWithdrawModel.value = model;

      if (cur != null && cur.isNotEmpty) {
        // 追加数据
        allWithdrawRecords.addAll(model.d);
      } else {
        // 首次加载或刷新，覆盖数据
        allWithdrawRecords
          ..clear()
          ..addAll(model.d);
      }

      withdrawCur = model.d.lastOrNull?.id ?? '';
      withdrawHasNoMoreData = model.t < kPaginationSize;
    } on HttpException catch (e) {
      toastError(e);
    } catch (_) {}
  }

  void _setupTabController() {
    tabController = TabController(length: tabTypeList.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        // resetAndLoadData();
      }
    });
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

enum AccountChangeType {
  deposit,
  withdraw;

  int get value {
    switch (this) {
      case AccountChangeType.deposit:
        return 0;
      case AccountChangeType.withdraw:
        return 1;
    }
  }

  String get name {
    switch (this) {
      case AccountChangeType.deposit:
        return 'deposit'.tr;
      case AccountChangeType.withdraw:
        return 'withdraw'.tr;
    }
  }

  static AccountChangeType? fromValue(int value) {
    switch (value) {
      case 0:
        return AccountChangeType.deposit;
      case 1:
        return AccountChangeType.withdraw;
      default:
        return null;
    }
  }
}
