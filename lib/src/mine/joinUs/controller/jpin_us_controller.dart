import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/resp_service_model.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:get/get.dart';

class JoinUsController extends GetXBaseController {
  final RxInt currentIndex = 0.obs;
  final customServices = <ThirdPartys>[].obs;

  @override
  void onInit() {
    print("object123456 JoinUsController onInit");
    queryCustomService();
    super.onInit();
  }

  @override
  void onReady() {
    print("object123456 JoinUsController onReady");
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void queryCustomService() async {
    var resp = await ApiRequest.customerService(1);
    if (resp != null) {
      customServices.value = resp.thirdPartys ?? [];
    }
  }
}
