import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:filbet/http/domain/domain/domain_manager.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/sharetrace_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/services/web_socket_service.dart';
import 'package:filbet/services/xinstall_service.dart';
import 'package:get/get.dart';

abstract class AppBootstrapController extends GetxController {
  final domainTip = '线路加载中...'.obs;

  /// initApp 初始化进度：0.0 ~ 1.0
  final RxDouble initAppProgress = 0.0.obs;

  @override
  void onInit() {
    initApp();

    super.onInit();
  }

  /// 检测是否有网络（非 none 视为有网）
  Future<bool> _hasNetwork() async {
    try {
      final results = await Connectivity().checkConnectivity();
      final list = results is List ? results as List : [results];
      if (list.isEmpty) return false;
      return list.any((r) => r != ConnectivityResult.none);
    } catch (_) {
      return false;
    }
  }

  Future<void> initApp({bool userChangeLine = false}) async {
    /// 为了初始化时序正常 确保异步方法 await 完成
    try {
      initAppProgress.value = 0.0;
      domainTip.value = '等待网络连接...';
      const maxWaitSeconds = 60 * 10;
      int waited = 0;
      while (!await _hasNetwork()) {
        if (waited >= maxWaitSeconds) {
          domainTip.value = '无网络，请检查网络连接';
          return;
        }
        await Future.delayed(const Duration(seconds: 1));
        waited += 1;
      }
      domainTip.value = '线路加载中...';
      var domain = await DomainManager.instance.queryDomainList(
        onTip: (msg) => domainTip.value = msg,
      );
      if (domain == null) {
//        domainTip.value = '线路加载失败，稍后再试';
        return;
      }
      initAppProgress.value = 0.2;
      Get.put(WebSocketService());
      // 先创建服务实例
      final globalService = GlobalService();
      final userService = UserService();
      await XinstallService.init();
      await SharetraceService.init();
      // 先注册到 GetX
      Get.put(globalService, permanent: true);
      Get.put(userService, permanent: true);
      initAppProgress.value = 0.35;
      // 再分别初始化
      await globalService.init();
      initAppProgress.value = 0.65;
      await userService.init();
      initAppProgress.value = 0.99;

      initAppProgress.value = 1.0;
      //神策数据
      // await startSensorsAnalyticsSDK();
      // await initPlatformState();
      ///上报日志
    } catch (e) {
      print('_initApp $e');
      domainTip.value = '线路加载失败，稍后再试';
      if (e == 'restricted') {
        // Get.offAllNamed(Routes.restrictedPage);
        return;
      }

      ///app启动失败

      onFailed(e);
    }
  }

  // void initEventBus() {
  //   registerEvent();
  // }

  /// 初始化完成
  void onInitialized();

  /// 初始化失败
  void onFailed(e);
}
