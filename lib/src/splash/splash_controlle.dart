import 'dart:async';

import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/src/splash/app_bootstrap_controller.dart';
import 'package:filbet/src/home/appconfig_model.dart';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum SplashType {
  single,
  multi;
}

class SplashController extends AppBootstrapController {
  SplashController({required SplashModel? splashModel})
      : splashModel = Rxn<SplashModel>(splashModel),
        super();

  static SplashController get to => Get.find();

  final Rxn<SplashModel> splashModel;

  //multi
  final RxInt currentIndex = 0.obs;
  RxInt remaining = 5.obs;
  Timer? _timer;
  final appVersion = "".obs;
  Worker? _initProgressWorker;
  bool _countdownStarted = false;

  SplashType get splashType {
    if (splashModel.value == null) {
      return SplashType.single;
    }
    final model = splashModel.value!;
    final imgs = model.getImageUrlsForDevice();
    return imgs.length == 1 ? SplashType.single : SplashType.multi;
  }

  Future<String> get imageForSinglePhotoViewUrl async {
    final model = splashModel.value;
    if (model == null) {
      return Assets.imagesWelcomeDefault;
    }
    return await model.imageForSinglePhotoView() ?? Assets.imagesWelcomeDefault;
  }

  @override
  void onInit() async {
    super.onInit();
    if (splashType == SplashType.multi) {
      return;
    }
    getVersion();

    // 倒计时：等 initApp() 进度完成后才开始
    _initProgressWorker = ever<double>(initAppProgress, (p) {
      if (_countdownStarted) return;
      if (p >= 1.0) {
        _countdownStarted = true;
        initSucceed();
      }
    });
  }

  void initSucceed() {
    if (splashModel.value == null) {
      startMain();
    } else {
      _startTimer();
    }
  }

  Future<void> startMain() async {
    _timer?.cancel();

    // 无论网络状态如何，都尝试启动主页面
    AppNavigator.startMain();
  }

  @override
  void onFailed(e) {}

  @override
  void onInitialized() {
    // 初始化完成后检查网络连接
  }

  void _startTimer() {
    _timer?.cancel();
    remaining.value = 5;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remaining--;
      if (remaining <= 0) {
        _timer?.cancel();
        startMain();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _initProgressWorker?.dispose();
    super.dispose();
  }

  void getVersion() async {
    var info = await PackageInfo.fromPlatform();
    appVersion.value = 'V${info.version}';
  }
}
