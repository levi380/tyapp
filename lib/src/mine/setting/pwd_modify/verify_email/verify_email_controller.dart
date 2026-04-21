import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetXBaseController {
  TextEditingController emailController = TextEditingController();
  late TextEditingController codeController = TextEditingController();

  UserService get to => Get.find();

  final UserService userService = Get.find<UserService>();

  final countdownSeconds = 0.obs;
  final isEnabled = false.obs;

  String mSid = '';

  @override
  void onInit() {
    codeController = TextEditingController()..addListener(codeListener);
    emailController.text = convertEmail();
    super.onInit();
  }

  String convertEmail() {
    String email = UserService.to.state.userInfo.email ?? '';
    var emailArr = email.split('@');
    String endEmail = '';
    String subEmail = '';
    if (emailArr.length == 2) {
      subEmail = emailArr[0];
      endEmail = emailArr[1];
      if (subEmail.length > 2) {
        subEmail = '${subEmail.substring(0, 2)}****';
      }
    } else {
      return email;
    }
    return '$subEmail@$endEmail';
  }

  void codeListener() {
    isEnabled.value = codeController.text.isNotEmpty;
  }

  void safeVerifyConfirm(ValidationType verityType, String value) {
    switch (verityType) {
      case ValidationType.changeLoginPwd:
        sendEmail(value);
        break;
      case ValidationType.changePayPwd:
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
        break;
    }
  }

  Future<void> sendEmail(String sid) async {
    mSid = sid;
    var resp = await ApiRequest.updateLoginPwd2(sid: sid);
    if (resp == true) {
      startCountDown();
    }
  }

  void nextStep(ValidationType verityType) {
    switch (verityType) {
      case ValidationType.changeLoginPwd:
        verifyCode();
        break;
      case ValidationType.changePayPwd:
        break;
      case ValidationType.checkData:
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

  Future<void> userNameStep2() async {
    if (codeController.text.trim().isEmpty) {
      return AppUtils.showToast('请输入验证码');
    }
    var resp = await ApiRequest.infoViewStep2(mSid, codeController.text, 1);
    if (resp != null) {
      Get.back(result: resp);
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

  void startCountDown() {
    AppUtils.showToast("验证码发送成功");
    countdownSeconds.value = countdownTime;
  }
}
