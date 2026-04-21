import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobeController extends GetxController with WidgetsBindingObserver {
  GlobeController(this.context);

  final BuildContext context;

  final commdata = Rx<Map<String, dynamic>?>(null);
  final hasNewMsg = false.obs; //站内信列表
  final hasLogin = false.obs; //是否登录状态

  Future<void> getUserInfo() async {}
}
