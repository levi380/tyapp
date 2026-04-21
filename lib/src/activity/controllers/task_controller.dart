import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final count = 0.obs;
  final List<String> tabTitles = ['daily_task'.tr, 'weekly_task'.tr, 'monthly_task'.tr];

  bool isLoading = false;
  // 模拟数据列表
  RxList<String> dataList = RxList<String>();
  // 分页控制
  int page = 1;
  final int _pageSize = 20;
  Rx<bool> hasMore = true.obs;

  // 获取数据（模拟API）
  Future<void> loadData({bool isRefresh = false}) async {
    await Future.delayed(const Duration(seconds: 2)); // 模拟网络延迟
    if (isRefresh) page = 1; // 刷新时重置页码
    final newData =
        List.generate(_pageSize, (i) => 'Item ${dataList.length + i + 1}');
    if (isRefresh) dataList.clear();
    dataList.addAll(newData);
    hasMore.value = newData.length >= _pageSize; // 判断是否还有更多数据
    page++;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    loadData(isRefresh: true);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
