import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/mine/vip/models/member_vip_text_data.dart';
import 'package:filbet/src/mine/vip/vip_service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/get_utils.dart';

class VipRulesController extends GetXBaseController {
  RxList<Map<String, dynamic>> rulesData = RxList<Map<String, dynamic>>([
    {
      "title": "vip_rules_advance_standard_title".tr,
      "content": "vip_rules_advance_standard".tr
    },
    {"title": "普升顺序".tr, "content": "VIP等级达到相应的要求可每天晋升一级，但VIP等级不可越级晋升"},
    {
      "title": "vip_rules_keep_level_title".tr,
      "content": "vip_rules_keep_level".tr
    },
    {
      "title": "vip_level_down_standard".tr,
      "content": "vip_rules_downgrade_standard".tr
    },
    {"title": "vip_level_up_bonus".tr, "content": "vip_rules_upgrade_gift".tr},
    {"title": "vip_birthday_bonus".tr, "content": ""},
    {"title": "vip_weekly_bonus".tr, "content": ""},
    {
      "title": "晋级优惠".tr,
      "content": "可在VIP页面自助领取，领取晋级优惠活动后开始计算活动有效流水；此优惠不与平台其他优惠共享；"
    },
    {"title": "VIP晋级".tr, "content": "每个等级的VIP晋级优惠仅支持指定场馆申请（只可申请符合当前等级的晋级优惠）"},
    {"title": "vip_rebate".tr, "content": ""},
  ]);

  @override
  void onInit() {
    _fetchMemberVipTextData();
    super.onInit();
  }

  Future _fetchMemberVipTextData() async {
    MemberVipTextDataModel? info = await VipService.getMemberVipTextData();
    List<Map<String, dynamic>> teamp = [];
    teamp.addAll(rulesData);
    for (Map element in teamp) {
      if (element.containsValue("vip_rebate".tr)) {
        element["content"] = "vip_rules_vip_rabate"
            .tr
            .replaceAll('{m}', "${info?.upgradeLevelGiftTurnoverLimit}");
      }
      if (element.containsValue("vip_weekly_bonus".tr)) {
        element["content"] = "vip_rules_week_gift"
            .tr
            .replaceAll('{m}', "${info?.weekGiftTurnoverLimit}");
      }

      if (element.containsValue("vip_birthday_bonus".tr)) {
        element["content"] = "vip_rules_birth_gift"
            .tr
            .replaceAll('{m}', "${info?.birthdayLimit}")
            .replaceAll('{n}', "${info?.birthdayTurnoverLimit}");
      }
    }
    rulesData.clear();
    rulesData.addAll(teamp);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
