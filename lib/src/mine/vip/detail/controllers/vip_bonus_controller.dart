import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/vip_setting_model.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:get/get.dart';

class VipBonunsController extends GetXBaseController {
  final vipSettingModels = <VipSettingModel>[].obs;

  @override
  void onInit() {
    queryMemberVipConfig();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future queryMemberVipConfig() async {
    var resp = await ApiRequest.queryMemberVipConfig();
    if (resp != null) {
      resp.setting?.vipSettingModels
          ?.sort((a, b) => (a.vipLevel ?? 0).compareTo(b.vipLevel ?? 0));
      vipSettingModels.value = resp.setting?.vipSettingModels ?? [];
      vipSettingModels.refresh();
    }
  }
}
