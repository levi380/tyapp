import 'package:flutter_ty_app/app/modules/group_bet/participate/controllers/participate_controller.dart';
import 'package:flutter_ty_app/app/modules/group_bet/sponser/controllers/sponser_controller.dart';
import 'package:get/get.dart';

import '../controllers/group_bet_controller.dart';

class GroupBetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SponserController>(
      () => SponserController(),
    );
    Get.lazyPut<ParticipateController>(
      () => ParticipateController(),
    );
    Get.lazyPut<GroupBetController>(
      () => GroupBetController(),
    );
  }
}
