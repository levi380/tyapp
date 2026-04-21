import 'dart:io';

import '../../../generated/locales.g.dart';
import '../login/login_head_import.dart';
import '../main_tab/main_tab_controller.dart';
import 'beginners_guide_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1356b157-6c7f-43df-adaa-7e21cd8621f9-yd 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  新手引导】】】
    【【【 AUTO_PARAGRAPH_TITLE 新手引导 视图 BeginnersGuidePage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 新手引导 视图 BeginnersGuidePage
    ```
    /// 获取屏幕高度
    double screenHeight = MediaQuery.of(context).size.height;
    /// 计算距离顶部的高度
    double topPadding = Platform.isIOS ? screenHeight * 0.15 : screenHeight * 0.1;

    ```
    】】】
 *
 */

class BeginnersGuidePage extends StatefulWidget {
  const BeginnersGuidePage({Key? key}) : super(key: key);

  @override
  State<BeginnersGuidePage> createState() => _BeginnersGuideState();
}

class _BeginnersGuideState extends State<BeginnersGuidePage> {
  final controller = Get.find<BeginnersGuideController>();
  final logic = Get.find<BeginnersGuideController>().logic;
  final bottomController = Get.find<MainTabController>();

  /// 获取屏幕高度
  late double screenHeight = MediaQuery.of(Get.context!).size.height;

  /// 计算距离顶部的高度
  late double topPadding =
      Platform.isIOS ? screenHeight * 0.15 : screenHeight * 0.1;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BeginnersGuideController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: context.isDarkMode
              ? Colors.black.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.3),
          body: Container(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (index) => controller.onPageChanged(index),
              physics: NeverScrollableScrollPhysics(),
              children: [
                ///专业版 新手版选择
                _professionalEditionBeginnerEdition(),

                ///真人引导界面
                if (!(Get.locale!.countryCode == 'PT' || Get.locale!.countryCode == 'IN' || Get.locale!.countryCode == 'MY'))
                  _liveOnGuidePage(),

                ///cp引导界面
                _lotteryLandingPage(),

                ///设置菜单引导
                _setMenuGuidePage(),
              ],
            ),
          ),
        );
      },
    );
  }

  ///专业版 新手版选择
  Widget _professionalEditionBeginnerEdition() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 25.w, right: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(bottom: 20.h),
            child: GestureDetector(
              onTap: () => controller.toBack(),
              child: ImageView(
                "assets/images/xsyd/beginners_guide_close.png",
                width: 30.w,
                height: 30.w,
                boxFit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 24.h,
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: context.isDarkMode ? Color(0xFF171B2B) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 16,
                  children: [
                    ImageView(
                      context.isDarkMode
                          ? "assets/images/xsyd/" +
                          logic.language +
                              "_1_zy_dark.png"
                          : "assets/images/xsyd/" +
                          logic.language +
                              "_1_zy_light.png",
                      width: 140.w,
                      height: 150.h,
                    ),
                    GestureDetector(
                      onTap: () => controller.onBettingMode(true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 6),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF4176FA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 4,
                          children: [
                            Text(
                              LocaleKeys.zr_cp_Lottery_Bet_Slips_usage.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 16,
                  children: [
                    ImageView(
                      context.isDarkMode
                          ? "assets/images/xsyd/" +
                          logic.language +
                              "_1_xs_dark.png"
                          : "assets/images/xsyd/" +
                          logic.language +
                              "_1_xs_light.png",
                      width: 140.w,
                      height: 150.h,
                    ),
                    GestureDetector(
                      onTap: () => controller.onBettingMode(false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 6),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF4176FA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 4,
                          children: [
                            Text(
                              LocaleKeys.zr_cp_Lottery_Bet_Slips_usage.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///真人引导界面
  Widget _liveOnGuidePage() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: topPadding.h),
      child: GestureDetector(
        onTap: () => controller.toBack(),
        child: ImageView(
          context.isDarkMode
              ? "assets/images/xsyd/" + logic.language + "_2_zr_dark.png"
              : "assets/images/xsyd/" + logic.language + "_2_zr_light.png",
          height: 260.h,
        ),
      ),
    );
  }

  ///cp引导界面
  Widget _lotteryLandingPage() {
    return Container(
      alignment: (Get.locale!.countryCode == 'PT' ||
              Get.locale!.countryCode == 'IN' ||
              Get.locale!.countryCode == 'MY')
          ? Alignment.topLeft
          : Alignment.topRight,
      margin: EdgeInsets.only(top: topPadding.h),
      child: GestureDetector(
        onTap: () => controller.toBack(),
        child: ImageView(
          context.isDarkMode
              ? "assets/images/xsyd/" + logic.language + "_2_cp_dark.png"
              : "assets/images/xsyd/" + logic.language + "_2_cp_light.png",
          height: 260.h,
        ),
      ),
    );
  }

  ///设置菜单引导
  Widget _setMenuGuidePage() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: 90.h),
      child: GestureDetector(
        onTap: () => controller.toBack(),
        child: ImageView(
          "assets/images/xsyd/" + logic.language + "_3.png",
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<BeginnersGuideController>();
    super.dispose();
  }
}
