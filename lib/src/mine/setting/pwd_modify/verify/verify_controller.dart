import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/services/user/user_state.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabItem {
  String title;
  String imageIcon;
  bool hasRedPoint = false;
  bool isNetImage = false;

  TabItem(this.title,
      {this.imageIcon = "", this.hasRedPoint = false, this.isNetImage = false});
}

class VerifyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<TabItem> tabs = [];

  late TabController tabController;
  final selectTabIndex = 0.obs;

  String? phone;
  String? email;
  String? deleteId;
  ValidationType? verifyType;

  @override
  void onInit() {
    super.onInit();
    // 从 Get.arguments 判断需要哪种验证方式
    final arguments = Get.arguments;
    if (arguments != null) {
      verifyType = arguments['verityType'];
      // 如果明确指定了需要手机验证
      phone = arguments['needPhone'];
      // 如果明确指定了需要邮箱验证
      email = arguments['needEmail'];
      deleteId = arguments['deleteId'];
    }
    // 根据判断结果动态设置 tabs
    tabs = [];
    if (phone?.isNotEmpty == true) {
      tabs.add(TabItem("手机验证".tr));
    }
    if (email?.isNotEmpty == true) {
      tabs.add(TabItem("邮箱验证".tr));
    }
    // 根据 tabs 数量创建 TabController
    tabController =
        TabController(length: tabs.isEmpty ? 1 : tabs.length, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    if (tabs.isEmpty) {
      nextStepByType();
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void nextStepByType() {
    if (verifyType != null) {
      switch (verifyType!) {
        case ValidationType.changeLoginPwd:
          toPwdModify();
          break;
        case ValidationType.changePayPwd:
          break;
        case ValidationType.checkData:
          break;
        case ValidationType.deleteData:
          break;
        case ValidationType.checkAccount:
          break;
        case ValidationType.userName:
          Get.back();
          break;
        case ValidationType.checkAccount:
          break;
      }
    }
  }

  void toPwdModify() {
    Future.delayed(Duration.zero, () {
      Get.offAndToNamed(Routes.PWD_MODIFY);
    });
  }
}
