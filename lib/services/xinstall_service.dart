import 'dart:convert';
import 'dart:developer';

import 'package:filbet/constants/log.dart';
import 'package:filbet/http/entity/x_install_param.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/sp_storage/storage_key.dart';
import 'package:filbet/utils/log/log.dart';
import 'package:xinstall_flutter_plugin/xinstall_flutter_plugin.dart';

class XinstallService {
  static final XinstallFlutterPlugin _plugin =
      XinstallFlutterPlugin.getInstance();

  /// 本会话内防并发重复（与本地标记配合）
  static bool _installParamLogUploaded = false;

  /// [xinstallParamHandler] 内日志：未卸载前整 App 生命周期只上报一次（SharedPreferences）
  static void _uploadInstallLogOnce(List<Map<String, dynamic>> events) {
    if (_installParamLogUploaded) return;
    if (SpStorage.getBool(StorageKey.installParamLogUploaded)) return;
    _installParamLogUploaded = true;
    SpStorage.setBool(StorageKey.installParamLogUploaded, true);
    LogUploader.upload(events);
  }

  static Future<void> init() async {
    try {
      await Future.any([
        Future(() {
          _plugin.init();
        }),
        Future.delayed(const Duration(seconds: 5)),
      ]);
    } catch (e) {}
  }

  static Future<void> getInstallTrace() async {
    //获取安装参数（首次安装）
    _plugin.getInstallParam(xinstallParamHandler, 15);
  }

  static Future xinstallParamHandler(Map<String, dynamic> data) async {
    try {
      Log.xInstallData = jsonEncode(data);
      var xInstallData = XInstallParam.fromJson(data);
      String value = xInstallData.data?.uo?.ic ?? '';
      if (value.isEmpty) {
        value = xInstallData.bindData?.uo?.ic ?? '';
      }
      print("object123456 value= $value");
      if (value.isNotEmpty) {
        GlobalService.to.state.installQuery.value = value;
      }
      if (GlobalService.to.state.installQuery.value.isEmpty) {
        _uploadInstallLogOnce([LogEvents.codeError(message: jsonEncode(data))]);
      }
    } catch (e) {
      _uploadInstallLogOnce(
        [LogEvents.codeError(message: jsonEncode(data), stack: '$e')],
      );
    }
  }
}
