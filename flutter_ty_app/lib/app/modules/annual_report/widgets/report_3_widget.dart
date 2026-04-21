import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';
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
    【【【 AUTO_PARAGRAPH_TITLE 年报 3 号模版 Report3Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 3 号模版 Report3Widget
    - Report3Widget
    ```
    Report3Widget(
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

class Report3Widget extends StatelessWidget {
  const Report3Widget({
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
    String sannualHobbySportNameR = "";
    String sannualHobbyPlayNameR = '';
    if (countryCode == 'CN') {
      content = Template.contentZh.replaceAll(RegExp(r'\r\s+'), '\r');
      sannualHobbySportNameR = "sannualHobbySportNameCn";
      sannualHobbyPlayNameR = 'sannualHobbyPlayNameCn';
    } else if (countryCode == 'TW') {
      content = Template.contentTw.replaceAll(RegExp(r'\r\s+'), '\r');
      sannualHobbySportNameR = "sannualHobbySportNameTw";
      sannualHobbyPlayNameR = 'sannualHobbyPlayNameTw';
    } else {
      content = Template.contentEn;
      sannualHobbySportNameR = "sannualHobbySportNameEn";
      sannualHobbyPlayNameR = "sannualHobbyPlayNameEn";
    }

    final annualReportController = Get.find<AnnualReportController>();

    content = content
        .replaceAll('%$sannualHobbySportNameR%s',
            '%h' + annualReportController.logic.annualHobbySportName + '%h')
        .replaceAll('%$sannualHobbyPlayNameR%s',
            '%h' + annualReportController.logic.annualHobbyPlayName + '%h')
        .replaceAll('%sannualHobbyPlayCount%s',
            '%h' + annualReportController.logic.annualHobbyPlayCount + '%h');
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
                            left: 25.w,
                            top: 30.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                      child: RichText(
                                        text: TextSpan(
                                          children: _getStyledText(content, [
                                            annualReportController
                                                .logic.annualHobbySportName,
                                            annualReportController
                                                .logic.annualHobbyPlayName,
                                            annualReportController
                                                .logic.annualHobbyPlayCount
                                          ]),
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
                                  'assets/images/nb/sport_' +annualReportController.logic.annualHobbySportBackgroundType.toString()+'.png',
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 200.h),
                                child: ImageView(
                                  width: 350.w,
                                  'assets/images/nb/sport_' +annualReportController.logic.annualHobbySportBackgroundType.toString()+'.png',
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
          text: '$word',
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
