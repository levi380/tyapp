import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/main.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-4834a495-21cf-4d55-b721-13c899acd3d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU  公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  路由中间件 】】】
    【【【 AUTO_PARAGRAPH_TITLE 路由中间件入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 用户未登录 /已登陆 中间件路由拦截逻辑判断
    ```
    class TYRouteMiddlePage extends GetMiddleware
    ```
    - 未登录状态 详情 菜单 包含注单记录  列表状态 会返回商户登录页面
    执行登录操作  1.app跳转登录页面  2.sdk进行回调
    ```
    return isSDK ? const RouteSettings(name:Routes.mainTab) : const RouteSettings(name: Routes.login);
    ```
    】】】
 *
 */
class TYRouteMiddlePage extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    /// return null;表示跳转到以前的路由
    String? token = StringKV.token.get();
    if (!ObjectUtil.isEmptyString(token)) {
      return null;
    }

    ///根据条件进行判断,满足条件进行跳转,否则不进行跳转
    ///执行登录操作  1.app跳转登录页面  2.sdk进行回调
    ///判断是否是sdk
    if (isSDK) {
      Bus.getInstance().emit(EventType.tyToLogin);
    }
    return isSDK ? const RouteSettings(name:Routes.mainTab) : const RouteSettings(name: Routes.login);
  }
}