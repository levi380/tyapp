import 'dart:convert';

import 'package:filbet/constants/log.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/xinstall_service.dart';
import 'package:filbet/utils/string_utils.dart';
import 'package:sharetrace_flutter_plugin/sharetrace_flutter_plugin.dart';

class SharetraceService {
  static final SharetraceFlutterPlugin _plugin =
      SharetraceFlutterPlugin.getInstance();

  static Future<void> init() async {
    try {
      _plugin.disableClipboard();
      _plugin.init();
    } catch (e) {}
  }

  static Future<void> getInstallTrace() async {
    //获取安装参数（首次安装）
    _plugin.getInstallTrace(responseHandler);
  }

  static Future responseHandler(Map<String, String> data) async {
    try {
      Log.shareTraceData = jsonEncode(data);
      String? paramsData = data['paramsData'];
      if (paramsData?.isNotEmpty == true) {
        String? ic = StringUtils.parseParams(paramsData ?? '')?['ic'];
        if (ic?.isNotEmpty == true) {
          GlobalService.to.state.installQuery.value = ic ?? '';
        }
      }
      if (GlobalService.to.state.installQuery.value.isEmpty) {
        XinstallService.getInstallTrace();
      }
    } catch (e) {
      XinstallService.getInstallTrace();
    }
  }
}
