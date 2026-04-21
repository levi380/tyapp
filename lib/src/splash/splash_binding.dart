import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/src/splash/splash_controlle.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    final splashModel = SpStorage.getSplashModel;
    Get.lazyPut(() => SplashController(splashModel: splashModel));
  }
}
