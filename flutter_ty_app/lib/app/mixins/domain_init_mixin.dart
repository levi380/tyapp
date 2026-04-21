import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/main.dart';

import '../config/getx_navigation.dart';
import '../global/config_controller.dart';
import '../global/ty_user_controller.dart';
import '../modules/login/login_head_import.dart';
import '../modules/main_tab/main_tab_controller.dart';
import '../routes/route_manager.dart';
import '../services/api/common_api.dart';
import '../services/models/domain_model.dart';
import '../services/network/domain.dart';
import '../utils/change_skin_tone_color_util.dart';
import '../utils/skin_status.dart';
import '../widgets/fireworks/fireworks_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-16041ec7-d06f-4baf-a76c-bc7753195068-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP入口页面】】】
    【【【 AUTO_PARAGRAPH_TITLE APP入口页面 登录逻辑处理 DomainInitMixin 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 登录逻辑处理  DomainInitMixin
    - 解析URL地址  取token  设置api   设置主题   设置国际化    URL可拼接赛事MID跳转详情
    - DomainInitMixin
    】】】
 *
 */
mixin DomainInitMixin {
  /// 主入口
  Future<void> initDomainData({
    String h5Url = '',
    String env = 'sandbox',
  }) async {
    /// 保存上一次选入的api环境
    StringKV.env.save(env);

    /// 解析sdk入口链接参数
    final Map<String, String> params = _parseParamsSafe(h5Url);

    /// 设置用户信息（token / 语言、样式模式 ）
    _setUserInfo(params);

    /// 初始化域名与后续流程
    await _initDomainAndProceed(h5Url, params);

    /// 启动域名检测
    AllDomain.instance().run();

    /// 设定默认黑夜样式   默认第一种
    ChangeSkinToneColorUtil.instance().setModeStatus(Status.BLACK_STYLE_1);
  }

  /// 安全解析Parameters
  Map<String, String> _parseParamsSafe(String h5Url) {
    try {
      if (h5Url.isEmpty) return <String, String>{};
      final uri = Uri.tryParse(h5Url);
      if (uri == null) return <String, String>{};
      return uri.queryParameters;
    } catch (e) {
      if (kDebugMode) AppLogger.debug('初始化Url错误: $e');
      ///还是返回空数据 后面判断
      return <String, String>{};
    }
  }

  /// 初始化域名
  Future<void> _initDomainAndProceed(String h5Url, Map<String, String> params) async {

    /// 回调逻辑抽离
    AllDomain.instance().create(h5Url, callback: (DamainModel res) async {
      try {
        /// 设置 api 域名
        AppDio.getInstance().setApiDomain();

        /// 如果有 token，拉取用户信息与余额
        if ((StringKV.token.get()?.isNotEmpty ?? false)) {
          TYUserController.to.getUserInfo();
        }

        /// 做一些公共动作（网络请求等）
        doCommonAction();

        // /// 等待 MainTabController  避免死锁
        // await _waitUntilUnregistered<MainTabController>(timeout: const Duration(seconds: 2));
        //等待MainTabController销毁。如果MainTabController不存在，不会等待
        while (Get.isRegistered<MainTabController>()) {
          await Future.delayed(const Duration(milliseconds: 100));
        }

        /// 跳转逻辑（区分 SDK 模式与普通app）
        if (isSDK) {
          Get_TY.navigatorStateKeyDB?.currentState?.pushNamedAndRemoveUntil(
            Routes.mainTab,
                (Route<dynamic> route) => false,
          );
        } else {
          Get.offAllNamed(Routes.mainTab);
          /// 获取烟花活动
          FireworksController.to.getFireworksActivity();
        }

        ///首页界面先去拉配置 不然球种显示太慢
        ConfigController.to.fetchConfig();

        /// 如果 url 带有 mid，跳转到赛事详情
        final String? mid = params['mid'];
        if (ObjectUtil.isNotEmpty(mid)) {
          RouteManager.goMatchDetail(mid: mid.toString());
        }
      } catch (e, st) {
        if (kDebugMode) {
          AppLogger.debug('初始化域名失败 error: $e');
          AppLogger.debug('$st');
        }
      }
    });
  }
/*
  /// 等待 Get 注册的 Controller 被移除（有超时，防止死等）
  Future<void> _waitUntilUnregistered<T>({required Duration timeout}) async {
    try {
      final completer = Completer<void>();
      final stopwatch = Stopwatch()..start();

      while (Get.isRegistered<T>()) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (stopwatch.elapsed >= timeout) {
          /// 超时退出
          if (kDebugMode) AppLogger.debug('注销控制器<${T.runtimeType}> 超时');
          break;
        }
      }
      if (!completer.isCompleted) completer.complete();
      return completer.future;
    } catch (e) {
      if (kDebugMode) AppLogger.debug('注销控制器 error: $e');
      return;
    }
  }
*/
  /// 公共动作（网络请求
  void doCommonAction() {
    final String existing = StringKV.eSportsImgDomain.get() ?? '';
    if (existing.isNotEmpty) return;

    try {
      CommonApi.instance().getDjImageDomain().then((value) {
        final String data = value.data ?? 'https://uphw-cdn5.q7b4549e.com';
        StringKV.eSportsImgDomain.save(data);
      }).catchError((e) {
        if (kDebugMode) AppLogger.debug('获取电竞图片资源域名 error: $e');
      });
    } catch (e) {
      if (kDebugMode) AppLogger.debug('获取电竞图片资源域名 catch error: $e');
    }
  }

  /// 设置用户信息
  void _setUserInfo(Map<String, String> params) {
    /// token
    final String token = params['token'] ?? '';
    h5Token = token;
    StringKV.token.save(token);

    /// 接口api
    final String urlApi = params['api'] ?? '';
    StringKV.urlApi.save(urlApi);

    /// 语言 &  黑白模式选择
    final String lang = params['lg'] ?? '';
    final String theme = (params['theme'] ?? '').toString();

    if (kDebugMode) {
      AppLogger.debug('token: $token');
      AppLogger.debug('lang: $lang');
      AppLogger.debug('theme: $theme');
    }
    if (theme.contains('day')) {
      Get.changeThemeMode(ThemeMode.light);
    } else if (theme.contains('night')) {
      Get.changeThemeMode(ThemeMode.dark);
    }

    /// 语言映射表
    final Map<String, Locale> langMap = {
      'en': const Locale('en', 'GB'),
      'zh': const Locale('zh', 'CN'),
      'tw': const Locale('zh', 'TW'),
      'vi': const Locale('vi', 'VN'),
      'ms': const Locale('ms', 'MY'),
      'th': const Locale('th', 'TH'),
      'ko': const Locale('ko', 'KR'),
      'pt': const Locale('pt', 'PT'),
      'id': const Locale('id', 'ID'),
      'es': const Locale('es', 'ES'),
      'my': const Locale('my', 'MM'),
      'ar': const Locale('ar', 'AE'),
      'ru': const Locale('ru', 'RU'),
      'hi': const Locale('hi', 'IN'),
    };
    /// 默认语言
    String languageCode = 'CN';

    try {
      for (final entry in langMap.entries) {
        if (lang.contains(entry.key)) {
          Get.updateLocale(entry.value);
          languageCode = entry.value.countryCode ?? languageCode;
          break;
        }
      }
    } catch (e) {
      if (kDebugMode) AppLogger.debug('入口获取语言错误 error: $e');
    }

    StringKV.language.save(languageCode);
  }
}
