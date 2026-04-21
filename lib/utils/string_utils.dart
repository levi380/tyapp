import 'package:intl/intl.dart';

class StringUtils {
  static Map<String, String>? parseParams(String query) {
    if (query.isEmpty) {
      return null;
    }
    final params = Uri.splitQueryString(query);
    return params;
  }

  static List<String> extractParts(String text) {
    final RegExp reg = RegExp(r'^(.*?)\{(.*?)\}(.*)$');
    final match = reg.firstMatch(text);
    if (match != null) {
      return [match.group(1) ?? '', match.group(2) ?? '', match.group(3) ?? ''];
    }
    return ['', '', ''];
  }

  /// 展示后面四个字符
  static String maskCard(String cardNo) {
    String number = cardNo.replaceAll(" ", "");
    if (number.length <= 8) return cardNo;
    return cardNo.replaceRange(0, cardNo.length - 4, "**** **** **** ");
  }

  /// 展示前面四个字符和后面四个字符
  static String frontFourBackFourCard(String card) {
    String number = card.replaceAll(" ", "");
    if (number.length <= 8) return card;
    String first = number.substring(0, 4);
    String last = number.substring(number.length - 4);
    return "$first **** $last";
  }

  ///校验邮箱格式是否正确
  static bool isValidEmail(String email) {
    final emailReg = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailReg.hasMatch(email);
  }

  ///判断 字符串是否以数字开头
  static bool startsWithNumber(String value) {
    return value.isNotEmpty && RegExp(r'[0-9]').hasMatch(value[0]);
  }

  // 创建一个数字格式化实例
  static NumberFormat formatter = NumberFormat('#.##');

  static String removeTrailingZeros(num number) {
    return formatter.format(number);
  }
}
