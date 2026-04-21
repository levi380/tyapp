import 'package:flutter/services.dart';

/// 设备方向管理器
class DeviceOrientationManager {
  /// 设置横屏方向
  static Future<void> setLandscapeOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// 设置竖屏方向
  static Future<void> setPortraitOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}