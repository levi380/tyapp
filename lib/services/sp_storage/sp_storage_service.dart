import 'dart:convert';

import 'package:filbet/services/sp_storage/storage_key.dart';
import 'package:filbet/src/home/appconfig_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:filbet/common/language.dart';

class SpStorage extends GetxService {
  static SpStorage get sp => Get.find();

  static late SharedPreferences _spInstance;
  static late SharedPreferences spInstance1;

  Future<SpStorage> init() async {
    debugPrint('SpStorage init');
    _spInstance = await SharedPreferences.getInstance();

    return this;
  }

  static String? get kdate {
    var val = _spInstance.getString(StorageKey.kdate);
    return val;
  }

  static Future<bool> setkdate(String jwt) {
    return _spInstance.setString(StorageKey.kdate, jwt);
  }

  static String? get homeAdsDate {
    var val = _spInstance.getString(StorageKey.homeAdsDate);
    return val != null ? '$val' : null;
  }

  static Future<bool> setHomeAdsDate(String stats) {
    return _spInstance.setString(StorageKey.homeAdsDate, stats);
  }

  static String? get jwtToken {
    var val = _spInstance.getString(StorageKey.tokenKey);
    return val != null ? '$val' : null;
  }

  static Future<bool> setToken(String jwt) {
    return _spInstance.setString(StorageKey.tokenKey, jwt);
  }

  static bool get hibalance {
    var val = _spInstance.getBool(StorageKey.hibalance);
    return val != null ? val : true;
  }

  static Future<bool> sethibalance(bool jwt) {
    return _spInstance.setBool(StorageKey.hibalance, jwt);
  }

  static Future<bool> removeToken() {
    return _spInstance.remove(StorageKey.tokenKey);
  }

  ///更新本地语言
  static Future<bool> updateAppLocalLanguage(String language) {
    return setString(StorageKey.appLocalLanguage, language);
  }

  ///获取本地语言
  static String getAppLocalLanguage() {
    return _spInstance.getString(StorageKey.appLocalLanguage) ?? '';
  }

  static SplashModel? get getSplashModel {
    Language languagemodel = SpStorage.getAppLocalLanguage() == null
        ? Language.zh_cn
        : Language.fromAbbr(SpStorage.getAppLocalLanguage());
        String key = StorageKey.splashModel + languagemodel.code;
    final result =
        _spInstance.getString(key);
    return result != null ? SplashModel.fromJson(json.decode(result)) : null;
  }

  static Future<bool> setSplashModel(SplashModel? model) {
    Language languagemodel = SpStorage.getAppLocalLanguage() == null
        ? Language.zh_cn
        : Language.fromAbbr(SpStorage.getAppLocalLanguage());
    ////
    if (model == null) {
      return _spInstance.remove(StorageKey.splashModel + languagemodel.code);
    }
    return _spInstance.setString(
        StorageKey.splashModel + languagemodel.code, json.encode(model));
  }

  //登录信息记录
  static void setRememberMe(Map<String, dynamic> form) {
    if (SpStorage.getBool(StorageKey.rememberMeState)) {
      var value = json.encode(form);
      _spInstance.setString(StorageKey.rememberMe, value);
    } else {
      _spInstance.remove(StorageKey.rememberMe);
    }
  }

  static Map<String, dynamic>? get getRememberMe {
    var result = _spInstance.getString(StorageKey.rememberMe);

    if (!SpStorage.getBool(StorageKey.rememberMeState)) {
      result = null;
    }
    return result != null ? json.decode(result) : null;
  }

  static bool containsKey(String key) {
    return _spInstance.containsKey(key);
  }

  static Future<bool> remove(String key) async {
    return _spInstance.remove(key);
  }

  static Future<bool> removeSplashModel() async {
    Language languagemodel = SpStorage.getAppLocalLanguage() == null
        ? Language.zh_cn
        : Language.fromAbbr(SpStorage.getAppLocalLanguage());
    return _spInstance.remove(StorageKey.splashModel + languagemodel.code);
  }

  static Future<bool> clear() async {
    return _spInstance.clear();
  }

  static int? getInt(String key) {
    return _spInstance.getInt(key);
  }

  static bool getBool(String key) {
    ///默认深色
    if ((key == StorageKey.appDarkTheme) |
        (key == StorageKey.rememberMeState) |
        (key == StorageKey.isFristApp)) {
      return _spInstance.getBool(key) ?? true;
    }
    return _spInstance.getBool(key) ?? false;
  }

  static double? getDouble(String key) {
    return _spInstance.getDouble(key);
  }

  static String getString(String key) {
    return _spInstance.getString(key) ?? '';
  }

  static List<String> getStringList(String key) {
    return _spInstance.getStringList(key) ?? [];
  }

  static Future<bool> setInt(String key, int value) async {
    return _spInstance.setInt(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    return _spInstance.setBool(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    return _spInstance.setDouble(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    return _spInstance.setString(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    return _spInstance.setStringList(key, value);
  }
}
