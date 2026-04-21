import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/login/login_and_register_controller.dart';
import 'package:get/get.dart';

class LoginAndRegisterBinding extends Bindings {
  @override
  void dependencies() {
    final arguments = Get.arguments;
    final LoginAndRegisterType controllerType = (arguments != null &&
            arguments is Map<String, dynamic> &&
            arguments['type'] is int)
        ? LoginAndRegisterType.fromValue(arguments['type'])
        : LoginAndRegisterType.login;

    final language = GlobalService.to.state.language;
    Get.lazyPut(() {
      return LoginAndRegisterController(
        type: controllerType,
        language: language,
      );
    });
  }
}
