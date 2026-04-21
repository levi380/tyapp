import 'package:flutter/services.dart';

class AdnroidChannel {
  static const _batteryChannelName = "com.tyapp.flutter.flutter_ty_app";  // 1.方法通道名称
  static MethodChannel? _batteryChannel;

  static void initChannels(){
    _batteryChannel = const MethodChannel(_batteryChannelName);
  }

  // 3. 异步任务，通过平台通道与特定平台进行通信，获取电量，这里的宿主平台是 Android
  static getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await _batteryChannel?.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    return batteryLevel;
  }

  // 3. 异步任务，通过平台通道与特定平台进行通信，获取getIsIpad，这里的宿主平台是 Android
  static Future<bool?> getIsIpad() async {
    final bool? isIpad = await _batteryChannel?.invokeMethod<bool>('getIsIpad');
    return isIpad;
  }
}
