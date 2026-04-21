import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtil {
  /// 设备的唯一id
  static String? identifier;
  static String? systemVersion;

  static String getDeviceOS() {
    String os = "";
    if (Platform.isAndroid) {
      os = "android"; //UUID for Android
    } else if (Platform.isIOS) {
      os = "ios"; //UUID for iOS
    }
    return os;
  }

  static Future<String> getDeviceIdentifier() async {
    if (DeviceUtil.identifier != null) {
      return Future.value(DeviceUtil.identifier);
    }

    String? identifier;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        // var build = await deviceInfoPlugin.androidInfo;
        // identifier = build.id; //UUID for Android

        const AndroidId androidIdPlugin = AndroidId();
        identifier = await androidIdPlugin.getId();
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      debugPrint('Failed to get platform version');
    }
    DeviceUtil.identifier = identifier;
    return identifier!;
  }

  static Future<String> getDeviceName() async {
    String? model;
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        model = androidInfo.board;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        model = iosDeviceInfo.name; //model for iOS
      }
    } on PlatformException {
      debugPrint('Failed to get platform version');
    }

    /// 后端限制登录的参数clientName 不能有'_'字符
    model = model?.replaceAll("_", '');
    return model!;
  }

  static Future<String> getDeviceModel() async {
    String? model;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        model = build.model; //model for Android
      } else if (Platform.isIOS) {
        var iosInfo = await deviceInfoPlugin.iosInfo;
        model = iosInfo.utsname.machine; //model for iOS
      }
    } on PlatformException {
      debugPrint('Failed to get platform version');
    }
    return model!;
  }

  static Future<String> getDeviceModelName() async {
    String? name;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        name = build.manufacturer; //model for Android
      } else if (Platform.isIOS) {
        var iosInfo = await deviceInfoPlugin.iosInfo;
        name = iosInfo.name; //model for iOS
      }
    } on PlatformException {
      debugPrint('Failed to get platform version');
    }
    return name!;
  }

  static Future<String> getSystemVersion() async {
    String version = "";
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        version = 'android ${build.version.release}'; //model for Android
      } else if (Platform.isIOS) {
        var iosInfo = await deviceInfoPlugin.iosInfo;
        version = 'iOS ${iosInfo.systemVersion}'; //model for iOS
      }
    } on PlatformException {
      debugPrint('Failed to get platform version');
    }
    systemVersion = version;
    return version;
  }

  static Future<int> getAndroidSDKNumber() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      return sdkInt;
    }
    return -1;
  }

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version; // 获取版本号
  }

  static Future<String> getAppName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.appName; // 获取版本号
  }

  bool isIPhoneX(MediaQueryData mediaQuery) {
    if (Platform.isIOS) {
      var size = mediaQuery.size;
      if (size.height == 812.0 || size.width == 812.0) {
        return true;
      }
    }
    return false;
  }

  static String _mapToReadable(String machine) {
    const map = {
      /// ===== iPhone =====
      'iPhone8,1': 'iPhone 6s',
      'iPhone8,2': 'iPhone 6s Plus',
      'iPhone8,4': 'iPhone SE (1st gen)',

      'iPhone9,1': 'iPhone 7',
      'iPhone9,2': 'iPhone 7 Plus',
      'iPhone9,3': 'iPhone 7',
      'iPhone9,4': 'iPhone 7 Plus',

      'iPhone10,1': 'iPhone 8',
      'iPhone10,2': 'iPhone 8 Plus',
      'iPhone10,3': 'iPhone X',
      'iPhone10,6': 'iPhone X',

      'iPhone11,2': 'iPhone XS',
      'iPhone11,4': 'iPhone XS Max',
      'iPhone11,6': 'iPhone XS Max',
      'iPhone11,8': 'iPhone XR',

      'iPhone12,1': 'iPhone 11',
      'iPhone12,3': 'iPhone 11 Pro',
      'iPhone12,5': 'iPhone 11 Pro Max',

      'iPhone12,8': 'iPhone SE (2nd gen)',

      'iPhone13,1': 'iPhone 12 mini',
      'iPhone13,2': 'iPhone 12',
      'iPhone13,3': 'iPhone 12 Pro',
      'iPhone13,4': 'iPhone 12 Pro Max',

      'iPhone14,4': 'iPhone 13 mini',
      'iPhone14,5': 'iPhone 13',
      'iPhone14,2': 'iPhone 13 Pro',
      'iPhone14,3': 'iPhone 13 Pro Max',

      'iPhone14,6': 'iPhone SE (3rd gen)',

      'iPhone14,7': 'iPhone 14',
      'iPhone14,8': 'iPhone 14 Plus',
      'iPhone15,2': 'iPhone 14 Pro',
      'iPhone15,3': 'iPhone 14 Pro Max',

      'iPhone15,4': 'iPhone 15',
      'iPhone15,5': 'iPhone 15 Plus',
      'iPhone16,1': 'iPhone 15 Pro',
      'iPhone16,2': 'iPhone 15 Pro Max',

      /// ===== 模拟器 =====
      'i386': 'Simulator',
      'x86_64': 'Simulator',
      'arm64': 'Simulator',
    };

    return map[machine] ?? "iPhone ($machine)";
  }
}
