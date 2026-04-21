import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../../main.dart';
import '../../../services/models/res/get_user_annual_report_template_entity.dart';
import '../../../utils/oss_util.dart';
import '../annual_report_controller.dart';
import 'annual_report_bottom_widget.dart';
import 'annual_report_title_widget.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1509bbab-4a30-49cc-837f-3535741f55b4-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  年报】】】
    【【【 AUTO_PARAGRAPH_TITLE 年报 10 号模版 Report10Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 10 号模版 Report10Widget
    - Report10Widget
    ```
    Report10Widget(
      Template:Template,
      pandaAnimationController: controller.pandaAnimationController,
      upperSlipAnimation: controller.upperSlipAnimation,
      pandaIsVisible: controller.pandaIsVisible,
      animationController: controller.animationController,
      isPlaying: controller.isPlaying,
      pauseMusic: () => controller.pauseMusic(),
      playMusic: () => controller.playMusic(),
      onSaveToPhoto: () => controller.onSaveToPhoto(),
      onWatchItAgain: () => controller.onWatchItAgain(),
    )
    ```
    】】】
 *
 */
class Report10Widget extends StatelessWidget {
  const Report10Widget({
    super.key,
    required this.Template,
    required this.pandaAnimationController,
    required this.upperSlipAnimation,
    required this.pandaIsVisible,
    required this.animationController,
    required this.isPlaying,
    required this.pauseMusic,
    required this.playMusic,
    required this.onSaveToPhoto,
    required this.onWatchItAgain,
  });
  final GetUserAnnualReportTemplateDataReportPO Template;
  final AnimationController pandaAnimationController;
  final Animation<double>  upperSlipAnimation;
  final bool pandaIsVisible;
  final AnimationController animationController;
  final bool isPlaying;
  final VoidCallback? pauseMusic;
  final VoidCallback? playMusic;
  final VoidCallback? onSaveToPhoto;
  final VoidCallback? onWatchItAgain;

  @override
  Widget build(BuildContext context) {
    String? countryCode = Get.locale?.countryCode.toString();
    String content = countryCode == 'CN'
        ? Template.contentZh
        : countryCode == 'TW'
        ? Template.contentTw
        : Template.contentEn;
    content = content.replaceAll('&nbsp;', ' ') ;
    content = content.replaceAll('\r', ' ') ;
    content = decodeHtmlEntities(content);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            OssUtil.getServerPath(
              'assets/images/nb/nb_bg_24.jpg',
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40.w,right: 40.w,top: 30),
                          height: 100.h,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            color: Colors.white.withValues(alpha:0.5),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 3.w,
                                  color: Colors.white),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 10.w,right: 10.w,top: 0.h,bottom: 0.h),
                            alignment: Alignment.center,
                            child: Text(
                              content,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF1B2835),
                                fontSize: 40.sp,
                                fontFamily:  Get.locale?.countryCode == 'TW' ? 'PingFang SC' : 'eryaxindahei',
                                fontWeight: Get.locale?.countryCode == 'TW' ? FontWeight.bold : FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        isIPad ?
                        Container(
                          margin: EdgeInsets.only(top: 80.h),
                          child: ImageView(
                            'assets/images/nb/nb_panda_24.png',
                            height: 600.h,
                            width: 600.w,
                          ),
                        ):
                        Container(
                          margin: EdgeInsets.only(top: 95.h),
                          child: ImageView(
                            'assets/images/nb/nb_panda_24.png',
                            height: 350.h,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 30.w, right: 30.w, top: 30.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: onWatchItAgain,
                                child: Container(
                                  height: 50.h,
                                  width: isIPad ? 170.w: 145.w,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        OssUtil.getServerPath(
                                          'assets/images/nb/nb_zkyc.png',
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      LocaleKeys.annual_user_report_9_watch.tr,
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0xFF2C325E),
                                        fontSize: Get.locale?.languageCode == 'zh' ?  24.sp :Get.locale?.languageCode == 'tw' ?  24.sp :18.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(width: isIPad ? 110.w : 30.w,),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  final annualReportController = Get.find<AnnualReportController>();
                                  annualReportController.initFillingPoint(16);
                                },
                                child: Container(
                                  height: 50.h,
                                  width: isIPad ? 170.w: 145.w,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        OssUtil.getServerPath(
                                          'assets/images/nb/nb_qtz.png',
                                        ),
                                      ),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      LocaleKeys.annual_user_report_9_place.tr,
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0xFF2C325E),
                                        fontSize: Get.locale?.languageCode == 'zh' ?  24.sp :Get.locale?.languageCode == 'tw' ?  24.sp :18.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            AnnualReportBottomWidget(
              isWhite: true,
              onSaveToPhoto: onSaveToPhoto,
              upperSlipAnimation: upperSlipAnimation,
            )
          ],
        ),
      ),
    );
  }

  String decodeHtmlEntities(String input) {
    return input
        .replaceAll('&nbsp;', ' ') // 转换空格
        .replaceAll('&lt;', '<') // 转换 <
        .replaceAll('&gt;', '>') // 转换 >
        .replaceAll('&amp;', '&') // 转换 &
        .replaceAll('&quot;', '"') // 转换 "
        .replaceAll('&apos;', "'")
        .replaceAll('\r', '\n');// 转换 '
  }

  String removeTrailingNewline(String input) {
    if (input.endsWith('\n')) {
      return input.substring(0, input.length - 1);
    }
    return input;
  }

}
