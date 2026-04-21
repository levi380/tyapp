import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/getx_navigation.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/result/gaming_results/gaming_results_view.dart';
import 'package:flutter_ty_app/app/modules/result/normal_results/normal_results_view.dart';
import 'package:flutter_ty_app/app/modules/result/vr_results/vr_results_view.dart';
import 'package:flutter_ty_app/app/modules/result/widgets/title_widget.dart';
import 'package:get/get.dart';
import '../../utils/change_skin_tone_color_util.dart';
import '../../widgets/fireworks/fireworks_animation.dart';
import '../../widgets/fireworks/fireworks_controller.dart';
import '../../widgets/image_view.dart';
import '../main_tab/main_tab_controller.dart';
import 'championship_results/championship_results_view.dart';
import 'result_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果 视图页面 ResultPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果 视图页面 ResultPage
    - ResultPage
    - 包含联赛删选-普通赛果-电竞赛果-冠军赛果
    ```
    ///头部
    _title(),
    /// 0 普通死啊过 ，1 电竞赛果 2 VR赛果 或者冠军赛果
    Expanded(
    child: controller.titleIndex == 0
    ? NormalResultsPage(controller.titleIndex)
    : controller.titleIndex == 1
    ? GamingResultsPage(controller.titleIndex)
    : controller.titleIndex == 2 ?
    VrResultsPage(controller.titleIndex)
    : ChampionshipResultsPage(controller.titleIndex),
    ),
    ```
    】】】
 *
 */
class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final controller = Get.find<ResultController>();
  final logic = Get.find<ResultController>().logic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///烟花活动
    FireworksController.to.getFireworksActivity();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResultController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            color: context.isDarkMode ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()  : Colors.white,
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///头部
                      _title(),
                      /// 0 普通死啊过 ，1 电竞赛果 2 VR赛果 或者冠军赛果
                      Expanded(
                        child: logic.titleIndex == 0
                            ? NormalResultsPage(logic.titleIndex)
                            : logic.titleIndex == 1
                            ? GamingResultsPage(logic.titleIndex)
                            : logic.titleIndex == 2 ?
                            VrResultsPage(logic.titleIndex)
                           : ChampionshipResultsPage(logic.titleIndex),
                      ),
                    ],
                  ),
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
            ),
          ),
        );
      },
    );
  }

  ///头部
  Widget _title() {
    return Container(
      margin: EdgeInsets.only(left: 14.w, right: 14.w),
      color: context.isDarkMode ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()  : Colors.white,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 0,
            child: InkWell(
              onTap: () => Get_TY.back(),
              child: Icon(
                Icons.arrow_back_ios,
                size: 22.w,
                color:
                    context.isDarkMode ? Colors.white : const Color(0xFF303442),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 2.w, right: 2.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: controller.scrollController,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List<TitleWidget>.generate(
                      logic.titleList.length, (index) {
                    return TitleWidget(
                      onTap: () => controller.onTitleIndex(index),
                      title: logic.titleList[index],
                      isSelected: logic.titleIndex == index ? true : false,
                      isDark: context.isDarkMode,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Obx(() {
              ///赛果筛选按钮显示
              return (logic.titleIndex == 0 || logic.titleIndex == 1 || logic.titleIndex == 3) && ConfigController.to.accessConfig.value.filterSwitch
                  ? InkWell(
                      onTap: () => controller.onSelectLeague(),
                      child: ImageView(
                        'assets/images/icon/icon_filter_nor.png',
                        width: 24.w,
                        height: 24.w,
                        color: context.isDarkMode
                            ? Colors.white.withValues(alpha:0.5)
                            : const Color(0xFF7981A3),
                      ),
                    )
                  : Container();
            }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ResultController>();
    super.dispose();
  }
}
