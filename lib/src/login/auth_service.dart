import 'package:filbet/api/api.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/http/http_exceptions.dart';
import 'package:get/get.dart';

class AuthService {
  Future<String> register({
    required String account,
    required String password,
    required String referrerCode,
  }) async {
    final response = await HttpClient.post(Api.register, data: {
      "username": account,
      "password": password,
      if (referrerCode.isNotEmpty) "referrer_code": referrerCode,
    });
    if (response.status == false) {
      // 与 login 一致：优先抛出解析后的 error，避免 response.message 为空时
      // BadServiceException(message: null) 在 UI 上退化成类型名 "BadServiceException"。
      throw response.error ??
          BadServiceException(
            message: (response.message?.isNotEmpty ?? false)
                ? response.message
                : 'reg_failed'.tr,
          );
    }
    if (response.data is String) {
      return response.data as String;
    } else {
      throw BadServiceException(message: 'reg_failed'.tr);
    }
  }

  Future<String> login({
    required String account,
    required String password,
  }) async {
    final response = await HttpClient.post(Api.login, data: {
      "username": account,
      "password": password,
    });
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is String) {
      return response.data as String;
    } else {
      throw BadServiceException(message: 'login_failed'.tr);
    }
  }

  Future<void> logout() async {
    await HttpClient.get(Api.logout);
  }

  /// 找回密码第一步：验证账号
  /// 返回 sid，用于后续步骤
  Future<String> recoveryStep1({
    required String username,
    required String account,
  }) async {
    final response = await HttpClient.post(Api.recoveryStep1, data: {
      "username": username,
      "account": account,
    });
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is String) {
      return response.data as String;
    } else {
      throw BadServiceException(message: '验证失败'.tr);
    }
  }

  /// 找回密码第二步：发送验证码
  Future<bool> recoveryStep2({
    required String sid,
  }) async {
    final response = await HttpClient.get(
      Api.recoveryStep2,
      queryParameters: {
        "sid": sid,
      },
    );
    if (response.status == false) {
      throw response.error!;
    }
    return response.status;
  }

  /// 找回密码第三步：验证验证码
  /// 验证手机或邮箱验证码是否正确
  Future<bool> recoveryStep3({
    required String sid,
    required String code,
  }) async {
    final response = await HttpClient.post(Api.recoveryStep3, data: {
      "sid": sid,
      "code": code,
    });
    if (response.status == false) {
      throw response.error!;
    }
    return response.status;
  }

  /// 找回密码第四步：重置密码
  /// 设置新密码
  Future<bool> recoveryStep4({
    required String sid,
    required String pwd,
  }) async {
    final response = await HttpClient.post(Api.recoveryStep4, data: {
      "sid": sid,
      "pwd": pwd,
    });
    if (response.status == false) {
      throw response.error!;
    }
    return response.status;
  }
}
