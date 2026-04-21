
import 'package:get/get.dart';
import 'ongoing_bets_logic.dart';

class OngoingBetsBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => OngoingBetsLogic());
  }
}


