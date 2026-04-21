
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_1.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_10.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_11.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_12.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_13.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_14.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_15.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_16.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_17.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_2.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_3.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_4.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_5.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_6.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_7.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_8.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_9.dart';
import '../../../../utils/oss_util.dart';



/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-488c53f4-9968-4535-b4cf-778c73d801d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐真人教程】】】
    【【【 AUTO_PARAGRAPH_TITLE  玩法判定 ZrTutorialDWidget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 玩法判定 ZrTutorialDWidget
    - ZrTutorialDWidget
    ```
    ///玩法判定
    ZrTutorialDWidget(
      isDark: context.isDarkMode,
      title: controller.tabList[controller.currentIndex],
    ),
    ```
    】】】
 *
 */


class ZrTutorialDWidget extends StatelessWidget {
  const ZrTutorialDWidget({
    super.key,
    required this.isDark,
    required this.title,
  });

  final bool isDark;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h, bottom: 30.h),
        decoration: isDark
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
                image: DecorationImage(
                  image: NetworkImage(
                    OssUtil.getServerPath(
                      'assets/images/icon/tutorial_background_darks.png',
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
          margin: EdgeInsets.only(top: 12.h, bottom: 24.h),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withValues(alpha:0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize:  18.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                color:
                    isDark ? const Color(0xFF4A4346) : const Color(0xFFF2F2F6),
                margin: EdgeInsets.only(
                  top: 12.h,
                ),
                height: 1.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Column(
                  children: [
                    ///1.庄&闲&和
                    ZrTutorialD1Widget(
                      isDark: isDark,
                    ),
                    ///2.庄对&闲对
                    ZrTutorialD2Widget(
                      isDark: isDark,
                    ),
                    ///3.任意对子
                    ZrTutorialD3Widget(
                      isDark: isDark,
                    ),
                    ///4.完美对子
                    ZrTutorialD4Widget(
                      isDark: isDark,
                    ),
                    ///5.超级对
                    ZrTutorialD5Widget(
                      isDark: isDark,
                    ),
                    ///6.龙7
                    ZrTutorialD6Widget(
                      isDark: isDark,
                    ),
                    ///7.熊猫8
                    ZrTutorialD7Widget(
                      isDark: isDark,
                    ),
                    ///8.大老虎&小老虎
                    ZrTutorialD8Widget(
                      isDark: isDark,
                    ),
                    ///9.老虎和
                    ZrTutorialD9Widget(
                      isDark: isDark,
                    ),
                    ///10.老虎对
                    ZrTutorialD10Widget(
                      isDark: isDark,
                    ),
                    ///11.庄天牌&闲天牌
                    ZrTutorialD11Widget(
                      isDark: isDark,
                    ),
                    ///12.天牌
                    ZrTutorialD12Widget(
                      isDark: isDark,
                    ),
                    ///13.龙&虎&和
                    ZrTutorialD13Widget(
                      isDark: isDark,
                    ),
                    ///14.超级六
                    ZrTutorialD14Widget(
                      isDark: isDark,
                    ),
                    ///15.庄龙宝&闲龙宝
                    ZrTutorialD15Widget(
                      isDark: isDark,
                    ),
                    ///16.超和
                    ZrTutorialD16Widget(
                      isDark: isDark,
                    ),
                    ///17.大小
                    ZrTutorialD17Widget(
                      isDark: isDark,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
