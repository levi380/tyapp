import 'package:filbet/api/api.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/src/mine/vip/models/member_vip_info.dart';
import 'package:filbet/src/mine/vip/models/member_vip_rate.dart';
import 'package:filbet/src/mine/vip/models/member_vip_text_data.dart';
import 'package:filbet/src/mine/vip/models/menber_vip_gift_config.dart';
import 'package:filbet/src/mine/vip/models/menber_vip_rate_platform.dart';
import 'package:filbet/src/mine/vip/models/resp_vip_rate_detail.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/fp.dart';
import 'package:filbet/common/currency.dart';

class VipService {
  static Future<MemberVipInfoModel?> getMemberVipInfo() async {
    try {
      final response = await HttpClient.get(Api.membervipinfo);
      if (response.status == false) {
        return null;
      }
      if (response.data is Map) {
        final convert =
            compose(MemberVipInfoModel.fromJson, Map<String, dynamic>.from);
        return convert(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<MemberVipTextDataModel?> getMemberVipTextData() async {
    final response = await HttpClient.get(Api.memberviptextdata);
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is Map) {
      final convert =
          compose(MemberVipTextDataModel.fromJson, Map<String, dynamic>.from);
      return convert(response.data);
    } else {
      throw Exception('Invalid response format');
    }
  }

  //获取Vip礼金配置
  static Future<List<MemberVipGifytConfigModel>>
      getMemberVipGiftListData() async {
    final response = await HttpClient.get(Api.membervipgiftlist);
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is Map) {
      final convert = compose(
          MemberVipGifytConfigModel.fromJson, Map<String, dynamic>.from);
      List<dynamic> list = (response.data as Map).values.toList();

      return List.generate(list.length, (index) {
        return convert(list[index]);
      });
    } else {
      throw Exception('Invalid response format');
    }
  }

  //获取Vip等级与配置
  static Future<List<MemberVipGifytConfigModel>>
      getMemberVipSettingData() async {
    final response = await HttpClient.get(Api.membervipsetting);
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is Map) {
      final convert = compose(
          MemberVipGifytConfigModel.fromJson, Map<String, dynamic>.from);
      List<dynamic> list = (response.data as Map).values.toList();

      return List.generate(list.length, (index) {
        return convert(list[index]);
      });
    } else {
      throw Exception('Invalid response format');
    }
  }

  //获取Vip反水场馆配置
  static Future<List<MemberVipRate>?> getMemberVipRebateListData() async {
    final response = await HttpClient.get(Api.memberviprebatelist);
    if (response.status == false) {
      return null;
    }
    if (response.data != null) {
      List<MemberVipRate> list = [];
      response.data.forEach((v) {
        list.add(MemberVipRate.fromJson(v));
      });
      return list;
    }
    return null;
  }

  //获取Vip反水场馆配置
  static Future<RespVipRateDetail?> queryMemberVipRebateGames(
      String platformId, int page, int pageSize) async {
    try {
      final response = await HttpClient.get(
        Api.memberVipRebateGames,
        queryParameters: {
          'platform_id': platformId,
          'page': page,
          'page_size': pageSize,
        },
      );
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      if (response.data != null) {
        return RespVipRateDetail.fromJson(response.data);
      }
    } catch (e) {
      print("object123456 $e");
      return null;
    }
  }
}
