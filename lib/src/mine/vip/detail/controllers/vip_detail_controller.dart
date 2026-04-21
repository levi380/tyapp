import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VipDetailController extends GetXBaseController
    with GetTickerProviderStateMixin {
  List<String> tabs = [
    'weekly_redpacket'.tr,
    "rebate_rate".tr,
    'withdrawal_limit'.tr
  ];

  late TabController tabController;

  @override
  void onInit() {
    _setupTabController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // 彻底销毁filterMenu，确保其AnimationController已释放，防止Ticker泄漏

    tabController.dispose();
    super.onClose();
  }

  void _setupTabController() {
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        // resetAndLoadData();
      }
    });
  }
}
