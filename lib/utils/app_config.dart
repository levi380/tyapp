import 'dart:convert';
import 'package:flutter/services.dart';

enum EnvType {
  prod,
  uat,
  fat,
  dev;

  /// 从字符串转换为 EnvType 枚举
  static EnvType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'prod':
      case 'production':
        return EnvType.prod;
      case 'uat':
        return EnvType.uat;
      case 'fat':
        return EnvType.fat;
      case 'dev':
      case 'development':
      default:
        return EnvType.dev;
    }
  }
}

class AppEnvConfig {
  final String appName;
  final String packageName;
  final String version;
  final String versionCode;
  String apiUrl;
  final String mqttUrl;
  final String adId;
  final EnvType envType;
  final List<String> urls;
  final List<String> onLineUrls;
  final List<String> onLineImgUrls;
  String imageUrl;

  AppEnvConfig({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.versionCode,
    required this.apiUrl,
    required this.mqttUrl,
    required this.adId,
    required this.envType,
    required this.urls,
    required this.onLineUrls,
    required this.onLineImgUrls,
    required this.imageUrl,
  });

  static late AppEnvConfig instance;

  static Future<void> load() async {
    const env = String.fromEnvironment('ENV', defaultValue: 'dev');
    final configString = await rootBundle.loadString('env/$env.json');
    final configJson = json.decode(configString);
    var appConfig = configJson["appConfig"];
    var envConfig = configJson["envConfig"];
    print("环境数据===${configJson}");
    List<String> imageUrls = (envConfig['onLineImgUrls'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    instance = AppEnvConfig(
      //获取App配置数据
      appName: appConfig['appName'],
      packageName: appConfig['packageName'],
      versionCode: appConfig['versionCode'],
      version: appConfig['version'],

      //获取环境数据
      apiUrl: envConfig['api']??'',
      mqttUrl: envConfig['mqtt'],
      adId: envConfig['adId'],
      envType: EnvType.fromString(envConfig['env'] ?? 'dev'),
      urls: (envConfig['urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      onLineUrls: (envConfig['onLineUrls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      onLineImgUrls: imageUrls,
      imageUrl:
          imageUrls.isNotEmpty ? imageUrls[0] : 'https://h5-img.skbet.app',
    );
  }
}
