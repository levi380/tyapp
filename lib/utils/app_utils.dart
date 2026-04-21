import 'package:filbet/api/api.dart';
import 'package:filbet/http/exception_user_message.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/widgets/loadinng_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static DateTime? _lastToastAt;
  static String? _lastToastMsg;

  static void copy(String value) async {
    try {
      await Clipboard.setData(ClipboardData(text: value));
      AppUtils.showToast("copy_success".tr);
    } catch (e) {
      print(e);
    }
  }

  static void showOptionDialog(String title, String confimStr, String cancelStr,
      String content, GestureTapCallback confim, GestureTapCallback cancel) {
    Get.defaultDialog(
      title: "提示",
      titleStyle: TextStyle(fontSize: 18.sp),
      confirm: GestureDetector(
        onTap: confim,
        child: Container(
          margin: EdgeInsets.only(left: 10.w),
          padding:
              EdgeInsets.only(left: 30.w, right: 30.w, top: 5.w, bottom: 5.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter, // 渐变起点
              end: Alignment.bottomCenter, // 渐变终点
              colors: [
                // 渐变颜色数组
                Color(0xff4150AA),
                Color(0xff4150AA),
              ], // 可选，控制每个颜色的停止位置
            ),
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: Text(
            "confirm".tr,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      cancel: GestureDetector(
        onTap: cancel,
        child: Container(
          margin: EdgeInsets.only(right: 10.w),
          padding:
              EdgeInsets.only(left: 30.w, right: 30.w, top: 5.w, bottom: 5.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
              border: Border.all(color: Color(0xff4150AA), width: 0.5.w)),
          child: Text(
            'cancel'.tr,
            style: TextStyle(color: Color(0xff4150AA)),
          ),
        ),
      ),
      middleText: content,
    );
  }

  static Future<void> launchKf() async {
    // try {
    //   AppLoading.show();
    //   var response = await Http().post(ApiUrl.getChatUrl);
    //   dynamic result = response.data["result"];
    //   dynamic code = response.data["code"];
    //   dynamic resultJson = jsonDecode(result);
    //   AppLoading.close();
    //   if (code == 1) {
    //     String kfUrl = resultJson["chat_url"];
    //     if (kfUrl.isNotEmpty) {
    //       Uri uri = Uri.parse(kfUrl);
    //       if (await canLaunchUrl(uri)) {
    //         await launchUrl(uri, mode: LaunchMode.externalApplication);
    //       }
    //     } else {}
    //   } else {
    //     dynamic msg = response.data["msg"];
    //   }
    // } catch (e) {
    //   AppLoading.close();
    //   e.printInfo();
    // }
  }

  ///获取图片完成路径
  static String getImgPath(String subPath) {
    if (subPath.startsWith("http")) {
      return subPath;
    }
    if (subPath.startsWith("/")) {
      return '${Api.imageurl}$subPath';
    } else {
      return '${Api.imageurl}/$subPath';
    }
  }

  static Future<bool> launchH5(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      bool result = await launchUrl(uri,
          mode: LaunchMode.externalApplication); // 在外部浏览器打开
      return result;
    } else {
      print('无法打开链接: $url');
      return false;
    }
  }

  // 密码输入：允许可打印 ASCII（0x21–0x7E），避免仅白名单符号导致常见标点无法输入。
  // 校验仍由 [passwordStringValidate03] / mustContainAtSpecial 等负责。
  static RegExp getInputFormatters() {
    return RegExp(r'[\x21-\x7E]');
  }

  static RegExp getInputAccountFormatters() {
    return RegExp(r'[A-Za-z0-9]');
  }

  /// 用服务端/接口可能为 null 或全空白的 [message] 做 Toast，避免不提示或 [showToast] 因 isEmpty 直接 return。
  static void showToastForResponse(
    String? message, {
    String ifEmpty = '网络异常，请稍后再试',
  }) {
    showToast(nonEmptyMessageOr(message, defaultMessage: ifEmpty));
  }

  /// 自定义 Toast。不再要求 [Get.context] 非空——`DioExceptionType.connectionError` 等
  /// 常在无路由上下文/启动早期触发，原逻辑会整段不弹，用户误以为「无提示」。
  static void showToast(String message) {
    if (message.isEmpty) return;

    // 短时间内相同文案不重复弹，减少 overlay 抖动和重复 dismiss。
    final now = DateTime.now();
    if (_lastToastMsg == message &&
        _lastToastAt != null &&
        now.difference(_lastToastAt!).inMilliseconds < 250) {
      return;
    }
    _lastToastMsg = message;
    _lastToastAt = now;

    var didLayoutRetry = false;
    void tryPresent() {
      final c = Get.context ?? Get.overlayContext;
      if (c != null && c is Element && !c.mounted) return;
      try {
        SmartDialog.showToast(
          message,
          alignment: Alignment.center,
          builder: (dialogContext) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 15.r),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xD91D1D1F),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            );
          },
        );
      } catch (_) {
        // SmartDialog 未初始化或 overlay 已销毁时，尝试 SnackBar
        final ctx = Get.context ?? Get.overlayContext;
        if (ctx != null) {
          final messenger = ScaffoldMessenger.maybeOf(ctx);
          if (messenger != null) {
            messenger
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(message),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                  margin: EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.h),
                ),
              );
            return;
          }
        }
        if (!didLayoutRetry) {
          didLayoutRetry = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            tryPresent();
          });
        }
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      tryPresent();
    });
  }

  static void show() {
    SmartDialog.showLoading(
      builder: (context) {
        return Align(
          alignment: Alignment.center,
          child: loadinngView(),
        );
      },
    );
  }

  static void dismiss() {
    try {
      SmartDialog.dismiss();
    } catch (_) {}
  }

  static bool addBankCardEnable() {
    String phone = UserService.to.state.userInfo.phone ?? '';
    bool isCn = true;
    if (phone.contains('-')) {
      if (!phone.startsWith("+86-")) {
        isCn = false;
      }
    }
    if (!isCn) {
      AppUtils.showToast('不允许添加银行卡，请联系客服');
    }
    return isCn;
  }
}
