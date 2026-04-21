import 'package:filbet/src/activity/controllers/task_controller.dart';
import 'package:get/get.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(
      () => TaskController(),
    );
  }
}
