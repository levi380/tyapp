import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/resp_winner_record.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:get/get.dart';

class LotteryRecordController extends GetXBaseController {
  final tabIndex = 0.obs;
  ActivityModel? model;
  final winnerRecord = <WinnerRecord>[].obs;
  final rewardTotals = <RewardTotal>[].obs;
  final summary = Summary().obs;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments.containsKey('model')) {
      model = Get.arguments['model'];
    }
    super.onInit();
  }

  @override
  void onReady() {
    queryWinnerRecord();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTabIndex(int index) {
    if (tabIndex.value == index) {
      return;
    }
    tabIndex.value = index;
  }

  Future queryWinnerRecord() async {
    var result = await ApiRequest.queryActivityWinnerRecord(
        model?.id ?? '', '${model?.ty ?? 0}', 1, 1, 50);
    if (result != null) {
      winnerRecord.value = result.d ?? [];
      summary.value = result.summary ?? Summary();
      rewardTotals.value = result.summary?.rewardTotals ?? [];
    }
  }
}
