import 'dart:ui';
import 'package:flutter_ty_app/app/utils/skin_status.dart';
import '../modules/login/login_head_import.dart';

class ChangeSkinToneColorUtil{

  static ChangeSkinToneColorUtil? _instance;

  static ChangeSkinToneColorUtil instance() {
    _instance ??= ChangeSkinToneColorUtil._();
    return _instance!;
  }
  ChangeSkinToneColorUtil._() {}

  ///默认是第一种样式（产品说了不需要做存储）
  Status modeStatus = Status.BLACK_STYLE_1;

  ///设置皮肤模式
  setModeStatus(Status state) {
    modeStatus = state;
  }

  ///获取皮肤模式
  getModeStatus() {
    return modeStatus;
  }

  ///根据夜间肤色 返回不同色值(3种颜色默认的，有不一样的颜色自己加， 不需变颜色noChange改成 true)
  Color getDarkBackgroundColor({
    bool noChange = false,
    Color colorStyle_1 = const Color(0xFF22242B),
    Color colorStyle_2 = const Color(0xFF1A2024),
    Color colorStyle_3 = const Color(0xFF1D1B22),
  }) {

    if (noChange){
      return colorStyle_1;
    }

    switch (modeStatus) {
    ///默认夜间 棕色
      case Status.BLACK_STYLE_1:
        return colorStyle_1;

    ///蓝色
      case Status.BLACK_STYLE_2:
        return colorStyle_2;

    ///紫色
      case Status.BLACK_STYLE_3:
        return colorStyle_3;
      }
  }
}
