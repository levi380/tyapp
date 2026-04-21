import 'dart:convert';

import 'package:filbet/api/api.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/activity_apply_model.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/activity/model/config_model.dart';
import 'package:filbet/src/deposit_activity/views/first_deposit_model.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/dialog/apply_record_dialog.dart';
import 'package:get/get.dart';
import 'package:filbet/http/http_client.dart';

class MatchWinnerController extends GetxController {
  final RxList<ShowResult> noticeList = RxList.empty();

  @override
  void onInit() {
    super.onInit();
    noticeList.value = Get.arguments as List<ShowResult> ?? [];
  }
}
