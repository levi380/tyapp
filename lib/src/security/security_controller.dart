import 'dart:async';
import 'dart:ffi';

import 'package:filbet/generated/assets.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:filbet/src/security/Address_provinces_model.dart';
import 'package:filbet/src/security/Bank_list_model.dart';
import 'package:filbet/src/security/address_areas_model.dart';
import 'package:filbet/src/security/address_cities_model.dart';
import 'package:filbet/src/security/security_data_model.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/src/withdraw/wallet_account_model.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/credential_validate_util.dart';
import 'package:filbet/utils/fp.dart';
import 'package:filbet/utils/security_util.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

const emailVerificationCodeCountDownDuration = 30;

class SecurityController extends GetXBaseController {
  final SecurityService _securityService = Get.find<SecurityService>();
  final WalletService _walletService = Get.find<WalletService>();

  final Rx<SecurityDataModel> _securityData;
  final Rx<String> googleAuthCode = ''.obs;
  final Rxn<String> _googleSecretCode = Rxn<String>();

  final RxList<WalletAccountModel> bankAccountList = RxList.empty();
  final alipayAccountList = <WalletAccountModel>[].obs;

  SecurityDataModel get securityData => _securityData.value;

  Stream<SecurityDataModel> get securityDataStream => _securityData.stream;

  //安全验证方式 0无 1邮箱 2谷歌码
  final Rx<SecuritySecondaryVerifyType> verifyType =
      SecuritySecondaryVerifyType.none.obs;

  List<SecuritySecondaryVerifyType> get availableSecondaryVerifies {
    var list = <SecuritySecondaryVerifyType>[];
    if (hasEmail) {
      list.add(SecuritySecondaryVerifyType.email);
    }
    if (hasGoogle) {
      list.add(SecuritySecondaryVerifyType.google);
    }
    list.add(SecuritySecondaryVerifyType.none);
    return list;
  }

  SecurityController({
    required SecurityDataModel securityData,
  }) : _securityData = securityData.obs;

  bool get hasGoogle => _securityData.value.hasGoogle;

  bool get hasEmail => _securityData.value.hasEmail;

  bool get hasSecAuth => verifyType.value != SecuritySecondaryVerifyType.none;

  int get usdtWalletMax => _securityData.value.usdtWalletMax;

  int get noWalletMax => 1;

  int get ebWalletMax => 1;

  List<WalletItem> get walletItems => _securityData.value.walletList;

  bool get hasLoginPassword => _securityData.value.hasLoginPwd;

  bool get isNewLoginPasswordValid {
    if (newLoginPassword.value.isEmpty) {
      return true;
    }
    return _isLoginPasswordValid(newLoginPassword.value);
  }

  bool get isOriginalLoginPasswordValid {
    if (originalLoginPassword.value.isEmpty) {
      return true;
    }
    return passwordStringValidate02(originalLoginPassword.value)
        .every((element) => element.item2);
  }

  bool get isConfirmLoginPasswordValid {
    if (confirmLoginPassword.value.isEmpty) {
      return true;
    }
    return confirmLoginPassword.value == newLoginPassword.value;
  }

  bool get isNewPaymentPasswordValid {
    if (newPaymentPassword.value.isEmpty) {
      return true;
    }
    return _isPaymentPasswordValid(newPaymentPassword.value);
  }

  bool get isOriginalPaymentPasswordValid {
    if (originalPaymentPassword.value.isEmpty) {
      return true;
    }
    return paymentPasswordStringValidate(originalPaymentPassword.value)
        .every((element) => element.item2);
  }

  bool get isConfirmPaymentPasswordValid {
    if (confirmPaymentPassword.value.isEmpty) {
      return true;
    }
    return confirmPaymentPassword.value == newPaymentPassword.value;
  }

  bool _isLoginPasswordValid(String password) {
    return passwordStringValidate02(password).every((element) => element.item2);
  }

  bool _isPaymentPasswordValid(String password) {
    return paymentPasswordStringValidate(password)
        .every((element) => element.item2);
  }

  bool get canUpdateLoginPassword {
    return _isLoginPasswordValid(originalLoginPassword.value) &&
        _isLoginPasswordValid(newLoginPassword.value) &&
        newLoginPassword.value == confirmLoginPassword.value;
  }

  bool get hasSetPaymentPassword => _securityData.value.hasPayPwd;

  bool get canSetPaymentPassword {
    return _isPaymentPasswordValid(newPaymentPassword.value) &&
        newPaymentPassword.value == confirmPaymentPassword.value;
  }

  bool get canUpdatePaymentPassword {
    return originalPaymentPassword.value.length == 6 &&
        _isPaymentPasswordValid(newPaymentPassword.value) &&
        newPaymentPassword.value == confirmPaymentPassword.value;
  }

  String get email => _securityData.value.email;

  final String Function(int) _convertBindAt =
      compose(formatDateTimeToString, convertTimestampToLocalDateTime);

  String get emailBindAt {
    final emailBindAt = _securityData.value.emailBindAt * 1000;
    if (emailBindAt > 0) {
      return _convertBindAt(emailBindAt);
    }
    return '';
  }

  String get googleBindAt {
    final googleBindAt = _securityData.value.googleBindAt * 1000;
    if (googleBindAt > 0) {
      return _convertBindAt(googleBindAt);
    }
    return '';
  }

  final Rx<int> emailVerficationCodeCountDown = 0.obs;

  bool get isEmailVerificationCodeCountDownRunning {
    return emailVerficationCodeCountDown.value > 0;
  }

  TextEditingController googleAuthController = TextEditingController();

  // login password
  TextEditingController originalLoginPasswordController =
      TextEditingController();
  TextEditingController newLoginPasswordController = TextEditingController();
  TextEditingController confirmLoginPasswordController =
      TextEditingController();

  Rx<String> originalLoginPassword = ''.obs;
  Rx<String> newLoginPassword = ''.obs;
  Rx<String> confirmLoginPassword = ''.obs;

  // payment password
  TextEditingController originalPaymentPasswordController =
      TextEditingController();
  TextEditingController newPaymentPasswordController = TextEditingController();
  TextEditingController confirmPaymentPasswordController =
      TextEditingController();

  Rx<String> originalPaymentPassword = ''.obs;
  Rx<String> newPaymentPassword = ''.obs;
  Rx<String> confirmPaymentPassword = ''.obs;

  // email verify
  Rx<String> emailAddress = ''.obs;
  Rx<String> emailVerificationCode = ''.obs;
  Rx<String> emailSecurityVerificationCode = ''.obs;

  TextEditingController bindEmailAddressController = TextEditingController();
  TextEditingController emailVerificationCodeController =
      TextEditingController();
  TextEditingController emailSecurityVerificationCodeController =
      TextEditingController();
  TextEditingController googleSecurityVerificationCodeController =
      TextEditingController();

  // List<Tuple2<CredentialStringValidateType, bool>>
  //     get loginPasswordValidationRulesResults {
  //   return passwordStringValidate(newLoginPassword.value);
  // }

  // List<Tuple2<CredentialStringValidateType, bool>>
  //     get payPasswordValidationRulesResults {
  //   return paymentPasswordStringValidate(newLoginPassword.value);
  // }

  bool get isEmailCanBind {
    return isEmailValid(emailAddress.value) &&
        emailVerificationCode.value.length == 6;
  }

  void earseSecondaryVerifyCode() {
    _earseGoogleAuthCode();
    _earseEmailSecurityCode();
  }

  void _earseGoogleAuthCode() {
    googleAuthController.clear();
    googleAuthCode.value = '';
  }

  void _earseEmailSecurityCode() {
    emailSecurityVerificationCodeController.clear();
    emailSecurityVerificationCode.value = '';
  }

  void earseTextControllers() {
    originalLoginPasswordController.clear();
    newLoginPasswordController.clear();
    confirmLoginPasswordController.clear();
    originalPaymentPasswordController.clear();
    newPaymentPasswordController.clear();
    confirmPaymentPasswordController.clear();
    bindEmailAddressController.clear();
    emailVerificationCodeController.clear();
    emailSecurityVerificationCodeController.clear();
    googleSecurityVerificationCodeController.clear();
    googleAuthController.clear();
    emailVerificationCodeCountDownCancel();
  }

  StreamSubscription<SecurityDataModel>? _securityDataSubscription;

  late final FocusNode originalLoginPasswordFocusNode;
  final RxBool originalLoginPasswordIsFocus = false.obs;
  late final FocusNode newLoginPasswordFocusNode;
  final RxBool newLoginPasswordIsFocus = false.obs;
  late final FocusNode confirmLoginPasswordFocusNode;
  final RxBool confirmLoginPasswordIsFocus = false.obs;

  @override
  void onInit() {
    super.onInit();
    originalLoginPasswordFocusNode = FocusNode();
    originalLoginPasswordFocusNode
        .addListener(_originalLoginPasswordFocusChange);

    newLoginPasswordFocusNode = FocusNode();
    newLoginPasswordFocusNode.addListener(_newLoginPasswordFocusChange);

    confirmLoginPasswordFocusNode = FocusNode();
    confirmLoginPasswordFocusNode.addListener(_confirmLoginPasswordFocusChange);

    originalLoginPasswordController.addListener(() {
      originalLoginPassword.value = originalLoginPasswordController.text;
    });

    newLoginPasswordController.addListener(() {
      newLoginPassword.value = newLoginPasswordController.text;
    });

    confirmLoginPasswordController.addListener(() {
      confirmLoginPassword.value = confirmLoginPasswordController.text;
    });

    originalPaymentPasswordController.addListener(() {
      originalPaymentPassword.value = originalPaymentPasswordController.text;
    });

    newPaymentPasswordController.addListener(() {
      newPaymentPassword.value = newPaymentPasswordController.text;
    });

    confirmPaymentPasswordController.addListener(() {
      confirmPaymentPassword.value = confirmPaymentPasswordController.text;
    });

    bindEmailAddressController.addListener(() {
      emailAddress.value = bindEmailAddressController.text;
    });

    emailVerificationCodeController.addListener(() {
      emailVerificationCode.value = emailVerificationCodeController.text;
    });

    emailSecurityVerificationCodeController.addListener(() {
      emailSecurityVerificationCode.value =
          emailSecurityVerificationCodeController.text;
    });

    googleAuthController.addListener(() {
      googleAuthCode.value = googleAuthController.text;
    });

    _securityDataSubscription = _securityData.stream.listen((data) {
      UserService.to.state.securityData = data;
    });
  }

  void _originalLoginPasswordFocusChange() {
    originalLoginPasswordIsFocus.value =
        originalLoginPasswordFocusNode.hasFocus;
  }

  void _newLoginPasswordFocusChange() {
    newLoginPasswordIsFocus.value = newLoginPasswordFocusNode.hasFocus;
  }

  void _confirmLoginPasswordFocusChange() {
    confirmLoginPasswordIsFocus.value = confirmLoginPasswordFocusNode.hasFocus;
  }

  Future<void> loadWalletAccountList() async {
    var allAccountList = await _walletService.getAccountList();
    // 过滤出银行卡数据
    bankAccountList.value =
        allAccountList.where((e) => e.paymentType == 6).toList();
    alipayAccountList.value =
        allAccountList.where((e) => e.paymentType == 7).toList();
  }

  @override
  void onReady() {
    super.onReady();
    loadSecurityData();
    loadWalletAccountList();
  }

  @override
  void dispose() {
    // 停止定期同步
    stopPeriodicSync();

    //dipose text controllers
    googleAuthController.dispose();
    originalLoginPasswordController.dispose();
    newLoginPasswordController.dispose();
    confirmLoginPasswordController.dispose();
    originalPaymentPasswordController.dispose();
    newPaymentPasswordController.dispose();
    confirmPaymentPasswordController.dispose();
    bindEmailAddressController.dispose();
    emailVerificationCodeController.dispose();
    bindEmailAddressController.dispose();
    emailVerificationCodeController.dispose();
    emailSecurityVerificationCodeController.dispose();

    _securityDataSubscription?.cancel();

    originalLoginPasswordFocusNode
        .removeListener(_originalLoginPasswordFocusChange);
    newLoginPasswordFocusNode.removeListener(_newLoginPasswordFocusChange);
    confirmLoginPasswordFocusNode
        .removeListener(_confirmLoginPasswordFocusChange);
    super.dispose();
  }

  //<editor-fold desc="开始倒计时">
  Timer? _codeCountTimer;

  void emailVerificationCodeCountDownStart() {
    if (isEmailVerificationCodeCountDownRunning) return;
    emailVerficationCodeCountDown.value =
        emailVerificationCodeCountDownDuration;
    _codeCountTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (emailVerficationCodeCountDown.value <= 0) {
        timer.cancel(); // 倒计时结束，停止
      } else {
        emailVerficationCodeCountDown.value--;
      }
    });
  }

  //</editor-fold>

  //<editor-fold desc="取消倒计时">
  void emailVerificationCodeCountDownCancel() {
    emailVerficationCodeCountDown.value = 0;
    _codeCountTimer?.cancel();
  }

  //</editor-fold>

  Future<SecurityDataModel> loadSecurityDataAndOutput() async {
    final model = await _securityService.loadSecurityData();
    _securityData.value = model;
    verifyType.value = _securityData.value.verifyType;
    return model;
  }

  Future<void> loadSecurityData() async {
    await fetchHandler<SecurityDataModel>(
      _securityService.loadSecurityData(),
      onSuccess: (model) {
        _securityData.value = model;
        verifyType.value = _securityData.value.verifyType;
      },
      onError: toastError,
      loading: true,
    );
  }

  Future<bool> setLoginPassword(
    String originalPassword,
    String newPassword, {
    String? securityCode,
  }) async {
    final isSuccess = await fetchHandler<bool>(
          _securityService.setLoginPassword(
            originalPassword,
            newPassword,
            securityCode: securityCode,
          ),
          onError: toastError,
          loading: true,
        ) ??
        false;

    if (isSuccess) {
      await loadSecurityData();
      earseTextControllers();
    }
    return isSuccess;
  }

  Future<bool> setPayPwd(
    String newPassword, {
    String? secCode,
  }) async {
    final isSuccess = await fetchHandler<bool>(
          _securityService.setPayPwd(
            newPassword,
          ),
          onError: toastError,
          loading: true,
        ) ??
        false;

    if (isSuccess) {
      AppUtils.showToast('settings_success'.tr);
      await loadSecurityData();
      earseTextControllers();
    }
    //多处用到此接口，需要返回是否成功做下一步处理
    return Future.value(isSuccess);
  }

  Future<bool> updatePayPwd(String newPassword, String originalPassword) async {
    final isSuccess = await fetchHandler<bool>(
          _securityService.setPayPwd(
            newPassword,
            oldPassword: originalPassword,
          ),
          onError: toastError,
          loading: true,
        ) ??
        false;

    if (isSuccess) {
      await loadSecurityData();
      earseTextControllers();
    }
    return isSuccess;
  }

  bool get canGetEmailVerificationCode {
    return isEmailValid(emailAddress.value) &&
        !isEmailVerificationCodeCountDownRunning;
  }

  Future<void> getEmailVerifyCode() async {
    final isSuccess = await fetchHandler<bool>(
      _securityService.sendEmailBindingVerifyCode(emailAddress.value),
      onError: toastError,
      loading: true,
    );

    if (isSuccess == true) {
      AppUtils.showToast('get_code_success'.tr);
      emailVerificationCodeCountDownStart();
    }
  }

  Future<bool> bindEmailAddress({String? secCode}) async {
    final tuple = await _securityService.bindEmail(
      bindEmailAddressController.text,
      emailVerificationCodeController.text,
      secCode: secCode,
    );

    if (tuple == true) {
      AppUtils.showToast('bind_success'.tr);
      await loadSecurityData();
      earseSecondaryVerifyCode();
      earseTextControllers();
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
      return true;
    } else {
      return false;
    }
  }

  Future<void> unbindEmail({String? secCode}) async {
    final isSuccess = await fetchHandler<bool>(
      _securityService.unbindEmail(secCode: secCode),
      onError: toastError,
      loading: true,
    );

    if (isSuccess == true) {
      if (Get.isBottomSheetOpen ?? false) Get.back();
      AppUtils.showToast('settings_success'.tr);
      await loadSecurityData();
      earseSecondaryVerifyCode();
    }
  }

  Future<bool> updateEmail({String? secCode}) async {
    final isSuccess = await fetchHandler<bool>(
      _securityService.updateEmail(
        bindEmailAddressController.text,
        emailVerificationCodeController.text,
        secCode: secCode,
      ),
      onError: toastError,
      loading: true,
    );

    if (isSuccess == true) {
      AppUtils.showToast('settings_success'.tr);
      await loadSecurityData();
      earseSecondaryVerifyCode();
      earseTextControllers();
      if (Get.isBottomSheetOpen ?? false) {
        Get.back(result: true);
      }
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteUSDTWalletAddress(
    String id, {
    String? secCode,
  }) async {
    final isSuccess = await fetchHandler<bool>(
      _walletService.deleteAccount(id, secCode: secCode),
      onError: toastError,
      loading: true,
    );

    if (isSuccess == true) {
      AppUtils.showToast('delete_success'.tr);
      await loadSecurityData();
      await loadWalletAccountList();
    }
  }

  Future<void> updateVerifyType(
    SecuritySecondaryVerifyType verifyType, {
    String? secCode,
  }) async {
    final isSuccess = await fetchHandler<bool>(
      _securityService.updateVerifyType(
        verifyType,
        securityCode: secCode,
      ),
      onError: toastError,
      loading: true,
    );

    if (isSuccess == true) {
      AppUtils.showToast('settings_success'.tr);
      this.verifyType.value = verifyType;
      await loadSecurityData();
      earseSecondaryVerifyCode();
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
    }
  }

  /// 发送安全验证码到邮箱
  Future<void> sendSecurityCodeToEmail() async {
    final isSuccess = await fetchHandler<bool>(
      _securityService.sendSecurityCodeToEmail(),
      onError: toastError,
      loading: true,
    );

    if (isSuccess == true) {
      AppUtils.showToast('get_code_success'.tr);
      emailVerificationCodeCountDownStart();
    }
  }

  (String, String) googleSecretCodeValue() {
    //每次获取都清除旧的，确保是一次性的
    _googleSecretCode.value = null;
    final secret = generateDoubleBase32EncodedString();
    _googleSecretCode.value = secret;
    final url = compose(generateOtpAuthUrl, trimEqualsSymbol)(secret);
    return (secret, url);
  }

  Future<bool?> bindGoogleAuth() async {
    final future = _securityService.bindGoogleAuthenticator(
        googleAuthCode.value, _googleSecretCode.value ?? '',
        secCode: emailSecurityVerificationCodeController.value.text ?? '');
    final isSuccess = await fetchHandler(
      future,
      onSuccess: (isSuccess) {
        if (!isSuccess) {
          AppUtils.showToast('bind_failed'.tr);
          return;
        }
        AppUtils.showToast('bind_success'.tr);
        earseSecondaryVerifyCode();
        loadSecurityData();
        if (Get.isBottomSheetOpen ?? false) {
          Get.back();
        }
      },
      onError: toastError,
      loading: true,
    );
    return isSuccess;
  }

  Future<void> unbindGoogleAuth({String? secCode}) async {
    final isSuccess = await fetchHandler(
      _securityService.unbindGoogleAuthenticator(secCode: secCode),
      onError: toastError,
      loading: true,
    );

    if (isSuccess == false) {
      AppUtils.showToast('settings_failed'.tr);
      return;
    }
    AppUtils.showToast('settings_success'.tr);
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
    earseSecondaryVerifyCode();
    await loadSecurityData();
  }

  Future<void> updateGoogleAuth() async {
    final isSuccess = await fetchHandler(
      _securityService.updateGoogleAuthenticator(
          googleAuthCode.value, _googleSecretCode.value ?? '',
          secCode: emailSecurityVerificationCodeController.value.text ?? ''),
      onError: toastError,
      loading: true,
    );

    if (isSuccess == false) {
      AppUtils.showToast('settings_failed'.tr);
      return;
    }

    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
    AppUtils.showToast('settings_success'.tr);
    earseSecondaryVerifyCode();
    await loadSecurityData();
  }

  /// 强制同步控制器和 Observable 的值
  void forceSyncEmailSecurityCode() {
    final controllerText = emailSecurityVerificationCodeController.text;
    if (emailSecurityVerificationCode.value != controllerText) {
      emailSecurityVerificationCode.value = controllerText;
    }
  }

  Timer? _syncTimer;

  /// 开始定期同步控制器和Observable的值
  void startPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      // 检查邮箱验证码
      final emailText = emailSecurityVerificationCodeController.text;
      if (emailSecurityVerificationCode.value != emailText) {
        emailSecurityVerificationCode.value = emailText;
      }

      // 检查Google验证码
      final googleText = googleAuthController.text;
      if (googleAuthCode.value != googleText) {
        googleAuthCode.value = googleText;
      }
    });
  }

  /// 停止定期同步
  void stopPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }
}

/// Google身份验证步骤枚举
enum GoogleAuthStep {
  tutorial, // 教程步骤
  qrCode, // 二维码/密钥步骤
  verify, // 验证码输入步骤
}

enum SecuritySecondaryVerifyType {
  //0: none, 1: Eamil, 2: Google
  none,
  email,
  google;

  String get name {
    switch (this) {
      case SecuritySecondaryVerifyType.none:
        return 'no_check'.tr;
      case SecuritySecondaryVerifyType.email:
        return 'email_verify'.tr;
      case SecuritySecondaryVerifyType.google:
        return 'google_auth'.tr;
    }
  }

  int get code {
    switch (this) {
      case SecuritySecondaryVerifyType.none:
        return 0;
      case SecuritySecondaryVerifyType.email:
        return 1;
      case SecuritySecondaryVerifyType.google:
        return 2;
    }
  }

  static SecuritySecondaryVerifyType fromInt(int value) {
    switch (value) {
      case 1:
        return SecuritySecondaryVerifyType.email;
      case 2:
        return SecuritySecondaryVerifyType.google;
      default:
        return SecuritySecondaryVerifyType.none;
    }
  }

  static SecuritySecondaryVerifyType fromString(String value) {
    switch (value) {
      case '1':
        return SecuritySecondaryVerifyType.email;
      case '2':
        return SecuritySecondaryVerifyType.google;
      default:
        return SecuritySecondaryVerifyType.none;
    }
  }
}

extension SecuritySecondaryVerifyTypeExtension on SecuritySecondaryVerifyType {
  String get imgUrl {
    switch (this) {
      case SecuritySecondaryVerifyType.email:
        return Assets.securityEmail;
      case SecuritySecondaryVerifyType.google:
        return Assets.securityGoogle;
      case SecuritySecondaryVerifyType.none:
        return Assets.securityNoverify;
    }
  }
}
