import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';

class FormatMoney {
  /// @description: 数字转中文
  /// @param {Integer} number 形如123的数字
  /// @return {String} 返回转换成的形如 一百二十三 的字符串
  static String numberToChinese(int number) {
    // 单位和字符映射表
    Map<String, String> t = {'units': '个十百千万@#%亿^&~', 'chars': '零一二三四五六七八九'};

    List<String> a = number.toString().split('');
    List<String> s = [];
    int j = a.length - 1;

    if (a.length > 12) {
      throw ArgumentError('too big');
    } else {
      for (int i = 0; i <= j; i++) {
        if (j == 1 || j == 5 || j == 9) {
          // 两位数 处理特殊的 1*
          if (i == 0) {
            if (a[i] != '1') s.add(t['chars']![int.parse(a[i])]);
          } else {
            s.add(t['chars']![int.parse(a[i])]);
          }
        } else {
          s.add(t['chars']![int.parse(a[i])]);
        }
        if (i != j) {
          s.add(t['units']![j - i]);
        }
      }
    }

    return s
        .join('')
        .replaceAllMapped(RegExp(r'零([十百千万亿@#%^&~])'), (match) {
          // 优先处理 零百 零千 等
          var d = match.group(1);
          int b = t['units']!.indexOf(d!);
          if (b != -1) {
            if (d == '亿') return d;
            if (d == '万') return d;
            if (a[j - b] == '0') return '零';
          }
          return '';
        })
        .replaceAll(RegExp(r'零+'), '零')
        .replaceAllMapped(RegExp(r'零([万亿])'), (match) {
          // 零百 零千处理后 可能出现 零零相连的 再处理结尾为零的
          var b = match.group(1);
          return b!;
        })
        .replaceAll(RegExp(r'亿[万千百]'), '亿')
        .replaceAll(RegExp(r'[零]$'), '')
        .replaceAllMapped(RegExp(r'([亿万])([一-九])'), (match) {
          var d = match.group(1);
          var b = match.group(2);
          int c = t['units']!.indexOf(d!);
          if (c != -1) {
            if (a[j - c] == '0') return '$d零$b';
          }
          return match.group(0)!;
        });
  }


  /// 将金额转化为千位符格式保留2位小数
  /// [num] 待格式化的金额
  /// 返回转化后的金额，例如 '64,464.95'
  static String formatMoney2(double? num) {
    try {
      if (num != null && num < 0) {
        num = 0;
      }
      num = (num ?? 0);
      String result = "";
      List<String> parts = num.toString().split(".");
      String num1 = parts[0];
      String num2 = parts.length > 1 ? parts[1] : "00";
      num2 = num2.padRight(2, "0").substring(0, 2);
      while (num1.length > 3) {
        result = ",${num1.substring(num1.length - 3)}$result";
        num1 = num1.substring(0, num1.length - 3);
      }
      if (num1.isNotEmpty) {
        num1 = "$num1$result";
      }
      return "$num1.$num2";
    } catch (error) {
      AppLogger.error(error);
      return "";
    }
  }

}
