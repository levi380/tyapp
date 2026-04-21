import 'package:filbet/api/api.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:filbet/http/http_client.dart';

class EmailVerityController extends GetXBaseController {
  TextEditingController emailController = TextEditingController();
  late TextEditingController codeController = TextEditingController();

  UserService get to => Get.find();

  final SecurityService _securityService = Get.put(SecurityService());
  final UserService userService = Get.find<UserService>();

  final countdownSeconds = 0.obs;

  final isEnabled = false.obs;

  @override
  void onInit() {
    codeController = TextEditingController()..addListener(codeListener);
    emailController.text = UserService.to.state.userInfo.email ?? '';
    super.onInit();
  }

  void codeListener() {
    isEnabled.value = codeController.text.isNotEmpty;
  }

  Future<void> sendEmail(String email) async {
    await fetchHandler(
      _securityService.sendEmailBindingVerifyCode(email),
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
    if (emailController.text.trim().isEmpty) {
      AppUtils.showToast('请输入手机号'.tr);
      return;
    }
    if (codeController.text.trim().isEmpty) {
      AppUtils.showToast('input_verify_code'.tr);
      return;
    }
    await fetchHandler(
      _securityService.postPhoneBind(emailController.text.trim(), codeController.text.tr),
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

  Future<void> getSendBindCode() async {
    sendEmail(emailController.text);
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
}
