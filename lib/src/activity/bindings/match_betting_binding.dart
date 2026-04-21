import 'package:filbet/src/activity/controllers/match_betting_controller.dart';
import 'package:filbet/src/activity/controllers/match_betting_his_controller.dart';
import 'package:get/get.dart';

class MatchBettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MatchBettingController>(
      () => MatchBettingController(),
    );
    Get.lazyPut<MatchBettingHisController>(
      () => MatchBettingHisController(),
    );
  }
}
