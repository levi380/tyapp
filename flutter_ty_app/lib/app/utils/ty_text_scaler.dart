import '../modules/login/login_head_import.dart';

import 'package:flutter/widgets.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-f726e49a-fa33-4c25-8ad4-b88a1d6254e6-dl 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  字号大小 】】】
    【【【 AUTO_PARAGRAPH_TITLE 字号大小 工具类 TyTextScaler 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 字号大小 工具类 TyTextScaler
    ```
    ///工具类 工具累  TyTextScaler.instance().scale(isIPad ? 18.sp : 16.sp)

    ///返回缩放后的字体大小
    double scale(double fontSize,{double? addSize}) {
    if (_textScaleFactor == 1.0) {
    return fontSize;
    } else {
    if (fontSize > 10) {
    return fontSize + (addSize ?? 3);
    } else {
    return fontSize + (addSize ?? 2);
    }
    }
    }

    ///设置新的缩放因子
    void setTextScaleFactor(double scaleFactor) {
    _textScaleFactor = scaleFactor;
    }

    ///originalSize 原始大小    changeSize  变更大小
    double getAdjustedFontSize(double originalSize, double changeSize) {
    /// 判断传入的 sizeOrScale 是否是比例（比如数字）
    if (_textScaleFactor != 1.0) {
    ///如果比例不为1.0 返回自定义设置大小
    return changeSize;
    } else {
    /// 如果比例为1.0，返回原大小
    return originalSize;
    }
    }
    ```
    】】】
 *
 */
class TyTextScaler implements TextScaler {
  static TyTextScaler? _instance;

  ///缩放因子 ,控制文本的缩放比例
  static double _textScaleFactor = 1.0;
  static double defaultScaleFactor = 1.0;
  static double biggerScaleFactor = 1.3;
  static TyTextScaler instance() {
    _instance ??= TyTextScaler._();
    return _instance!;
  }

  TyTextScaler._() {
    ///限制在1.2到2.0之前
    clamp(minScaleFactor: 1.2, maxScaleFactor: 2.0);
  }
  // TyTextScaler(this._textScaleFactor);

  ///获取当前缩放因子
  @override
  double get textScaleFactor => _textScaleFactor;

  ///实现TextScaler 接口中的clamp 方法 ,也限制缩放因子范围
  @override
  TextScaler clamp(
      {double minScaleFactor = 0, double maxScaleFactor = double.infinity}) {
    _textScaleFactor = _textScaleFactor.clamp(minScaleFactor, maxScaleFactor);
    return this;
  }

  bool get isScale {
    return _textScaleFactor != 1.0;
  }

  ///返回缩放后的字体大小
  double scale(double fontSize,{double? addSize}) {
    if (_textScaleFactor == 1.0) {
      return fontSize;
    } else {
      if (fontSize > 10) {
        return fontSize + (addSize ?? 3);
      } else {
        return fontSize + (addSize ?? 2);
      }
    }
  }

  ///设置新的缩放因子
  void setTextScaleFactor(double scaleFactor) {
    _textScaleFactor = scaleFactor;
  }

  ///originalSize 原始大小    changeSize  变更大小
  double getAdjustedFontSize(double originalSize, double changeSize) {
    /// 判断传入的 sizeOrScale 是否是比例（比如数字）
    if (_textScaleFactor != 1.0) {
      ///如果比例不为1.0 返回自定义设置大小
      return changeSize;
    } else {
      /// 如果比例为1.0，返回原大小
      return originalSize;
    }
  }
}
