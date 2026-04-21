import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/security/security_data_model.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/credential_validate_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class ModifyWithdrawPwdController extends GetXBaseController {
  final SecurityService securityService = Get.find<SecurityService>();
  final Rx<SecurityDataModel?> securityData = Rx<SecurityDataModel?>(null);

  TextEditingController oldPwdController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  RxString oldPwdText = "".obs;
  RxString newPwdText = "".obs;
  RxString confirmPwdText = "".obs;
  final setNewPaymentPassword = false.obs;
  final changePaymentPassword = false.obs;
  final RxBool newPwdIsFocus = false.obs;
  final RxBool confirmPwdIsFocus = false.obs;
  final RxBool oldPwdIsFocus = false.obs;

  //新密码
  late final FocusNode newPwdFocusNode;
  late final FocusNode confirmPwdFocusNode;
  late final FocusNode oldPwdFocusNode;

  @override
  void onInit() {
    loadSecurityData();
    super.onInit();
    newPwdFocusNode = FocusNode();
    newPwdFocusNode.addListener(_onNewPwdFocusChange);
    confirmPwdFocusNode = FocusNode();
    confirmPwdFocusNode.addListener(_onConfirmPwdFocusChange);
    oldPwdFocusNode = FocusNode();
    oldPwdFocusNode.addListener(_onOldPwdFocusChange);

    oldPwdController.addListener(() {
      oldPwdText.value = oldPwdController.text;
      getSetNewPaymentPassword();
      getChangePaymentPassword();
    });
    newController.addListener(() {
      newPwdText.value = newController.text;
      getSetNewPaymentPassword();
      getChangePaymentPassword();
    });
    confirmController.addListener(() {
      confirmPwdText.value = confirmController.text;
      getSetNewPaymentPassword();
      getChangePaymentPassword();
    });
  }

  void _onNewPwdFocusChange() {
    newPwdIsFocus.value = newPwdFocusNode.hasFocus;
  }

  void _onConfirmPwdFocusChange() {
    confirmPwdIsFocus.value = confirmPwdFocusNode.hasFocus;
  }

  void _onOldPwdFocusChange() {
    oldPwdIsFocus.value = oldPwdFocusNode.hasFocus;
  }

  @override
  void dispose() {
    newController.dispose();
    confirmController.dispose();
    oldPwdController.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    newPwdFocusNode.removeListener(_onNewPwdFocusChange);
    confirmPwdFocusNode.removeListener(_onConfirmPwdFocusChange);
    oldPwdFocusNode.removeListener(_onOldPwdFocusChange);
    super.onClose();
  }

  Future<bool> setPaymentPassword() async {
    var hasPayPwd = securityData.value?.hasPayPwd ?? false;
    if (hasPayPwd && oldPwdText.isEmpty) {
      AppUtils.showToast('input_old_pwd'.tr);
      return false;
    }

    if (newPwdText.isEmpty) {
      AppUtils.showToast('input_new_pwd'.tr);
      return false;
    }
    if (confirmPwdText.isEmpty) {
      AppUtils.showToast('input_confirm_pwd'.tr);
      return false;
    }

    if (!hasPayPwd) {
      final isSuccess = await fetchHandler<bool>(
            securityService.setPayPwd(
              newPwdText.value,
            ),
            onError: toastError,
            loading: true,
          ) ??
          false;
      if (isSuccess) {
        AppUtils.showToast('settings_success'.tr);
        await loadSecurityData();
        Get.back(result: true);
      }
      return Future.value(isSuccess);
      //多处用到此接口，需要返回是否成功做下一步处理
    } else {
      final isSuccess = await fetchHandler<bool>(
            securityService.setPayPwd(
              newPwdText.value,
              oldPassword: oldPwdText.value,
            ),
            onError: toastError,
            loading: true,
          ) ??
          false;
      if (isSuccess) {
        AppUtils.showToast('settings_success'.tr);
        await loadSecurityData();
        Get.back(result: true);
      }
      //多处用到此接口，需要返回是否成功做下一步处理
      return Future.value(isSuccess);
    }
  }

  Future<void> loadSecurityData() async {
    await fetchHandler<SecurityDataModel>(
      securityService.loadSecurityData(),
      onSuccess: (model) {
        securityData.value = model;
      },
      onError: toastError,
      loading: true,
    );
  }

  bool getSetNewPaymentPassword() {
    setNewPaymentPassword.value = _isPaymentPasswordValid(newController.value.text) && newPwdText == confirmPwdText;
    return setNewPaymentPassword.value;
  }

  bool getChangePaymentPassword() {
    changePaymentPassword.value = _isPaymentPasswordValid(oldPwdController.value.text) &&
        _isPaymentPasswordValid(newController.value.text) &&
        newPwdText == confirmPwdText;
    return changePaymentPassword.value;
  }

  bool _isPaymentPasswordValid(String password) {
    return paymentPasswordStringValidate(password).every((element) => element.item2);
  }

  List<Tuple2<CredentialStringValidateType, bool>> paymentPasswordStringValidate(String value) {
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
}
