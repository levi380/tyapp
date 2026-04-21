import 'package:filbet/src/activity/controllers/coin_detail_controller.dart';
import 'package:get/get.dart';

class CoinDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoinDetailController>(
      () => CoinDetailController(),
    );
  }
}
