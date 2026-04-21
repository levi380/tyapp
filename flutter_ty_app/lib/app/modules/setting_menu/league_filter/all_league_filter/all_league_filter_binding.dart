import 'package:get/get.dart';

import 'all_league_filter_controller.dart';

class AllLeagueFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllLeagueFilterController(finishCb: (String stid) {  }));
  }
}
