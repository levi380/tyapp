import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'themeData.dart';

import '../base_service.dart';

class ThemeService extends BaseService {
  final _theme = darkTheme.obs;

  static ThemeService get to => Get.find();
  AppThemeModel get theme => _theme.value;

  void setTheme(AppThemeModel newTheme) {
    _theme.value = newTheme;
  }

    Future<ThemeService> init() async {
    debugPrint('ThemeService init');

    return this;
  }
}
