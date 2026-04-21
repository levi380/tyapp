import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/resp_winner_record.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:get/get.dart';

class WinnerRecordController extends GetXBaseController {
  ActivityModel? model;
  final winnerRecord = <WinnerRecord>[].obs;

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

  Future queryWinnerRecord() async {
    var result = await ApiRequest.queryActivityWinnerRecord(
        model?.id ?? '', '${model?.ty ?? 0}', 2, 1, 50);
    if (result != null) {
      winnerRecord.value = result.d ?? [];
    }
  }
}
