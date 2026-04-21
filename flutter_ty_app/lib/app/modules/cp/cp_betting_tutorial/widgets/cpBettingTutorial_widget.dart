
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';

import '../../../../utils/oss_util.dart';
import '../../../../widgets/image_view.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6413aae8-8a7e-47c0-9a74-e3720f3aa655-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 彩票投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票盘口教程 头部选项卡部件 CpBettingTutorialWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票盘口教程 头部选项卡部件 CpBettingTutorialWidget
    - CpBettingTutorialWidget
    ```
    CpBettingTutorialWidget(
      isDark: context.isDarkMode,
      title: controller.tabList[controller.currentIndex],
      img: controller.getLanguageImg(index),
    )
    ```
    】】】
 *
 */

class CpBettingTutorialWidget extends StatelessWidget {
  const CpBettingTutorialWidget({
    super.key,
    required this.isDark,
    required this.title,
    required this.img,
  });

  final bool isDark;
  final String title;
  final String img;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin:
            EdgeInsets.only(left: CpState.tutorialCardMarginLeft, right: CpState.tutorialCardMarginRight, top: CpState.tutorialCardMarginTop, bottom: CpState.tutorialCardMarginBottom),
        decoration: isDark
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
                image: DecorationImage(
                  image: NetworkImage(
                    OssUtil.getServerPath(
                      CpState.tutorialBgDark,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              )
            : BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(25.r),
                ),
              ),
        child: Container(
          margin: EdgeInsets.only(top: CpState.tutorialCardInnerMarginTop, bottom: CpState.tutorialCardInnerMarginBottom),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? CpState.tutorialTitleColorDark
                        : CpState.tutorialTitleColorLight,
                    fontSize: CpState.tutorialTitleSize,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                color:
                    isDark ? CpState.tutorialDividerColorDark : CpState.tutorialDividerColorLight,
                margin: EdgeInsets.only(
                  top: 12.h,
                ),
                height: 1.h,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
                child: ImageView(
                  img,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
