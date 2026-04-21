import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/activity_apply_model.dart';
import 'package:filbet/http/entity/activity_turntable_detail_model.dart';
import 'package:filbet/http/entity/resp_winner_record.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/utils/event_bus.dart';
import 'package:filbet/widgets/dialog/apply_record_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityDetailTurntableController extends GetxController {
  ActivityModel? model;
  final enable = true.obs; //未申请，false已参与
  final applyModels = <ActivityApplyModel>[].obs;
  final tabIndex = 0.obs;
  final turntableDetailModel = ActivityTurntableDetailModel().obs;
  final winnerRecord = <WinnerRecord>[].obs;
  final isRefreshing = false.obs;
  final remainingTimes = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments.containsKey('model')) {
      model = Get.arguments['model'];
    }
    queryActivityDetail();
    queryWinnerRecord();
  }

  ///打开外部链接
  void openExternalLinks(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void clickWinnerRecord() {
    if (UserService.to.state.isVisitor) {
      EventBus.emit(EventType.goToLogin);
      return;
    }
    Get.toNamed(
      Routes.WINNER_RECORD,
      arguments: {'model': model},
    );
  }

  void clickRecord() {
    if (UserService.to.state.isVisitor) {
      EventBus.emit(EventType.goToLogin);
      return;
    }
    Get.toNamed(
      Routes.LOTTERY_RECORD,
      arguments: {'model': model},
    );
  }

  void clickApplyRecord() {
    Get.dialog(ApplyRecordDialog(models: applyModels.value));
  }

  Future<void> queryActivityDetail() async {
    isRefreshing.value = true;
    try {
      turntableDetailModel.value =
          await ApiRequest.queryActivityTurntableDetail(
                  model?.id ?? '', '${model?.ty ?? 0}') ??
              ActivityTurntableDetailModel();
      await queryWinnerRecord();
    } finally {
      isRefreshing.value = false;
    }
  }

  Future<Prizes?> applyTurntableActivity() async {
    var result = await ApiRequest.applyJoinTurntableActivity(
        model?.id ?? '', '${model?.ty ?? 0}', tabIndex.value + 1);
    if (result != null) {
      num available = result.available ?? 0;
      List<Plays> plays = turntableDetailModel.value.config?.plays ?? [];
      if (plays[tabIndex.value].playType == 1) {
        turntableDetailModel.value.times?.play1Available = available;
      } else {
        turntableDetailModel.value.times?.play2Available = available;
      }
      remainingTimes.value = available.toInt();
    }
    return result;
  }

  Future queryWinnerRecord() async {
    var result = await ApiRequest.queryActivityWinnerRecord(
        model?.id ?? '', '${model?.ty ?? 0}', 2, 1, 30);
    if (result != null) {
      winnerRecord.value = result.d ?? [];
    }
  }
}
