import 'package:intl/intl.dart';


// 保留千分位 + 最多 2 位小数（无小数时不显示）
String toThousands(String? value) {
  if (value == null || value.isEmpty) return '0';
  try {
    final doubleValue = double.parse(value);
    final formatter = NumberFormat('#,##0.##');
    return formatter.format(doubleValue);
  } catch (e) {
    return '0';
  }
}

String removeZero(String? value) {
  if (value == null || value.isEmpty) return '0';
  try {
    final doubleValue = double.parse(value);
    final formatter = NumberFormat('#0.##');
    return formatter.format(doubleValue);
  } catch (e) {
    return '0';
  }
}

// 扩展版 (给 String 用)
extension StringThousands on String {
  String toThousands() {
    if (isEmpty) return '0';
    try {
      final doubleValue = double.parse(this);
      final formatter = NumberFormat('#,##0.##');
      return formatter.format(doubleValue);
    } catch (e) {
      return '0';
    }
  }
}

extension DoubleThousands on double {
  String toThousands({bool fixed2 = false}) {
    final formatter = fixed2
        ? NumberFormat('#,##0.00') // 强制两位小数
        : NumberFormat('#,##0.##'); // 最多两位小数
    return formatter.format(this);
  }
}

String toStringAsFixed2(String? value) {
  if (value == null) return '0.00'; // 如果值为null，返回默认值
  if (value.isEmpty) return '0.00';
  try {
    final doubleValue = double.parse(value);
    return doubleValue.toStringAsFixed(2);
  } catch (e) {
    return '0.00'; // 如果解析失败，返回默认值
  }
}

String toStringAsFixed4(String? value) {
  if (value == null) return '0.0000'; // 如果值为null，返回默认值
  if (value.isEmpty) return '0.0000';
  try {
    final doubleValue = double.parse(value);
    return doubleValue.toStringAsFixed(4);
  } catch (e) {
    return '0.0000'; // 如果解析失败，返回默认值
  }
}

extension StringNumUtil on String {
  String absolute() {
    if (isEmpty) return '0.00';
    try {
      final doubleValue = double.parse(this);
      return doubleValue.abs().toStringAsFixed(2);
    } catch (e) {
      return '0.00'; // 如果解析失败，返回默认值
    }
  }

  String toFixed2() {
    return toStringAsFixed2(this);
  }

  String toFixed4() {
    return toStringAsFixed4(this);
  }
}

extension DoubleNumUtil on double {
  String toFixed2() {
    return toThousands(toStringAsFixed(2));
  }

  String toFixed4() {
    return toStringAsFixed(4);
  }
}
