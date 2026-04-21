import 'dart:io';

import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/vip_upgrade_offer.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/home/homegame_model.dart';
import 'package:filbet/src/mine/controllers/mine_controller.dart';
import 'package:filbet/src/mine/vip/models/menber_vip_gift_config.dart';
import 'package:filbet/src/mine/vip/privilege/model/upgrade_item.dart';
import 'package:filbet/src/mine/vip/vip_service.dart';
import 'package:filbet/src/mine/welfareCenter/models/platform_model.dart';
import 'package:filbet/src/mine/welfareCenter/views/bottom_platform_list.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/string_utils.dart';
import 'package:filbet/widgets/dialog/tips_redpacket_dialog.dart';
import 'package:filbet/widgets/dialog/vip_upgrade_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class VipRPrivilegeController extends GetXBaseController {
  final cardIndex = 0.obs;
  RxList<MemberVipGifytConfigModel> settingList =
      RxList<MemberVipGifytConfigModel>([]);
  RxList privilegeList = RxList<Map<String, dynamic>>([
    {
      "title": "vip_time_withdraw_day".tr,
      "icon": Assets.mineIcVipPrivilege1,
      "result": "0"
    },
    {
      "title": "vip_amount_withdraw_day".tr,
      "icon": Assets.mineIcVipPrivilege3,
      "result": "0"
    },
    {
      "title": "vip_level_up_bonus".tr,
      "icon": Assets.mineIcVipPrivilege3,
      "result": "0"
    },
    {
      "title": "vip_birthday_bonus".tr,
      "icon": Assets.mineIcVipPrivilege4,
      "result": "0"
    },
    {
      "title": "weekly_redpacket".tr,
      "icon": Assets.mineIcVipPrivilege5,
      "result": "0",
      "tips": ""
    }
  ]);
  final upgradeList = [
    UpgradeItem(title: "最低转账"),
    UpgradeItem(title: "红利比例"),
    UpgradeItem(title: "最高奖金"),
    UpgradeItem(title: "流水倍数"),
    UpgradeItem(title: "次数限制"),
    UpgradeItem(title: "游戏场馆"),
  ];
  String coinSymbol = "";
  final totalDeposite = "".obs;
  final depositeRequirement = "".obs;
  final keepLevelequirement = "".obs;

  bool isMaxLevel = false;
  List<MemberVipGifytConfigModel> configList = [];
  final upgradeOffers = <UpgradeOffer>[].obs;
  final platformModel = VenueModel().obs;

  @override
  void onInit() async {
    coinSymbol = UserService.to.state.currencyType.abbr;
    isMaxLevel = UserService.to.state.vipInfo.value?.isMaxLevel ?? false;
    cardIndex.value = UserService.to.state.vipInfo.value?.currentLevel ?? 0;
    if (cardIndex.value > 0) {
      cardIndex.value = cardIndex.value - 1;
    }
    // 并行请求，避免互相阻塞
    await _fetchMemberVipGiftListData();
    await _getMemberVipSettingData();
    // await Future.wait(
    //     [_fetchMemberVipGiftListData(), _getMemberVipSettingData()]);
    queryVipPromotionList();
    resetPrivilegeList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectPlatform() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      builder: (c) {
        return BottomPlatformList(
          models: platformList,
          platformSelect: (model) {
            platformModel.value = model;
          },
        );
      },
    );
  }

  void applyUpgradeOffer() {
    //判断场馆
    if (platformModel.value.name == null) {
      AppUtils.showToast('请选择场馆');
      return;
    }
    //弹出确认框
    Get.dialog(VipUpgradeConfirmDialog(
      platformModel: platformModel.value,
      upgradeOffer: upgradeOffers[cardIndex.value],
    )).then((value) {
      if (value is Map) {
        applyVipPromotion(value['pid'], value['amount']);
      }
    });
  }

  List<VenueModel> get platformList {
    List<VenueModel> platforms = [];

    // 检查 upgradeOffers 是否为空或 cardIndex 是否越界
    if (upgradeOffers.isEmpty ||
        cardIndex.value < 0 ||
        cardIndex.value >= upgradeOffers.length) {
      return platforms;
    }

    var categories = GlobalService.to.state.allGameConfig.value;
    List<num> platformIds = upgradeOffers[cardIndex.value].platformIds ?? [];

    // 按照 platformIds 的顺序排序
    platforms = platformIds
        .map((platformId) {
          return categories.firstWhere(
            (item) => (num.tryParse(item.id ?? '') ?? -1) == platformId,
            orElse: () => VenueModel(), // 如果找不到，返回空对象
          );
        })
        .where((item) => item.id != null && item.maintained == 1) //维护中的数据不显示
        .toList(); // 过滤掉空对象

    return platforms;
  }

  Future _fetchMemberVipGiftListData() async {
    List<MemberVipGifytConfigModel> result =
        await VipService.getMemberVipGiftListData();
    result.sort((a, b) => (a.vipLevel ?? 0).compareTo(b.vipLevel ?? 0));
    result.removeWhere((element) => (element.vipLevel == 0));
    configList.addAll(result);
  }

  resetPrivilegeList() {
    if (settingList.isEmpty) {
      return;
    }
    MemberVipGifytConfigModel model = settingList[cardIndex.value];
    totalDeposite.value = StringUtils.removeTrailingZeros(
        num.tryParse(model.upgradeDeposit ?? "0") ?? 0);
    depositeRequirement.value = StringUtils.removeTrailingZeros(
        num.tryParse(model.upgradeTurnover ?? "0") ?? 0);
    keepLevelequirement.value = StringUtils.removeTrailingZeros(
        num.tryParse(model.retainTurnover ?? "0") ?? 0);

    for (Map element in privilegeList) {
      if (element.containsValue("vip_time_withdraw_day".tr)) {
        element["result"] = "${model.dailyWithdrawTimes}";
      }
      if (element.containsValue("vip_amount_withdraw_day".tr)) {
        element["result"] = model.dailyWithdrawAmount;
      }
      if (element.containsValue("vip_level_up_bonus".tr)) {
        element["result"] = fetchUpgradeGift();
      }

      if (element.containsValue("vip_birthday_bonus".tr)) {
        element["result"] = fetchBirthGift();
      }
      if (element.containsValue("weekly_redpacket".tr)) {
        element["result"] = fetchWeekGift();
        element["tips"] = fetchWeekGiftTips();
      }
    }

    // privilegeList.removeWhere((el)=>((el.containsValue("vip_birthday_bonus".tr)||el.containsValue("vip_level_up_bonus".tr))&&double.parse(el["result"])<=0));
  }

  String fetchBirthGift() {
    for (MemberVipGifytConfigModel element in configList) {
      if (element.vipLevel == settingList[cardIndex.value].vipLevel) {
        return element.birthdayGift ?? "0";
      }
    }

    return "0.0";
  }

  String fetchUpgradeGift() {
    for (MemberVipGifytConfigModel element in configList) {
      if (element.vipLevel == settingList[cardIndex.value].vipLevel) {
        return element.upgradeGift ?? "0";
      }
    }

    return "0.0";
  }

  String fetchWeekGift() {
    for (MemberVipGifytConfigModel element in configList) {
      if (element.vipLevel == settingList[cardIndex.value].vipLevel) {
        return element.weeklyGift ?? "0";
      }
    }

    return "0.0";
  }

  String fetchWeekGiftTips() {
    for (MemberVipGifytConfigModel element in configList) {
      if (element.vipLevel == settingList[cardIndex.value].vipLevel) {
        return element.appTips ?? "";
      }
    }

    return "";
  }

  Future _getMemberVipSettingData() async {
    settingList.value = await VipService.getMemberVipSettingData();
    settingList.sort((a, b) => (a.vipLevel ?? 0).compareTo(b.vipLevel ?? 0));
    settingList.removeWhere((element) => (element.vipLevel == 0));
    update();
  }

  Future queryVipPromotionList() async {
    var resp = await ApiRequest.queryVipPromotionList();
    if (resp != null) {
      upgradeOffers.value = resp.list ?? [];
      upgradeOffers.removeWhere((element) => (element.vipLevel == 0));
    }
  }

  Future applyVipPromotion(String pid, String amount) async {
    var resp = await ApiRequest.applyVipPromotion(pid, amount);
    if (resp == true) {
      AppUtils.showToast('活动参与成功');
      UserService.to.queryTotalBalance();
    }
  }

  void showRedPacketTipsDialog(String? tips) {
    Get.dialog(
      TipsRedpacketDialog(
        title: '每周红包领取规则',
        content: tips ??
            '每周红包领取规则:\n\n1、会员在上周六00:00:00至本周五23:59:59的期间完成投注任务,可在每周六领取每周红包。\n\n2、各等级红包金额和领取要求详见VIP 详情页所示。',
      ),
    );
  }
}
