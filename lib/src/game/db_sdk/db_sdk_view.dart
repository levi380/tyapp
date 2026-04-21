import 'package:filbet/src/game/db_sdk/db_sdk_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_ty_app/main.dart' as flutter_ty_app;
import 'package:get/get.dart';

class DbSdkView extends GetView<DbSdkController> {
  const DbSdkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.gameUrl.value.isEmpty) {
          return SizedBox();
        }
        return flutter_ty_app.MyApp(
          locale: const Locale('zh', 'CN'), //默认中文
          url: controller.gameUrl.value,
          env: 'prod', //默认生产环境
          context: context, // 默认传 context  有首页返回场馆按钮， 不要首页返回按钮 传 null
        );
      }),
    );
  }
}
