
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-ef4aa1e5-66b2-48e8-81c1-62321ddeaf17-dl 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  存储组件  】】】
    【【【 AUTO_PARAGRAPH_TITLE 存储组件  StringKV 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 存储组件  StringKV
    - StringKV
    ```
    /// get_storage
    ///这是一个快速、超轻量级且同步的内存键值对，每次操作都会将数据备份到磁盘。它完全用 Dart 编写，并且可以轻松集成到 Flutter 的 Get 框架中。支持 Android、iOS、Web、Mac、Linux、fuchsia 和 Windows**。可存储字符串、整数、双精度浮点数、映射和列表。

    /// token
    token,
    ///url参数上的api 或者 登录接口返回的api
    urlApi,
    /// baseurl
    baseUrl,

    /// language
    language,

    /// 登录之后保存
    imgUrl,
    jtStaticUrl,
    /// 视频页面地址 vue为数组
    liveUrl,

    /// 登录之后保存
    wssUrl,

    /// 日间夜间模式
    themeStyle,
    /// 最快请求api
    best_api,
    /// 域名分组
    gr,

    /// 元数据
    originData,

    /// 接收h5地址
    h5url,
    OldNewId,
    menuInit,
    nameMap,
    req_checkId,

    /// 电竞图片域名  末尾带'/'
    eSportsImgDomain,

    ///登录环境
    env,
    tournamentMatchMap,

    /// 语言
    language,

    // 服务器时间与本地时间差值
    diffTime,

    /// 商户选择的时区 记录到本地
    timeZone,

    ///视图高度
    layoutHeight,

    ///队名偏好
    teamNamePreference,

    /// 主题
    theme,
    dailyActivities,

    ///主页 热门-时间
    sort,

    ///主页  专业-新手
    userVersion,

    isIPad,
    ///是否弹窗、新手引导
    isTan,
    cpTan,

    ///滑动下注
    slideBet,

    ///是否开启字体变大
    isBiggerSize,

    // 全屏投注引导
    quickBetting,

    ```
    】】】
 *
 */

const dbName = "com.tyapp.ob";

late Box appStorage;

/// 初始化
Future<bool> dbPreInit() async {
  await Hive.initFlutter();
  appStorage = await Hive.openBox(dbName);
  return true;
}

Future<void> dbClear() async {
  try {
    await appStorage.clear();
  } catch (e) {
    return;
  }
}

/// 保存字符串
enum StringKV {
  /// token
  token,
  ///url参数上的api 或者 登录接口返回的api
  urlApi,
  /// baseurl
  baseUrl,

  /// language
  language,

  /// 登录之后保存
  imgUrl,
  jtStaticUrl,
  /// 视频页面地址 vue为数组
  liveUrl,

  /// 登录之后保存
  wssUrl,

  /// 日间夜间模式
  themeStyle,
  /// 最快请求api
  best_api,
  /// 域名分组
  gr,

  /// 元数据
  originData,

  /// 接收h5地址
  h5url,
  OldNewId,
  menuInit,
  nameMap,
  req_checkId,

  /// 电竞图片域名  末尾带'/'
  eSportsImgDomain,

  ///登录环境
  env,
  tournamentMatchMap,

  /// 登录之后保存的sessionId
  sessionId,
}

extension StringKVX on StringKV {
  String? get() {
    return appStorage.get(name) as String?;
  }

  Future<void> save(String? value) async {
    if (value != null && value.isNotEmpty) {
      await appStorage.put(name, value);
    }
  }

  Future<void> remove() async {
    await appStorage.delete(name);
  }
}

/// 保存整形
enum IntKV {
  /// 语言
  language,

  // 服务器时间与本地时间差值
  diffTime,

  /// 商户选择的时区 记录到本地
  timeZone,

  ///视图高度
  layoutHeight,

  ///队名偏好
  teamNamePreference,
}

extension IntKVX on IntKV {
  int? get() {
    return appStorage.get(name) as int?;
  }

  Future<void> save(int value) async {
    await appStorage.put(name, value);
  }

  Future<void> remove() async {
    await appStorage.delete(name);
  }
}

/// 保存布尔值
enum BoolKV {
  /// 主题
  theme,
  dailyActivities,

  ///主页 热门-时间
  sort,

  ///主页  专业-新手
  userVersion,

  isIPad,
  ///是否弹窗、新手引导
  isTan,
  cpTan,

  ///滑动下注
  slideBet,

  ///是否开启字体变大
  isBiggerSize,

  // 全屏投注引导
  quickBetting,
}

extension BoolKVX on BoolKV {
  bool? get() {
    return appStorage.get(name) as bool?;
  }

  Future<void> save(bool value) async {
    await appStorage.put(name, value);
  }

  Future<void> remove() async {
    await appStorage.delete(name);
  }
}

/// 保存对象
enum MapKV {
  topic,

  // 子玩法
  playInfo,
}

extension MapKVX on MapKV {
  Map? get() {
    return appStorage.get(name) as Map?;
  }

  Future<void> save(Map value) async {
    await appStorage.put(name, value);
  }

  Future<void> remove() async {
    await appStorage.delete(name);
  }
}

/// 保存数组
enum ListKV {
  // api 列表
  domainApi,
  playInfo,
  // 详情置顶列表
  matchDetailPlayTops,
  ///注单列表，预约修改赔率，用来控制1分钟以内不能修改的
  betListsHasModified
}

extension ListKVX on ListKV {
  List get() {
    return appStorage.get(name) as List? ?? [];
  }

  Future<void> save(List value) async {
    await appStorage.put(name, value);
  }

  Future<void> remove() async {
    await appStorage.delete(name);
  }
}
