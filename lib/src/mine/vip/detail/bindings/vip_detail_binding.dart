import 'package:filbet/src/mine/vip/detail/controllers/vip_bonus_controller.dart';
import 'package:filbet/src/mine/vip/detail/controllers/vip_detail_controller.dart';
import 'package:filbet/src/mine/vip/detail/controllers/vip_monthly_controller.dart';
import 'package:filbet/src/mine/vip/detail/controllers/vip_rebate_controller.dart';
import 'package:filbet/src/mine/vip/detail/controllers/vip_rules_controller.dart';
import 'package:get/get.dart';

class VipDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return VipDetailController();
    });
    Get.lazyPut(() {
      return VipRulesController();
    });
    Get.lazyPut(() {
      return VipBonunsController();
    });
    Get.lazyPut(() {
      return VipRebateController();
    });
    Get.lazyPut(() {
      return VipMonthlyController();
    });
  }
}
