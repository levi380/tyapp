import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';
import '../../../../main.dart';

import '../main_tab_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fd7c406b-7a61-4ad5-8525-78ce9cb69b8d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP底部菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部菜单小组件 footballAndBasketballWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 足球篮球专题页入口 footballAndBasketballWidget
    - footballAndBasketballWidget
    ```
    足球篮球专题页入口
    ```
    】】】
 *
 */

class footballAndBasketballWidget extends StatelessWidget {
  const footballAndBasketballWidget({
    super.key,
    required this.controller,
  });

  final MainTabController controller;

  @override
  Widget build(BuildContext context) {
    return controller.footballBasketballTemplateIsNearEdge == true
        ? Positioned(
            right: -20,
            bottom: bottomHideSwitch == true ? 380 : 10,
            child: GestureDetector(
              onTap: () => controller.onTap(),
              onPanUpdate: (details) => controller.onPanUpdate(details),
              child: Container(
                width: 52.w,
                height: 52.w,
                child: PageView.builder(
                  itemCount: controller.queryLeagueTemplateListData.length,
                  controller: controller.pageController,
                  onPageChanged: (page) => controller.onPageChanged(page),
                  itemBuilder: (context, index) {
                    return ImageView(
                      controller.queryLeagueTemplateListData[index]
                          .activityTemplateImageH5Sdk,
                      cdn: true,
                      width: 52.w,
                      height: 52.w,
                    );
                  },
                ),
              ),
            ),
          )
        : Positioned(
            left: controller.footballBasketballTemplatePosition.dx,
            top: controller.footballBasketballTemplatePosition.dy,
            child: Draggable(
              feedback: Container(
                width: 100.w,
                height: 48.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => controller.onPreviousPage(),
                      child: ImageView(
                        footballBasketballTemplate5,
                        width: 22.w,
                        height: 22.w,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.toFootballBasketballTemplate(),
                      child: Container(
                        width: 52.w,
                        height: 52.w,
                        child: PageView.builder(
                          itemCount:
                              controller.queryLeagueTemplateListData.length,
                          controller: controller.pageController,
                          onPageChanged: (page) =>
                              controller.onPageChanged(page),
                          itemBuilder: (context, index) {
                            return ClipOval(
                              child: ImageView(
                                controller.queryLeagueTemplateListData[index]
                                    .activityTemplateImageH5Sdk,
                                cdn: true,
                                width: 52.w,
                                height: 52.w,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.onNextPage(),
                      child: ImageView(
                        footballBasketballTemplate4,
                        width: 22.w,
                        height: 22.w,
                      ),
                    ),
                  ],
                ),
              ),
              child: Container(
                width: 100.w,
                height: 48.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => controller.onPreviousPage(),
                      child: ImageView(
                        footballBasketballTemplate5,
                        width: 22.w,
                        height: 22.w,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.toFootballBasketballTemplate(),
                      child: Container(
                        width: 52.w,
                        height: 52.w,
                        child: PageView.builder(
                          itemCount:
                              controller.queryLeagueTemplateListData.length,
                          controller: controller.pageController,
                          onPageChanged: (page) =>
                              controller.onPageChanged(page),
                          itemBuilder: (context, index) {
                            return ImageView(
                              controller.queryLeagueTemplateListData[index]
                                  .activityTemplateImageH5Sdk,
                              cdn: true,
                              width: 52.w,
                              height: 52.w,
                            );
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.onNextPage(),
                      child: ImageView(
                        footballBasketballTemplate4,
                        width: 22.w,
                        height: 22.w,
                      ),
                    ),
                  ],
                ),
              ),
              childWhenDragging: Container(),
              onDragEnd: (details) =>
                  controller.onFootballBasketballTemplateDragEnd(details),
            ),
          );
  }
}
