import 'package:flutter_ty_app/app/modules/dj/widgets/menu/hot_league_widget.dart';
import 'package:get/get.dart';

import '../controllers/dj_controller.dart';


class DJBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => DJHotLeagueController(),permanent: true);
    Get.lazyPut(() => DJController());
  }
}
