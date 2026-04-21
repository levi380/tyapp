import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';

import 'package:flutter_ty_app/generated/locales.g.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 杯赛积分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 规则dialog
    】】】
 *
 */
class AnalyzeTipDialog extends StatelessWidget {
  AnalyzeTipDialog({super.key, this.callback, this.isCup = true});

  final Function? callback;
  final bool isCup;
  final List<String> cupList = [
    LocaleKeys.analysis_football_matches_cup_rules_title.tr,
    LocaleKeys.analysis_football_matches_cup_rules_title2.tr,
    LocaleKeys.analysis_football_matches_cup_rules_title3.tr,
    LocaleKeys.analysis_football_matches_cup_rules_title4.tr,
  ];

  final List<String> combineList = [
    LocaleKeys.analysis_football_matches_league_rules_title.tr,
    LocaleKeys.analysis_football_matches_league_rules_title2.tr,
    LocaleKeys.analysis_football_matches_league_rules_title3.tr,
    LocaleKeys.analysis_football_matches_league_rules_title4.tr
  ];


  /// 构建规则提示对话框UI
  /// 根据isCup显示杯赛或联赛规则
  @override
  Widget build(BuildContext context) {
    List<String> dataList = isCup ? cupList : combineList;
    return Align(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    "assets/images/zr/analyze_ty_tip_bg.png",
                  ),
                ),
                fit: BoxFit.fill),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: EdgeInsets.symmetric(horizontal: 55.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 44.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: ScrollController(),
                child: Column(
                  children: [
                    Container(
                      height: 44.w,
                      alignment: Alignment.center,
                      child: Text(
                        dataList[0],
                        style: TextStyle(
                            fontSize: (14.sp),
                            color: AppColor.color303442,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Divider(
                      color: Color(
                        0xAFE4E6ED,
                      ),
                      height: 1.w,
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    Container(
                      child: Text(
                        dataList[1],
                        style: TextStyle(
                            fontSize: (12.sp), color: AppColor.color303442),
                      ),
                    ),
                    SizedBox(
                      height: 16.w,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        dataList[2],
                        style: TextStyle(
                            fontSize: (14.sp),
                            color: AppColor.color303442,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 4.w,
                    ),
                    Container(
                      child: Text(
                        dataList[3],
                        style: TextStyle(
                            fontSize: (12.sp), color: AppColor.color303442),
                      ),
                    ),
                    SizedBox(
                      height: 60.w,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 15.w,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    if (callback != null) {
                      callback!();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 36.w,
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    decoration: const BoxDecoration(
                      color: Color(0xff179CFF),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(
                      LocaleKeys.app_h5_bet_confirm.tr,
                      style: TextStyle(fontSize: (14.sp), color: Colors.white),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
