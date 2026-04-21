
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';

///  统一调试开关
bool kSwrDebug = false;

/// 统一前缀
const _kPrefix = '[SWR]';

void swrLog(String msg, {String emoji = '🔍'}) {
  if (!kSwrDebug) return;
  AppLogger.debug('$_kPrefix $emoji $msg');
}

void swrWarn(String msg) {
  AppLogger.warn('$_kPrefix ️ $msg');
}

void swrErr(Object err, [StackTrace? st]) {
  AppLogger.error(err, stackTrace: st);
}
