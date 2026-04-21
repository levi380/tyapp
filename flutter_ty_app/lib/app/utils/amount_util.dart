import 'package:intl/intl.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9236b86d-2f93-40b7-a267-6fcfe0acb8fe-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  金额处理类  】】】
    【【【 AUTO_PARAGRAPH_TITLE 金额处理类  AmountUtil 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 金额处理类  AmountUtil
    - AmountUtil
    ```
    AmountUtil.toAmountSplit();
    /// 千分位加逗号，直接截取，而不是四舍五入
    AmountUtil.numberFormat();
    ```
    】】】
 *
 */

abstract class AmountUtil {

  static String toAmountSplit(String num) {
    String numStr = (num).toString();

    if (numStr.contains('.')) {
      List<String> parts = numStr.split('.');
      String integerPart = parts[0];
      String decimalPart = parts[1];

      String formattedInteger = integerPart.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
            (match) => '${match.group(1)},',
      );

      return '$formattedInteger.$decimalPart';
    } else {
      return numStr.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
            (match) => '${match.group(1)},',
      );
    }
  }
  /// 千分位加逗号，直接截取，而不是四舍五入
  static String numberFormat(dynamic data, {point = 2, comma = true}) {
    try {
      if (double.tryParse(data.toString()) == null) return '--';
      if (data == double.infinity) return '0.00';
      if (data == double.negativeInfinity) return '0.00';
      final dataStr = data.toString();
      String integer;
      String decimal;
      if (dataStr.contains('.')) {
        final List<String> splitArr = dataStr.split('.');
        integer = splitArr[0];
        decimal = splitArr[1].length > 1 ? splitArr[1].substring(0, point) : splitArr[1] + '0' * (point - 1);
      } else {
        integer = dataStr;
        decimal = '0' * point;
      }

      bool negative = integer.contains('-0');
      String format = comma ? '###,###,###' : '';
      integer = NumberFormat(format).format(int.parse(integer));
      if (negative && (integer.contains('-')) == false) {
        integer = '-' + integer;
      }
      return point == 0 ? integer : integer + '.' + decimal;
    } catch (_) {
      return '0.00';
    }
  }
}
