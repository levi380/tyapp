import 'package:characters/characters.dart';
import 'package:flutter/services.dart';

/// 银行卡「真实姓名」输入规则与校验。
///
/// A. 中文：仅汉字 + 间隔号 ·；英文：仅字母、半角空格、英文点；禁止中英文混输。
/// B. 中文 2～20 字符；英文 2～60 字符。
/// C. 英文字母自动转大写。
class BankCardRealNameRules {
  BankCardRealNameRules._();

  /// 统一错误提示（产品文案）
  static const String errorHint = '姓名仅支持汉字、英文字母、空格及间隔号 ·';

  static const String _middleDot = '\u00B7'; // ·

  static bool _isHan(String ch) {
    if (ch.length != 1) return false;
    final c = ch.codeUnitAt(0);
    return c >= 0x4e00 && c <= 0x9fa5;
  }

  static bool _isLatin(String ch) {
    if (ch.length != 1) return false;
    final c = ch.codeUnitAt(0);
    return (c >= 0x41 && c <= 0x5a) || (c >= 0x61 && c <= 0x7a);
  }

  static bool _hasMix(String t) {
    var han = false;
    var lat = false;
    for (final ch in t.characters) {
      if (_isHan(ch)) han = true;
      if (_isLatin(ch)) lat = true;
      if (han && lat) return true;
    }
    return false;
  }

  static bool _anyHan(String t) => RegExp(r'[\u4e00-\u9fa5]').hasMatch(t);

  /// 提交前校验；通过返回 `null`，否则返回错误文案。
  static String? validate(String raw) {
    final t = raw.trim();
    if (t.isEmpty) return null; // 由调用方处理「未填写」

    if (_hasMix(t)) return errorHint;

    if (_anyHan(t)) {
      if (!RegExp(r'^[\u4e00-\u9fa5\u00B7]+$').hasMatch(t)) {
        return errorHint;
      }
      final hanCount = RegExp(r'[\u4e00-\u9fa5]').allMatches(t).length;
      if (hanCount < 2) return '姓名至少2个字符';
      if (hanCount < 2 || t.characters.length > 20) return errorHint;
    } else {
      // 英文路径：不含间隔号 ·
      if (!RegExp(r'^[A-Za-z .]+$').hasMatch(t) || t.contains(_middleDot)) {
        return errorHint;
      }
      if (t.characters.length < 2) return '姓名至少2个字符';
      if (t.characters.length < 2 || t.characters.length > 60) {
        return errorHint;
      }
    }
    return null;
  }
}

/// 输入时：小写转大写、过滤非法字符、禁止中英文混输、按路径限制最大长度。
class BankCardRealNameInputFormatter extends TextInputFormatter {
  static const String _middleDot = '\u00B7';

  static bool _isHan(String ch) {
    if (ch.length != 1) return false;
    final c = ch.codeUnitAt(0);
    return c >= 0x4e00 && c <= 0x9fa5;
  }

  static bool _isLatin(String ch) {
    if (ch.length != 1) return false;
    final c = ch.codeUnitAt(0);
    return (c >= 0x41 && c <= 0x5a) || (c >= 0x61 && c <= 0x7a);
  }

  static bool _isAllowedChar(String ch) {
    if (ch.length != 1) return false;
    final c = ch.codeUnitAt(0);
    if (_isHan(ch)) return true;
    if (ch == _middleDot) return true;
    if (c >= 0x41 && c <= 0x5a) return true;
    if (c == 0x20) return true;
    if (ch == '.') return true;
    return false;
  }

  static bool _hasMix(String t) {
    var han = false;
    var lat = false;
    for (final ch in t.characters) {
      if (_isHan(ch)) han = true;
      if (_isLatin(ch)) lat = true;
      if (han && lat) return true;
    }
    return false;
  }

  static bool _anyHan(String t) => RegExp(r'[\u4e00-\u9fa5]').hasMatch(t);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 中文输入法组字中不改写，避免打断选字
    if (!newValue.composing.isCollapsed) {
      return newValue;
    }

    var text = newValue.text.replaceAllMapped(
      RegExp(r'[a-z]'),
      (m) => m.group(0)!.toUpperCase(),
    );

    final buf = StringBuffer();
    for (final ch in text.characters) {
      if (_isAllowedChar(ch)) buf.write(ch);
    }
    text = buf.toString();

    if (_hasMix(text)) {
      return oldValue;
    }

    // 中文路径仅保留汉字与 ·；英文路径去掉 ·（及不可能存在的汉字）
    if (_anyHan(text)) {
      final b = StringBuffer();
      for (final ch in text.characters) {
        if (_isHan(ch) || ch == _middleDot) b.write(ch);
      }
      text = b.toString();
    } else {
      final b = StringBuffer();
      for (final ch in text.characters) {
        if (ch == _middleDot || _isHan(ch)) continue;
        b.write(ch);
      }
      text = b.toString();
    }

    final maxLen = _anyHan(text) ? 20 : 60;
    if (text.characters.length > maxLen) {
      text = text.characters.take(maxLen).toString();
    }

    final end = text.length;
    final sel = newValue.selection;
    final selection = TextSelection(
      baseOffset: sel.baseOffset.clamp(0, end),
      extentOffset: sel.extentOffset.clamp(0, end),
    );

    return TextEditingValue(
      text: text,
      selection: selection,
      composing: TextRange.empty,
    );
  }
}
