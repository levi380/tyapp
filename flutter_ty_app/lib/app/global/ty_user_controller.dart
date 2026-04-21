import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/core/constant/index.dart';
import 'package:flutter_ty_app/app/global/server-time.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/balance_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/user_info.dart';
import 'package:flutter_ty_app/app/services/models/res/user_personalise_entity.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/quick_bet/quick_bet_controller.dart';
import '../modules/zr/widgets/choose_new_profession_page.dart';
import '../modules/zr/widgets/zr_yindao_page.dart';
import '../services/api/match_api.dart';
import '../services/api/menu_api.dart';
import '../services/models/res/get_user_customize_info_entity.dart';
import '../services/network/domain.dart';
import '../utils/bus/bus.dart';
import '../utils/bus/event_enum.dart';
import '../widgets/fireworks/fireworks_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-c3610dae-ec5b-40e3-aa00-225f93a036f0-dl 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  用户中心 】】】
    【【【 AUTO_PARAGRAPH_TITLE 用户中心 控制器 TYUserController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 用户中心 控制器 TYUserController
    ```
    ///0-关，1-开 队名偏好菜单
    String languageSwitch = '0';

    /// 用户是否开启一键投注
    var isOneClickBet = false.obs;

    /// 用户一键投注设置金额
    double oneClickBetAmount = 0.0;

    /// 用户自定义投注金额  单关投注 串关投注 显示列表
    late List<int> seriesList = [];
    late List<int> singleList = [];

    ///烟花活动
    FireworksController.to.getFireworksActivity();
    ///获取服务器时间
    serverTime.getServerTime();

    ///单独调用刷新余额
    getBalance();
    getUserParamConfig();
    /// 拉取用户信息（时区、字体大小等等）
    getUserPersonaliseSettings();
    ```
    】】】
 *
 */
class TYUserController extends GetxController {
  static TYUserController get to =>
      Get.put(TYUserController(), permanent: true);

  Rxn<UserInfo> userInfo = Rxn<UserInfo>();
  final balance = Rxn<BalanceEntity>();

  final RxDouble balanceAmount = 0.0.obs;
  String preOdds = 'EU';
  String curOdds = 'EU';

  bool isShowGuide=false;
  String userName = '';
  String userId = '';

  ///0-关，1-开 队名偏好菜单
  String languageSwitch = '0';

  late UserPersonaliseEntity userPersonaliseEntity;

  //late UserPersonaliseEntity userPersonaliseEntity;

  /// 用户是否开启一键投注
  var isOneClickBet = false.obs;

  /// 用户一键投注设置金额
  double oneClickBetAmount = 0.0;

  /// 用户自定义投注金额  单关投注 串关投注 显示列表
  late List<int> seriesList = [];
  late List<int> singleList = [];

  @override
  void onInit() {
    super.onInit();
    initUserPersonaliseEntity();
  }

  @override
  void onClose() {
    Bus.getInstance().off(EventType.tyAmountRefresh);
    super.onClose();
  }

  afterUserCb() async {
    ///接口集中 并且串行执行
    await Future.wait([
      ///单独调用刷新余额
       getBalance(),
      ///获取服务器时间
      serverTime.getServerTime(),
      getUserParamConfig(),
      /// 拉取用户信息（时区、字体大小等等）
      getUserPersonaliseSettings(),
    ]);

    ///用户配置内容
    _loadSecondaryData();
    ///UI部分
    _handleAnnualReport();
  }

  ///刷新用户配置接口 用户配置内容
  void _loadSecondaryData() {
    Future.wait([
      getUserPersonalise(),
      getUserCustomizeInfo(),
      getUserCustomizeInfoBetAmount(),
      ///烟花活动
      FireworksController.to.getFireworksActivity(),
    ]).catchError((e) {
      AppLogger.debug('Secondary load error');
      return [];
    });
  }

  ///刷新用户配置接口 UI部分
  void _handleAnnualReport() {
    final open = userInfo.value?.isOpen == "1" &&
        userInfo.value?.paramConfigs?["usRt"] == "1";

    AnnualReportEntrance = open;
    if (Get.isRegistered<MainTabController>()) {
      MainTabController.to.update();
    }
  }

 ///菜单
  /// isRefresh 是否是底部刷新按钮调用
  Future<void> refreshUserInfo({bool isRefresh = false}) async {
    try {
      final res =
          await AccountApi.instance().getUserInfo(StringKV.token.get() ?? '');
      if (res.success) {
        userInfo.value = res.data;
        userName = res.data!.userName;
        languageSwitch = res.data!.languageSwitch;
        // AppLogger.debug("userInfo.value = ${userInfo.value}");
        AllDomain.instance().setUserInfo(userInfo.value);
        //获取用户热门，时间排序方式。
        TyHomeController.to.homeState.isHot =
            (TYUserController.to.userInfo.value!.sort == 1);
        BoolKV.sort.save(TYUserController.to.userInfo.value!.sort == 1);

        if(!isRefresh){
          ///底部按钮刷新 不更新日夜间模版  81382
          /// configVO.profesTag字段,1 是日间 2 是夜间
          /// 調整app歸屬字段
          res.data?.configVO?.appDefault == 1
              ? Get.changeThemeMode(ThemeMode.light)
              : Get.changeThemeMode(ThemeMode.dark);
          TyHomeController.to.homeState.isLight =
          res.data?.configVO?.appDefault == 1 ? true : false;
        }

      }
    } catch (e) {
      AppLogger.debug('get user info error: $e');
    }
  }

  /// 获取服务器时间 存入本地 需要计算 和本地时间的差值
  Future<void> getServerTime() async {
    try {
      /// 记录请求发出时的本地时间
      /// 设置东八区时区（UTC+8）
      final DateTime now = DateTime.now().toUtc().add(const Duration(hours: 8));
      /// 记录请求发出时的本地（东八区）时间戳
      int currentTime = now.millisecondsSinceEpoch;

      final response = await AccountApi.instance().getServerTime();
      /// 解析服务器时间（例如为毫秒时间戳字符串）
      int serverTime = int.tryParse(response.data) ?? 0;
      /// 计算时间差
      int timeDiff = serverTime - currentTime;
      if (kDebugMode) {
        AppLogger.debug('服务器时间: $serverTime');
        AppLogger.debug('本地请求时间: $currentTime');
        AppLogger.debug('时间差值: $timeDiff ms');
      }
      /// 保存时间差（自定义持久化逻辑）
      IntKV.diffTime.save(timeDiff);
    } catch (e, stacktrace) {
      if (kDebugMode) {
        AppLogger.error(e,stackTrace: stacktrace);
      }
    }
  }

  ///单独调用刷新余额
  Future<void> getBalance() async {
    try {
      final balanceRes =
          await AccountApi.instance().getBalance(userInfo.value?.userId ?? '');
      if (balanceRes.success) {
        balance.value = balanceRes.data;
        balanceAmount.value = balanceRes.data!.amount;
        AppLogger.debug(" BoolKV.isTan  =  ${ BoolKV.isTan.get()}");
        if(StringKV.language.get() == 'CN'&&isShowGuide==false ){
          ///只有简体中文有引导
          //   AppLogger.debug("===========>数据   isShowGuide   ${isShowGuide}  ${userInfo
          //       .value?.userId}  ${(userInfo
          //       .value?.userId ==
          //       userInfo
          //           .value?.userId)}   userIdKey ${"guid_show_${TYUserController.to
          //       .getUid()}"}  hasdata  ${(appStorage.hasData(
          //       "guid_show_${TYUserController.to.getUid()}"))}");
            if (userInfo
                .value?.userId == null ) {
              return;
            }
            if (appStorage.get("guid_show_${TYUserController.to.getUid()}")!=null) {
              return;
            }
              if (isShowGuide == true) {
                return;
              }
              // AppLogger.debug("===========>开始执行  ${StringKV.baseUrl.get()}");
              fetchFirstShowDialog();
            // 防止域名没有切换过来
        }


        update();
      }
    } catch (e) {
      AppLogger.debug('get balance error: $e');
    }
  }


  ///首次新手引导弹窗
  void fetchFirstShowDialog() async{
    // 在跨端设备 请求其他设备是否做了 加载
    MatchApi.instance()
        .getUserPersonaliseNew(["zr"], TYUserController.to.getUid()).then((value) {
      Map<String,dynamic> map=value.data??{};
      // AppLogger.debug("=============================>map  ${map}  ma zr  ${map["userParams"]}  3  ${map["userParams"]["zr"]}");

      if(map["zr"]!=null&&map["userParams"]!=null&&map["userParams"]["zr"]=="1"){
        if(isShowGuide) {
          return;
        }
        chooseNewOrProfession();
        appStorage.put("guid_show_${TYUserController.to.getUid()}", true);
        isShowGuide==true;
        MatchApi.instance()
            .setUserPersonaliseNew(TYUserController.to.getUid(), [{"uid":TYUserController.to.getUid(),"paramKey":"zr","paramValue":"0"}]);
      }


    });
  }

  ///选择专业版或者新手版弹窗
  chooseNewOrProfession() async {
    await Get.dialog(
      chooseNewOrProfessionPage(
        callback: () {
          zrYindao();
        },
      ),
      barrierColor: Colors.black.withValues(alpha:0.5),
    );
  }

  ///新手引导弹窗
  void zrYindao() {
    Get.dialog(
      useSafeArea: false,
      ZrYindaoPage(
        type: 'zr',
      ),
      barrierColor: Colors.black.withValues(alpha:0.76),
    );
  }
  Future<void> getUserPersonalise() async {
    try {
      TyHomeController.to.homeState.isProfess =
          BoolKV.userVersion.get() ?? true;
      final personaliseRes = await AccountApi.instance().getUserPersonalise(1);
      if (personaliseRes.success && personaliseRes.data != null) {
        BetOddsConstantModel? data = oddsConstant.firstWhereOrNull(
            (e) => e.handicapType == personaliseRes.data!.handicapType);
        curOdds = data?.value ?? 'EU';
        if(userInfo.value?.paramConfigs?[curOdds] != "1"){
              //如果选择的类型被关闭，则使用欧赔
              curOdds = 'EU';
        }
        preOdds = curOdds;
        String userVersion = "0";
        if (personaliseRes.data!.userVersion.isNotEmpty) {
          userVersion = personaliseRes.data!.userVersion;
        }
        //获取用户是专业版本，新手版。
        TyHomeController.to.homeState.isProfess = (userVersion == "0");
        BoolKV.userVersion.save(userVersion == "0");
      }
    } catch (e) {
      AppLogger.debug('get balance error: $e');
    }
  }

/*
  Future<void> setUserPersonalise({
    String? toAccept,
    String? userVersion,
    String? handicapType,
  }) async {
    try {
      final personaliseRes = await AccountApi.instance()
          .setUserPersonalise(toAccept, userVersion, handicapType);
      if (personaliseRes.success && toAccept != null) {
        userPersonaliseEntity.toAccept = toAccept;
      }
    } catch (e) {
      AppLogger.debug('setUserPersonalise error: $e');
    }
  }
*/
  Future<void> setUserBetPrefer(
    int userBetPrefer,
  ) async {
    try {
      final res =
          await AccountApi.instance().recordUserPreference(userBetPrefer);
      if (res.success) {
        userInfo.value?.userBetPrefer = userBetPrefer;
        update(['auto_accept']);
      }
    } catch (e) {
      AppLogger.debug('setUserBetPrefer error: $e');
    }
  }

  Future<void> getUserCustomizeInfo() async {
    try {
      final customizeInfoRes = await MenuApi.instance().getUserCustomizeInfo();
      if (customizeInfoRes.code == '0000000') {
        isOneClickBet.value = customizeInfoRes.data.switchOn;
        if (customizeInfoRes.data.singleList.isNotEmpty) {
          singleList = customizeInfoRes.data.singleList;
        } else {
          UserInfoCvoSingle single =
              userInfo.value?.cvo?.single ?? UserInfoCvoSingle();

          List<int> arr = [
            // single.qon,
            // single.qtw,
            // single.qth,
            // single.qfo,
            // single.qth,
            // single.qfi
          ];

          single.toJson().forEach((key, value) {
            if (key.startsWith('q')) {
              arr.add(value);
            }
          });
          arr.sort((a, b) => a - b);
          if (arr.length > 5) {
            arr.removeLast();
          }
          singleList = arr;
        }

        if (customizeInfoRes.data.seriesList.isNotEmpty) {
          seriesList = customizeInfoRes.data.seriesList;
        } else {
          UserInfoCvoSeries series =
              userInfo.value?.cvo?.series ?? UserInfoCvoSeries();
          List<int> arr = [
            // series.qon,
            // series.qtw,
            // series.qth,
            // series.qfo,
            // series.qth,
            // series.qfi
          ];
          series.toJson().forEach((key, value) {
            if (key.startsWith('q')) {
              arr.add(value);
            }
          });
          arr.sort((a, b) => a - b);
          if (arr.length > 5) {
            arr.removeLast();
          }
          seriesList = arr;
        }

        ///初始化接口设置  自定义快捷投注设置
        setUserCustomizeInfo();
      }
    } catch (e) {
      AppLogger.debug('get UserCustomizeInfo error: $e');
    }
  }

  Future<void> getUserCustomizeInfoBetAmount(
      {GetUserCustomizeInfoEntity? infoRes}) async {
    GetUserCustomizeInfoEntity customizeInfoRes;
    if (infoRes != null) {
      customizeInfoRes = infoRes;
    } else {
      try {
        customizeInfoRes = await MenuApi.instance().getUserCustomizeInfo();
      } catch (e) {
        AppLogger.debug('get UserCustomizeInfo error: $e');
        return;
      }
    }
    if (customizeInfoRes.code == '0000000') {
      isOneClickBet.value = customizeInfoRes.data.switchOn;
      oneClickBetAmount =
          double.tryParse(customizeInfoRes.data.fastBetAmount.toString()) ??
              userInfo.value?.cvo?.single?.qfi.toDouble() ??
              10;
      QuickBetController.to.isClose.value = !customizeInfoRes.data.switchOn;
    }
  }

  String getUid() {
    if (ObjectUtil.isNotEmpty(userInfo.value?.userId)) {
      return userInfo.value!.userId;
    } else {
      /// uuid
      return const Uuid().v1();
    }
  }


  String getlanguageList() {
    return userInfo.value?.languageList ?? '';
  }

  void initUserPersonaliseEntity() {
    /*
    userPersonaliseEntity = UserPersonaliseEntity();
    userPersonaliseEntity.addHandicap = '0'; // 附加盘(0-关/1-开,默认关)
    userPersonaliseEntity.handicapType = '0'; //	盘口类型,欧盘/亚盘(EU-欧盘,AS-亚盘,默认欧盘)
    userPersonaliseEntity.isHk = '0'; // 港译/简译(0-港译/1-简译,默认简译)
    userPersonaliseEntity.playAdName = '1'; // 列表页附加玩法(0-关,1-开,默认关)
    userPersonaliseEntity.playAdNameCg = '0'; // 列表页附加玩法配置(0-3行展示/1-全部行,默认全部行)
    userPersonaliseEntity.skinMode = '1'; // 日间/夜间(0-日间,1-夜间,默认日间)
    userPersonaliseEntity.toAccept = '1'; // 自动接受最好赔率(0-任何赔率/1-最佳赔率,默认任何赔率)
    userPersonaliseEntity.userLanguage = 'zh'; //	多语言切换(默认根据商户设置,对应值为多语言code)
    userPersonaliseEntity.userVersion = '0'; //	专业版/新手版(0-专业版,1-新手版,默认专业版)
     */
    Bus.getInstance().on(EventType.tyAmountRefresh, (value) {
      getBalance();
    });
  }

  /// 是否允许更多赔率类型切换 设置一键开关
  bool get handicapTypeChangeMore {
    return true;
  }

  String getCurHandicapName() {
    BetOddsConstantModel? data =
        oddsConstant.firstWhereOrNull((e) => e.value == curOdds);
    if (data != null) {
      return data.label.tr;
    }
    return "";
  }
}
