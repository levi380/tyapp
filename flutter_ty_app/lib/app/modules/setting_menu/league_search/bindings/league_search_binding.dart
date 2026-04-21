import 'package:get/get.dart';

import '../controllers/league_search_controller.dart';

class LeagueSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeagueSearchController>(
      () => LeagueSearchController(),
    );
  }
}
