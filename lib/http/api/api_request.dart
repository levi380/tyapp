import 'dart:convert';
import 'dart:developer';

import 'package:filbet/api/api.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/entity/activity_turntable_detail_model.dart';
import 'package:filbet/http/entity/login_info.dart';
import 'package:filbet/http/entity/platform_check_model.dart';
import 'package:filbet/http/entity/platform_check_out_model.dart';
import 'package:filbet/http/entity/resp_activity_apply_list.dart';
import 'package:filbet/http/entity/resp_redeem_record.dart';
import 'package:filbet/http/entity/resp_service_model.dart';
import 'package:filbet/http/entity/resp_vip_config.dart';
import 'package:filbet/http/entity/resp_widthdraw_method.dart';
import 'package:filbet/http/entity/resp_winner_record.dart';
import 'package:filbet/http/entity/vip_upgrade_offer.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/services/user/currency_balance.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/home/resp_message_model.dart';
import 'package:filbet/src/login/captcha/resp_captcha_code.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class ApiRequest {
  static Future<ActivityModel?> queryActivityDetail(
      String promoId, String ty) async {
    try {
      var response = await HttpClient.get(Api.activityDetail,
          queryParameters: {'id': promoId, 'ty': ty});
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return ActivityModel.fromJson(Map<String, dynamic>.from(response.data));
    } catch (e) {
      print("object123456 $e");
      return null;
    }
  }

  static Future<ActivityTurntableDetailModel?> queryActivityTurntableDetail(
      String promoId, String ty) async {
    try {
      var response = await HttpClient.get(Api.activityDetail, queryParameters: {
        'id': promoId,
        'ty': ty,
        'v': DateTime.now().millisecondsSinceEpoch
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return ActivityTurntableDetailModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> applyJoinActivity(String promoId, String ty) async {
    try {
      var response = await HttpClient.post(Api.applyJoinActivity,
          data: {'id': promoId, 'ty': ty});
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return true;
    } catch (e) {
      return null;
    }
  }

  static Future<Prizes?> applyJoinTurntableActivity(
      String promoId, String ty, int playType) async {
    try {
      var response = await HttpClient.post(Api.applyJoinActivity, data: {
        'id': promoId,
        'ty': ty,
        'promo_id': promoId,
        'play_type': playType,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return Prizes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  static Future<RespActivityApplyList?> applyActivityList() async {
    try {
      var response = await HttpClient.get(Api.applyActivityList);
      if (response.status == false) {
        return null;
      }
      return RespActivityApplyList.fromJson(
          Map<String, dynamic>.from(response.data));
    } catch (e) {
      return null;
    }
  }

  static Future<RespWinnerRecord?> queryActivityWinnerRecord(
    String id,
    String ty,
    int s,
    int page,
    int page_size,
  ) async {
    try {
      var response = await HttpClient.post(Api.activityWinnerRecord, data: {
        'id': id,
        'ty': ty,
        'promo_id': id,
        's': s,
        'sum': 1,
        'page': page,
        'page_size': page_size,
      });
      if (response.status == false) {
        return null;
      }
      return RespWinnerRecord.fromJson(response.data);
    } catch (e) {
      print("object123456 $e");
      return null;
    }
  }

  static Future<List<String>?> getCountryCodeList() async {
    try {
      final response = await HttpClient.get(Api.countryCodeList);
      if (response.status == false) {
        return null;
      }
      List<dynamic> fruits = response.data ?? [];
      return List<String>.from(fruits);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> getSendBindCode(String phone, String country) async {
    try {
      SmartDialog.showLoading();
      final response = await HttpClient.post(Api.sendBindCode, data: {
        'phone': phone,
        'country': country,
      });
      SmartDialog.dismiss();
      if (!response.status) {
        AppUtils.showToastForResponse(response.message,
            ifEmpty: 'get_code_fail'.tr);
        return null;
      }
      return response.status;
    } catch (e) {
      SmartDialog.dismiss();
      return null;
    }
  }

  static Future<bool?> postPhoneCodeVerify(
      int activeMethod, String code, int type) async {
    try {
      SmartDialog.showLoading();
      final response = await HttpClient.post(Api.phoneCodeVerify, data: {
        'active_method': activeMethod,
        'code': code,
        'type': type,
      });
      SmartDialog.dismiss();
      if (!response.status) {
        AppUtils.showToastForResponse(response.message, ifEmpty: '验证码不正确'.tr);
        return null;
      }
      return response.status;
    } catch (e) {
      SmartDialog.dismiss();
      return null;
    }
  }

  static Future<bool> postPhoneVerify(String phoneDigitsy) async {
    try {
      final response = await HttpClient.post(Api.phoneVerify, data: {
        'phone_digits': phoneDigitsy,
      });
      if (!response.status) {
        AppUtils.showToastForResponse(response.message);
      }
      return response.status;
    } catch (e) {
      return false;
    }
  }

//   static Future<CurrencyBalance?> financeWallet() async {
//     try {
//       final response = await HttpClient.get(Api.financewallet);
//       if (response.status == false) {
// //        AppUtils.showToastForResponse(response.message);
//         return null;
//       }
//       return CurrencyBalance.fromJson(Map<String, dynamic>.from(response.data));
//     } catch (e) {
//       return null;
//     }
//   }

//   static Future<CurrencyBalance?> financeLockWallet() async {
//     try {
//       final response = await HttpClient.get(Api.financeLockWallet);
//       if (response.status == false) {
// //        AppUtils.showToastForResponse(response.message);
//         return null;
//       }
//       return CurrencyBalance.fromJson(Map<String, dynamic>.from(response.data));
//     } catch (e) {
//       return null;
//     }
//   }

  static Future<CurrencyBalance?> financeWelfareWallet() async {
    try {
      final response = await HttpClient.get(Api.financeWelfareWallet);
      if (response.status == false) {
//        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return CurrencyBalance.fromJson(Map<String, dynamic>.from(response.data));
    } catch (e) {
      return null;
    }
  }

  static Future<PlatformCheckModel?> transferInCheck(
      String platId, String amount,
      {int? multiple}) async {
    try {
      final response =
          await HttpClient.get(Api.transferInCheck, queryParameters: {
        'plat_id': platId,
        'amount': amount,
        if (multiple != null) 'multiple': multiple,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return PlatformCheckModel.fromJson(
          Map<String, dynamic>.from(response.data));
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> transferInWallet(
    String pid,
    String amount,
  ) async {
    try {
      final response = await HttpClient.post(
        Api.transferIn,
        data: {
          'pid': pid,
          'amount': amount,
        },
      );
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  static Future<PlatformCheckOutModel?> transferOutWallet(
    String pid,
    String amount,
  ) async {
    try {
      final response = await HttpClient.post(
        Api.transferOut,
        data: {
          'pid': pid,
          'amount': amount,
        },
      );
      if (response.status == false) {
//        AppUtils.showToastForResponse(response.message);
        log("object ${response.message}");
        PlatformCheckOutModel? model =
            PlatformCheckOutModel.fromJson(jsonDecode(response.message ?? ''));
        return model;
      }
      return null;
    } catch (e) {
      print("object123456 $e");
      return null;
    }
  }

  static Future<bool?> updateAutoTransfer(int autoTransfer) async {
    try {
      final response = await HttpClient.post(
        Api.updateAutoTransfer,
        data: {
          'auto_transfer': autoTransfer,
        },
      );
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

//   static Future<String?> platformBalance(String pid) async {
//     try {
//       final response = await HttpClient.get(
//         Api.platformBalance,
//         queryParameters: {
//           'pid': pid,
//         },
//       );
//       if (response.status == false) {
// //        AppUtils.showToastForResponse(response.message);
//         return null;
//       }
//       return response.data;
//     } catch (e) {
//       return null;
//     }
//   }

  static Future<RespVipConfig?> queryMemberVipConfig() async {
    try {
      final response = await HttpClient.get(Api.memberVipConfig);
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return RespVipConfig.fromJson(Map<String, dynamic>.from(response.data));
    } catch (e) {
      return null;
    }
  }

  static Future<VipUpgradeOffer?> queryVipPromotionList() async {
    try {
      final response = await HttpClient.get(Api.memberVipPromotionList);
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return VipUpgradeOffer.fromJson(response.data);
    } catch (e) {
      print("object123456 $e");
      return null;
    }
  }

  static Future<bool?> applyVipPromotion(String pid, String amount) async {
    try {
      AppUtils.show();
      final response =
          await HttpClient.post(Api.memberVipPromotionApply, data: {
        'platform_id': pid,
        'transfer_amount': amount,
      });
      AppUtils.dismiss();
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      AppUtils.dismiss();
      return null;
    }
  }

  static Future<bool?> modifyLoginPwd(
    String oldPassword,
    String newPassword, {
    String? securityCode,
  }) async {
    try {
      AppUtils.show();
      final response = await HttpClient.post(
        Api.securitySetLoginPassword,
        data: {
          'old_pwd': oldPassword,
          'new_pwd': newPassword,
          if (securityCode != null) 'sec_code': securityCode,
        },
      );
      AppUtils.dismiss();
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      AppUtils.dismiss();
      return null;
    }
  }

  static Future<RespRedeemRecord?> queryRedemptionRecord(
      int page, int type, int startTimestampMs, int endTimestampMs) async {
    try {
      final response = await HttpClient.post(Api.memberClaimList, data: {
        'page': page,
        'page_size': kPaginationSize,
        'promo_type': 0,
        'status': type,
        'start_time': startTimestampMs,
        'end_at': endTimestampMs,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return RespRedeemRecord.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  static Future balanceRecover() async {
    try {
      final response = await HttpClient.post(Api.balanceRecover);
      if (response.status == false) {
//        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return RespRedeemRecord.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  /// 第一步：验证账号
  static Future<String?> updateLoginPwd1(String account) async {
    try {
      final response = await HttpClient.post(Api.updateLoginPwd1, data: {
        "account": account,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      if (response.data is String) {
        return response.data as String;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 第二步：发送验证码
  static Future<bool?> updateLoginPwd2({required String sid}) async {
    try {
      final response = await HttpClient.post(
        Api.updateLoginPwd2,
        data: {
          "sid": sid,
        },
      );
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  /// 验证验证码
  static Future<bool?> updateLoginPwd3({
    required String sid,
    required String code,
  }) async {
    try {
      final response = await HttpClient.post(Api.updateLoginPwd3, data: {
        "sid": sid,
        "code": code,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  /// 找回密码第四步：重置密码
  /// 设置新密码
  static Future<bool?> updateLoginPwd4({
    String? sid,
    required String oldPwd,
    required String newPwd,
  }) async {
    try {
      final response = await HttpClient.post(Api.updateLoginPwd4, data: {
        if (sid != null) "sid": sid,
        "old_pwd": oldPwd,
        "new_pwd": newPwd,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  /// 第一步：验证账号
  static Future<LoginInfo?> loginStep1(String account, String password) async {
    try {
      final response = await HttpClient.post(Api.loginStep1, data: {
        "username": account,
        "password": password,
      });
      if (response.status == false) {
        var info = LoginInfo.fromJson(jsonDecode(response.message ?? ''));
        info.failed = true;
        return info;
      }
      return LoginInfo.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  /// 第二步：验证手机号
  static Future<bool?> loginStep2(
      String sid, String phoneDigits, bool isFirst) async {
    try {
      final response = await HttpClient.post(
        Api.loginStep2,
        data: {
          "sid": sid,
          "phone_digits": phoneDigits,
        },
      );
      if (response.status == false) {
        if (isFirst) {
          AppUtils.showToastForResponse(response.message);
        }
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  /// 发送验证码
  static Future<bool?> loginStep3(String sid) async {
    try {
      final response = await HttpClient.post(Api.loginStep3, data: {
        "sid": sid,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  /// 验证验证码
  static Future<String?> loginStep4(String sid, String sms) async {
    try {
      final response = await HttpClient.post(Api.loginStep4, data: {
        "sid": sid,
        "sms": sms,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      if (response.data is String) {
        return response.data as String;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 第一步：验证账号
  static Future<String?> accountBindStep1(String phone) async {
    try {
      final response = await HttpClient.post(Api.accountBindStep1, data: {
        "phone": phone,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      if (response.data is String) {
        return response.data as String;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 第二步：向验证手机号发送短信验证码
  static Future<bool?> accountBindStep2(String sid) async {
    try {
      final response = await HttpClient.post(Api.accountBindStep2, data: {
        "sid": sid,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  /// 取款卡绑定-第三步-验证验证码
  static Future<bool?> accountBindStep3(Map params) async {
    try {
      final response =
          await HttpClient.post(Api.accountBindStep3, data: params);
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  /// 绑卡
  static Future<bool?> accountBindStep4(Map params) async {
    try {
      final response =
          await HttpClient.post(Api.accountBindStep4, data: params);
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  /// 第一步
  static Future<String?> infoViewStep1(String account) async {
    try {
      final response = await HttpClient.post(Api.infoViewStep1, data: {
        "contact": account,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      if (response.data is String) {
        return response.data as String;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> infoViewStep2(String sid, String code, int type,
      {String? accountId}) async {
    try {
      final response = await HttpClient.post(Api.infoViewStep2, data: {
        "sid": sid,
        "code": code,
        "type": type,
        if (accountId != null) "account_id": accountId,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      if (response.data is String) {
        return response.data as String;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  //公告列表
  static Future<RespMessageModel?> queryNoticeAll(
      int noticeType, int page) async {
    try {
      final response =
          await HttpClient.get(Api.noticeListAll, queryParameters: {
        'notice_type': noticeType, //0=全部，1=普通，2=特殊
        'page_size': 20,
        'page': page,
      });
      if (response.status == false) {
//        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return RespMessageModel.fromJson(response.data);
    } catch (e) {
      print("object123456  $e");
      return null;
    }
  }

  //公告列表
  static Future<RespMessageModel?> queryNotice(int noticeType, int page) async {
    try {
      final response = await HttpClient.get(Api.noticeListV2, queryParameters: {
        'notice_type': noticeType, //0=全部，1=普通，2=特殊
        'page_size': 20,
        'page': page,
      });
      if (response.status == false) {
//        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return RespMessageModel.fromJson(response.data);
    } catch (e) {
      print("object123456  $e");
      return null;
    }
  }

  //公告
  static Future<bool?> readNotices(
    List<String>? readIds,
    bool? isReadAll,
  ) async {
    try {
      final response = await HttpClient.post(Api.noticeReadListV2, data: {
        'read_ids': readIds,
//        'is_read_all': isReadAll,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  //公告
  static Future<bool?> deleteNotices(
    List<String>? readIds,
    bool? isDeleteAll,
  ) async {
    try {
      final response = await HttpClient.post(Api.noticeDeleteV2, data: {
        'delete_ids': readIds,
//        'is_delete_all': isDeleteAll,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  //消息列表V2
  static Future<RespMessageModel?> queryMessages(
      int messageType, int page) async {
    try {
      final response =
          await HttpClient.get(Api.messageListV2, queryParameters: {
        'message_type': messageType, //消息类型筛选：0=全部，1=通知，2=活动，3=充提
        'page_size': 20,
        'page': page,
      });
      if (response.status == false) {
        //       AppUtils.showToastForResponse(response.message);
        return null;
      }
      return RespMessageModel.fromJson(response.data);
    } catch (e) {
      print("object123456  $e");
      return null;
    }
  }

  //读取消息列表V2
  static Future<bool?> readMessages(
      List<String>? readIds, bool? isReadAll) async {
    try {
      final response = await HttpClient.post(Api.messageReadListV2, data: {
        'read_ids': readIds,
//        'is_read_all': isReadAll,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  //消息列表V2
  static Future<bool?> deleteMessages(
    List<String>? readIds,
    bool? isDeleteAll,
  ) async {
    try {
      final response = await HttpClient.post(Api.messageDeleteV2, data: {
        'delete_ids': readIds,
//        'is_delete_all': isDeleteAll,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  //消息列表
  static Future<RespMessageModel?> queryPrivateMessages(
      int messageType, int page) async {
    try {
      final response = await HttpClient.get(Api.messageList, queryParameters: {
        'message_type': messageType, //消息类型筛选：0=全部，1=通知，2=活动，3=充提
        'page_size': 20,
        'page': page,
      });
      if (response.status == false) {
//        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return RespMessageModel.fromJson(response.data);
    } catch (e) {
      print("object123456  $e");
      return null;
    }
  }

  //读取消息列表
  static Future<bool?> readPrivateMessages(
      List<String>? readIds, bool? isReadAll) async {
    try {
      final response = await HttpClient.post(Api.messageReadList, data: {
        'read_ids': readIds,
//        'is_read_all': isReadAll,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  //消息列表
  static Future<bool?> deletePrivateMessages(
    List<String>? readIds,
    bool? isDeleteAll,
  ) async {
    try {
      final response = await HttpClient.post(Api.messageDelete, data: {
        'delete_ids': readIds,
//        'is_delete_all': isDeleteAll,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.status;
    } catch (e) {
      return null;
    }
  }

  //消息列表
  static Future<RespCaptchaCode?> captchaVerify(
    String ticket,
    String randstr,
    String username,
  ) async {
    try {
      final response = await HttpClient.post(Api.captchaVerify, data: {
        'captcha_type': 9,
        'ticket': ticket,
        'randstr': randstr,
        'username': username,
      });
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return RespCaptchaCode.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  //忘记支付密码第一步（验证手机号）
  static Future<String?> payPwdResetStep1(String phone) async {
    try {
      final response = await HttpClient.post(Api.resetStep1, data: {
        'phone': phone,
      });
      if (!response.status) {
        AppUtils.showToastForResponse(response.message, ifEmpty: '手机号校验失败！');
      }
      if (response.data is String) {
        return response.data as String;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  //忘记支付密码第二步（发送验证码）
  static Future<bool?> payPwdResetStep2(String sid) async {
    try {
      final response = await HttpClient.post(Api.resetStep2, data: {
        'sid': sid,
      });
      if (!response.status) {
        AppUtils.showToastForResponse(response.message);
        return false;
      }
      return true;
    } catch (e) {
      return null;
    }
  }

  //忘记支付密码第三步（验证验证码）
  static Future<bool?> payPwdResetStep3(String sid, String code) async {
    try {
      final response = await HttpClient.post(Api.resetStep3, data: {
        'sid': sid,
        'code': code,
      });
      if (!response.status) {
        AppUtils.showToastForResponse(response.message);
        return false;
      }
      return true;
    } catch (e) {
      return null;
    }
  }

  static Future<RespServiceModel?> customerService(int action) async {
    try {
      var response = await HttpClient.get(Api.customerservice,
          queryParameters: {'action': action});
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }

      return RespServiceModel.fromJson(response.data);
    } catch (e) {}
    return null;
  }

  //删除账户1
  static Future<String?> deleteAccountStep1(String id, String account) async {
    try {
      final response = await HttpClient.post(Api.accountDeleteStep1, data: {
        'id': id,
        'account': account,
      });
      if (!response.status) {
        AppUtils.showToastForResponse(response.message, ifEmpty: '手机号校验失败！');
      }
      if (response.data is String) {
        return response.data as String;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  //删除账户2
  static Future<bool?> deleteAccountStep2(String sid, String code) async {
    try {
      final response = await HttpClient.post(Api.accountDeleteStep2, data: {
        'sid': sid,
        'code': code,
      });
      if (!response.status) {
        AppUtils.showToastForResponse(response.message);
        return false;
      }
      return true;
    } catch (e) {
      return null;
    }
  }

  static Future<List<MethodModel>?> queryWithdrawMethodList() async {
    try {
      AppUtils.show();
      final response = await HttpClient.get(Api.channelWithdrawList);
      AppUtils.dismiss();
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message, ifEmpty: '网络请求失败'.tr);
        return null;
      }
      if (response.data is List) {
        return List<MethodModel>.from(
          response.data.map((item) => MethodModel.fromJson(item)),
        );
      }
      return null;
    } catch (e) {
      AppUtils.dismiss();
      return null;
    }
  }

  static Future<bool?> cancelTransaction(String id, String reason) async {
    try {
      AppUtils.show();
      final response = await HttpClient.post(Api.transactionCancel, data: {
        'id': id,
        'reason': reason,
      });
      AppUtils.dismiss();
      if (!response.status) {
        AppUtils.showToastForResponse(response.message);
      }
      return response.status;
    } catch (e) {
      AppUtils.dismiss();
      return null;
    }
  }

  static Future<String?> gameInit(String platformId, String gameId) async {
    try {
      AppUtils.show();
      String currency = UserService.to.state.currencyType.code;
      var response = await HttpClient.get(Api.launch, queryParameters: {
        "pid": platformId,
        "game_id": gameId,
        "cur": currency
      });
      AppUtils.dismiss();
      if (!response.status) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return response.data;
    } catch (e) {
      AppUtils.dismiss();
      return null;
    }
  }
}
