import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/src/login/captcha/captcha_dialog.dart';
import 'package:filbet/src/login/captcha/captcha_result.dart';
import 'package:get/get.dart';

class CaptchaService {
  CaptchaService._();

  static final instance = CaptchaService._();

  /// 主入口：弹窗只弹一次，校验失败时只刷新弹窗内 HTML 不关窗
  Future<bool> verify(String account) async {
    final result = await _showCaptcha(account);
    return result != null &&
        result.randstr.isNotEmpty &&
        result.ticket.isNotEmpty;
  }

  /// 弹出验证码 Dialog；校验失败时通过 onCaptchaSubmit 返回 false，由弹窗内部刷新 HTML
  Future<CaptchaResult?> _showCaptcha(String account) async {
    return Get.dialog<CaptchaResult>(
      CaptchaDialog(
        onCaptchaSubmit: (result) async {
          try {
            return await captchaVerify(
              result.ticket,
              result.randstr,
              account,
            );
          } catch (_) {
            return false;
          }
        },
      ),
    );
  }

  /// 调你自己的后端接口
  Future<bool> captchaVerify(
    String ticket,
    String randstr,
    String account,
  ) async {
    final resp = await captchaVerifyByServer(ticket, randstr, account);
    return resp == true;
  }

  Future<bool> captchaVerifyByServer(
      String ticket, String randstr, String username) async {
    var resp = await ApiRequest.captchaVerify(ticket, randstr, username);
    return resp?.captchaCode == 1;
  }
}
