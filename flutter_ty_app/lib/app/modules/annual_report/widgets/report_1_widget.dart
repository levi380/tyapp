import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/get_user_annual_report_template_entity.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';
import '../../../../generated/locales.g.dart';
import '../../../../main.dart';
import '../../../utils/oss_util.dart';
import '../annual_report_controller.dart';
import 'annual_report_bottom_widget.dart';
import 'annual_report_title_widget.dart';
import 'package:intl/intl.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1509bbab-4a30-49cc-837f-3535741f55b4-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  年报】】】
    【【【 AUTO_PARAGRAPH_TITLE 年报 1 号模版 Report1Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 1 号模版 Report1Widget
    - Report1Widget
    ```
    Report1Widget(
      Template:Template,
      pandaAnimationController: controller.pandaAnimationController,
      upperSlipAnimation: controller.upperSlipAnimation,
      isPlaying: controller.isPlaying,
      pandaIsVisible: controller.pandaIsVisible,
      animationController: controller.animationController,
      pauseMusic: () => controller.pauseMusic(),
      playMusic: () => controller.playMusic(),
      onSaveToPhoto: () => controller.onSaveToPhoto(),
    )
    ```
    】】】
 *
 */
class Report1Widget extends StatelessWidget {
  const Report1Widget({
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
    String? countryCode = Get.locale?.countryCode.toString();

    String content = countryCode == 'CN'
        ? Template.contentZh
        : countryCode == 'TW'
            ? Template.contentTw
            : Template.contentEn;
    final annualReportController = Get.find<AnnualReportController>();
    String userCreateTime = countryCode == 'GB' ?  annualReportController.logic.userCreateTime :DateFormat('yyyy'+LocaleKeys.zr_cp_bet_Window_year.tr+'MM'+LocaleKeys.zr_cp_bet_Window_month.tr+'dd'+LocaleKeys.zr_cp_bet_Window_day.tr+'').format(DateTime.parse(annualReportController.logic.userCreateTime)).toString();
    AppLogger.debug(userCreateTime);
    content = content
        .replaceAll('%suserCreateTime%s',
            '%h' +userCreateTime+ '%h')
        .replaceAll('%sdiffFriendTime%s',
            '%h' + annualReportController.logic.diffFriendTime + '%h');
    content = decodeHtmlEntities(content);
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
                          margin: EdgeInsets.only(
                              left: 25.w, top: 30.h, right: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: annualReportController
                                    .testAnimationController2,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: annualReportController
                                        .testOpacityAnimation2.value,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: annualReportController
                                                      .testFallAnimation2
                                                      .value <
                                                  0
                                              ? 0
                                              : annualReportController
                                                  .testFallAnimation2.value,
                                          bottom: 5.0),
                                      child: RichText(
                                        strutStyle: StrutStyle(height: 2),
                                        text: TextSpan(
                                            children: _getStyledText(content, [
                                          annualReportController.logic.userCreateTime,
                                          annualReportController.logic.diffFriendTime
                                        ])),
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
                                margin: EdgeInsets.only(top: 200.h),
                                width: 600.w,
                                height: 600.h,
                                child: ImageView(
                                  'assets/images/nb/nb_panda_1.png',
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 220.h),
                                width: 390.w,
                                height: 293.h,
                                child: ImageView(
                                  'assets/images/nb/nb_panda_1.png',
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

  /// 获取具有不同样式的 TextSpan 列表     /// 你需要样式的词
  List<TextSpan> _getStyledText(String text, List<String> wordsToStyle) {
    List<TextSpan> spans = [];

    /// 按空格分割字符串为单词
    List<String> words = text.split('%h');

    for (var word in words) {
      if (wordsToStyle.contains(word)) {
        spans.add(TextSpan(
          text: ' $word ',
          style: TextStyle(
            color: Colors.white,
            fontSize: isIPad ? 28.sp : 20.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.bold,
          ),
        ));
      } else {
        // 否则，正常显示
        spans.add(
          TextSpan(
            text: '$word',
            style: TextStyle(
              color: Colors.white,
              fontSize: isIPad ? 24.sp : 16.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }
    }

    return spans;
  }
}
