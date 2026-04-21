import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/home/platform_name_model.dart';

class MemberVipRatePlatformModel {
  final List<int>? vipLevelList;
  final List<String>? rebateRateList;
  final int? platformId;
  final String? platformName;

  MemberVipRatePlatformModel(
      {this.vipLevelList,
      this.rebateRateList,
      this.platformId,
      this.platformName});

  factory MemberVipRatePlatformModel.fromJson(Map<String, dynamic> json) {
    return MemberVipRatePlatformModel(
      platformId: json['platform_id'],
      platformName: fetchPlatformName("${json['platform_id'] ?? 0}"),
      vipLevelList: json['vip_level_list'],
      rebateRateList: json['rebate_rate_list'],
    );
  }

  static fetchPlatformName(String pid) {
    for (PlatFormNameModel element
        in GlobalService.to.state.allPlatformNameConfig) {
      if (element.id == pid) {
        return element.name ?? "";
      }
    }
  }
}
