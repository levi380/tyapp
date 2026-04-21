import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../../main.dart';
import '../../../services/models/res/get_user_annual_report_template_entity.dart';
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
    【【【 AUTO_PARAGRAPH_TITLE 年报 4 号模版 Report4Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 4 号模版 Report4Widget
    - Report4Widget
    ```
    Report4Widget(
      Template:Template,
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

class Report4Widget extends StatelessWidget {
  const Report4Widget({
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
  });

  final GetUserAnnualReportTemplateDataReportPO Template;
  final AnimationController pandaAnimationController;
  final Animation<double> upperSlipAnimation;
  final bool pandaIsVisible;
  final AnimationController animationController;
  final bool isPlaying;
  final VoidCallback? pauseMusic;
  final VoidCallback? playMusic;
  final VoidCallback? onSaveToPhoto;

  @override
  Widget build(BuildContext context) {
    final annualReportController = Get.find<AnnualReportController>();
    String? countryCode = Get.locale?.countryCode.toString();

    String content = countryCode == 'CN'
        ? Template.contentZh
        : countryCode == 'TW'
        ? Template.contentTw
        : Template.contentEn;
    content = content.replaceAll('%sannualHobbyBetTime%s',
        '%h' + (annualReportController.logic.annualHobbyBetTime == 1
            ? LocaleKeys
            .annual_user_report_4_morning
            .tr
            : annualReportController.logic.annualHobbyBetTime == 2
            ? LocaleKeys
            .annual_user_report_4_afternoon
            .tr
            : LocaleKeys
            .annual_user_report_4_night
            .tr)+ '%h');
    content = content.endsWith('\r') ? content.substring(0,content.length-1) : content;
    content = decodeHtmlEntities(content);


    int annualHobbyBetTime = annualReportController.logic.annualHobbyBetTime;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            OssUtil.getServerPath(
              (annualHobbyBetTime == 1
                  ? 'assets/images/nb/nb_bg_6.jpg'
                  : annualHobbyBetTime == 2
                      ? 'assets/images/nb/nb_bg_7.jpg'
                      : 'assets/images/nb/nb_bg_8.jpg'),
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
                                animation: annualReportController
                                    .testAnimationController1,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: annualReportController
                                        .testOpacityAnimation1.value,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: annualReportController
                                                      .testFallAnimation1
                                                      .value <
                                                  0
                                              ? 0
                                              : annualReportController
                                                  .testFallAnimation1.value,
                                          bottom: 5.0),
                                      child: Text(
                                        content,
                                        style: TextStyle(
                                          color: annualHobbyBetTime == 1
                                              ? Color(0xFF2C325E)
                                              : Colors.white,
                                          fontSize: TyTextScaler.instance().scale(isIPad ? 22.sp : 20.sp),
                                          fontFamily:
                                              Get.locale?.countryCode == 'TW'
                                                  ? 'PingFang SC'
                                                  : 'eryaxindahei',
                                          fontWeight:
                                              Get.locale?.countryCode == 'TW'
                                                  ? FontWeight.bold
                                                  : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // AnimatedBuilder(
                              //   animation: annualReportController
                              //       .testAnimationController2,
                              //   builder: (context, child) {
                              //     return Opacity(
                              //       opacity: annualReportController
                              //           .testOpacityAnimation2.value,
                              //       child: Container(
                              //         margin: EdgeInsets.only(
                              //             top: annualReportController
                              //                         .testFallAnimation2
                              //                         .value <
                              //                     0
                              //                 ? 0
                              //                 : annualReportController
                              //                     .testFallAnimation2.value,
                              //             bottom: 5.0),
                              //         child: Text(
                              //           LocaleKeys
                              //                   .annual_user_report_4_often.tr +
                              //               (annualHobbyBetTime == 1
                              //                   ? LocaleKeys
                              //                       .annual_user_report_4_morning
                              //                       .tr
                              //                   : annualHobbyBetTime == 2
                              //                       ? LocaleKeys
                              //                           .annual_user_report_4_afternoon
                              //                           .tr
                              //                       : LocaleKeys
                              //                           .annual_user_report_4_night
                              //                           .tr) +
                              //               LocaleKeys
                              //                   .annual_user_report_4_matches
                              //                   .tr,
                              //           style: TextStyle(
                              //             color: annualHobbyBetTime == 1
                              //                 ? Color(0xFF2C325E)
                              //                 : Colors.white,
                              //             fontSize: TyTextScaler.instance().scale(isIPad ? 22.sp : 20.sp),
                              //             fontFamily: 'PingFang SC',
                              //             fontWeight: FontWeight.bold,
                              //           ),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),
                              AnimatedBuilder(
                                animation: annualReportController
                                    .testAnimationController3,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: annualReportController
                                        .testOpacityAnimation3.value,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: annualReportController
                                                      .testFallAnimation3
                                                      .value <
                                                  0
                                              ? 0
                                              : annualReportController
                                                  .testFallAnimation3.value,
                                          bottom: 5.0),
                                      child: Text(
                                        annualHobbyBetTime == 1
                                            ? LocaleKeys
                                                .annual_user_report_4_quiet.tr
                                            : annualHobbyBetTime == 2
                                                ? LocaleKeys
                                                    .annual_user_report_4_time
                                                    .tr
                                                : LocaleKeys
                                                    .annual_user_report_4_challenge
                                                    .tr,
                                        style: TextStyle(
                                          color: annualHobbyBetTime == 1
                                              ? Color(0xFF2C325E)
                                              : Colors.white,
                                          fontSize: TyTextScaler.instance().scale(isIPad ? 18.sp : 16.sp),
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              AnimatedBuilder(
                                animation: annualReportController
                                    .testAnimationController4,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: annualReportController
                                        .testOpacityAnimation4.value,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: annualReportController
                                                      .testFallAnimation4
                                                      .value <
                                                  0
                                              ? 0
                                              : annualReportController
                                                  .testFallAnimation4.value,
                                          bottom: 5.0),
                                      child: Text(
                                        annualHobbyBetTime == 1
                                            ? LocaleKeys
                                                .annual_user_report_4_decisions.tr
                                            : annualHobbyBetTime == 2
                                                ? LocaleKeys
                                                    .annual_user_report_4_skills
                                                    .tr
                                                : LocaleKeys
                                                    .annual_user_report_4_victory
                                                    .tr,
                                        style: TextStyle(
                                          color: annualHobbyBetTime == 1
                                              ? Color(0xFF2C325E)
                                              : Colors.white,
                                          fontSize: TyTextScaler.instance().scale(isIPad ? 18.sp : 16.sp),
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        isIPad
                            ? Container(
                                margin: EdgeInsets.only(top: 250.h),
                                child: ImageView(
                                  width: 600.w,
                                  height: 500.h,
                                  'assets/images/nb/nb_panda_6.png',
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 200.h),
                                child: ImageView(
                                  width: 300.w,
                                  'assets/images/nb/nb_panda_6.png',
                                ),
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
        .replaceAll('\r', '\n') // 转换 '
        .replaceAll('%h', ' ');// 转换 '
    
  }
}
