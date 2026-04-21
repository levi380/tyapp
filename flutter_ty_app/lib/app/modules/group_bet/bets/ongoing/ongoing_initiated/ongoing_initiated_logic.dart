import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';


class OngoingInitiatedLogic extends GetxController {
  var timeType = 0.obs;

  setType(int type) {
    this.timeType.value = type;
  }
}
