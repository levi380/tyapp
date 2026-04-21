import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/services/api/account_api.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:uuid/uuid.dart';

/// 页面停留时长记录工具
/// - 首页加载上报
/// - 5s 心跳机制
class PageStayTracker {
  PageStayTracker._();

  static final PageStayTracker instance = PageStayTracker._();

  Timer? _heartbeatTimer;
  bool _heartbeatSuccess = false;
  int _consecutiveFailures = 0;

  void init() {
    /// 重置失败次数，确保重新登录后能继续发送心跳
    _consecutiveFailures = 0;
    _startHeartbeatTimer();
  }

  /// 获取商户编码
  String _getMerchantCode() {
    return TYUserController.to.userInfo.value?.mc?.toString() ?? '';
  }

  /// 上报首页加载耗时
  Future<void> reportLoadingTime() async {
    if (!_isLoggedIn()) {
      // 未登录或用户信息未就绪，每隔 1 秒检查一次
      Future.delayed(const Duration(seconds: 1), () => reportLoadingTime());
      return;
    }
    AppLogger.debug('PageStayTracker: 登录开始上报');
    await _uploadStatisticsWithRetry();
  }

  /// 启动 5 秒心跳机制
  void _startHeartbeatTimer() {
    _heartbeatTimer ??= Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        /// 如果连续失败达到 600 次，停止发送心跳
        if (_consecutiveFailures >= 10) {
          _heartbeatTimer?.cancel();
          _heartbeatTimer = null;
          AppLogger.debug('PageStayTracker: 心跳已停止，因为连续失败达到 600 次');
          return;
        }

        /// 发送心跳
        _sendHeartbeat();
      },
    );
  }

  /// 发送心跳
  Future<void> _sendHeartbeat() async {
    if (!_isLoggedIn()) return;
    try {
      final sid = const Uuid().v4();
      final uid = TYUserController.to.getUid();
      final code = _getMerchantCode();
      final sign = md5.convert(utf8.encode('$sid|$code|$uid')).toString();
      final sessionId = _getSessionId();

      final data = {
        "sessionId": sessionId,
        "os": Platform.operatingSystem,
        "sid": sid,
        "uid": uid,
        "code": code,
        "device": "3",
        "sign": sign,
        "t": DateTime.now().millisecondsSinceEpoch,
      };

      await AccountApi.instance().heartbeat(data);
      // 心跳成功
      _heartbeatSuccess = true;
      _consecutiveFailures = 0;
      AppLogger.debug('PageStayTracker: 心跳正常, 接口: heartbeat, 参数: $data');
    } catch (e) {
      // 心跳失败
      _consecutiveFailures++;
      AppLogger.error(
          'PageStayTracker: 心跳失败: $e, 连续失败次数: $_consecutiveFailures');
    }
  }

  /// 重试逻辑：失败每隔2s重发一次，最多重试5次
  Future<void> _uploadStatisticsWithRetry({int retryCount = 0}) async {
    try {
      final sessionId = _getSessionId();
      final browser = Platform.isIOS ? 'iOS' : 'Android';
      final os = Platform.operatingSystemVersion;
      final frontLoadingTime =
          DateTime.now().difference(appStartTime).inMilliseconds;

      final data = {
        "browser": browser,
        "os": os,
        "frontLoadingTime": frontLoadingTime,
        "sessionId": sessionId,
      };

      await AccountApi.instance().sendStatisticsInfo(data);
      AppLogger.debug(
          'PageStayTracker: 上报成功, 接口: sendStatisticsInfo, 参数: $data');
    } catch (e) {
      AppLogger.error('PageStayTracker:上报失败 (重试 ${retryCount + 1}): $e');
      if (retryCount < 4) {
        // 2秒后重试
        Future.delayed(const Duration(seconds: 2), () {
          _uploadStatisticsWithRetry(retryCount: retryCount + 1);
        });
      } else {
        AppLogger.error('重试结束,不再请求');
      }
    }
  }

  /// 判断用户是否登录
  bool _isLoggedIn() {
    final hasToken = StringKV.token.get()?.isNotEmpty ?? false;
    final hasUserInfo = TYUserController.to.userInfo.value != null;
    return hasToken && hasUserInfo;
  }

  /// 获取前地址sessionId参数
  String _getSessionId() {
    String sid = h5ulr.queryParametersOf('sessionId');
    if (sid.isEmpty) {
      /// 如果登录页进来的 就获取持久化的数据
      sid = StringKV.sessionId.get() ?? '';
    }
    return sid;
  }

  void dispose() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }
}
