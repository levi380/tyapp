import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/image_view.dart';
import 'splash_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-e0a4b6c0-8628-4ef2-8688-3a7e18188421-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP启动页】】】
    【【【 AUTO_PARAGRAPH_TITLE APP启动页 视图 SplashPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - APP启动页 视图 SplashPage
    - SplashPage
    】】】
 *
 */
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final logic = Get.find<SplashController>().logic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: ImageView(
            oddsInfoLoadingGif,
            width: 70.w,
          ),
        ),
      ),
    );
  }
}
