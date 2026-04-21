import 'package:filbet/api/api.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/credential_validate_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import 'package:filbet/http/http_client.dart';

class ForgetWithdrawalPwdController extends GetxController {
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  RxString newPwdText = "".obs;
  RxString confirmPwdText = "".obs;
  RxString sid = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments.containsKey('sid')) {
      sid.value = Get.arguments['sid'];
    }
    newController.addListener(() {
      newPwdText.value = newController.text;
    });
    confirmController.addListener(() {
      confirmPwdText.value = confirmController.text;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    newController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  bool get setNewPaymentPassword {
    return _isPaymentPasswordValid(newController.value.text) &&
        newPwdText == confirmPwdText;
  }

  bool _isPaymentPasswordValid(String password) {
    return paymentPasswordStringValidate(password)
        .every((element) => element.item2);
  }

  List<Tuple2<CredentialStringValidateType, bool>>
      paymentPasswordStringValidate(String value) {
    return [
      Tuple2(
        CredentialStringValidateType.length6,
        value.length == 6,
      ),
      Tuple2(
        CredentialStringValidateType.onlyNumber,
        CredentialStringValidateType.onlyNumber.validate(value),
      ),
    ];
  }

  Future<bool> getResetStep3() async {
    final response = await HttpClient.post(Api.resetStep4, data: {
      'sid': sid.value,
      'new_pwd': confirmController.text.trim(),
    });
    if (!response.status) {
      AppUtils.showToastForResponse(
        response.message, ifEmpty: "修改失败");
    }
    return response.status;
  }
}
