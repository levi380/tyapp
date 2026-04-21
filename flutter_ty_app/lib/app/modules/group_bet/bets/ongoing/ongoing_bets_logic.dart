
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

class OngoingBetsLogic extends GetxController {
  var type = 0.obs;
  setType(int type) {
    this.type.value = type;
    update();
  }
}
