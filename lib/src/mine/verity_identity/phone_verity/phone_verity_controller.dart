import 'package:filbet/api/api.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:filbet/http/http_client.dart';

class PhoneVerityController extends GetXBaseController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  UserService get to => Get.find();

  final SecurityService _securityService = Get.put(SecurityService());
  final UserService userService = Get.find<UserService>();

  final countdownSeconds = 0.obs;
  String mSid = '';

  final selAreaCodeText = '+86'.obs;
  final RxString phoneNumber = ''.obs;
  final GlobalKey phoneContainerKey = GlobalKey();

  @override
  void onInit() {
    convertAreaAndPhone();
    phoneController.text = phoneNumber.value;
    super.onInit();
  }

  Future<void> sendSms(phone, code) async {
    await fetchHandler(
      _securityService.getSendBindCode(phone, code),
      onSuccess: (model) {
        if (model) {
          //发送成功
          countdownSeconds.value = countdownTime;
          countdownSeconds.refresh();
        }
      },
      onError: toastError,
      loading: true,
    );
  }

  Future<void> postPhoneBind() async {
    if (phoneController.text.trim().isEmpty) {
      AppUtils.showToast('请输入手机号'.tr);
      return;
    }
    if (codeController.text.trim().isEmpty) {
      AppUtils.showToast('input_verify_code'.tr);
      return;
    }
    await fetchHandler(
      _securityService.postPhoneBind(phoneController.text.trim(), codeController.text.tr),
      onSuccess: (model) {
        if (model) {
          Get.back();
          userService.getUserInfos();
        }
      },
      onError: toastError,
      loading: true,
    );
  }

  Future<void> getSendBindCode(String phone) async {
    sendSms(phone.trim().isNotEmpty ? phone : phoneController.text, "+86");
  }

  Future<bool> postPhoneVerify(String phoneDigitsy) async {
    try {
      final response = await HttpClient.post(Api.phoneVerify, data: {
        'phone_digits': phoneDigitsy,
      });
      if (!response.status) {
        AppUtils.showToastForResponse(
        response.message, ifEmpty: '手机号校验失败！');
      }
      return response.status;
    } catch (e) {
      return false;
    }
  }

  Future<bool> phoneCodeVerify(int activeMethod, String code, int type) async {
    final responseCodeVerify = await HttpClient.post(Api.phoneCodeVerify, data: {
      'active_method': activeMethod, //验证码类型 1 电话 2 邮箱 其他返回错误
      'code': code, //6位数字验证码，例如："123456"
      'type': type, //要操作的业务类型：0=无业务 只验证是否正确 1=修改登录密码，2=修改支付密码 3=删除账户地址
    });
    if (!responseCodeVerify.status) {
      AppUtils.showToast(responseCodeVerify.message ?? '验证码不正确'.tr);
      return false;
    }
    return true;
  }

  void safeVerifyConfirm(ValidationType verityType, String value) {
    switch (verityType) {
      case ValidationType.changeLoginPwd:
        break;
      case ValidationType.changePayPwd:
        confirmUserName(value);
        break;
      case ValidationType.checkData:
        break;
      case ValidationType.deleteData:
        break;
      case ValidationType.userName:
        break;
      case ValidationType.checkAccount:
        confirmUserName(value);
        break;
    }
  }

  void confirmUserName(String sid) {
    mSid = sid;
    AppUtils.showToast("验证码发送成功");
    countdownSeconds.value = countdownTime;
  }

  Future<void> userNameStep2(int type, String accountId) async {
    if (codeController.text.trim().isEmpty) {
      AppUtils.showToast('请输入验证码');
      return;
    }
    //信息类型（1=实名，2=手机号，3=邮箱，4=取款地址）
    var resp = await ApiRequest.infoViewStep2(mSid, codeController.text, type, accountId: accountId);
    if (resp != null) {
      Get.back(result: resp);
    }
  }

  Future<void> confirmChangePayPwd(String sid, String code) async {
    bool? isSuccess = await ApiRequest.payPwdResetStep3(sid, code);
    if (isSuccess != null && isSuccess) {
      Get.back(result: sid);
    }
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
