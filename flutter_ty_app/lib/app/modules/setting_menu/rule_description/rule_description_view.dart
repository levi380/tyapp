import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../config/theme/app_color.dart';
import '../../../global/assets/webview_cache.dart';
import '../../../widgets/fireworks/fireworks_animation.dart';
import '../../../widgets/fireworks/fireworks_controller.dart';
import '../../main_tab/main_tab_controller.dart';
import 'rule_description_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-7442ad20-6841-43b0-910a-13b44c7b8923-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 规则说明】】】
    【【【 AUTO_PARAGRAPH_TITLE 规则说明 视图页面 RuleDescriptionPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 规则说明 视图页面 RuleDescriptionPage
    - RuleDescriptionPage
    ```
    ///加载web组件
    WebviewCacheController.to.getRule(),
    ```
    】】】
 *
 */
class RuleDescriptionPage extends StatefulWidget {
  const RuleDescriptionPage({Key? key}) : super(key: key);

  @override
  State<RuleDescriptionPage> createState() => _RuleDescriptionPageState();
}

class _RuleDescriptionPageState extends State<RuleDescriptionPage> {
  final controller = Get.find<RuleDescriptionController>();
  final logic = Get.find<RuleDescriptionController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RuleDescriptionController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: context.isDarkMode
                ? AppColor.titleBackgroundColor
                : Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: InkWell(
              onTap: () => Get.back(),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: 10.w,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20.w,
                  color: context.isDarkMode
                      ? Colors.white
                      : const Color(0xFF303442),
                ),
              ),
            ),
            title: Text(
              LocaleKeys.setting_menu_rule_description.tr,
              style: TextStyle(
                color:
                    context.isDarkMode ? Colors.white : const Color(0xFF303442),
                fontSize: 16.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Stack(
            children: [
              WebviewCacheController.to.getRule(),
              Obx(() =>MainTabController.to.isFireworksPaly.value&&
                  FireworksController.to.isFireworksActivityValid(MainTabController.to.activityEntity,FireworksController.to.serverNow) ?
              FireworksAnimation(
                id:MainTabController.to.fireworksId.value,
                beginTime:MainTabController.to.beginTime.value,
                endTime:MainTabController.to.endTime.value,
                type:MainTabController.to.fireworksType.value,
                number:MainTabController.to.fireworksNumber,
                championName:MainTabController.to.championName.value,
                championIcon:MainTabController.to.championIcon.value ,
              ):Container()),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Get.delete<RuleDescriptionController>();
    super.dispose();
  }
}
