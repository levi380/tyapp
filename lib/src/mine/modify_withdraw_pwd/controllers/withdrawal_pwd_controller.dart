import 'package:filbet/api/api.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:filbet/http/http_client.dart';


class WithdrawalPwdController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> postPhoneVerify(String phoneDigitsy) async {
    try {
      final response = await HttpClient.post(Api.phoneVerify, data: {
        'phone_digits': phoneDigitsy,
      });
      if (!response.status) {
        AppUtils.showToastForResponse(
        response.message, ifEmpty: '验证失败');
      }
      return response.status;
    } catch (e) {
      return false;
    }
  }
}
