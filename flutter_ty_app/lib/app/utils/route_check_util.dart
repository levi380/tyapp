import 'package:common_utils/common_utils.dart';

import '../db/app_cache.dart';
import '../services/network/token_whitelist.dart';

class RouteCheckUtil {
  static bool checkNoLoginAndGoToLogin() {
    String? token = StringKV.token.get();
    if (ObjectUtil.isEmptyString(token)) {
      ///登录操作
      TokenWhiteList.operationsForLogin();
      return false;
    } else {
      return true;
    }
  }

  static bool checkIsLogin() {
    String? token = StringKV.token.get();
    return !ObjectUtil.isEmptyString(token);
  }
}
