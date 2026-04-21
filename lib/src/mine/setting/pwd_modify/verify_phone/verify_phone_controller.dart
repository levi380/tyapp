import 'package:filbet/api/api.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerifyPhoneController extends GetXBaseController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  final countdownSeconds = 0.obs;

  String mSid = '';
  RxString codeText = "".obs;

  final selAreaCodeText = '+86'.obs;
  final RxString phoneNumber = ''.obs;
  final GlobalKey phoneContainerKey = GlobalKey();

  @override
  void onInit() {
    convertAreaAndPhone();
    phoneController.text = phoneNumber.value;
    super.onInit();
    codeController.addListener(() {
      codeText.value = codeController.text;
    });
  }

  void safeVerifyConfirm(ValidationType verityType, String value) {
    switch (verityType) {
      case ValidationType.changeLoginPwd:
        sendCode(value);
        break;
      case ValidationType.changePayPwd:
        confirmUserName(value);
        break;
      case ValidationType.checkData:
        break;
      case ValidationType.deleteData:
        confirmUserName(value);
        break;
      case ValidationType.userName:
        confirmUserName(value);
        break;
      case ValidationType.checkAccount:
        confirmUserName(value);
        break;
    }
  }

  void nextStep(ValidationType verityType) {
    switch (verityType) {
      case ValidationType.changeLoginPwd:
        verifyCode();
        break;
      case ValidationType.changePayPwd:
        Get.back(result: true);
        break;
      case ValidationType.checkData:
        Get.back(result: true);
        break;
      case ValidationType.deleteData:
        deleteAccount();
        break;
      case ValidationType.userName:
        userNameStep2();
        break;
      case ValidationType.checkAccount:
        break;
    }
  }

  Future<void> sendCode(String sid) async {
    mSid = sid;
    var resp = await ApiRequest.updateLoginPwd2(sid: sid);
    if (resp == true) {
      startCountDown();
    }
  }

  void confirmUserName(String sid) {
    mSid = sid;
    startCountDown();
  }

  Future<void> verifyCode() async {
    if (codeController.text.trim().isEmpty) {
      return AppUtils.showToast('请输入验证码');
    }
    var resp = await ApiRequest.updateLoginPwd3(
      sid: mSid,
      code: codeController.text,
    );
    if (resp == true) {
      Get.offAndToNamed(Routes.PWD_MODIFY, arguments: {'sid': mSid});
    }
  }

  Future<void> deleteAccount() async {
    if (codeController.text.trim().isEmpty) {
      return AppUtils.showToast('请输入验证码');
    }
    var resp = await ApiRequest.deleteAccountStep2(
      mSid,
      codeController.text,
    );
    if (resp == true) {
      Get.back(result: true);
    }
  }

  Future<void> userNameStep2() async {
    if (codeController.text.trim().isEmpty) {
      return AppUtils.showToast('请输入验证码');
    }
    var resp = await ApiRequest.infoViewStep2(mSid, codeController.text, 1);
    if (resp != null) {
      Get.back(result: resp);
    }
  }

  void startCountDown() {
    AppUtils.showToast("验证码发送成功");
    countdownSeconds.value = countdownTime;
  }

  void convertAreaAndPhone() {
    String phoneWithArea = UserService.to.state.userInfo.phone ?? "";
    var arr = phoneWithArea.split('-');
    if (arr.length > 1) {
      selAreaCodeText.value = arr[0].isNotEmpty ? arr[0] : '+86';
      phoneNumber.value = arr[1];
    } else {
      phoneNumber.value = arr[0];
    }
  }
}
