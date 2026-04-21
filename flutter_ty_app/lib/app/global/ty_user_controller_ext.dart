import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/core/constant/index.dart';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/user_info.dart';
import 'package:flutter_ty_app/app/services/models/res/user_param_config_entity.dart';
import 'package:flutter_ty_app/app/utils/time_zone/timeZoneUtils.dart';
import '../../generated/locales.g.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/setting_menu/setting_menu_controller.dart';
import '../modules/setting_menu/bet_order_notification/bet_order_notification_controller.dart';
import '../services/api/match_api.dart';
import '../services/network/domain.dart';
import '../utils/ty_text_scaler.dart';
extension TYUserControllerExt on TYUserController{
  ///拉取用户配置
  /// oss逻辑会拉取此接口 在此判断

  Future<void> getUserInfo() async {
    try {
      if (userInfo.value == null) {
        final res =
        await AccountApi.instance().getUserInfo(StringKV.token.get() ?? '');
        if (res.success) {
          userInfo.value = res.data;
          userName = res.data!.userName;
          userId = res.data!.userId;
          languageSwitch = res.data!.languageSwitch;
          // AppLogger.debug("userInfo.value = ${userInfo.value}");


          AllDomain.instance().setUserInfo(userInfo.value);
          /// 拉取用户时区信息
          // await getUserPersonaliseNew();
          /// 拉取用户字体大小记录
          // await getFontSizeSet();

          /// 拉取用户信息（时区、字体大小等等）
          await getUserPersonaliseSettings();

          //获取用户热门，时间排序方式。
          TyHomeController.to.homeState.isHot =
          (TYUserController.to.userInfo.value!.sort == 1);
          BoolKV.sort.save(TYUserController.to.userInfo.value!.sort == 1);

          /// configVO.profesTag字段,1 是日间 2 是夜间
          /// 調整app歸屬字段
          res.data?.configVO?.appDefault == 1
              ? Get.changeThemeMode(ThemeMode.light)
              : Get.changeThemeMode(ThemeMode.dark);


          TyHomeController.to.homeState.isLight =
          res.data?.configVO?.appDefault == 1 ? true : false;

        }
      }
      ///app登录退出账号走afterUserCb方法
      afterUserCb();
    } catch (e) {
      AppLogger.debug('get user info error: $e');
    }
  }

  /// 拉取用户时区信息
  Future<void> getUserPersonaliseNew() async {
    try {
      final res =  await  MatchApi.instance()
          .getUserPersonaliseNew([ConfigNotifyType.timezone.key], TYUserController.to.getUid());
      Map<String,dynamic> map= res.data ?? {};
      if(map.keys.length != 0 &&  map.get("userParams") != null )
      {
        Map<String,dynamic> timeZoneMap = map["userParams"];
        String timeZone = timeZoneMap.get(ConfigNotifyType.timezone.key) ?? "";
        int zoneIndex = TimeZoneUtils.timeZone.values.toList().indexOf(timeZone);
        ///设置用户时区
        if(zoneIndex != -1){
          TimeZoneUtils.zoneIndex = TimeZoneUtils.timeZone.keys.toList()[zoneIndex] ;
        }
        ///储存一份时区到本地
        IntKV.timeZone.save(TimeZoneUtils.zoneIndex);
        TimeZoneUtils.needReload = false;
        // AppLogger.debug('时区timeZone-------$timeZone');
      };
    } catch (e) {
      AppLogger.debug('get getUserPersonaliseNew  error: $e');
    }
  }

  /// 拉取用户字体大小
  Future<void> getFontSizeSet() async {
    try {
      final res =  await  MatchApi.instance()

          .getUserPersonaliseNew([ConfigNotifyType.fontSizeSet.key], TYUserController.to.getUid());
      Map<String,dynamic> map= res.data ?? {};
      if(map.keys.length != 0 &&  map.get("userParams") != null )
      {
        Map<String,dynamic> fontSizeMap = map["userParams"];
        String fontSizeSet = fontSizeMap.get(ConfigNotifyType.fontSizeSet.key) ?? "";
        if(fontSizeSet.isNotEmpty){
          BoolKV.isBiggerSize.save(fontSizeSet == '1' ? true : false);
          if (fontSizeSet == '1') {
            ///测试缩放因子
            TyTextScaler.instance()
                .setTextScaleFactor(TyTextScaler.biggerScaleFactor);
          } else {
            TyTextScaler.instance()
                .setTextScaleFactor(TyTextScaler.defaultScaleFactor);
          }
          Get.forceAppUpdate();
        }

      };
    } catch (e) {
      AppLogger.debug('get getFontSizeSet  error: $e');
    }
  }

  /// 拉取用户个性化设置（字体大小、时区、全屏投注引导等信息）
  Future<void> getUserPersonaliseSettings() async {
    try {
      final res = await MatchApi.instance().getUserPersonaliseNew(
          [ConfigNotifyType.fontSizeSet.key, ConfigNotifyType.timezone.key, ConfigNotifyType.quickBetting.key,
            ...OrderNotifyType.values.map((e) => e.key).toList()],
          TYUserController.to.getUid());

      Map<String, dynamic> map = res.data ?? {};

      if (map.keys.isNotEmpty && map.get("userParams") != null) {
        Map<String, dynamic> userParams = map["userParams"];

        // 处理字体大小设置
        String fontSizeSet = userParams.get(ConfigNotifyType.fontSizeSet.key) ?? "";
        if (fontSizeSet.isNotEmpty) {
          BoolKV.isBiggerSize.save(fontSizeSet == '1' ? true : false);
          if (fontSizeSet == '1') {
            ///测试缩放因子
            TyTextScaler.instance()
                .setTextScaleFactor(TyTextScaler.biggerScaleFactor);
          } else {
            TyTextScaler.instance()
                .setTextScaleFactor(TyTextScaler.defaultScaleFactor);
          }
          Get.forceAppUpdate();
        }

        // 处理时区设置
        String timeZone = userParams.get(ConfigNotifyType.timezone.key) ?? "";
        if (timeZone.isNotEmpty) {
          int zoneIndex = TimeZoneUtils.timeZone.values.toList().indexOf(timeZone);
          ///设置用户时区
          if (zoneIndex != -1) {
            TimeZoneUtils.zoneIndex = TimeZoneUtils.timeZone.keys.toList()[zoneIndex];
          }
          /// 储存一份时区到本地
          IntKV.timeZone.save(TimeZoneUtils.zoneIndex);
          TimeZoneUtils.needReload = false;
        }

        // 处理全屏投注引导逻辑
        String quickBetting = userParams.get("quickBetting") ?? "";
        if (quickBetting.isNotEmpty) {
          // quickBetting 获取用户是否第一次打开H5全屏投注，如果是第一次打开全屏投注，弹框打开引导图，默认1，, 0-关，1-开
          BoolKV.quickBetting.save(quickBetting == '1' ? true : false);
        }

        BetOrderNotificationController.sn = userParams.get(OrderNotifyType.success.key) ?? "";
        BetOrderNotificationController.fn = userParams.get(OrderNotifyType.failed.key) ?? "";
        BetOrderNotificationController.rsn = userParams.get(OrderNotifyType.reserveSuccess.key) ?? "";
        BetOrderNotificationController.rfn = userParams.get(OrderNotifyType.reserveFailed.key) ?? "";
      }
    } catch (e) {
      AppLogger.debug('get getUserPersonaliseSettings error: $e');
    }
  }

  ///投注手势
  Future<void> getUserParamConfig() async {
    try {
      final res =
      await AccountApi.instance().getUserParamConfig("");
      if (res.success) {
        for(UserParamConfigEntity userParamConfigEntity in res.data??[]){
          if(userParamConfigEntity.paramKey == "betGesture"){
            BoolKV.slideBet.save((int.tryParse(userParamConfigEntity.paramValue)??0)==0);
            break;
          }
        }
      }
    } catch (e) {
      AppLogger.debug('getUserParamConfig error: $e');
    }
  }

  /// --------------------- 初始化接口设置  自定义快捷投注设置 ---------------------
  setUserCustomizeInfo() {
    setUserCustomizeSingle();
    setUserCustomizeSeries();
  }

  setUserCustomizeSingle() {
    UserInfoCvoSingle? single = userInfo.value?.cvo?.single;
    if (single == null) {
      single = UserInfoCvoSingle();
      userInfo.value?.cvo?.single = single;
    }
    if (singleList.isEmpty) return;

    single.qon = singleList[0];
    if (singleList.length > 1) {
      single.qtw = singleList[1];
    }
    if (singleList.length > 2) {
      single.qth = singleList[2];
    }
    if (singleList.length > 3) {
      single.qfo = singleList[3];
    }
    if (singleList.length > 4) {
      single.qfi = singleList[4];
    }
  }

  setUserCustomizeSeries() {
    UserInfoCvoSeries? series = userInfo.value?.cvo?.series;
    if (series == null) {
      series = UserInfoCvoSeries();
      userInfo.value?.cvo?.series = series;
    }

    if (seriesList.isEmpty) return;

    series.qon = seriesList[0];

    if (seriesList.length > 1) {
      series.qtw = seriesList[1];
    }
    if (seriesList.length > 2) {
      series.qth = seriesList[2];
    }
    if (seriesList.length > 3) {
      series.qfo = seriesList[3];
    }
    if (seriesList.length > 4) {
      series.qfi = seriesList[4];
    }
  }
/// --------------------- 初始化接口设置  自定义快捷投注设置 ---------------------

  ///  预约结算 start 0：关；1：开
  /// settleSwitch                    足球提前结算开关
  /// settleSwitchBasket              篮球提前结算开关
  /// sysBookedSettleSwitch           系统预约提前结算开关
  /// sysPartSettleSwitch             系统部分提前结算开关
  ///
  ///提前结算，足球开关
  bool isSettleSwitch() {
    if (userInfo.value == null) return true;
    bool settleSwitch = false;
    if (ObjectUtil.isNotEmpty(userInfo.value?.settleSwitchVO)) {
      settleSwitch = userInfo.value!.settleSwitchVO?.settleSwitch == 1;
    }
    return settleSwitch;
  }

  ///提前结算，篮球开关
  bool isSettleSwitchBasket() {
    if (userInfo.value == null) return true;
    bool settleSwitchBasket = false;
    if (ObjectUtil.isNotEmpty(userInfo.value?.settleSwitchVO)) {
      settleSwitchBasket =
          userInfo.value!.settleSwitchVO?.settleSwitchBasket == 1;
    }
    return settleSwitchBasket;
  }

  /// sysBookedSettleSwitch           系统预约提前结算开关
  /// sysPartSettleSwitch             系统部分提前结算开关
  ///系统预约提前结算开关
  bool isSysBookedSettleSwitch() {
    bool sysBookedSettleSwitch = false;
    if (ObjectUtil.isNotEmpty(userInfo.value?.settleSwitchVO)) {
      sysBookedSettleSwitch =
          userInfo.value!.settleSwitchVO?.sysBookedSettleSwitch == 1;
    }
    return sysBookedSettleSwitch;
  }

  ///系统部分提前结算开关
  bool isSysPartSettleSwitch() {
    bool sysPartSettleSwitch = false;
    if (ObjectUtil.isNotEmpty(userInfo.value?.settleSwitchVO)) {
      sysPartSettleSwitch =
          userInfo.value!.settleSwitchVO?.sysPartSettleSwitch == 1;
    }
    return sysPartSettleSwitch;
  }

  /// bookedSettleSwitchFootball      预约提前结算开关-足球
  /// bookedSettleSwitchBasketball    预约提前结算开关-篮球
  ///预约提前结算开关，足球开关
  bool isBookedSettleSwitchFootball() {
    bool bookedSettleSwitchFootball = false;
    if (ObjectUtil.isNotEmpty(userInfo.value?.settleSwitchVO)) {
      bookedSettleSwitchFootball =
          userInfo.value!.settleSwitchVO?.bookedSettleSwitchFootball == 1;
    }
    return bookedSettleSwitchFootball;
  }

  ///预约提前结算开关，篮球开关
  bool isBookedSettleSwitchBasketball() {
    bool bookedSettleSwitchBasketball = false;
    if (ObjectUtil.isNotEmpty(userInfo.value?.settleSwitchVO)) {
      bookedSettleSwitchBasketball =
          userInfo.value!.settleSwitchVO?.bookedSettleSwitchBasketball == 1;
    }
    return bookedSettleSwitchBasketball;
  }

  /// partSettleSwitchFootball        部分提前结算开关-足球
  /// partSettleSwitchBasketball      部分提前结算开关-篮球
  ///部分提前结算开关，足球开关
  bool isPartSettleSwitchFootball() {
    bool partSettleSwitchFootball = false;
    if (ObjectUtil.isNotEmpty(userInfo.value?.settleSwitchVO)) {
      partSettleSwitchFootball =
          userInfo.value!.settleSwitchVO?.partSettleSwitchFootball == 1;
    }
    return partSettleSwitchFootball;
  }

  ///部分提前结算开关，篮球开关
  bool isPartSettleSwitchBasketball() {
    bool partSettleSwitchBasketball = false;
    if (ObjectUtil.isNotEmpty(userInfo.value?.settleSwitchVO)) {
      partSettleSwitchBasketball =
          userInfo.value!.settleSwitchVO?.partSettleSwitchBasketball == 1;
    }
    return partSettleSwitchBasketball;
  }

  /// 是否支持当前赔率
  bool isCurDdds(String? odds) {
    // 获取当前的盘口赔率
    String currOddsNum = (Csid.odds_table[curOdds]) ?? '1';

    // 获取当前投注项 如果不支持当前的赔率 就使用欧赔
    if (odds?.contains(currOddsNum) == true) {
      return true;
    }
    return false;
  }

  ///获取当前倍率对应的名称
  String curOddsLabel(String? odds) {
    BetOddsConstantModel? betOddsConstantModel;
    if (isCurDdds(odds)) {
      betOddsConstantModel =
          oddsConstant.firstWhereOrNull((element) => element.value == curOdds);
    }
    return betOddsConstantModel?.label ?? LocaleKeys.odds_EU;
  }

  ///获取当前支持赔率
  String curOddsValue(String? odds) {
    BetOddsConstantModel? betOddsConstantModel;
    if (isCurDdds(odds)) {
      betOddsConstantModel =
          oddsConstant.firstWhereOrNull((element) => element.value == curOdds);
    }
    return betOddsConstantModel?.value ?? 'EU';
  }

  /// 获取当前币种
  String currCurrency() {
    int? curCode = int.tryParse(userInfo.value?.cvo?.series?.code ?? '1');
    String currency = currency_code[curCode] ?? 'RMB';
    return currency;
  }

  String toAmountSplit(String num) {
    String numStr = (num).toString();

    if (numStr.contains('.')) {
      List<String> parts = numStr.split('.');
      String integerPart = parts[0];
      String decimalPart = parts[1];

      String formattedInteger = integerPart.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
            (match) => '${match.group(1)},',
      );

      return '$formattedInteger.$decimalPart';
    } else {
      return numStr.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
            (match) => '${match.group(1)},',
      );
    }
  }

  /// 设置盘口
  setCur(String key) {
    curOdds = key;
    preOdds = curOdds;
  }

  /// 是否显示 活动
  bool isHaveActivity() {
    return (userInfo.value?.activityList.isNotEmpty ?? false) &&
        ['zh', 'hk'].contains(Get.locale?.languageCode);
  }

  /// 对应国际化title
  String getTitle() {
    String languageCode = Get.locale?.languageCode ?? "zh";
    String? title = "";
    if (languageCode == 'zh') {
      title = userInfo.value?.configVO?.titleMap?.zh;
    } else if (languageCode == 'en') {
      title = userInfo.value?.configVO?.titleMap?.en;
    } else if (languageCode == 'md') {
      title = userInfo.value?.configVO?.titleMap?.md;
    } else if (languageCode == 'ms') {
      title = userInfo.value?.configVO?.titleMap?.ms;
    } else if (languageCode == 'pty') {
      title = userInfo.value?.configVO?.titleMap?.pty;
    } else if (languageCode == 'th') {
      title = userInfo.value?.configVO?.titleMap?.th;
    } else if (languageCode == 'ad') {
      title = userInfo.value?.configVO?.titleMap?.ad;
    } else if (languageCode == 'vi') {
      title = userInfo.value?.configVO?.titleMap?.vi;
    } else if (languageCode == 'tw') {
      title = userInfo.value?.configVO?.titleMap?.tw;
    } else if (languageCode == 'hy') {
      title = userInfo.value?.configVO?.titleMap?.hy;
    }
    return title ?? userInfo.value?.configVO?.title ?? "";
  }
}