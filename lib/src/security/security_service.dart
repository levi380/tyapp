import 'dart:convert';

import 'package:filbet/api/api.dart';
import 'package:filbet/http/exception_user_message.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/src/security/Address_provinces_model.dart';
import 'package:filbet/src/security/Bank_list_model.dart';
import 'package:filbet/src/security/address_areas_model.dart';
import 'package:filbet/src/security/address_cities_model.dart';
import 'package:filbet/src/security/security_controller.dart';
import 'package:filbet/src/security/security_data_model.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/fp.dart';

class SecurityService {
  Future<SecurityDataModel> loadSecurityData() async {
    final response = await HttpClient.post(Api.securityLoad);
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is Map) {
      return compose(
        SecurityDataModel.fromJson,
        Map<String, dynamic>.from,
      )(response.data);
    } else {
      throw Exception('Invalid response format for security data');
    }
  }

  Future<bool> setLoginPassword(
    String oldPassword,
    String newPassword, {
    String? securityCode,
  }) async {
    final response = await HttpClient.post(
      Api.securitySetLoginPassword,
      data: {
        'old_pwd': oldPassword,
        'new_pwd': newPassword,
        if (securityCode != null) 'sec_code': securityCode,
      },
    );
    if (!response.status) {
      throw response.error!;
    }
    return true;
  }

  Future<bool> setPayPwd(
    String newPassword, {
    String? oldPassword,
    String? sid,
  }) async {
    final response = await HttpClient.post(
      Api.resetStep4,
      data: {
        'new_pwd': newPassword,
        if (oldPassword != null) 'old_pwd': oldPassword,
        if (sid != null) 'sid': sid,
      },
    );
    if (!response.status) {
      throw response.error!;
    }
    return true;
  }

  Future<bool> sendEmailBindingVerifyCode(String email) async {
    final response = await HttpClient.post(
      Api.securityEmailBindingCode,
      data: {
        'email': email,
      },
    );
    if (!response.status) {
      throw response.error!;
    }
    return true;
  }

  Future<bool?> bindEmail(String email, String code, {String? secCode}) async {
    try {
      AppUtils.show();
      final response = await HttpClient.post(Api.securityEmailBind, data: {
        'email': email,
        'bind_code': code,
        if (secCode != null) 'sec_code': secCode,
      });
      AppUtils.dismiss();
      if (response.status == false) {
        final ex = response.error;
        AppUtils.showToast(
          ex != null
              ? exceptionMessageForUser(ex)
              : nonEmptyMessageOr(
                  response.message ?? response.data?.toString(),
                  defaultMessage: '绑定未成功，请重试',
                ),
        );
      }
      return response.status;
    } catch (e) {
      AppUtils.dismiss();
      return null;
    }
  }

  Future<bool> unbindEmail({String? secCode}) async {
    final response = await HttpClient.post(
      Api.securityEmailUnbind,
      data: {
        if (secCode != null) 'sec_code': secCode,
      },
    );
    if (!response.status) {
      throw response.error!;
    }
    return true;
  }

  Future<bool> updateEmail(
    String email,
    String bindCode, {
    String? secCode,
  }) async {
    final response = await HttpClient.post(Api.securityEmailUpdate, data: {
      'email': email,
      'bind_code': bindCode,
      if (secCode != null) 'sec_code': secCode,
    });
    if (!response.status) {
      throw response.error!;
    }
    return true;
  }

  Future<bool> sendSecurityCodeToEmail() async {
    final response = await HttpClient.post(Api.securitySendEmailSecurityCode);
    if (!response.status) {
      throw response.error!;
    }
    return true;
  }

  Future<bool> updateVerifyType(
    SecuritySecondaryVerifyType verifyType, {
    String? securityCode,
  }) async {
    final response = await HttpClient.post(Api.securityVerifyTypeUpdate, data: {
      'verify_type': verifyType.code,
      if (securityCode != null) 'sec_code': securityCode,
    });
    if (!response.status) {
      throw response.error!;
    }
    return true;
  }

  Future<bool> bindGoogleAuthenticator(
    String googleCode,
    String googleSecret, {
    String? secCode,
  }) async {
    final response = await HttpClient.post(Api.securityGoogleBind, data: {
      if (secCode != null) 'sec_code': secCode,
      'google_code': googleCode,
      'google_secret': googleSecret,
    });
    return Future.value(response.status);
  }

  Future<bool> unbindGoogleAuthenticator({String? secCode}) async {
    final response = await HttpClient.post(Api.securityGoogleUnbind, data: {
      if (secCode != null) 'sec_code': secCode,
    });
    return Future.value(response.status);
  }

  Future<bool> updateGoogleAuthenticator(
    String googleCode,
    String googleSecret, {
    String? secCode,
  }) async {
    final response = await HttpClient.post(Api.securityGoogleUpdate, data: {
      'sec_code': secCode,
      'google_code': googleCode,
      'google_secret': googleSecret,
    });
    return Future.value(response.status);
  }

  Future<List<AddressProvincesModel>> getAddressProvinces() async {
    try {
      final response = await HttpClient.get(Api.provinces);
      if (response.status == false) {
        return [];
      }
      List<dynamic> rawList = response.data ?? [];
      return rawList
          .map((e) =>
              AddressProvincesModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<AddressCitiesModel>> getAddressCities(String provinceCode) async {
    try {
      final response = await HttpClient.get(Api.cities, queryParameters: {
        "province_code": provinceCode ?? "",
      });
      if (response.status == false) {
        return [];
      }
      List<dynamic> rawList = response.data ?? [];
      return rawList
          .map((e) => AddressCitiesModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<AddressAreasModel>> getAddressAreas(String cityCode) async {
    try {
      final response = await HttpClient.get(Api.areas, queryParameters: {
        "city_code": cityCode ?? "",
      });
      if (response.status == false) {
        return [];
      }
      List<dynamic> rawList = response.data ?? [];
      return rawList
          .map((e) => AddressAreasModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<BankListModel>> getBankList() async {
    try {
      final response = await HttpClient.get(Api.bankList);
      if (response.status == false) {
        return [];
      }
      List<dynamic> rawList = response.data ?? [];
      return rawList
          .map((e) => BankListModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> getCountryCodeList() async {
    try {
      final response = await HttpClient.get(Api.countryCodeList);
      if (response.status == false) {
        throw response.error!;
      }
      List<dynamic> fruits = response.data ?? [];
      return List<String>.from(fruits);
    } catch (e) {
      throw Exception('Invalid response data');
    }
  }

  Future<bool> getSendBindCode(String phone, String country) async {
    final response = await HttpClient.post(Api.sendBindCode, data: {
      'phone': phone,
      'country': country,
    });
    if (!response.status) {
      throw response.error!;
    }
    return response.status;
  }

  Future<bool> postPhoneVerify(String phoneDigitsy) async {
    final response = await HttpClient.post(Api.phoneVerify, data: {
      'phone_digits': phoneDigitsy,
    });
    if (!response.status) {
      throw response.error!;
    }
    return response.status;
  }

  Future<bool> postPhoneBind(String phone, String bindCode) async {
    final response = await HttpClient.post(Api.phoneBind, data: {
      'phone': phone,
      'bind_code': bindCode,
    });
    if (!response.status) {
      throw response.error!;
    }
    return response.status;
  }

  Future<bool> accountBindStep2(String sid) async {
    final response = await HttpClient.post(Api.accountBindStep2, data: {
      'sid': sid,
    });
    if (!response.status) {
      throw response.error!;
    }
    return response.status;
  }
}
