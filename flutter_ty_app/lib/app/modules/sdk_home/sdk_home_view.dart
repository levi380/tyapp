
import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../../widgets/image_view.dart';
import '../../widgets/empty/no_data.dart';
import 'sdk_home_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-16041ec7-d06f-4baf-a76c-bc7753195068-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP入口页面】】】
    【【【 AUTO_PARAGRAPH_TITLE APP入口页面 视图 SdkHomePage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - APP入口页面 视图 SdkHomePage
    - SdkHomePage
    】】】
 *
 */
class SdkHomePage extends StatefulWidget {
  const SdkHomePage({Key? key}) : super(key: key);

  @override
  State<SdkHomePage> createState() => _SdkHomePageState();
}

class _SdkHomePageState extends State<SdkHomePage> {
  final controller = Get.find<SdkTyHomeController>();
  final logic = Get.find<SdkTyHomeController>().logic;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints)
        {
          IntKV.layoutHeight.save(constraints.maxHeight.floor());

          return Obx(() {
            if (logic.loading.value) {
              return Center(
                child: Container(
                  alignment: Alignment.center,
                  child: ImageView(
                    oddsInfoLoadingGif,
                    width: 70.w,
                  ),
                ),
              );
            } else {
              return Center(
                child: InkWell(
                    onTap: controller.retry,
                    child: NoData(
                        content: "${LocaleKeys.common_no_network.tr} ${LocaleKeys
                            .app_tap_reload.tr}")
                ),
              );
            }
          });
        }
    );
  }


  @override
  void dispose() {
    Get.delete<SdkTyHomeController>();
    super.dispose();
  }
}