import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/resp_vip_config.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:get/get.dart';

class VipMonthlyController extends GetXBaseController {
  final vipConfig = RespVipConfig().obs;
  final longestVenueConfigs = <VenueConfigs>[].obs;

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
    if (resp != null && resp.weeklyBonus != null) {
      // 如果 weeklyBonus 长度不足 11，补齐到 11 个
      if (resp.weeklyBonus!.length < 11) {
        final currentLength = resp.weeklyBonus!.length;
        final needToAdd = 11 - currentLength;
        for (int i = 0; i < needToAdd; i++) {
          resp.weeklyBonus!.add(WeeklyBonus());
        }
      }

      // 获取最长的 venueConfigs 长度
      int maxVenueConfigsLength = 0;
      for (var bonus in resp.weeklyBonus!) {
        final length = bonus.venueConfigs?.length ?? 0;
        if (length > maxVenueConfigsLength) {
          maxVenueConfigsLength = length;
        }
      }

      // 补齐其他 weeklyBonus 的 venueConfigs 到最长的长度
      if (maxVenueConfigsLength > 0) {
        // 找到最长的 venueConfigs（用于补齐时参考）
        for (var bonus in resp.weeklyBonus!) {
          final length = bonus.venueConfigs?.length ?? 0;
          if (length == maxVenueConfigsLength) {
            longestVenueConfigs.value = bonus.venueConfigs ?? [];
            break;
          }
        }

        for (var bonus in resp.weeklyBonus!) {
          bonus.venueConfigs ??= [];
          final currentLength = bonus.venueConfigs!.length;
          if (currentLength < maxVenueConfigsLength) {
            final needToAdd = maxVenueConfigsLength - currentLength;
            // 使用最长的 venueConfigs 的 venueId 来补齐
            if (longestVenueConfigs.isNotEmpty) {
              for (int i = 0; i < needToAdd; i++) {
                final sourceIndex = currentLength + i;
                if (sourceIndex < longestVenueConfigs.length) {
                  bonus.venueConfigs!.add(VenueConfigs(
                    venueId: longestVenueConfigs[sourceIndex].venueId,
                  ));
                } else {
                  bonus.venueConfigs!.add(VenueConfigs());
                }
              }
            } else {
              for (int i = 0; i < needToAdd; i++) {
                bonus.venueConfigs!.add(VenueConfigs());
              }
            }
          }
        }

        // 为所有 venueConfigs 赋值 name（通过 venueId 匹配 allPlatformNameConfig 的 id）
        for (var bonus in resp.weeklyBonus!) {
          if (bonus.venueConfigs != null) {
            for (var venueConfig in bonus.venueConfigs!) {
              if (venueConfig.venueId != null &&
                  venueConfig.venueId!.isNotEmpty) {
                // 在 allPlatformNameConfig 中查找匹配的 id
                for (var platform
                    in GlobalService.to.state.allPlatformNameConfig) {
                  if (platform.id == venueConfig.venueId) {
                    venueConfig.name = platform.name;
                    break;
                  }
                }
              }
            }
          }
        }
      }
    }
    vipConfig.value = resp ?? RespVipConfig();
  }
}
