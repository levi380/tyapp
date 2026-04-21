//FullLifeCycleController

import 'package:country_picker/country_picker.dart';
import 'package:filbet/api/api.dart' show Api;
import 'package:filbet/http/http_client.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telegram_login_flutter/telegram_login_flutter.dart';

class LoginTelegramController extends GetXBaseController {
  final phoneController = TextEditingController();
  final isLoading = false.obs;
  TelegramUser? user;
  String tgBotId = "";
  String tgDomain = "";
  final UserService _userService = Get.find<UserService>();
  final loginInvalid = false.obs;
  final country = Rx<Country?>(null);
  @override
  void onInit() {
    getTgAuthBotid();
    phoneController.addListener(() {
      loginInvalid.value = phoneController.text.isNotEmpty;
    });

    super.onInit();
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  Future<void> getTgAuthBotid() async {
    final response = await HttpClient.post(Api.tgLoginGetBotId, data: {});

    if (response.status == false) {
      return;
    }
    if (response.data is Map) {
      tgBotId = response.data["bot_id"];
      tgDomain = response.data["domain"];
    }
  }

  Future<void> loginWithTelegaram(Map<String, dynamic> tgAuthParams) async {
    isLoading.value = true;
    final response = await HttpClient.post(Api.tgLogin, data: tgAuthParams);
    isLoading.value = false;

    if (response.status == false) {
      return;
    }

    if (response.data is String) {
      String token = response.data;

      await _userService.initializeRegularUser(token: token);
      GlobalService.to.memberIndex();
      Get.until((route) => route.isFirst);
      Get.back();
    }
  }
}
