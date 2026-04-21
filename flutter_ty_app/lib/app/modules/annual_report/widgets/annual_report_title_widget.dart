import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../annual_report_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1509bbab-4a30-49cc-837f-3535741f55b4-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  年报】】】
    【【【 AUTO_PARAGRAPH_TITLE 年报 头部组件 AnnualReportTitleWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 头部组件 AnnualReportTitleWidget
    - AnnualReportTitleWidget
    ```
    ///头部
    AnnualReportTitleWidget(
      animationController: animationController,
      isPlaying: isPlaying,
      pauseMusic: pauseMusic,
      playMusic: playMusic,
    )
    ```
    】】】
 *
 */

class AnnualReportTitleWidget extends StatelessWidget {
  const AnnualReportTitleWidget({
    super.key,
    required this.animationController,
    required this.isPlaying,
    required this.pauseMusic,
    required this.playMusic,
  });

  final AnimationController animationController;
  final bool isPlaying;
  final VoidCallback? pauseMusic;
  final VoidCallback? playMusic;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 13.w, right: 13.w),
      alignment: Alignment.topCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              final annualReportController = Get.find<AnnualReportController>();
              annualReportController.initFillingPoint(16);
              Get.back();
            },
            child: ImageView(
              'assets/images/nb/nb_back.png',
              width: 26.w,
              height: 26.w,
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle:
                    animationController.value * 2.0 * 3.141592653589793, // 旋转角度
                child: child,
              );
            },
            child: GestureDetector(
              onTap: isPlaying ? pauseMusic : playMusic,
              child: ImageView(
                isPlaying
                    ? 'assets/images/nb/nb_play.png'
                    : 'assets/images/nb/nb_pause.png',
                width: 26.w,
                height: 26.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
