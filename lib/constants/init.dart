import 'package:filbet/constants/refresher.dart';
import 'package:filbet/generated/app_translations.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/http/http_config.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/routes/event_config.dart';
import 'package:filbet/services/sharetrace_service.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/theme/theme_service.dart';
import 'package:filbet/services/xinstall_service.dart';
import 'package:filbet/src/login/auth_service.dart';
import 'package:filbet/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

bool shouldUseFirebaseEmulator = false;

class AppInit {
  static void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppEnvConfig.load();
    await Get.putAsync(() async => await SpStorage().init());
    ///GlobalService 初始化
    await Get.putAsync(() async => await ThemeService().init());
    EventConfig().registerEvent();
    final config = HttpConfig(baseUrl: AppEnvConfig.instance.apiUrl);
    HttpClient.init(dioConfig: config);

    // 设置状态栏字体为黑色（适合浅色背景）
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 状态栏背景透明
      statusBarIconBrightness: Brightness.dark, // Android 状态栏图标为黑色
      statusBarBrightness: Brightness.light, // iOS 状态栏为黑色
    ));

    SystemChrome.setPreferredOrientations([
      // 强制竖屏
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    runApp(MyApp());
  }
}

///get   GetMaterialApp 兼容
GlobalObjectKey globalObjectKey = const GlobalObjectKey("globalObjectKey");
GlobalKey<NavigatorState>? navigatorStateKey = const GlobalObjectKey("navigatorStateKey");
GlobalKey<ScaffoldMessengerState> scaffoldMessengerStateKey= const GlobalObjectKey("scaffoldMessengerStateKey");
///ScreenUtilInit 兼容
GlobalObjectKey screenUtilInitKey = const GlobalObjectKey("screenUtilInitKey");

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Widget _builder(BuildContext context, Widget? child) {
    /// 全局取消状态栏图标
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MediaQuery(
      /// 设置文字大小不随系统设置改变
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
        child: child ?? const SizedBox(),
      ),
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    // 在 initState 中更新 locale，而不是在 build 中
    WidgetsBinding.instance.addPostFrameCallback((_) {
      List<Locale> supportedLocales = AppTranslations.supportedLocales;
      String languageKey = SpStorage.getAppLocalLanguage();
      Locale? locale = resolveLocale(languageKey, supportedLocales);
      if (locale != null) {
        Get.updateLocale(locale);
      }
    });
  }

  /// 获取默认 Locale，自动识别简体/繁体
  Locale getDefaultLocale() {
    // final deviceLocale = Get.deviceLocale;

    // if (deviceLocale == null) {

    // }

    // // 判断中文
    // if (deviceLocale.languageCode == "zh") {
    //   switch (deviceLocale.countryCode) {
    //     case "TW":
    //     case "HK":
    //     case "MO":
    //       return const Locale("zh", "TW"); // 统一繁体中文
    //     default:
    //       return const Locale("zh", "CN"); // 默认简体中文
    //   }
    // }

    // // 其他语言原样返回
    // return deviceLocale;
    return const Locale("zh", "CN"); // 如果拿不到，就给个中文
  }

  Locale? resolveLocale(String languageKey, List<Locale> supportedLocales) {
    // 1) 规范化：vi-VN / vi_VN / VI_vn -> vi_VN
    final norm = languageKey.trim().replaceAll('-', '_');
    final parts = norm.split('_');
    String lang = parts[0].toLowerCase();
    String? country = parts.length > 1 ? parts[1].toUpperCase() : null;

    // 2) 先精确匹配 语言+地区
    for (final loc in supportedLocales) {
      final lc = loc.languageCode.toLowerCase();
      final cc = (loc.countryCode ?? '').toUpperCase();
      if (lc == lang && (country == null || country == cc)) {
        return loc;
      }
    }

    // 3) 退化：仅按语言匹配
    for (final loc in supportedLocales) {
      if (loc.languageCode.toLowerCase() == lang) {
        return loc;
      }
    }

    return Locale("zh", "CN"); // 找不到就返回 null，由调用方决定 fallback
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> supportedLocales = AppTranslations.supportedLocales;
    String languageKey = SpStorage.getAppLocalLanguage();

    Locale? locale =
        resolveLocale(languageKey, supportedLocales); // 命中 Locale('vi','VN')
    // 不要在 build 方法中调用 Get.updateLocale，应该在 initState 或其他地方调用
    // if (locale != null) {
    //   Get.updateLocale(locale);
    // }
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        key: screenUtilInitKey,
        builder: (ctx, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // builder: FlutterSmartDialog.init(),
            // showPerformanceOverlay: true,
            title: "sk",
            key: globalObjectKey,
            navigatorKey: navigatorStateKey,
            scaffoldMessengerKey: scaffoldMessengerStateKey,
            theme: ThemeData(
              highlightColor: const Color.fromRGBO(0, 0, 0, 0),
              splashColor: const Color.fromRGBO(0, 0, 0, 0),
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
              primaryColorDark: Colors.black,
            ),
            localizationsDelegates: const [
              // CountryLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: supportedLocales,
            fallbackLocale: AppTranslations.fallbackLocale,
            locale: locale,
            translations: AppTranslations(),

            /// 弹窗
            navigatorObservers: [FlutterSmartDialog.observer],
            builder: FlutterSmartDialog.init(
                loadingBuilder: (String msg) => CustomLoadingWidget(),
                builder: _builder),
            getPages: AppPages.getPages,
            initialBinding: InitBinding(),
            initialRoute: Routes.SPLASH,
            defaultTransition: Transition.rightToLeft,
            transitionDuration: const Duration(milliseconds: 150),
          );
          // GoogleVerifyPage
        },
      ),
    );
  }
}

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService(), permanent: true);
  }
}
