import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/daily_activities/widgets/daily_activities_title_widget.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../widgets/image_view.dart';
import 'daily_activities_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-4e9be854-24f7-4038-82b7-1ee2bd55e911-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 活动界面】】】
    【【【 AUTO_PARAGRAPH_TITLE 活动界面 视图 DailyActivitiesPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 活动界面 视图 DailyActivitiesPage
    - DailyActivitiesPage
    ```
    ///webView 加载
      WebViewWidget(
      controller: controller.webViewController,
      ),
      ///投注组件
      _title(),
    ```
    】】】
 *
 */
class DailyActivitiesPage extends StatefulWidget {
  const DailyActivitiesPage({Key? key}) : super(key: key);

  @override
  State<DailyActivitiesPage> createState() => _DailyActivitiesPageState();
}

class _DailyActivitiesPageState extends State<DailyActivitiesPage> {
  final controller = Get.find<DailyActivitiesController>();
  final logic = Get.find<DailyActivitiesController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyActivitiesController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: logic.progress == 100
                ? Stack(
                    children: [
                      ///webView 加载
                      WebViewWidget(
                        controller: controller.webViewController,
                      ),
                      ///投注组件
                      _title(),
                    ],
                  )
                : Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: ImageView(
                        oddsInfoLoadingGif,
                        width: 70.w,
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  ///头部
  Widget _title() {
    return DailyActivitiesTitleWidget();
  }

  @override
  void dispose() {
    Get.delete<DailyActivitiesController>();
    super.dispose();
  }
}
