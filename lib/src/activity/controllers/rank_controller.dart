import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RankController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final count = 0.obs;
  final List<String> tabTitles = ['hand_count'.tr, 'victory'.tr, 'win_rate'.tr, 'single_hand_profit'.tr];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
