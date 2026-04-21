import 'package:filbet/api/api.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/common/currency.dart';

String staticImageResolver(String? imgUrl) {
  if (imgUrl != null && imgUrl != '' && !imgUrl.contains('http')) {
    final staticUrl = Api.imageurl;
    if (imgUrl.contains("%lang%")) {
     
      imgUrl =
          imgUrl.replaceAll("%lang%", GlobalService.to.state.language.code);
    }

    if (staticUrl.endsWith('/') && imgUrl.startsWith('/')) {
      return staticUrl + imgUrl.replaceFirst('/', '');
    } else if (!staticUrl.endsWith('/') && !imgUrl.startsWith('/')) {
      return '$staticUrl/$imgUrl';
    }
    return (staticUrl + imgUrl);
  }

  return imgUrl?.trim() ?? '';
}

String staticImageurl(String? imgUrl) {
  if (imgUrl != null && imgUrl != '' && !imgUrl.contains('http')) {
    final staticUrl = Api.imageurl;

    if (staticUrl.endsWith('/') && imgUrl.startsWith('/')) {
      return staticUrl + imgUrl.replaceFirst('/', '');
    } else if (!staticUrl.endsWith('/') && !imgUrl.startsWith('/')) {
      return '$staticUrl/$imgUrl';
    }
    return (staticUrl + imgUrl);
  }

  return imgUrl?.trim() ?? '';
}

extension StringsUtil on String? {
  String staticUrl() {
    return staticImageResolver(this);
  }

// 中文名称 货币代码 官方符号 符号位置
// 人民币 CNY ¥  左侧（¥100）
// 美元 USD $ 左侧（$100）
// 越南盾 VND ₫ 右侧（100₫）
// 港元 HKD HK$ 左侧（HK$100）
// 韩元 KRW ₩ 左侧（₩100）
// 印尼盾 IDR Rp 左侧（Rp100）
// 泰铢 THB ฿ 左侧（฿100）
// 墨西哥比索 MXN Mex$ 左侧（Mex$100 ）
// 巴西雷亚尔 BRL R$ 左侧（R$100）
// 印度卢比 INR ₹ 左侧（₹100）
// 菲律宾比索 PHP ₱ 左侧（₱100）
  String strforcurry() {
    return strforcurrencyType(this);
  }
}


String strforcurrencyCode(String? url ,int code) {
  String text = url ?? "";

  Currency currency = Currency.fromCodeInt(code);
  switch (currency) {
    case Currency.rmb:
      return '¥' + text;
    // case Currency.usd:
    //   return '\$' + text;
    // case Currency.vnd:
    //   return text + '₫';
    // case Currency.hkd:
    //   return 'HK\$' + text;
    // case Currency.krw:
    //   return '₩' + text;
    // case Currency.idr:
    //   return 'Rp' + text;
    // case Currency.thb:
    //   return '฿' + text;
    // case Currency.mxn:
    //   return 'Mex\$' + text;
    // case Currency.brl:
    //   return 'R\$' + text;
    // case Currency.inr:
    //   return '₹' + text;
    // case Currency.php:
    //   return '₱' + text;
  }
}


String strforcurrencyType(String? url) {
  String text = url ?? "";

  switch (UserService.to.state.currencyType) {
    case Currency.rmb:
      return '¥$text';
    // case Currency.usd:
    //   return '\$' + text;
    // case Currency.vnd:
    //   return text + '₫';
    // case Currency.hkd:
    //   return 'HK\$' + text;
    // case Currency.krw:
    //   return '₩' + text;
    // case Currency.idr:
    //   return 'Rp' + text;
    // case Currency.thb:
    //   return '฿' + text;
    // case Currency.mxn:
    //   return 'Mex\$' + text;
    // case Currency.brl:
    //   return 'R\$' + text;
    // case Currency.inr:
    //   return '₹' + text;
    // case Currency.php:
    //   return '₱' + text;
  }
}




int parseAvatarIndex(String? avatar) {
  //"/avatars/7.webp"
  if (avatar == null || avatar.isEmpty) {
    return 0; // 默认返回索引0
  }

  try {
    // 使用正则表达式匹配数字
    final RegExp regExp = RegExp(r'(\d+)\.webp');
    final Match? match = regExp.firstMatch(avatar);

    if (match != null && match.groupCount > 0) {
      // 提取第一个捕获组（数字部分）
      return int.parse(match.group(1)!);
    }

    // 如果正则匹配失败，尝试手动解析
    // 获取文件名部分（最后一个 "/" 之后的内容）
    final String fileName = avatar.split('/').last;
    // 移除 ".webp" 扩展名
    final String nameWithoutExt = fileName.replaceAll('.webp', '');
    // 尝试解析为整数
    return int.parse(nameWithoutExt);
  } catch (e) {
    // 解析失败时返回默认值
    return 0;
  }
}

String amountnojiStr(String item) {
  String text =
      "${(double.tryParse(item ?? 0.toString()) ?? 0).abs().toStringAsFixed(2)}"
          .strforcurry();
  if ((double.tryParse(item ?? 0.toString()) ?? 0) >= 0) {
    text = "" + text;
  } else {
    text = "-" + text;
  }

  return text;
}


String amountnoStr(String item) {
  String text =
      "${(double.tryParse(item ?? 0.toString()) ?? 0).abs().toStringAsFixed(2)}"
          .strforcurry();
  if ((double.tryParse(item ?? 0.toString()) ?? 0) >= 0) {
    text = "+" + text;
  } else {
    text = "-" + text;
  }

  return text;
}
