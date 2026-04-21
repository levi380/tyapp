
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../main.dart';
import '../../../services/models/res/get_user_annual_report_template_entity.dart';
import '../../../utils/oss_util.dart';
import '../../../utils/utils.dart';
import '../annual_report_controller.dart';
import 'annual_report_bottom_widget.dart';
import 'annual_report_title_widget.dart';

import '../../../../generated/locales.g.dart';
import 'package:intl/intl.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1509bbab-4a30-49cc-837f-3535741f55b4-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  年报】】】
    【【【 AUTO_PARAGRAPH_TITLE 年报 6 号模版 Report6Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 6 号模版 Report6Widget
    - Report6Widget
    ```
    Report6Widget(
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
class Report6Widget extends StatelessWidget {
  Report6Widget({
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
  final annualReportController = Get.find<AnnualReportController>();
  late final  int annualHobbyBetTime = annualReportController.logic.annualHobbyBetTime;
  @override
  Widget build(BuildContext context) {
    String annualMaxBetAmountCreateTime = Get.locale?.countryCode == 'GB' ?  annualReportController.logic.annualMaxBetAmountCreateTime :DateFormat('yyyy'+LocaleKeys.zr_cp_bet_Window_year.tr+'MM'+LocaleKeys.zr_cp_bet_Window_month.tr+'dd'+LocaleKeys.zr_cp_bet_Window_day.tr+'').format(DateTime.parse(annualReportController.logic.annualMaxBetAmountCreateTime)).toString();
    String? countryCode = Get.locale?.countryCode.toString();
    String content = countryCode == 'CN'
        ? Template.contentZh
        : countryCode == 'TW'
        ? Template.contentTw
        : Template.contentEn;
    String annualMaxBetAmountTournamentIdName = "";
    String annualMaxBetAmountMatchIdName = "";
    String annualMaxBetCurrency = "";
    String annualMaxBetAmountPlayOptionName = "";

    if (countryCode == 'TW') {
      content = Template.contentTw.replaceAll(RegExp(r'\r\s+'), '\r');
      annualMaxBetAmountTournamentIdName =
          "annualMaxBetAmountTournamentIdNameTw";
      annualMaxBetAmountMatchIdName = "annualMaxBetAmountMatchIdNameTw";
      annualMaxBetCurrency = "annualMaxBetCurrencyCn";
      annualMaxBetAmountPlayOptionName = "annualMaxBetAmountPlayOptionNameTw";
    } else if (Get.locale?.countryCode == 'CN') {
      content = Template.contentZh.replaceAll(RegExp(r'\r\s+'), '\r');
      annualMaxBetAmountTournamentIdName =
          "annualMaxBetAmountTournamentIdNameCn";
      annualMaxBetAmountMatchIdName = "annualMaxBetAmountMatchIdNameCn";
      annualMaxBetCurrency = "annualMaxBetCurrencyCn";
      annualMaxBetAmountPlayOptionName = "annualMaxBetAmountPlayOptionNameCn";
    } else {
      content = Template.contentEn;
      annualMaxBetAmountTournamentIdName =
          "annualMaxBetAmountTournamentIdNameEn";
      annualMaxBetAmountMatchIdName = "annualMaxBetAmountMatchIdNameEn";
      annualMaxBetCurrency = "annualMaxBetCurrencyEn";
      annualMaxBetAmountPlayOptionName = "annualMaxBetAmountPlayOptionNameEn";
    }
    content = content
        .replaceAll(
            '%sannualMaxSettleAmountCreateTime%s',
            '%h' +
                annualMaxBetAmountCreateTime +
                '%h')
        .replaceAll(
            '%s$annualMaxBetAmountTournamentIdName%s',
            '%h' +
                annualReportController.logic.annualMaxBetAmountTournamentIdName +
                '%h')
        .replaceAll('%s$annualMaxBetAmountMatchIdName%s',
            '%h' + annualReportController.logic.sannualMaxBetAmountMatchIdName + '%h')
        .replaceAll('%sannualMaxBetAmount%s',
            '%h' + annualReportController.logic.annualMaxBetAmount + '%h')
        .replaceAll('%sannualMaxBetAmountPercentRank%s',
            '%h' + annualReportController.logic.annualMaxBetAmountPercentRank + '%%h')
        .replaceAll('%s$annualMaxBetCurrency%s',
            '%h' + annualReportController.logic.annualMaxBetCurrency + '%h')
        .replaceAll(
            '%s$annualMaxBetAmountPlayOptionName%s',
            '%h' +
                annualReportController.logic.annualMaxBetAmountPlayOptionName +
                '%h');

    content = decodeHtmlEntities(content);
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
                                        strutStyle: StrutStyle(height: 1.8),
                                        text: TextSpan(
                                            children: _getStyledText(content, [
                                              annualMaxBetAmountCreateTime,
                                          annualReportController
                                              .logic.annualMaxBetAmountTournamentIdName,
                                          annualReportController
                                              .logic.sannualMaxBetAmountMatchIdName,
                                          annualReportController
                                              .logic.annualMaxBetAmount,
                                          annualReportController
                                                  .logic.annualMaxBetAmountPercentRank +
                                              '%',
                                          annualReportController
                                              .logic.annualMaxBetCurrency,
                                          annualReportController
                                              .logic.annualMaxBetAmountPlayOptionName
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
                                margin: EdgeInsets.only(top: 120.h),
                                child: ImageView(
                                  'assets/images/nb/nb_panda_20.png',
                                  height: 500.h,
                                  width: 600.w,
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 70.h),
                                child: ImageView(
                                  'assets/images/nb/nb_panda_20.png',
                                  height: 350.h,
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

    /// 按%h分割字符串为单词
    List<String> words = text.split('%h');

    for (var word in words) {
      if (wordsToStyle.contains(word)) {
        spans.add(TextSpan(
          text: '$word',
          style: TextStyle(
            color: annualHobbyBetTime == 1 ? Color(0xFF2C325E) : Colors.white,
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
              color:  annualHobbyBetTime == 1 ? Color(0xFF2C325E) : Colors.white,
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
