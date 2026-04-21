import 'dart:math';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_vip_level.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/main/main_controller.dart';
import 'package:filbet/src/mine/views/user_enum.dart';
import 'package:filbet/src/mine/vip/models/member_vip_info.dart';
import 'package:filbet/src/mine/vip/vip_service.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filbet/common/currency.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/http/http_client.dart';
import 'package:tuple/tuple.dart';

class MineController extends GetXBaseController
    with GetTickerProviderStateMixin {
  static MineController get to => Get.find();

  late AnimationController? animationController;

  EasyRefreshController easyRefreshController =
      EasyRefreshController(controlFinishRefresh: true);

  final RxList<Currency> currencyList = Currency.values.obs;

  RxString betnumber = "0".obs;
  RxString betrebate = "0".obs;
  RxString betwin = "0".obs;
  RxString needString = "".obs;
  final vipInfo = Rx<MemberVipInfoModel?>(null);

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      //设置Ticker 动画帧的回调函数
      duration: const Duration(milliseconds: 2000),
      // 正向动画时长 //2s
      reverseDuration: const Duration(milliseconds: 2000),
      // 反向动画时长 //2s
      lowerBound: 0,
      // 开始动画数值  double类型
      upperBound: 1.0,
      // 结束动画数值 double类型
      animationBehavior: AnimationBehavior.normal,
      // 动画器行为 是否重复动画 两个枚举值
      debugLabel: "zd", // 调试标签 动画过多时方便调式，toString时显示
    );

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() async {
    super.onReady();
    memberreport();
    financeWelfareWallet();
    Future.delayed(const Duration(milliseconds: 300), () async {
      fetchMemberVipInfo();
    });
  }

  void financeWelfareWallet() async {
    var resp = await ApiRequest.financeWelfareWallet();
    if (resp != null) {
      UserService.to.state.welfareAmount.value = resp.balance ?? '0';
    }
  }

  // void getUserInfos() {
  //   animationController!.repeat(period: const Duration(milliseconds: 1000));

  //   //    UserService.to.getUserInfos(onComplete: () {
  //   //   Future.delayed(const Duration(milliseconds: 1000), () {
  //   //     if (animationController != null && !isClosed) {
  //   //       animationController!.reset();
  //   //     }
  //   //   });
  //   // }, onError: () {
  //   //   animationController!.reset();

  //   // });
  // }

  double calculateProgress() {
    // 2. 升级总进度 = min(充值进度, 投注进度)
    // 例如：
    // 升级到 VIP1 需要充值 1000 元，投注 1000 元。
    // 用户当前充值了 1200 元，投注了 600 元。
    // 充值进度 = 1200 / 1000 = 120%（溢出按 100% 计算）
    // 投注进度 = 600 / 1000 = 60%
    // 总进度条显示 = 60%
    double targetTurnover =
        double.parse(vipInfo.value?.targetTurnover ?? '0'); // 下一级别目标流水
    if (targetTurnover <= 0) return 0.0; // 防止目标为0
    double currentTurnover = double.parse(
        vipInfo.value?.exchangeVipCurrentTurnover ?? '0'); // 升vip开始的累计流水
    double target = currentTurnover / targetTurnover;
    double targetClamp = target.clamp(0.0, 1.0);
    double currentDeposit =
        double.parse(vipInfo.value?.currentDeposit ?? '0'); // 当前存款
    double targetDeposit =
        double.parse(vipInfo.value?.targetDeposit ?? '0'); // 下一级目标存款
    if (targetDeposit <= 0) return 0.0; // 防止目标为0
    double deposit = currentDeposit / targetDeposit;
    double depositClamp = deposit.clamp(0.0, 1.0);
    double result = min(targetClamp, depositClamp);
    return result;
  }

  void financewallet() async {
    if (!(animationController?.isAnimating ?? false)) {
      animationController!.repeat(period: const Duration(milliseconds: 1000));
    }
    await UserService.to.queryTotalBalance();
    if (animationController != null) {
      animationController?.stop();
      animationController?.reset();
    }
  }

  /// 进入设置页面
  void jumpToSettingPage() {
    Get.toNamed(Routes.SETTING);
  }

  void middleListClick(UserCenterItemType type) {
    // userCenterTransactionRecord, // 交易记录
    // userCenterBetRecords, //投注记录
    // userCenterRechargAndWithdrawRecords, // 存取记录
    // userCenterReceiveCenter, //福利中心
    // userCenterSecurityCenter, //安全中心

    // userCenterPersonal, //个人资料
    // userCenterMessageCenter, // 消息中心
    // userCenterHelpCenter, // 帮助中心
    switch (type) {
      case UserCenterItemType.userCenterTransactionRecord:
        Get.toNamed(Routes.TRANSACTION_RECORD)?.then((value) {
          financewallet();
        });
        break;
      case UserCenterItemType.myAssets:
        AppNavigator.toMyAssets().then((value) {
          financewallet();
        });
        break;
      case UserCenterItemType.userCenterBetRecords:
        Get.toNamed(Routes.BET_RECORD);
        break;
      case UserCenterItemType.userCenterRechargAndWithdrawRecords:
        Get.toNamed(Routes.TRANSACTION_RECORD)?.then((value) {
          financewallet();
        });
        break;
      case UserCenterItemType.userCenterReceiveCenter:
        Get.toNamed(Routes.WELFARE_CENTER);
        break;
      // case UserCenterItemType.userCenterSecurityCenter:
      //   Get.toNamed(Routes.SECURITY);
      //   break;
      case UserCenterItemType.userCenterPersonal:
        Get.toNamed(Routes.USER_INFO);
        break;
      case UserCenterItemType.userCenterMessageCenter:
        AppNavigator.gotoMessage();
        break;
      case UserCenterItemType.userCenterHelpCenter:
        AppNavigator.gotoHelpCenter();
        break;
      case UserCenterItemType.userCenterJoinUs:
        AppNavigator.gotoJoinUs();
        break;
      case UserCenterItemType.feedBack:
        AppNavigator.toFeedBack();
        break;
      case UserCenterItemType.accountManager:
        Get.toNamed(Routes.ACCOUNT_MANAGE);
        break;
    }
  }

  ///vip信息接口
  Future fetchMemberVipInfo() async {
    vipInfo.value = await VipService.getMemberVipInfo();
    double needDeposite = double.parse(vipInfo.value?.targetDeposit ?? "0") -
        double.parse(vipInfo.value?.currentDeposit ?? "0");
    if (needDeposite < 0) {
      needDeposite = 0;
    }
    double needTurnOver = double.parse(vipInfo.value?.targetTurnover ?? "0") -
        double.parse(vipInfo.value?.exchangeVipCurrentTurnover ?? "0");
    if (needTurnOver < 0) {
      needTurnOver = 0;
    }
    needString.value =
        "${"升级还需存款/流水".tr}: ${vipInfo.value?.targetLevel == 0 ? "-/-" : "${toStringAsFixed2(needDeposite.toString())}/${toStringAsFixed2(needTurnOver.toString())}"}";
  }

  //<editor-fold desc="使用的语言">
  String switchLanguage() {
    Language language = GlobalService.to.state.language;
    switch (language) {
      // case Language.en:
      //   return "en_US";
      case Language.zh_tw:
        return "zh_TW";
      default:
        return "zh_CN";
    }
  }

//</editor-fold>

  Future memberreport() async {
    var response = await HttpClient.get(
      Api.memberreport,
    );

    if (response.status == false) {
      return;
    }

// "cnt": 0, //已结算注
//   "rebate_sum": "", /累计返水
//   "win_sum": "" //累计输赢
    betnumber.value = response.data["cnt"].toString() ?? "0";
    betrebate.value = response.data["rebate_sum"] ?? "0";
    betwin.value = response.data["win_sum"] ?? "0";
  }

  void footerClick(int type) {
    if (type == 0) {
      Get.toNamed(Routes.BET_RECORD);
    }

    if (type == 1) {
      Get.toNamed(Routes.BET_RECORD);
    }
    if (type == 2) {
      Get.toNamed(Routes.WELFARE_CENTER);
    }
  }
}
