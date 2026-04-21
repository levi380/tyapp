import 'package:get/get.dart';

import 'pip_video_controller.dart';

class PipVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PipVideoController>(
      () => PipVideoController(),
    );
  }
}
