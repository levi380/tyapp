import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/services/user/user_state.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/dialog/dialog_kfview.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/security/security_data_model.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoController extends GetXBaseController {
  final SecurityService securityService = Get.find<SecurityService>();
  final Rx<SecurityDataModel?> securityData = Rx<SecurityDataModel?>(null);

  UserService get _userService => Get.find<UserService>();

  UserServiceState get userState => _userService.state;

  TextEditingController setNickController = TextEditingController();

  RxInt currentHeaderIndex = 0.obs;
  RxBool verifyState = false.obs;
  RxBool checkState = false.obs;

  final realNameView = ''.obs;

  // 将 getter 改为响应式的计算属性
  String get nickname {
    return userState.userInfo.nickName?.isEmpty == true ||
            userState.userInfo.nickName == null
        ? '请输入昵称'.tr
        : userState.userInfo.nickName!;
  }

  String get realName {
    return userState.userInfo.realName?.isEmpty == true ||
            userState.userInfo.realName == null
        ? '为了您的资金能够迅速到账，请确保与银行卡开户姓名一致'.tr
        : userState.userInfo.realName!;
  }

  String get phone {
    return userState.userInfo.phone?.isEmpty == true ||
            userState.userInfo.phone == null
        ? '绑定手机号保障账号安全'.tr
        : userState.userInfo.phone!;
  }

  String get email {
    return userState.userInfo.email?.isEmpty == true ||
            userState.userInfo.email == null
        ? '绑定邮箱保护账号安全'.tr
        : userState.userInfo.email!;
  }

  // String get password {
  //   return _userService.state.securityData.hasPayPwd ? "set".tr : 'unset'.tr;
  // }

  String get gender {
    if (userState.userInfo.gender == null) {
      return '未选择'.tr;
    }
    // // 性别 1 男，2女 其它：未设置
    switch (userState.userInfo.gender) {
      case 1:
        return 'male'.tr;
      case 2:
        return 'female'.tr;
      default:
        return '未选择'.tr;
    }
  }

  String get birthday {
    return userState.userInfo.birthday?.isEmpty == true ||
            userState.userInfo.birthday == null
        ? '添加日期，确保您已满18岁'.tr
        : userState.userInfo.birthday!;
  }

  @override
  void onInit() {
    loadSecurityData();
    super.onInit();
    currentHeaderIndex.value = userState.userAvatarIndex;
  }

  Future<void> loadSecurityData() async {
    await fetchHandler<SecurityDataModel>(
      securityService.loadSecurityData(),
      onSuccess: (model) {
        securityData.value = model;
        update();
      },
      onError: toastError,
      loading: true,
    );
  }

  @override
  void dispose() {
    setNickController.dispose();
    super.dispose();
  }
}
