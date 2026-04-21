import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/config/theme/theme_controller.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/assets/preloadImg.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'app/config/getx_navigation.dart';
import 'app/config/swr/swr_service.dart';
import 'app/config/lang/translation_service.dart';
import 'app/config/theme/app_theme.dart';
import 'app/global/assets/smart_image_preloader.dart';
import 'app/modules/quick_bet/quick_bet_view.dart';
import 'app/modules/sdk_home/sdk_home_binding.dart';
import 'app/modules/shop_cart/order/bet_order_toast.dart';
import 'app/modules/shop_cart/shop_cart_material.dart';
import 'app/modules/shop_cart/shop_cart_navigator_observer.dart';
import 'app/modules/shop_cart/shop_cart_view.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/AndroidChannel.dart';
import 'app/utils/bus/bus.dart';
import 'app/utils/bus/event_enum.dart';
import 'app/widgets/image_view.dart';

/// 是否进SDK开关

bool isSDK = true;

/// 新增 SDK-底部菜单开关
bool bottomHideSwitch = false;

///原生安卓IOS SDK 返回按钮
bool back = false;

///Flutter SDK 返回按钮
BuildContext? oBContext;

bool isIPad = false;
bool envMock = false;
var h5ulr = '';
var h5Env = '';
var h5Token = '';
var mainEnv = '生产维护';
///欧洲杯专题页开关
bool europeanCup = false;
bool europeanCupSetting = false;
///足球篮球运营模版
bool footballBasketballTemplate = false;
bool footballBasketballTemplateSetting = false;
bool isFootballBasketballTemplate = false;
String footballBasketballTemplateThemeColor = '#225241';

///奥运会专题页开关
bool olympicGames = false;
bool olympicGamesSetting = false;

///年报入口
bool AnnualReportEntrance = false;

///蛇年春节装饰
bool springAdornSwitch = false;

/// 记录启动时间
DateTime appStartTime = DateTime.now();


/// 未登录通知 跳转至登录页
void notLoginNotification() {
  Bus.getInstance().emit(EventType.tyToLogin);

  /* //接受SDK通知并跳转登录
  Bus.getInstance().on(EventType.tyToLogin, (value) {
    Get.toNamed('/login',id:1);
  });*/
}

Future<void> main() async {
  appStartTime = DateTime.now();
  PerfBinding();
  await TYInit();
  await timeSwitch();
  final Locale local = TranslationService.getInitLocale();
  // BuildContext oBContext;

  runApp(MyApp(
    locale: local,
    url: '',
    env: '',
    context: null,
    // isDark: isDarkMode ?? true, //缺省使用dark模式
  ));

}

timeSwitch() {
  DateTime nowDate = DateTime.now();
  int nowDateMillis = nowDate.millisecondsSinceEpoch;

  //欧洲杯下架时间
  int europeanCupRemoveDate =
      DateTime.parse("2026-07-18 23:59:59").millisecondsSinceEpoch;

  //奥运会下架时间
  int olympicGamesRemoveDate =
      DateTime.parse("2026-08-16 23:59:59").millisecondsSinceEpoch;

  //欧洲杯赛事结束 关闭
  if (europeanCupRemoveDate <= nowDateMillis) {
    europeanCup = false;
  }

  //奥运会赛事结束 关闭
  if (olympicGamesRemoveDate <= nowDateMillis) {
    olympicGames = false;
  }
}

Future<void> TYInit() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///初始化 SmartImagePreloader
  SmartImagePreloader.instance.init();
  /// 初始化数据库
  await dbPreInit();
  
  /// 初始化 SWR 服务
  Get.put(SwrService());

  /// 状态栏透明
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  /// 禁用手机横屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 异步执行非关键初始化任务，避免阻塞启动主流程
  _asyncInitTasks();
}

/// 异步初始化非关键任务
Future<void> _asyncInitTasks() async {
  try {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      isIPad = iosInfo.utsname.machine.contains('iPad');
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String model = androidInfo.product.toLowerCase();
      if (model.contains('ipa') ||
          model.contains('pad') ||
          model.contains('scm') ||
          model.contains('ags')) {
        isIPad = true;
      }
      /// 调用原生 Android 通道
      AdnroidChannel.initChannels();
      isIPad = (await AdnroidChannel.getIsIpad()) ?? isIPad;
    }
    BoolKV.isIPad.save(isIPad);
    AppLogger.debug('异步初始化任务完成: isIPad=$isIPad');
  } catch (e) {
    AppLogger.error('异步初始化任务失败: $e');
  }
}

///调用原生 获取判断是否iPad
getIsIpad() async {
  isIPad = (await AdnroidChannel.getIsIpad())!;
  return isIPad;
}

Future<void> loadFont() async {
  // 使用 rootBundle.load 方法加载字体文件
  String fontPath = 'fonts/Akrobat-Bold.otf';

  var fontData;
  try {
    fontData = rootBundle.load(fontPath);
    // 使用 FontLoader 加载字体文件
    var myCustomFont = FontLoader('Akrobat')..addFont(fontData);
    // 开始加载字体文件
    await myCustomFont.load();
  } catch (e) {
    fontPath = 'packages/flutter_ty_app/$fontPath';
    try {
      fontData = rootBundle.load(fontPath);
      // 使用 FontLoader 加载字体文件
      var myCustomFont = FontLoader('Akrobat')..addFont(fontData);
      // 开始加载字体文件
      await myCustomFont.load();
    } catch (ee) {
      // AppLogger.debug(ee.toString());
    }
  }
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.locale,
    required this.url,
    required this.env,
    required context,
  }) {
    h5ulr = url;
    h5Env = env;
    oBContext = context;
  }

  ///theme控制器
  final ThemeController themeController = Get.put(ThemeController());
  final Locale locale;
  final String url;
  final String env;
  /// 确保 addPostFrameCallback 只注册一次
  static bool _preloadTasksScheduled = false;
  Widget _loading() {
    return ImageView(
      'assets/images/game/refresh_icon.gif',
      width: 35.w,
      height: 35.w,
    );
  }

  ///get 兼容


  ///ScreenUtilInit 兼容
  final  GlobalObjectKey screenUtilInitKeyDB =
      const GlobalObjectKey("screenUtilInitKeyDB");

  @override
  Widget build(BuildContext context) {
    /// 第一次 build 时执行一次性、一定要非阻塞的资源加载调度
    if (!_preloadTasksScheduled) {
      _preloadTasksScheduled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppLogger.debug('MyApp: 首次帧渲染后调度预加载任务和字体加载。');
        PreloadImg.preloadOnHome(context);
        PreloadImg.delayPreloadOnDetail(context);
        PreloadImg.preloadMenu(context);
        PreloadImg.preloadLeague(context);
        PreloadImg.preloadOnNb(context);
        /// 延迟字体加载
        loadFont();
      });
    }

    themeController.isDarkMode.value = BoolKV.theme.get() ?? false;
    return ScreenUtilInit(
      key: screenUtilInitKeyDB,
      designSize: isIPad
          ? const Size(768, 1024)
          : isTablet(context)
              ? const Size(768, 1024)
              : const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) => RefreshConfiguration(
        footerBuilder: () => CustomFooter(
          height: 80.h,
          builder: (BuildContext context, LoadStatus? mode) {
            return Container(
              padding: EdgeInsets.only(top: 10.h, bottom: 0.h),
              alignment: Alignment.center,
              child: Text(
                '${LocaleKeys.myScroll_msg7.tr}～',
                style: TextStyle(
                    color: context.isDarkMode ? Colors.white : const Color(0xFF303442), fontSize: 12.sp.scale),
              ),
            );
          },
        ),
        headerBuilder: () => ClassicHeader(
          refreshingText: '${LocaleKeys.myScroll_msg5.tr}～',
          idleText: '${LocaleKeys.myScroll_msg5.tr}～',
          completeText: '${LocaleKeys.myScroll_msg5.tr}～',
          failedText: '${LocaleKeys.myScroll_msg5.tr}～',
          releaseText: '${LocaleKeys.myScroll_msg5.tr}～',
          completeDuration: Duration.zero,
          idleIcon: _loading(),
          refreshingIcon: _loading(),
          completeIcon: _loading(),
          failedIcon: _loading(),
          releaseIcon: _loading(),
        ),
        child: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: OKToast(
            child: GetMaterialApp(
              textDirection: TextDirection.ltr,
              key: Get_TY.globalObjectKeyDB,
              navigatorKey: Get_TY.navigatorStateKeyDB,
              scaffoldMessengerKey: Get_TY.scaffoldMessengerStateKeyDB,
              title: '体育',
              debugShowMaterialGrid: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              enableLog: true,
              defaultTransition: Transition.cupertino,
              themeMode: themeController.isDarkMode.value
                  ? ThemeMode.dark
                  : ThemeMode.light,
              translations: TranslationService(),
              localizationsDelegates: const [
                RefreshLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [

                ///中文-简体
                Locale('zh', 'CN'),
                ///中文-繁体
                Locale('zh', 'TW'),

                ///英式-英语
                Locale('en', 'GB'),

                ///越南
                Locale('vi', 'VN'),

                ///泰国
                Locale('th', 'TH'),

                ///马来西亚
                Locale('ms', 'MY'),

                ///印尼语
                Locale('id', 'ID'),

                ///葡萄牙
                Locale('pt', 'PT'),

                ///韩国
                Locale('ko', 'KR'),

                ///西班牙语
                Locale('es', 'ES'),

                ///缅甸语
                Locale('my', 'MM'),

                ///阿拉伯语
                Locale('ar', 'AE'),

                ///俄语
                Locale('ru', 'RU'),

                ///印地语
                Locale('hi', 'IN'),

                ///设置菜单特殊繁译
                Locale('zh', 'HANS'),

              ],
              locale: locale,
              fallbackLocale: TranslationService.fallbackLocale,
              // defaultTransition: Transition.cupertino,
              debugShowCheckedModeBanner: false,
              initialRoute: isSDK ? TYAppPages.initSDK : TYAppPages.initAPP,
              getPages: TYAppPages.routes,
              initialBinding: SdkHomeBinding(),
              navigatorObservers: [ShopCartNavigatorObserver(), Routes.observer,],
              builder: (context, child) {
                return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: TextScaler.noScaling),
                    child: ShopCartMaterial(
                      child: Stack(
                        children: [
                          if (child != null) child,
                          ShopCartComponent(),
                          QuickBetComponent(),
                          const BetOrderToast(),
                        ],
                      ),
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }

  /// 次要判断是否为平板 最短边大于1500 目前大部分pad最低是1536px
  bool isTablet(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    if (mediaQuery.size.shortestSide * 2 >= 1500) {
      isIPad = true;
    } else {
      isIPad = false;
    }
    return isIPad;
  }

  ///添加全局点击背景收起键盘判断
  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

/// 性能监控管理类（支持功能级别的独立导出）
class PerfMonitor {
  static final PerfMonitor _instance = PerfMonitor._internal();
  factory PerfMonitor() => _instance;
  PerfMonitor._internal();

  /// 全局记录（可选）
  final List<Map<String, dynamic>> records = [];

  /// section 数据缓存
  final Map<String, List<Map<String, dynamic>>> _sectionRecords = {};

  /// 当前正在统计的 section
  String? _currentSection;

  /// 开始统计
  void startSection(String name) {
    _currentSection = name;
    _sectionRecords[name] = [];
    _pushRecord({
      "type": "section_start",
      "name": name,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    });
    AppLogger.debug("▶️ 开始统计: $name");
  }

  /// 结束统计并导出 JSON 文件
  Future<void> endSection(String name) async {
    if (!_sectionRecords.containsKey(name)) return;

    final sectionData = [
      {
        "type": "section_start",
        "name": name,
        "timestamp": _sectionRecords[name]!.first["timestamp"],
      },
      ..._sectionRecords[name]!,
      {
        "type": "section_end",
        "name": name,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      }
    ];

    try {
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/perf_data.json';

      final file = File(path);
      await file.writeAsString(
        const JsonEncoder.withIndent('  ').convert(sectionData),
      );

      AppLogger.debug("✅ 已导出 $name 性能数据: $path");
    } catch (e) {
      AppLogger.debug("❌ 导出 $name 性能数据失败: $e");
    }

    // 清理
    _currentSection = null;
    _sectionRecords.remove(name);
  }

  /// 页面切换
  void recordPage(String pageName) {
    final entry = {
      "type": "page_switch",
      "page": pageName,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };
    _pushRecord(entry);
  }

  /// 帧耗时
  void recordFrame(FrameTiming timing) {
    final entry = {
      "type": "frame",
      "build": timing.buildDuration.inMilliseconds,
      "raster": timing.rasterDuration.inMilliseconds,
      "total": timing.totalSpan.inMilliseconds,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };
    _pushRecord(entry);
  }

  /// 内存
  void recordMemory(int used) {
    final entry = {
      "type": "memory",
      "used": used,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };
    _pushRecord(entry);
  }

  /// 通用收集方法
  void _pushRecord(Map<String, dynamic> entry) {
    records.add(entry);
    if (_currentSection != null) {
      _sectionRecords[_currentSection]!.add(entry);
    }
  }
}

/// 初始化绑定 FrameTimings，但不做导出
class PerfBinding extends WidgetsFlutterBinding {
  @override
  void initInstances() {
    super.initInstances();

    SchedulerBinding.instance.addTimingsCallback((timings) {
      for (var t in timings) {
        PerfMonitor().recordFrame(t);
      }
    });

    // 这里保留内存采集示例，你也可以随时停掉
    Timer.periodic(Duration(seconds: 5), (timer) {
      PerfMonitor().recordMemory((100 + timer.tick * 5) * 1024 * 1024);
    });
  }
}

void ensurePerfBinding() {
  PerfBinding();
}