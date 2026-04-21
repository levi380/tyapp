
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
    【【【 AUTO_PARAGRAPH_TITLE 年报 8 号模版 Report8Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 8 号模版 Report8Widget
    - Report8Widget
    ```
    Report8Widget(
      Template:Template,
      pandaAnimationController: controller.pandaAnimationController,
      upperSlipAnimation: controller.upperSlipAnimation,
      pandaIsVisible: controller.pandaIsVisible,
      animationController: controller.animationController,
      isPlaying: controller.isPlaying,
      pauseMusic: () => controller.pauseMusic(),
      playMusic: () => controller.playMusic(),
      onSaveToPhoto: () => controller.onSaveToPhoto(),
      content: Get.locale?.languageCode == 'zh' ? controller.reportPO[index].contentZh :Get.locale?.languageCode == 'tw' ?  controller.reportPO[index].contentTw : controller.reportPO[index].contentEn,
      resultList: getResultList(index),
    )
    ```
    】】】
 *
 */
class Report8Widget extends StatelessWidget {
  const Report8Widget({
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
    required this.resultList,
  });
  final GetUserAnnualReportTemplateDataReportPO Template;
  final Animation<double>  upperSlipAnimation;
  final AnimationController pandaAnimationController;
  final bool pandaIsVisible;
  final AnimationController animationController;
  final bool isPlaying;
  final VoidCallback? pauseMusic;
  final VoidCallback? playMusic;
  final VoidCallback? onSaveToPhoto;
  final dynamic resultList;

  @override
  Widget build(BuildContext context) {
    /// 提取数字和文字
    List<Map<String, String>> xList = [];
    if(resultList != null){
      /// 解析 JSON
      Map<String, dynamic> jsonData = jsonDecode(resultList);

      /// 遍历 JSON 数据，提取数字和文字
      jsonData.forEach((key, value) {
        xList.add({'number': key, 'text': value});
      });
      /// 按数字排序
      xList.sort((a, b) => int.parse(a['number']!).compareTo(int.parse(b['number']!)));
    }
    String? countryCode = Get.locale?.countryCode.toString();
    String content = countryCode== 'CN'
        ? Template.contentZh
        : countryCode == 'TW'
        ? Template.contentTw
        : Template.contentEn;
    final annualReportController = Get.find<AnnualReportController>();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            OssUtil.getServerPath(
              'assets/images/nb/nb_bg_22.jpg',
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
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 25.w, top: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                  top: 5.h,
                                  bottom: 5.h,
                                ),
                                child: Text(
                                  content,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: TyTextScaler.instance().scale(isIPad ? 18.sp : 16.sp),
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                height: isIPad ? 430.h :290.h,
                                child: xList.isNotEmpty ?
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 0,
                                      child: AnimatedBuilder(
                                        animation: annualReportController.leftSlipAnimation,
                                        builder: (context, child) {
                                          return Transform.translate(
                                            offset: Offset( annualReportController.leftSlipAnimation.value,0),
                                            child: child,
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top: 0.h),
                                          child: ImageView(
                                            'assets/images/nb/nb_left.png',
                                            width: 17.w,
                                            height: 17.w,
                                            color:  Color(0xFF2C325E),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 4,
                                      child: PageView.builder(
                                        itemCount: (xList.length / 4).ceil(),
                                        itemBuilder: (context, pageIndex) {
                                          return ListView.builder(
                                            itemCount: 4,
                                            itemBuilder: (context, index) {
                                              int itemIndex = pageIndex * 4 + index;
                                              if (itemIndex < xList.length) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                                                  height: 60.h,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFF009BFF),
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          width: 4, color: Colors.white),
                                                      borderRadius: BorderRadius.circular(120),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 1.w, top: 1.h, bottom: 1.h),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          width: 60.w,
                                                          height: 60.w,
                                                          decoration: ShapeDecoration(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(120),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Get.locale?.languageCode == 'zh' || Get.locale?.languageCode == 'tw' ?
                                                              Text(
                                                                xList[itemIndex]['number'].toString()+' '+ getMonth(int.parse(xList[itemIndex]['number'].toString())),
                                                                style: TextStyle(
                                                                  color: Color(0xFF2C325E),
                                                                  fontSize: TyTextScaler.instance().scale(isIPad ? 23.sp : 21.sp),
                                                                  fontFamily: 'PingFang SC',
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ) :
                                                              Text(
                                                                getMonth(int.parse(xList[itemIndex]['number'].toString())),
                                                                style: TextStyle(
                                                                  color: Color(0xFF2C325E),
                                                                  fontSize: TyTextScaler.instance().scale(16.sp),
                                                                  fontFamily: 'PingFang SC',
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(width: 10),
                                                        Container(
                                                          width: isIPad ? null : 200.w,
                                                          child: Text(
                                                            xList[itemIndex]['text'].toString(),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            textAlign: TextAlign.start,
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: TyTextScaler.instance().scale(isIPad ? 18.sp : 16.sp),
                                                              fontFamily: 'PingFang SC',
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return SizedBox.shrink(); // 空白占位
                                              }
                                            },
                                          );
                                        },
                                      ) ,
                                    ),
                                    Expanded(
                                      flex: 0,
                                      child: AnimatedBuilder(
                                        animation: annualReportController.rightSlipAnimation,
                                        builder: (context, child) {
                                          return Transform.translate(
                                            offset: Offset(annualReportController.rightSlipAnimation.value,0 ),
                                            child: child,
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top: 0.h),
                                          child: Container(
                                            margin: EdgeInsets.only(top: 0.h),
                                            child: ImageView(
                                              'assets/images/nb/nb_right.png',
                                              width: 17.w,
                                              height: 17.w,
                                              color:  Color(0xFF2C325E),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                :Container(),
                              )


                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 0.h),
                          child: ImageView(
                            'assets/images/nb/nb_panda_22.png',
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
              isWhite: false,
              onSaveToPhoto: onSaveToPhoto,
              upperSlipAnimation: upperSlipAnimation,
            )
          ],
        ),
      ),
    );
  }

   getMonth(int month) {
    if(month==1){
      return  LocaleKeys.annual_user_report_0_moon1.tr;
    }else if (month==2){
      return  LocaleKeys.annual_user_report_0_moon2.tr;
    }else if (month==3){
      return  LocaleKeys.annual_user_report_0_moon3.tr;
    }else if (month==4){
      return  LocaleKeys.annual_user_report_0_moon4.tr;
    }else if (month==5){
      return  LocaleKeys.annual_user_report_0_moon5.tr;
    }else if (month==6){
      return  LocaleKeys.annual_user_report_0_moon6.tr;
    }else if (month==7){
      return  LocaleKeys.annual_user_report_0_moon7.tr;
    }else if (month==8){
      return  LocaleKeys.annual_user_report_0_moon8.tr;
    }else if (month==9){
      return  LocaleKeys.annual_user_report_0_moon9.tr;
    }else if (month==10){
      return  LocaleKeys.annual_user_report_0_moon10.tr;
    }else if (month==11){
      return  LocaleKeys.annual_user_report_0_moon11.tr;
    }else if (month==12){
      return  LocaleKeys.annual_user_report_0_moon12.tr;
    }
  }
}
