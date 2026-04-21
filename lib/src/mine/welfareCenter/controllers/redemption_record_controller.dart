import 'dart:math' as math;

import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/resp_redeem_record.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:get/get.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:filbet/utils/time_util.dart';
import 'dart:async';
import 'package:filbet/widgets/filter/filter_model.dart';

class RedemptionRecordController extends GetXBaseController
    with GetTickerProviderStateMixin {
  final records = <RedeemRecordModel>[].obs;
  RxInt total = 0.obs;
  String startTimestamp = "";
  String endTimestamp = "";
  int page = 1;

  final List<SubFilterModel> dateList = [
    SubFilterModel(name: 'today'.tr, value: '1'),
//    SubFilterModel(name: 'yesterday'.tr, value: '2'),
    SubFilterModel(name: 'last_7_days'.tr, value: '7'),
    SubFilterModel(name: 'last_30_days'.tr, value: '30'),
    SubFilterModel(name: 'all'.tr, value: '5'),
  ];

  final List<SubFilterModel> statusList = [
    SubFilterModel(showName: '全部'.tr, name: '全部'.tr, value: '0'),
    SubFilterModel(name: '审核中'.tr, value: '2'),
    SubFilterModel(name: '派发中'.tr, value: '4'),
    SubFilterModel(name: '派发失败'.tr, value: '5'),
    SubFilterModel(name: '派发成功'.tr, value: '6'),
    SubFilterModel(name: '已拒绝'.tr, value: '7'),
  ];

  final RxList<FilterModel> filterModelList = <FilterModel>[].obs;
  final RxList<FilterModel> selectList = <FilterModel>[].obs;

  final RxList<FilterModel> selectDate = <FilterModel>[].obs;

  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  ///筛选类型下标
  final RxInt filterTypeIndex = (-1).obs;

  int welfareType = 0;

  @override
  void onInit() {
    super.onInit();
    final timeRange = getTimeRangeFromDateValue("5");
    if (startTimestamp != timeRange.start || endTimestamp != timeRange.end) {
      setTimeRange(timeRange.start, timeRange.end);
    }
    configPopupKeys();
  }

  @override
  void onReady() {
    super.onReady();
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

  void configPopupKeys() {
    filterModelList.value = [
      FilterModel(
        type: FilterType.status,
        title: '类型筛选'.tr,
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
    this.welfareType = welfaredType;
  }

  // 根据日期筛选值获取时间范围
  ({String start, String end}) getTimeRangeFromDateValue(String dateValue) {
    return getTimeRangeByType(dateValue);
  }

  fetchData({bool isRefresh = false}) {
    _fetchData(isRefresh);
  }

  void applyFilter() {
    _fetchData(true);
  }

  _fetchData(bool isRefresh) async {
    try {
      // 刷新时重置页码
      if (isRefresh) {
        page = 1;
      } else {
        // 加载更多时页码递增
        page++;
      }

      final startTimestampMs = parseDateTimeStringToTimestamp(startTimestamp);
      final endTimestampMs = parseDateTimeStringToTimestamp(endTimestamp);

      final resp = await ApiRequest.queryRedemptionRecord(
          page, welfareType, startTimestampMs, endTimestampMs);

      // 处理响应数据
      if (resp != null) {
        // 更新总数（取当前值和接口返回值的最大值）
        total.value = math.max(total.value, resp.t?.toInt() ?? 0);
        final transactions = resp.d ?? [];

        // 更新记录列表
        if (isRefresh) {
          // 刷新时直接替换整个列表
          records.value = transactions;
        } else {
          // 加载更多时追加数据
          records.addAll(transactions);
        }
      } else {
        // 请求失败时，如果是刷新则清空数据
        if (isRefresh) {
          records.clear();
          total.value = 0;
        }
      }
      records.refresh();
      // 判断是否还有更多数据
      final hasMore = records.length < total.value;

      // 结束刷新/加载状态
      if (isRefresh) {
        easyRefreshController.finishRefresh();
        // 如果有更多数据，重置footer以便下次加载
        if (hasMore) {
          easyRefreshController.resetFooter();
        }
      } else {
        easyRefreshController.finishLoad(
          hasMore ? IndicatorResult.success : IndicatorResult.noMore,
        );
      }
    } catch (e) {
      e.printError();
      // 错误时也要结束刷新/加载状态
      if (isRefresh) {
        easyRefreshController.finishRefresh();
        // 如果刷新失败，清空数据
        if (records.isEmpty) {
          records.clear();
          total.value = 0;
        }
      } else {
        // 加载更多失败时，回退页码
        if (page > 1) {
          page--;
        }
        easyRefreshController.finishLoad(IndicatorResult.fail);
      }
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

  String convertTypeName(int status) {
    return statusList.firstWhere((item) => item.value == '$status').name;
  }
}
