import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_ty_app/app/utils/format_money_util.dart';
import 'dart:math';
import 'dart:io';

import 'package:get/get.dart';

import '../../generated/locales.g.dart';
import '../db/app_cache.dart';

// 简易深拷贝
Map clonedObject(obj) {
  return jsonDecode(jsonEncode(obj));
}

// 判断有值 只做if判断
bool hasValue(dynamic value) {
  return value != null;
}

bool isString(dynamic value) {
  return hasValue(value) && value is String;
}

// 字符串有值
bool hasStrValue(dynamic value) {
  return isString(value) && value.isNotEmpty;
}

bool isList(dynamic value) {
  return hasValue(value) && value is List;
}

// 数组 并且有值
bool hasValList(dynamic value) {
  return isList(value) && value.isNotEmpty;
}

// 字符串数组 并且有值
bool isStrList(dynamic value) {
  return hasValList(value) && hasStrValue(value[0]);
}

bool isFunction(dynamic value) {
  return hasValue(value) && value is Function;
}

bool isMap(dynamic value) {
  return hasValue(value) && value is Map;
}

// hasOwnProperty
bool hasKey(dynamic obj, dynamic key) {
  if (!hasValue(obj)) return false;
  if (obj is Map) {
    return obj.containsKey(key);
  } else if (obj is List) {
    if (key is int) {
      return key >= 0 && key < obj.length;
    }
  }
  return false;
}

// 解密 单个字符串
String jiemiWord(String word, key) {
  String res = word;
  try {
    final iv = IV.fromLength(16); // 初始化向量，长度为 16
    final encrypter = Encrypter(
        AES(Key.fromUtf8(key), mode: AESMode.ecb)); // 使用 AESMode.ecb 模式
    final decrypted = encrypter.decrypt64(word, iv: iv);
    res = decrypted.toString();
  } finally {
    return res;
  }
}

// api参数域名加密
String apiEncrypt(String apiStr) {
  // 解密url 内 api 字段使用的 key
  final decryptKeyUrlApi = Key.fromUtf8("OBTY20220712OBTY");
  final iv = IV.fromLength(16); // 如果使用 ECB 模式，则 IV 可以是任何值，因为它不会被使用

  final encrypter = Encrypter(AES(decryptKeyUrlApi, mode: AESMode.ecb));

  String res = '';

  if (apiStr.isNotEmpty) {
    final encrypted = encrypter.encrypt(apiStr, iv: iv);
    res = encrypted.base64;
  }

  return res;
}

String decryptWithAes(String encryptedText, String userId) {
  ///生成 AES 密钥
  final key =
      Key.fromUtf8((userId + List.filled(16, '0').join('')).substring(0, 16));
  final iv = IV.fromLength(16); // ECB 模式不需要 IV，但可以填充

  // 创建 AES 解密器
  final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

  // 确保输入为 Base64 编码
  final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
  return decrypted;
}

// 域名拼接 防止参数不带/
String composeUrl(String a, String b) {
  if (!a.endsWith('/')) {
    a += '/';
  }
  if (b.startsWith('/')) {
    b = b.substring(1);
  }
  return a + b;
}

String createGcuuid({int num = 18}) {
  List<String> strList =
      "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
          .split('');
  final len = strList.length;
  String uuid = quid();

  // 添加当前时间戳和随机数作为种子
  uuid += DateTime.now().millisecondsSinceEpoch.toString();
  uuid += Random().nextInt(10000).toString();

  for (int index = 0; index < num; index++) {
    uuid += strList[Random().nextInt(len)];
  }
  return uuid;
}

String quid() {
  var s = '';
  for (var i = 0; i < 9; i++) {
    s += ((Random().nextDouble() * 16).floor()).toRadixString(16);
  }
  return s;
}

/**
 * 设备3:安卓，4:iOS ，5:其他设备
 */
int getDevice() {
  int device = 5;
  if (Platform.isAndroid) {
    device = 3;
  } else if (Platform.isIOS) {
    device = 4;
  } else if (Platform.isWindows) {
    //传5电竞投注可能会报错
    device = 2;
  }
  return device;
}

/**
 * 金额两位小数补零
 */
String setAmount(String amount) {
  String changeAmount = amount;
  if (amount.isNotEmpty) {
    if (amount.contains('.')) {
      List<String> split = amount.split('.');
      if (split[0].isNotEmpty && split[1].isNotEmpty) {
        if (split[1].length < 2) {
          changeAmount = amount + "0";
        }
      }
    } else {
      changeAmount = amount + ".00";
    }
  }
  return changeAmount;
}

/**
 * 金额两位小数补零，个位数超过3个补，号
 */
String formatNumber(String input) {
  // 尝试将输入字符串解析为数字
  double? number = double.tryParse(input);

  // 如果解析失败，返回 "0.00"
  if (number == null) {
    return "0.00";
  }

  // 记录负号
  String sign = number < 0 ? '-' : '';
  number = number.abs(); // 取绝对值

  // 转换为字符串并格式化为两位小数
  String formatted = number.toStringAsFixed(2);

  // 分割整数部分和小数部分
  List<String> parts = formatted.split('.');
  String integerPart = parts[0];
  String decimalPart = parts[1];

  // 添加千位分隔符
  StringBuffer buffer = StringBuffer();
  int length = integerPart.length;

  for (int i = 0; i < length; i++) {
    // 每3位添加一个逗号
    if (i > 0 && (length - i) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(integerPart[i]);
  }

  // 拼接整数部分和小数部分，添加负号
  return '$sign${buffer.toString()}.${decimalPart}';
}







bool isZh() {
  return Get.locale?.languageCode == 'zh';
}

// 过滤比赛赔率的方法
String filterMatchOdds(String? val) {
  if (val == null) return "";

  var obj = json.decode(val);
  if (obj is Map) {
    return FormatMoney.formatMoney2(double.tryParse(obj["1"]) ?? 0.0);
  } else {
    return FormatMoney.formatMoney2(obj);
  }
}

// 减法
// 原理：将浮点数转换为整数进行减法运算，运算结果再除以10的N次幂
// 例子：16.733+5.1232 ===> (167330-51232)÷10000
double subtract(double arg1, double arg2) {
  int r1 = arg1.toString().split(".")[1].length;
  int r2 = arg2.toString().split(".")[1].length;
  int m = pow(10, (r1 > r2 ? r1 : r2)).toInt(); // 将结果转换为int类型
  // 动态控制精度长度
  int n = r1 >= r2 ? r1 : r2;
  double result = ((arg1 * m - arg2 * m) / m);
  // 将结果转为字符串，并指定保留小数位数
  String resultString = result.toStringAsFixed(n);
  return double.parse(resultString);
}

// 乘法
// 原理：将浮点数转换为整数进行乘法运算，运算结果再除以10的N次幂
// 例子：45.123*6 ===> (45123*6000)÷1000
double multiplication(double arg1, double arg2) {
  int m = 0;
  String s1 = arg1.toString();
  String s2 = arg2.toString();
  try {
    m += s1.split(".")[1].length;
  } catch (e) {}
  try {
    m += s2.split(".")[1].length;
  } catch (e) {}
  int result = (double.parse(s1.replaceAll(".", "")) *
          double.parse(s2.replaceAll(".", "")))
      .toInt();
  return result / pow(10, m); // 这里直接使用了 pow 函数，不再需要 math 前缀
}

// 加法
// 原理：将浮点数转换为整数进行加法运算，运算结果再除以10的N次幂
// 例子：10.333+5.1232 ===> (103330+51232)÷10000
double addition(double arg1, double arg2) {
  int r1 = 0;
  int r2 = 0;
  int m = 0;
  try {
    r1 = arg1.toString().split(".")[1].length;
  } catch (e) {}
  try {
    r2 = arg2.toString().split(".")[1].length;
  } catch (e) {}
  m = pow(10, max(r1, r2)).toInt();
  return (arg1 * m + arg2 * m) / m;
}

//获取注单类型
String getBetType(int matchType, String langCode) {
  Map<int, Map<String, String>> dataSource = {
    1: {
      'zs': '赛前',
      'en': 'Prematch',
      'zh': '賽前',
      'tw': '賽前',
      'hk': '賽前',
      'pt': 'Pré-marcação',
      'ru': 'Прематч',
      'ko': '경기 전',
      'th': 'ก่อนการต่อสู้',
      'vi': 'Trước Trận',
      'es': 'Pre',
      'ms': 'PreGame',
      'ad': 'PreMatch',
      'mya': 'ပွဲအကြို',
      'ara': 'التداول المبكر',
      'hi': 'अग्रिम ट्रेड'
    },
    // 1: {
    //   'zs': '早盘',
    //   'en': 'Early',
    //   'zh': '早盤',
    //   'tw': '早盤',
    //   'hk': '早盤',
    //   'pt': 'Cedo',
    //   'ru': 'Рано',
    //   'ko': '이전',
    //   'th': 'ล่วงหน้า',
    //   'vi': 'Cược Sớm',
    //   'es': 'Temprano',
    //   'ms': 'Early',
    //   'ad': 'Awal',
    //   'mya': 'ပွဲကြို',
    //   'ara': 'التداول المبكر',
    //   'hi': 'अग्रिम ट्रेड',
    //},
    2: {
      'zs': '滚球',
      'en': 'In-Play',
      'zh': '滾球',
      'tw': '滾球',
      'hk': '滾球',
      'pt': 'Jogando',
      'ru': 'В игре',
      'ko': '인플레이',
      'th': 'ในการแข่งขัน',
      'vi': 'Trong Trận',
      'es': 'En juego',
      'ms': 'InPlay',
      'ad': 'InPlay',
      'mya': 'ကစားခြင်း။',
      'ara': 'أثناء اللعب',
      'hi': 'खेल चालू हैं'
    },
    3: {
      'zs': '冠军盘',
      'en': 'Outrights',
      'zh': '冠军盘',
      'tw': '冠軍盤',
      'hk': '冠軍盤',
      'pt': 'Juara',
      'ru': 'Итоги',
      'ko': '챔피언',
      'th': 'เดิมพันสุดท้าย',
      'vi': 'Chung Cuộc',
      'es': 'Directamente',
      'ms': 'Outrights',
      'ad': 'Juara',
      'mya': 'ချန်ပီယံ',
      'ara': 'رهانات طويلة الأجل',
      'hi': 'विजेता',
    }
  };
  var betType = dataSource[matchType]?[langCode] ?? '';
  return betType;
}



/*
注单显示的赔率类型：中文简体、繁体显示马来盘、印尼盘等名称，其它语言显示英文简称
 */
String getOrderMarketType(String marketType) {
  String? orderMarketType;
  if (marketType == "EU") {
    orderMarketType = LocaleKeys.odds_EU.tr;
    if (Get.locale?.languageCode == 'zh') {
      orderMarketType = LocaleKeys.odds_EU.tr;
    } else {
      orderMarketType = Locales.en_GB['odds_EU'];
    }
  } else if (marketType == "GB") {
    orderMarketType = LocaleKeys.odds_GB.tr;
    if (Get.locale?.languageCode == 'zh') {
      orderMarketType = LocaleKeys.odds_GB.tr;
    } else {
      orderMarketType = Locales.en_GB['odds_GB'];
    }
  } else if (marketType == "HK") {
    orderMarketType = LocaleKeys.odds_HK.tr;
    if (Get.locale?.languageCode == 'zh') {
      orderMarketType = LocaleKeys.odds_HK.tr;
    } else {
      orderMarketType = Locales.en_GB['odds_HK'];
    }
  } else if (marketType == "ID") {
    orderMarketType = LocaleKeys.odds_ID.tr;
    if (Get.locale?.languageCode == 'zh') {
      orderMarketType = LocaleKeys.odds_ID.tr;
    } else {
      orderMarketType = Locales.en_GB['odds_ID'];
    }
  } else if (marketType == "MY") {
    orderMarketType = LocaleKeys.odds_MY.tr;
    if (Get.locale?.languageCode == 'zh') {
      orderMarketType = LocaleKeys.odds_MY.tr;
    } else {
      orderMarketType = Locales.en_GB['odds_MY'];
    }
  } else if (marketType == "US") {
    orderMarketType = LocaleKeys.odds_US.tr;
    if (Get.locale?.languageCode == 'zh') {
      orderMarketType = LocaleKeys.odds_US.tr;
    } else {
      orderMarketType = Locales.en_GB['odds_US'];
    }
  }
  return orderMarketType ?? marketType;
}

/// 判断字符串是否包含中文
bool dbContainsChinese(String input) {
  final regex = RegExp(r'[\u4e00-\u9fa5]');
  return regex.hasMatch(input);
}

String replacedPercent(String percent, String inner) {
  /// 使用正则表达式替换所有 % 包裹的部分
  String replacedText = percent.replaceAllMapped(RegExp(r'%([^%]+)%'), (match) {
    return inner;
  });
  return replacedText;
}

String decodeHtmlEntities(String input) {
  return input
      .replaceAll('&nbsp;', ' ') // 转换空格
      .replaceAll('&lt;', '<') // 转换 <
      .replaceAll('&gt;', '>') // 转换 >
      .replaceAll('&amp;', '&') // 转换 &
      .replaceAll('&quot;', '"') // 转换 "
      .replaceAll('&apos;', "'")
      .replaceAll('\r', '\n'); // 转换 '
}

String getStaticDomain() {
  String env = StringKV.env.get() ?? "";
  if (env == '隔离') {
    return 'http://lspre-topic.dbsportxxx14bl5.com';
  }
  return 'https://topic.sportxxx1zx.com';
}



