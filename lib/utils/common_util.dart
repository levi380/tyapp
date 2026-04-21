// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';

class tsCommonUtils {
  // 防抖函数: eg:输入框连续输入，用户停止操作300ms才执行访问接口
  static const deFaultDurationTime = 300;
  static Timer? timer;

  static void antiShake(Function? doSomething,
      {durationTime = deFaultDurationTime}) {
    timer?.cancel();
    timer = Timer(Duration(milliseconds: durationTime), () {
      doSomething!.call();
      timer = null;
    });
  }

  // 节流函数: eg:300ms内，只会触发一次
  static int startTime = 0;

  static void throttle(Function? doSomething,
      {durationTime = deFaultDurationTime}) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - startTime > durationTime) {
      doSomething!.call();
      startTime = DateTime.now().millisecondsSinceEpoch;
    }
  }
}

bool isIPhoneWithNotch(BuildContext context) {
  if (!Platform.isIOS) return false;
  final padding = MediaQuery.of(context).padding;
  return padding.top > 20;
}

Future<String> getSplashImageSavePath(String filename) async {
  Language languagemodel = SpStorage.getAppLocalLanguage() == null
      ? Language.zh_cn
      : Language.fromAbbr(SpStorage.getAppLocalLanguage());
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/splash/${languagemodel.code}/$filename';
}
