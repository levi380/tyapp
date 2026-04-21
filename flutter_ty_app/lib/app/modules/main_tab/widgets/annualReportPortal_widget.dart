import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';

import '../main_tab_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fd7c406b-7a61-4ad5-8525-78ce9cb69b8d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP底部菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部菜单小组件 annualReportPortalWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报入口 annualReportPortalWidget
    - annualReportPortalWidget
    ```
    年报入口
    ```
    】】】
 *
 */

class annualReportPortalWidget extends StatelessWidget {
  const annualReportPortalWidget({
    super.key,
    required this.controller,
  });

  final MainTabController controller;

  @override
  Widget build(BuildContext context) {
    return controller.isNearEdge == true
        ? Positioned(
            right: 0,
            bottom: 300,
            child: Draggable(
              feedback: ImageView(
                annualReportLogo1,
                width: 22.w,
                height: 42.h,
              ),
              child: GestureDetector(
                onTap: () => controller.onToAnnualReports(),
                child: ImageView(
                  annualReportLogo1,
                  width: 22.w,
                  height: 42.h,
                ),
              ),
              childWhenDragging: Container(),
              onDragEnd: (details) => controller.onDragEnds(details),
            ),
          )
        : Positioned(
            left: controller.position.dx,
            top: controller.position.dy,
            child: Draggable(
              feedback: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => controller.onNbClose(),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: ImageView(
                        width: 20.w,
                        height: 20.h,
                        annualReportClose,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.onToAnnualReport(),
                    child: ImageView(
                      annualReportLogos,
                      width: 80.w,
                      height: 80.w,
                      errorWidget: ImageView(
                        annualReportLogos,
                        width: 80.w,
                        height: 80.w,
                      ),
                    ),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => controller.onNbClose(),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: ImageView(
                        width: 20.w,
                        height: 20.h,
                        annualReportClose,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.onToAnnualReport(),
                    child: ImageView(
                      annualReportLogos,
                      width: 80.w,
                      height: 80.w,
                      errorWidget: ImageView(
                        annualReportLogos,
                        width: 80.w,
                        height: 80.w,
                      ),
                    ),
                  ),
                ],
              ),
              childWhenDragging: Container(),
              onDragEnd: (details) => controller.onDragEnd(details),
            ),
          );
  }
}
