import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../../main.dart';
import '../../../utils/oss_util.dart';
import '../../../utils/ty_text_scaler.dart';
import '../annual_report_controller.dart';
import 'annual_report_bottom_widget.dart';
import 'annual_report_title_widget.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1509bbab-4a30-49cc-837f-3535741f55b4-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  年报】】】
    【【【 AUTO_PARAGRAPH_TITLE 年报 无数据展示 ReportNodataWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 无数据展示 ReportNodataWidget
    - ReportNodataWidget
    ```
    ReportNodataWidget(
      pandaAnimationController: controller.pandaAnimationController,
      upperSlipAnimation: controller.upperSlipAnimation,
      pandaIsVisible: controller.pandaIsVisible,
      animationController: controller.animationController,
      isPlaying: controller.isPlaying,
      pauseMusic: () => controller.pauseMusic(),
      playMusic: () => controller.playMusic(),
      onSaveToPhoto: () => controller.onSaveToPhoto(),
    )
    ```
    】】】
 *
 */
class ReportNodataWidget extends StatelessWidget {
  const ReportNodataWidget({
    super.key,
    required this.pandaAnimationController,
    required this.upperSlipAnimation,
    required this.pandaIsVisible,
    required this.animationController,
    required this.isPlaying,
    required this.pauseMusic,
    required this.playMusic,
    required this.onSaveToPhoto,
  });

  final AnimationController pandaAnimationController;
  final Animation<double>  upperSlipAnimation;
  final bool pandaIsVisible;
  final AnimationController animationController;
  final bool isPlaying;
  final VoidCallback? pauseMusic;
  final VoidCallback? playMusic;
  final VoidCallback? onSaveToPhoto;

  @override
  Widget build(BuildContext context) {
    final annualReportController = Get.find<AnnualReportController>();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            OssUtil.getServerPath(
              'assets/images/nb/nb_bg_1.jpg',
            ),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                ///头部
                AnnualReportTitleWidget(
                  animationController: animationController,
                  isPlaying: isPlaying,
                  pauseMusic: pauseMusic,
                  playMusic: playMusic,
                ),

                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, -1), // 从顶部开始
                    end: Offset(0, 0), // 到中心位置
                  ).animate(CurvedAnimation(
                    parent: pandaAnimationController,
                    curve: Curves.easeInOut,
                  )),
                  child: Visibility(
                    visible: pandaIsVisible,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 25.w, top: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: annualReportController.testAnimationController1,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: annualReportController.testOpacityAnimation1.value,
                                    child:  Container(
                                      margin: EdgeInsets.only(
                                        top: 5.h,
                                        bottom: 5.h,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: LocaleKeys.annual_user_report_10_noData1.tr+annualReportController.logic.year,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: isIPad ? 18.sp : 16.sp,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: LocaleKeys.annual_user_report_10_noData2.tr,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: TyTextScaler.instance().scale(isIPad ? 22.sp :20.sp),
                                                fontFamily: 'eryaxindahei',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              AnimatedBuilder(
                                animation: annualReportController.testAnimationController2,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: annualReportController.testOpacityAnimation2.value,
                                    child: Container(
                                      margin: EdgeInsets.only(top: annualReportController.testFallAnimation2.value < 0 ? 0 : annualReportController.testFallAnimation2.value, bottom: 5.0),
                                      child: Text(
                                        LocaleKeys.annual_user_report_10_noData3.tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: TyTextScaler.instance().scale(isIPad ? 18.sp :16.sp),
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              AnimatedBuilder(
                                animation: annualReportController.testAnimationController3,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: annualReportController.testOpacityAnimation3.value,
                                    child: Container(
                                      margin: EdgeInsets.only(top: annualReportController.testFallAnimation3.value < 0 ? 0 : annualReportController.testFallAnimation3.value, bottom: 5.0),
                                      child: Text(
                                        LocaleKeys.annual_user_report_10_noData4.tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: TyTextScaler.instance().scale(isIPad ? 18.sp :16.sp),
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              AnimatedBuilder(
                                animation: annualReportController.testAnimationController4,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: annualReportController.testOpacityAnimation4.value,
                                    child: Container(
                                      margin: EdgeInsets.only(top: annualReportController.testFallAnimation4.value < 0 ? 0 : annualReportController.testFallAnimation4.value, bottom: 5.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:LocaleKeys.annual_user_report_10_noData5.tr.replaceAll('%',(int.parse(annualReportController.logic.year)+1).toString()),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: TyTextScaler.instance().scale(isIPad ? 18.sp :16.sp),
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text:   LocaleKeys.annual_user_report_10_noData6.tr,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: TyTextScaler.instance().scale(isIPad ? 22.sp : 20.sp),
                                                fontFamily: 'eryaxindahei',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              AnimatedBuilder(
                                animation: annualReportController.testAnimationController4,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: annualReportController.testOpacityAnimation4.value,
                                    child: Container(
                                      margin: EdgeInsets.only(top: annualReportController.testFallAnimation4.value < 0 ? 0 : annualReportController.testFallAnimation4.value, bottom: 5.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:   LocaleKeys.annual_user_report_10_noData7.tr,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: TyTextScaler.instance().scale(isIPad ? 18.sp :16.sp),
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text:  LocaleKeys.annual_user_report_10_noData8.tr,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: TyTextScaler.instance().scale(isIPad ? 22.sp : 20.sp),
                                                fontFamily: 'eryaxindahei',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                            ],
                          ),
                        ),

                        isIPad ?
                        Container(
                          margin: EdgeInsets.only(top: 320.h),
                          width: 600.w,
                          height: 300.h,
                          child: ImageView(
                            'assets/images/nb/nb_panda_3.png',
                          ),
                        ):
                        Container(
                          margin: EdgeInsets.only(top: 200.h),
                          child: ImageView(
                            'assets/images/nb/nb_panda_3.png',
                            height: 245.h,
                          ),
                        ),


                        AnimatedBuilder(
                          animation: annualReportController.bgAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: annualReportController.bgAnimation.value,
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                  final annualReportController = Get.find<AnnualReportController>();
                                  annualReportController.initFillingPoint(16);
                                },
                                child: Container(
                                  width: isIPad ? 300.w : 165.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        OssUtil.getServerPath(
                                          'assets/images/nb/nb_sc.png',
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(right: 35.w, left: 35.w),
                                    child: Text(
                                      LocaleKeys.annual_user_report_9_place.tr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0xFF2C325E),
                                        fontSize: TyTextScaler.instance().scale(18.sp),
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
            AnnualReportBottomWidget(
              isWhite: true,
              onSaveToPhoto: onSaveToPhoto,
              upperSlipAnimation:upperSlipAnimation,
            )
          ],
        ),
      ),
    );
  }
}
