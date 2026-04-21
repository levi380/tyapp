import 'dart:async';

import 'package:filbet/common/language.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/generated/app_translations.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/login_info.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/sharetrace_service.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/sp_storage/storage_key.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/services/xinstall_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/login/auth_service.dart';
import 'package:filbet/src/login/login_official_sponsor.dart';
import 'package:filbet/src/login/captcha/captcha_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/credential_validate_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class LoginAndRegisterController extends GetXBaseController {
  final scrollController = ScrollController();

  // TextEditingController
  //账号
  late final TextEditingController accountController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  late final TextEditingController verifyController;

  // late final TextEditingController invitationCodeController;

  //账号 FocusNode
  late final FocusNode accountFocusNode;

  //密码
  late final FocusNode passwordFocusNode;

  //确认密码
  late final FocusNode confirmPasswordFocusNode;

  /// 安全验证验证码
  late final FocusNode verifyFocusNode;

  // late final FocusNode invitationCodeFocusNode;

  // 存储监听器引用以便清理
  late final List<Worker> _workers;

  final Rx<LoginAndRegisterType> type;
  final Rx<Language> language;
  final RxBool isRememberPassword = true.obs;
  final RxString account = ''.obs;
  final RxString password = ''.obs;
  final RxString confirmPassword = ''.obs;
  final RxString invitationCode = ''.obs;
  final RxString verifyCode = ''.obs;
  final RxBool isLoading = false.obs;

  /// 登录请求进行中，按钮不可点击
  final RxBool isLoginSubmitting = false.obs;

  /// 注册请求进行中，按钮不可点击
  final RxBool isRegisterSubmitting = false.obs;
  final RxBool accountIsFocus = false.obs;
  final RxBool passwordIsFocus = false.obs;
  final RxBool confirmPasswordIsFocus = false.obs;
  final RxBool verifyIsFocus = false.obs;

  /// 任一登录相关输入框聚焦（用于头部 logo 显隐）
  final RxBool anyFieldFocused = false.obs;

  // final RxBool invitationCodedIsFocus = false.obs;
  final RxBool isProtocolCheck = true.obs;

  final AuthService _authService = Get.find<AuthService>();
  final UserService _userService = Get.find<UserService>();

  late final StreamSubscription<LoginAndRegisterType> _typeSubscription;
  late final StreamSubscription<Language> _languageSubscription;

  final countdownSeconds = 0.obs;

  // ---  OverlayEntry 修改部分 ---
  // 1. 为输入框的容器添加 GlobalKey
  final accountFieldKey = GlobalKey();
  final passwordFieldKey = GlobalKey();
  final confirmPasswordFieldKey = GlobalKey();
  final invitationCodeFieldKey = GlobalKey();

  LoginAndRegisterController(
      {required LoginAndRegisterType type, required Language language})
      : type = type.obs,
        language = language.obs;

  LoginInfo? loginInfo;

  /// 登录页官方赞助商（展示尺寸在 View 中结合 ScreenUtil 缩放）
  final List<LoginOfficialSponsor> officialSponsors = const [
    LoginOfficialSponsor(
      asset: Assets.loginBragaSportsClub,
      titleKey: '布列斯特俱乐部',
    ),
    LoginOfficialSponsor(
      asset: Assets.loginIconToulouseFootball,
      titleKey: '图卢兹俱乐部',
    ),
    LoginOfficialSponsor(
      asset: Assets.loginCeltaVigo,
      titleKey: '皇家维戈塞尔塔',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    getInstallQuery();
    language.value = GlobalService.to.state.language;

    _initializeControllers();
    _initializeListeners();

    _typeSubscription = type.stream.listen((LoginAndRegisterType value) {
      if (value == LoginAndRegisterType.register) {
        isRememberPassword.value = false; // 注册时不自动记住密码
      }
    });

    // 异步加载记住密码状态
    _loadRememberPasswordState();
  }

  void _loadRememberPasswordState() async {
    final Map<String, dynamic>? map = SpStorage.getRememberMe;

    if (map != null) {
      isRememberPassword.value = true;
      account.value = map[StorageKey.userName] ?? '';
      password.value = map[StorageKey.password] ?? '';
      accountController.text = account.value;
      passwordController.text = password.value;
    } else {
      isRememberPassword.value = false;
    }
    update();
  }

  void _initializeControllers() {
    accountController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    verifyController = TextEditingController();

    accountFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    verifyFocusNode = FocusNode();
    // invitationCodeFocusNode = FocusNode();
  }

  void _initializeListeners() {
    // 初始化 workers 列表
    _workers = [];

    // 监听语言变化并同步到 UserService
    _languageSubscription = language.listen((Language newLanguage) {
      GlobalService.to.state.language = newLanguage;
      SpStorage.updateAppLocalLanguage(newLanguage.abbr);

      Locale locale =
          resolveLocale(newLanguage.abbr, AppTranslations.supportedLocales);
      Get.updateLocale(locale);

      GlobalService.to.memberIndex();

      GlobalService.to.customerService();

      Future.delayed(const Duration(milliseconds: 250), () {
        Get.forceAppUpdate();
      });
    });

    // 监听语言变化触发UI更新
    _workers.add(ever(language, (_) => update()));

    // --- OverlayEntry 修改部分 ---
    // 3. 监听焦点变化来显示/隐藏气泡
    accountFocusNode.addListener(_onAccountFocusChange);
    passwordFocusNode.addListener(_onPasswordFocusChange);
    confirmPasswordFocusNode.addListener(_onConfirmPasswordFocusChange);
    // invitationCodeFocusNode.addListener(_onInvitationCodeFocusChange);
    // --- 结束 OverlayEntry 修改 ---

    // 监听响应式变量变化，用于实时重绘UI（当用户输入时）
    // 这个 update() 会触发 GetBuilder 重建，包括 Overlay 中的 GetBuilder
    _workers.add(ever(account, (_) => update()));
    _workers.add(ever(password, (_) => update()));
    _workers.add(ever(confirmPassword, (_) => update()));
    // _workers.add(ever(invitationCode, (_) => update()));

    // 监听登录/注册类型变化
    // _workers.add(ever(type, (LoginAndRegisterType? value) {
    //   // 只清空确认密码，保留账号和密码
    //   confirmPasswordController.clear();
    //   confirmPassword.value = '';
    //   // invitationCode.value = '';
    //   update();
    // }));

    // 监听记住密码状态变化
    _workers.add(ever(isRememberPassword, (bool value) {
      update();
    }));

    accountFocusNode.addListener(() {
      _onAccountFocusChange();
      if (accountFocusNode.hasFocus) {
        _scrollToWidget(accountFieldKey);
      }
    });
    passwordFocusNode.addListener(() {
      _onPasswordFocusChange();
      if (passwordFocusNode.hasFocus) {
        _scrollToWidget(passwordFieldKey);
      }
    });
    confirmPasswordFocusNode.addListener(() {
      _onConfirmPasswordFocusChange();
      if (confirmPasswordFocusNode.hasFocus) {
        _scrollToWidget(confirmPasswordFieldKey);
      }
    });
    verifyFocusNode.addListener(_onVerifyFocusChange);
  }

  Locale resolveLocale(String languageKey, List<Locale> supportedLocales) {
    // 1) 规范化：vi-VN / vi_VN / VI_vn -> vi_VN
    final norm = languageKey.trim().replaceAll('-', '_');
    final parts = norm.split('_');
    String lang = parts[0].toLowerCase();
    String? country = parts.length > 1 ? parts[1].toUpperCase() : null;

    // 2) 先精确匹配 语言+地区
    for (final loc in supportedLocales) {
      final lc = loc.languageCode.toLowerCase();
      final cc = (loc.countryCode ?? '').toUpperCase();
      if (lc == lang && (country == null || country == cc)) {
        return loc;
      }
    }

    // 3) 退化：仅按语言匹配
    for (final loc in supportedLocales) {
      if (loc.languageCode.toLowerCase() == lang) {
        return loc;
      }
    }

    return Locale("zh", "CN"); // 找不到就返回 null，由调用方决定 fallback
  }

  void _disposeListeners() {
    _languageSubscription.cancel();
    _typeSubscription.cancel();
  }

  void _disposeControllers() {
    // --- OverlayEntry 修改部分 ---
    // 移除Overlay相关的监听器
    accountFocusNode.removeListener(_onAccountFocusChange);
    passwordFocusNode.removeListener(_onPasswordFocusChange);
    confirmPasswordFocusNode.removeListener(_onConfirmPasswordFocusChange);
    verifyFocusNode.removeListener(_onVerifyFocusChange);
    // --- 结束 OverlayEntry 修改 ---

    // 取消所有 GetX workers
    for (final worker in _workers) {
      worker.dispose();
    }
    _workers.clear();

    // 释放控制器和焦点节点
    accountController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    // invitationCodeController.dispose();

    accountFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    verifyFocusNode.dispose();
    // invitationCodeFocusNode.dispose();
  }

  @override
  void onClose() {
    scrollController.dispose();
    _disposeListeners();
    _disposeControllers();
    super.onClose();
  }

  // --- OverlayEntry 修改部分 ---
  // 4. 实现焦点变化的处理方法
  void _onAccountFocusChange() {
    accountIsFocus.value = accountFocusNode.hasFocus;
    _syncAnyFieldFocused();
  }

  void _onPasswordFocusChange() {
    passwordIsFocus.value = passwordFocusNode.hasFocus;
    _syncAnyFieldFocused();
  }

  void _onConfirmPasswordFocusChange() {
    confirmPasswordIsFocus.value = confirmPasswordFocusNode.hasFocus;
    _syncAnyFieldFocused();
  }

  void _onVerifyFocusChange() {
    verifyIsFocus.value = verifyFocusNode.hasFocus;
    _syncAnyFieldFocused();
  }

  void _syncAnyFieldFocused() {
    anyFieldFocused.value = accountFocusNode.hasFocus ||
        passwordFocusNode.hasFocus ||
        confirmPasswordFocusNode.hasFocus ||
        verifyFocusNode.hasFocus;
  }

  // --- 结束 OverlayEntry 修改 ---

  void toggleLoginAndRegisterType(LoginAndRegisterType type) {
    this.type.value = type;
    // Future.microtask(() {
    //   accountFocusNode.requestFocus();
    // });
  }

  void toggleRememberPassword() {
    isRememberPassword.value = !isRememberPassword.value;
  }

  // login validation
  bool get isLoginAccountValid {
    return accountStringValidate(account.value)
        .every((element) => element.item2);
  }

  bool get isPresentLoginAccountInputError {
    if (account.value.isEmpty) {
      return false;
    }
    return accountStringValidate(account.value)
        .any((element) => !element.item2);
  }

  bool get isLoginPasswordValid {
    return passwordStringValidate03(password.value)
        .every((element) => element.item2);
  }

  bool get isPresentLoginPasswordInputError {
    // if (passwordFocusNode.hasFocus) {
    //   return false;
    // }
    if (password.value.isEmpty) {
      return false;
    }
    return passwordStringValidate03(password.value)
        .any((element) => !element.item2);
  }

  bool get isPresentLoginConfirmPasswordInputError {
    // if (passwordFocusNode.hasFocus) {
    //   return false;
    // }
    if (confirmPassword.value.isEmpty) {
      return false;
    }
    return passwordStringValidate03(confirmPassword.value)
        .any((element) => !element.item2);
  }

  bool get isConfirmPasswordInputError {
    if (passwordController.text.isNotEmpty) {
      return passwordController.text.trim() !=
          confirmPasswordController.text.trim();
    } else {
      return passwordStringValidate03(confirmPassword.value)
          .any((element) => !element.item2);
    }
  }

  bool get isLoginButtonEnable => isLoginAccountValid && isLoginPasswordValid;

  // register validation
  bool get isRegisterAccountValid => isLoginAccountValid;

  bool get isPresentRegisterPasswordStrengthIndicator {
    return passwordFocusNode.hasFocus;
  }

  bool get isConfirmPasswordValid =>
      confirmPassword.value == password.value &&
      confirmPassword.value.isNotEmpty;

  bool get isRegisterButtonEnable =>
      isLoginAccountValid && isLoginPasswordValid && isConfirmPasswordValid;

  List<Tuple2<CredentialStringValidateType, bool>>
      get passwordValidationRulesResults {
    return passwordStringValidate03(password.value);
  }

  void clearAllFields() {
    accountController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    // invitationCodeController.clear();
    account.value = '';
    password.value = '';
    confirmPassword.value = '';
    // invitationCode.value = '';
  }

  void focusToAccount() {
    accountFocusNode.requestFocus();
  }

  Future<void> register() async {
    // final ok = await CaptchaService.instance.verify(account.value);
    // if (!ok) return;
    if (isRegisterSubmitting.value) return;
    isRegisterSubmitting.value = true;
    try {
      await fetchHandler(
        _authService.register(
          account: account.value,
          password: password.value,
          referrerCode: GlobalService.to.state.installQuery.value,
        ),
        onSuccess: (token) async {
          await _userService.initializeRegularUser(
            token: token,
            isRegister: true,
          );

          GlobalService.to.memberIndex();
          Get.offAllNamed(Routes.MAIN);
        },
        onError: toastError,
        loading: true,
      );
    } finally {
      isRegisterSubmitting.value = false;
    }
  }

  // Future<void> login() async {
  //   await fetchHandler(
  //     _authService.login(
  //       account: account.value,
  //       password: password.value,
  //     ),
  //     onSuccess: (token) async {
  //       loginSuccess(token);
  //     },
  //     onError: toastError,
  //     loading: true,
  //   );
  // }

  ///登录改为校验手机号
  void loginByVerifyPhone() async {
    if (isLoginSubmitting.value) return;
    isLoginSubmitting.value = true;
    try {
      loginInfo = await ApiRequest.loginStep1(account.value, password.value);
      if (loginInfo != null) {
        num errorCount = loginInfo?.errorCount ?? 0;
        // if (errorCount <= 1) {
        //   final ok = await CaptchaService.instance.verify(account.value);
        //   if (!ok) return;
        // }
        if (loginInfo?.failed == true) {
          if (errorCount > 5) {
            final ok = await CaptchaService.instance.verify(account.value);
            if (!ok) return;
          }
          AppUtils.showToastForResponse(loginInfo?.errorMessage);
          return;
        }
        if (loginInfo?.hasPhone == true) {
          toggleLoginAndRegisterType(LoginAndRegisterType.verify);
        } else {
          loginSuccess(loginInfo?.sid ?? '');
        }
      }
    } finally {
      print("object1234567890");
      isLoginSubmitting.value = false;
    }
  }

  void loginByVerifyPhoneAgain(String inputContent) async {
    loginInfo = await ApiRequest.loginStep1(account.value, password.value);
    if (loginInfo != null) {
      loginStep2(loginInfo?.sid ?? '', inputContent);
    }
  }

  void loginStep2(String sid, String inputContent) async {
    bool? result = await ApiRequest.loginStep2(sid, inputContent, false);
    if (result == true) {
      sendCode();
    }
  }

  void sendCode() async {
    var result = await ApiRequest.loginStep3(loginInfo?.sid ?? '');
    if (result == true) {
      AppUtils.showToast('验证码发送成功');
      countdownSeconds.value = countdownTime;
    }
  }

  void verifySmsCode() async {
    if (verifyController.text.isEmpty) {
      AppUtils.showToast("请输入验证码");
      return;
    }
    var token = await ApiRequest.loginStep4(
        loginInfo?.sid ?? '', verifyController.text);
    if (token != null) {
      loginSuccess(token);
    }
  }

  void loginSuccess(String token) async {
    if (isRememberPassword.value) {
      SpStorage.setRememberMe({
        StorageKey.userName: account.value,
        StorageKey.password: password.value,
      });
    }
    await _userService.initializeRegularUser(token: token);
    GlobalService.to.memberIndex();
    Get.offAllNamed(Routes.MAIN);
  }

  Future<void> _scrollToWidget(GlobalKey key) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final context = key.currentContext;
    if (context == null) return;

    final keyboardHeight = MediaQuery.of(Get.context!).viewInsets.bottom;
    if (keyboardHeight == 0) {
      return;
    }

    // ignore: use_build_context_synchronously
    final RenderBox box = context.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);
    final widgetHeight = box.size.height;
    final widgetBottom = position.dy + widgetHeight;

    final screenHeight = MediaQuery.of(Get.context!).size.height;
    final keyboardTop = screenHeight - keyboardHeight;

    if (widgetBottom > keyboardTop) {
      final scrollOverlap = widgetBottom - keyboardTop + 20.h;

      await scrollController.animateTo(
        scrollController.offset + scrollOverlap,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
      update();
    }
  }

  void getInstallQuery() async {
    try {
      SharetraceService.getInstallTrace();
    } catch (e) {
      XinstallService.getInstallTrace();
      print("object123456 $e");
    }
  }
}

enum LoginAndRegisterType {
  login,
  register,
  verify;

  int get value {
    switch (this) {
      case LoginAndRegisterType.login:
        return 0;
      case LoginAndRegisterType.register:
        return 1;
      case LoginAndRegisterType.verify:
        return 2;
    }
  }

  static LoginAndRegisterType fromValue(int value) {
    switch (value) {
      case 0:
        return LoginAndRegisterType.login;
      case 1:
        return LoginAndRegisterType.register;
      case 2:
        return LoginAndRegisterType.verify;
      default:
        throw ArgumentError('Invalid value for LoginAndRegisterType: $value');
    }
  }
}
