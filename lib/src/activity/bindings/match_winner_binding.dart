import 'package:filbet/src/activity/controllers/match_winner_controller.dart';
import 'package:get/get.dart';

class MatchWinnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MatchWinnerController>(
      () => MatchWinnerController(),
    );
  }
}
