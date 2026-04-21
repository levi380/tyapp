import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';

import '../../global/ty_user_controller.dart';
import '../../modules/login/login_head_import.dart';
import '../../modules/main_tab/main_tab_controller.dart';
import '../../services/api/match_api.dart';
import '../../services/models/res/fireworks_activity_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-38f82dfe-f843-439e-8655-2c32f6e9307f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE 定时烟花】】】
    【【【 AUTO_PARAGRAPH_TITLE 烟花Controller 】】】
    【【【 AUTO_PARAGRAPH_CONTENT

    # FireworksController 类功能总结

    ## 1. 类定义与依赖
    - **继承**: `FireworksController` 继承自 `GetxController`。
    - **单例**: 使用 `Get.put` 方法将其实例化为单例，方便全局访问。

    ## 2. 属性定义
    - `fireworksActivityList`: 存储烟花活动列表。
    - `_timer`: 活动开始的定时器。
    - `_endTimer`: 活动结束的定时器。
    - `isPlayed`: 标记按播放方式是否已经播放。
    - `firstIsPlayed`: 标记第一个活动是否已经播放。
    - `isClientPlayed`: 标记按客户端类型是否已经播放。
    - `now`: 存储服务器时间。

    ## 3. 获取烟花活动
    - **方法**: `getFireworksActivity()`
    - 调用 API 获取烟花活动。
    - 更新活动列表和当前时间。
    - 调用 `updateMainTabController` 更新主控制器状态。

    ## 4. 定时器管理
    - **方法**:
    - `shouldStartTimer(DateTime now, FireworksActivityEntity activity)`: 判断是否需要启动定时器。
    - `startTimer(FireworksActivityEntity activity, DateTime now)`: 启动定时器。
    - `cancelTimer()`: 取消定时器。

    ## 5. 检查活动状态
    - **方法**: `checkActivityStatus(FireworksActivityEntity activity, DateTime now)`
    - 检查当前活动的有效性。
    - 更新活动状态和播放信息。

    ## 6. 活动有效性判断
    - **方法**: `isFireworksActivityValid(FireworksActivityEntity activity, DateTime now)`
    - 检查活动是否在有效时间内。
    - 确保满足播放条件。

    ## 7. 更新主控制器状态
    - **方法**: `updateMainTabController(List<FireworksActivityEntity> fireworksActivityList, DateTime now)`
    - 更新主控制器的状态，包括烟花类型、播放次数等信息。

    ## 8. 多语言支持
    - **方法**: `languageContrast(languageType, language)`
    - 根据用户的语言设置匹配活动的语言描述。

    ## 9. 标记活动为已播放
    - **方法**: `markAsPlayed(String activityId)`
    - 将活动标记为已播放，并通过 API 保存播放状态。


    】】】
 *
 */
class FireworksController extends GetxController {
  static FireworksController get to =>
      Get.put(FireworksController(), permanent: true);

  /// 定时播放烟花列表
  List<FireworksActivityEntity> fireworksActivityList = [];
  Timer? _timer; // 可选的定时器，用于活动开始
  Timer? _endTimer; // 可选的定时器，用于活动结束

  bool isPlayed = false; //按播放方式是否已经播放
  bool firstIsPlayed = false; //第一个是否已经播放
  bool isClientPlayed = false; //按客户端类型是否已经播放

  late FireworksActivityEntity activityEntity ;
  ///服务器时间
  late DateTime serverNow;

  /// 获取烟花活动的异步方法
  Future<void> getFireworksActivity() async {
    try {
      // 调用 API 获取烟花活动
      final res = await MatchApi.instance().getFireworksActivity(StringKV.token.get()!);
      // 检查返回的数据是否非空
      if (ObjectUtil.isNotEmpty(res.data)) {
        fireworksActivityList = res.data!; // 更新活动列表
        // 获取服务器当前时间
        // String? nowTime = res.ts.toString()?.substring(0,res.ts.toString().length-3);
        serverNow = DateTime.fromMillisecondsSinceEpoch(res.ts!.toInt());
        // 更新主控制器的状态
        updateMainTabController(fireworksActivityList, serverNow);
      }
    } catch (e) {
      // 捕获并打印异常
      AppLogger.debug("Error fetching fireworks activity: $e");
    }
  }

  /// 判断是否需要启动定时器
  bool shouldStartTimer(DateTime now, FireworksActivityEntity activity) {
    // 如果当前时间小于活动开始时间，并且距离活动开始时间不超过30分钟
    return now.millisecondsSinceEpoch < activity.beginTime.toInt() &&
        DateTime.fromMillisecondsSinceEpoch(activity.beginTime.toInt())
                .difference(now)
                .inMinutes <=
            60;
  }

  /// 启动定时器
  void startTimer(FireworksActivityEntity activity, DateTime now) {
    int delay = activity.beginTime.toInt() - now.millisecondsSinceEpoch;

    // 如果延迟为负，立即检查活动状态
   AppLogger.debug("fireworksAnimation: delay $delay");
    if (delay < 0) {
      checkActivityStatus(activity, now); // 立即检查活动状态
    } else {
      /*if (_timer?.isActive == true) {
        AppLogger.debug("fireworksAnimation: 活动定时器定时器已在运行");
        return; // 如果定时器正在运行，直接返回
      }*/
      _timer = Timer(Duration(milliseconds: delay), () {
        now = DateTime.fromMillisecondsSinceEpoch(
            now.millisecondsSinceEpoch + delay + 3000);
        //  AppLogger.debug("fireworksAnimation: 活动开始");
       // getFireworksActivity();
        FireworksController.to.serverNow=now;
        checkActivityStatus(activity, now); // 定时器到期后检查活动状态
        //AppLogger.debug("fireworksAnimation1:${MainTabController.to.isFireworksPaly.value}");
        // AppLogger.debug("fireworksAnimation2:${FireworksController.to.isFireworksActivityValid(MainTabController.to.activityEntity,FireworksController.to.serverNow)}");
        // AppLogger.debug("fireworksAnimation5:${DateTimeUtils.formatDateTime(DateTime.fromMillisecondsSinceEpoch(FireworksController.to.serverNow.millisecondsSinceEpoch))}");


      });
    }
  }

  /// 取消定时器
  void cancelTimer() {
    // 取消活动开始的定时器
    if (_timer?.isActive == true) {
      _timer?.cancel();
      _timer = null;
    }
    // 取消活动结束的定时器
    if (_endTimer?.isActive == true) {
      _endTimer?.cancel();
      _endTimer = null;
    }
  }

  /// 检查当前活动的状态
  void checkActivityStatus(
      FireworksActivityEntity activity, DateTime now) async {
    // 打印调试信息
    //  AppLogger.debug("checkActivityStatus: 开始时间 ${DateTimeUtils.formatDateTime(DateTime.fromMillisecondsSinceEpoch(activity.beginTime.toInt()))} 结束时间 ${DateTimeUtils.formatDateTime(DateTime.fromMillisecondsSinceEpoch(activity.endTime.toInt()))}");
    //  AppLogger.debug("烟花活动开关: ${activity.activityStatus == 1}");
    //  AppLogger.debug("商户活动开关: ${TYUserController.to.userInfo.value?.paramConfigs?["fireworksActivity"] == "1"}");
    // AppLogger.debug("商户活动开关: ${TYUserController.to.userInfo.value?.paramConfigs?["fireworksActivity"]}");
    //  AppLogger.debug("deviceType展示设备类型: ${activity.deviceType.toInt()==0||activity.deviceType.toInt()==2}");
    // AppLogger.debug("isFireworksActivityValid: ${isFireworksActivityValid(activity, now)}");

    // 如果当前时间在活动开始和结束之间并且没有播放过动画并且包含sdk  deviceType展示设备类型(0:全部,1:PC亚洲版,2:移动端亚洲版包含h5新版/sdk/ipad,3:PC欧洲版,4:H5欧洲版)
    if (isFireworksActivityValid(activity, now)) {
      MainTabController.to.isFireworksPaly.value = (activity.activityStatus == 1);
    }

    // 如果活动还未结束并且是循环播放类型，设置结束定时器
    if (activity.endTime.toInt() > now.millisecondsSinceEpoch &&
        activity.playType == 2) {
      int delayEnd = activity.endTime.toInt() - now.millisecondsSinceEpoch;
     AppLogger.debug("fireworksAnimation: 关闭活动定时器开启 ${delayEnd}");
      if (_endTimer?.isActive == true) {
        AppLogger.debug("fireworksAnimation: 关闭活动定时器定时器已在运行");
        return; // 如果定时器正在运行，直接返回
      }
      _endTimer = Timer(Duration(milliseconds: delayEnd), () {
        AppLogger.debug("fireworksAnimation: 活动结束，关闭活动");
        MainTabController.to.isFireworksPaly.value = false; // 关闭活动
      });
    }
  }

// 检查活动是否有效的方法
  bool isFireworksActivityValid(
      FireworksActivityEntity activity, DateTime now) {
    final currentTime = now.millisecondsSinceEpoch; // 获取当前时间戳
    final deviceType = activity.deviceType.toInt(); // 获取设备类型

    // 检查活动的有效性
    /*
    * (activity.playType != 2 ? !isPlayed : true)：如果活动的播放类型不是2，则检查isPlayed的状态，
    * 确保未播放（!isPlayed）。如果播放类型是2，则不进行播放状态检查，直接返回true。*/
    final isActivityValid = (currentTime > activity.beginTime.toInt() &&
        currentTime < activity.endTime.toInt() &&
        (activity.playType != 2 ? !isPlayed : true));

    // 检查设备类型的有效性
    final isDeviceTypeValid = (deviceType == 0 || deviceType == 2);
    // AppLogger.debug("isActivityStatus: ${isActivityStatus}");
    // AppLogger.debug("isActivityValid: ${currentTime}");
    //  AppLogger.debug("isActivityValid1: ${ currentTime > activity.beginTime.toInt()}");
    // AppLogger.debug("isActivityValid2: ${ currentTime < activity.endTime.toInt()}");
    // AppLogger.debug("fireworksActivity: ${TYUserController.to.userInfo.value?.paramConfigs?["fireworksActivity"] == "1"}");
    //   AppLogger.debug("isActivityValid3: ${(activity.playType!=2 ? !isPlayed : true)}");
    // 返回最终判断结果
    return TYUserController.to.userInfo.value?.paramConfigs?["fireworksActivity"] == "1" &&
        isDeviceTypeValid &&
        isActivityValid;
  }

  /// 更新主控制器的状态
  void updateMainTabController(
      List<FireworksActivityEntity> fireworksActivityList, DateTime now) async {
    final firstRes = await MatchApi.instance()
        .getUserPlayInfo(StringKV.token.get()!, fireworksActivityList.first.id);
    firstIsPlayed = firstRes['data']['isPlayed'] == 1;
    //AppLogger.debug("fireworksAnimation第一个烟花是否播放过${firstIsPlayed} 唯一id:${fireworksActivityList.first.id.toString()}");
    // 确定要播放的活动
    final activity =
        now.millisecondsSinceEpoch > fireworksActivityList.first.endTime.toInt()||fireworksActivityList.first.activityStatus==0
            ? fireworksActivityList.last
            : fireworksActivityList.first.playType != 2 && firstIsPlayed
                ? fireworksActivityList.last
                : fireworksActivityList.first;

    final res = await MatchApi.instance()
        .getUserPlayInfo(StringKV.token.get()!, activity.id);
    isPlayed = res['data']['isPlayed'] == 1;
    isClientPlayed = res['data']['isClientPlayed'] == 1;

    //  AppLogger.debug("选中活动是否已经播放过isClientPlayed: ${res['data']['isClientPlayed']}");
    //  AppLogger.debug("选中活动是否已经播放过isPlayed: ${isPlayed} 唯一id:${activity.id}");

    // 打印调试信息
    // debugPrint("fireworksAnimation当前时间: ${DateTimeUtils.formatDateTime(now)} = ${now.millisecondsSinceEpoch}");
    // debugPrint("fireworksAnimation开始时间: ${DateTimeUtils.formatDateTime(DateTime.fromMillisecondsSinceEpoch(activity.beginTime.toInt()))} = ${activity.beginTime}");
    //  debugPrint("fireworksAnimation结束时间: ${DateTimeUtils.formatDateTime(DateTime.fromMillisecondsSinceEpoch(activity.endTime.toInt()))} = ${activity.endTime}");

    // 根据活动类型设置烟花播放次数
    MainTabController.to.fireworksNumber.value =
        (activity.playType == 0 ? 1 : (activity.playType == 1 ? 3 : 5));
    MainTabController.to.fireworksType.value = activity.fireworksType; // 设置烟花类型
    MainTabController.to.championIcon.value = activity.logo; // 设置冠军图标
    MainTabController.to.beginTime.value = activity.beginTime.toInt(); // 设置开始时间
    MainTabController.to.endTime.value = activity.endTime.toInt(); // 设置结束时间
    MainTabController.to.fireworksId.value = activity.id.toInt(); // 唯一ID
    MainTabController.to.activityEntity = activity;
    activityEntity = activity;

    // 获取用户语言
    String languageCode = Get.locale?.languageCode ?? "zh";

    _setChampionName(activity.languageVOList, languageCode);

    // 检查是否需要启动定时器
    if (shouldStartTimer(now, activity)) {
      AppLogger.debug("fireworksAnimation: 检查是否需要启动定时器");
      startTimer(activity, now); // 启动定时器
    } else if (now.millisecondsSinceEpoch > activity.beginTime.toInt() &&
        now.millisecondsSinceEpoch < activity.endTime.toInt()) {
      //debugPrint("fireworksAnimation: 当前时间在活动期间内");
      // 可以在这里添加其他逻辑，例如直接播放烟花等
      //开始活动
      checkActivityStatus(activity, now);
    } else {
      //debugPrint("fireworksAnimation:不在活动时间");
      // 如果定时器正在运行，取消它
      cancelTimer();
    }
  }

  void _setChampionName(List<FireworksActivityLanguageReqList> languageVOList,
      String languageCode) {
    if (languageVOList.isNotEmpty) {
      for (var langReq in languageVOList) {
        if (languageContrast(langReq.languageType, languageCode)) {
          MainTabController.to.championName.value = langReq.copyDesc; // 设置冠军名称
          break; // 找到匹配语言后退出循环
        }
      }
    }
  }

// 多语言差异性
  ///中文简体。zh
  ///英语   en
  ///中文繁体  tw
  ///越语。vi
  ///泰国  th
  ///马来西亚  ms
  ///韩国 ko
  ///葡萄牙  pt
  ///印地语 hi
  ///印尼 ad
  ///俄罗斯  ru
  ///阿拉伯国家  ar
  ///西班牙 es
  ///缅甸 my
  bool languageContrast(String languageType, String language) {
    /// 服务端语言code -> 烟花本地语言码映射转换
    const Map<String, String> languageMap = {
      'hin': 'hi',
      'ara': 'ar',
      'mya': 'my',
    };

    /// 统一 languageType
    final normalizedType =
        languageMap[languageType] ?? languageType;

    /// 中文繁体特殊处理
    final normalizedLanguage =
    (language == 'zh' && Get.locale?.countryCode == 'TW')
        ? 'tw'
        : language;

    return normalizedLanguage == normalizedType;
  }
  // 标记活动为已播放
  markAsPlayed(String activityId) async {
    try {
      await MatchApi.instance()
          .saveUserPlayInfo(activityId, "1", StringKV.token.get()!);
    } catch (e) {
      print(e);
    }
  }
}
