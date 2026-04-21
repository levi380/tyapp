import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/home/platform_name_model.dart';
import 'package:filbet/src/mine/vip/models/member_vip_rate.dart';
import 'package:filbet/src/mine/vip/models/menber_vip_rate_platform.dart';
import 'package:filbet/src/mine/vip/models/resp_vip_rate_detail.dart';
import 'package:filbet/src/mine/vip/vip_service.dart';
import 'package:filbet/widgets/dialog/rebate_detail_dialog.dart';
import 'package:get/get.dart';

class VipRebateController extends GetXBaseController {
  final platformList = <MemberVipRate>[].obs;
  List<Map<String, dynamic>> rulesData = [
    {"title": "", "content": "sk_official_tips_one".tr},
    {"title": "", "content": "sk_official_tips_two".tr},
  ];

  @override
  void onInit() {
    _getMemberVipRabateListData();
    super.onInit();
  }

  Future _getMemberVipRabateListData() async {
    platformList.value = await VipService.getMemberVipRebateListData() ?? [];
    // platformList
    //     .sort((a, b) => (a.platformId ?? '').compareTo(b.platformId ?? ''));
    platformList.removeWhere(
        (element) => fetchPlatformName(element.platformId ?? '') == false);
    platformList.refresh();
  }

  bool fetchPlatformName(String pid) {
    for (PlatFormNameModel element
        in GlobalService.to.state.allPlatformNameConfig) {
      if (element.id == pid) {
        return true;
      }
    }
    return false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future queryMemberVipRebateGames(
      String platformName, String platformId) async {
    var resp = await VipService.queryMemberVipRebateGames(platformId, 1, 100);
    if (resp != null) {
      List<VipRateDetail> models = resp.d ?? [];
      Get.dialog(
        RebateDetailDialog(platformName: platformName, models: models),
      );
    }
  }
}
