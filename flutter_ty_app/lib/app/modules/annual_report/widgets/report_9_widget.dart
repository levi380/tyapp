

import 'package:flutter_ty_app/app/modules/annual_report/annual_report_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:flutter_ty_app/main.dart';

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
    【【【 AUTO_PARAGRAPH_TITLE 年报 9 号模版 Report8Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 9 号模版 Report8Widget
    - Report8Widget
    ```
    Report9Widget(
      Template:Template,
      pandaAnimationController: controller.pandaAnimationController,
      upperSlipAnimation: controller.upperSlipAnimation,
      pandaIsVisible: controller.pandaIsVisible,
      animationController: controller.animationController,
      isPlaying: controller.isPlaying,
      pauseMusic: () => controller.pauseMusic(),
      playMusic: () => controller.playMusic(),
      onSaveToPhoto: () => controller.onSaveToPhoto(),
      bgAnimation: controller.annualTitleAnimation,
      content: Get.locale?.languageCode == 'zh' ? controller.reportPO[index].contentZh :Get.locale?.languageCode == 'tw' ?  controller.reportPO[index].contentTw : controller.reportPO[index].contentEn,
    )
    ```
    】】】
 *
 */
class Report9Widget extends StatelessWidget {
  const Report9Widget({
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
    required this.bgAnimation,
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
  final Animation<double> bgAnimation;

  @override
  Widget build(BuildContext context) {
    final annualReportController = Get.find<AnnualReportController>();
    String? countryCode = Get.locale?.countryCode.toString();
    String content = countryCode == 'CN'
        ? Template.contentZh
        : countryCode == 'TW'
        ? Template.contentTw
        : Template.contentEn;
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
                    child: Stack(
                      children: [

                        isIPad ?
                        Container(
                          margin: EdgeInsets.only(top: 550.h),
                          child: ImageView(
                            'assets/images/nb/nb_panda_23.png',
                            height: 300.h,
                            width: 600.w,
                          ),
                        ):
                        Container(
                          margin: EdgeInsets.only(top: 400.h),
                          child: ImageView(
                            'assets/images/nb/nb_panda_23.png',
                            height: 350.h,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 25.w, right: 25.w,top: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: ()=> annualReportController.onTitlePopUp(),
                                child:Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 5.h,
                                        bottom: 5.h,
                                      ),
                                      child: Text(
                                        content,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isIPad ? 30.sp : 18.sp,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    ImageView(
                                      'assets/images/nb/nb_Info.png',
                                      width: 22.w,
                                      height: 22.w,
                                    ).marginOnly(left: 5.w),
                                  ],
                                ),
                              ),



                              Stack(
                                children: [
                                  Container(
                                    height: 600.h,
                                    margin: EdgeInsets.only(
                                      top: 10.h,
                                    ),
                                    child: Row(
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
                                          child: Container(
                                            height: 600.h,
                                            child: PageView.builder(
                                              itemCount: (annualReportController.annualUserTitle.length / 4).ceil(), // 每页 4 个项目
                                              itemBuilder: (context, pageIndex) {
                                                return GridView.builder(
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 10.w,
                                                    mainAxisSpacing: 10.w,
                                                    childAspectRatio: isIPad ? 1.4: 0.8,
                                                  ),
                                                  itemCount: 4,
                                                  itemBuilder: (context, index) {
                                                    final colorIndex = pageIndex * 4 + index;
                                                    if (colorIndex >= annualReportController.annualUserTitle.length) return Container(); // 防止越界
                                                    return AnimatedBuilder(
                                                      animation: bgAnimation,
                                                      builder: (context, child) {
                                                        return Transform.scale(
                                                          scale: bgAnimation.value,
                                                          child: Container(
                                                            width: 200.w,
                                                            height: 187.h,
                                                            decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                image: NetworkImage(
                                                                  OssUtil.getServerPath(
                                                                    'assets/images/nb/nb_ch.png',
                                                                  ),
                                                                ),
                                                                fit: BoxFit.fitHeight,
                                                              ),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets.only(top: 0.h),
                                                                  alignment: Alignment.center,
                                                                  child: ImageView(
                                                                    width: 60.w,
                                                                    height: 60.h,
                                                                    'assets/images/nb/ch/zj_'+ annualReportController.annualUserTitle[colorIndex].titleId.toString()+'.png',
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 130.w,
                                                                  margin: EdgeInsets.only(top: 0.h),
                                                                  height: Get.locale?.countryCode == 'GB' ? 45.h  : null,
                                                                  alignment: Alignment.topCenter,
                                                                  child: Text(
                                                                    Get.locale?.countryCode == 'CN' ?  annualReportController.annualUserTitle[colorIndex].titleNameCn :Get.locale?.countryCode == 'TW' ?  annualReportController.annualUserTitle[colorIndex].titleNameTw : annualReportController.annualUserTitle[colorIndex].titleNameEn,
                                                                    maxLines: 3,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      color: Color(0xFF2C325E),
                                                                      fontSize: 17.sp,
                                                                      fontFamily: 'eryaxindahei',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                                // Container(
                                                                //   width: 80.w,
                                                                //   margin: EdgeInsets.only(top: 5.h),
                                                                //   height: 60,
                                                                //   alignment: Alignment.center,
                                                                //   child: Text(
                                                                //     Get.locale?.countryCode == 'CN' ?  annualReportController.annualUserTitle[colorIndex].titleDescribeCn :Get.locale?.countryCode == 'TW' ?  annualReportController.annualUserTitle[colorIndex].titleDescribeTw : annualReportController.annualUserTitle[colorIndex].titleDescribeEn,
                                                                //     textAlign: TextAlign.center,
                                                                //     maxLines: 2,
                                                                //     overflow: TextOverflow.ellipsis,
                                                                //     style: TextStyle(
                                                                //       color: Color(0xFF878DBA),
                                                                //       fontSize: TyTextScaler.instance().scale(10.sp),
                                                                //       fontFamily: 'PingFang SC', fontWeight:
                                                                //     FontWeight.w400,
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
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
                                    ),
                                  ),
                                  if(annualReportController.logic.titlePopUp )
                                    Center(
                                      child: Container(
                                        height: 600.h,
                                        margin: EdgeInsets.only(
                                          top: 20.h,
                                        ),
                                        width: isIPad ? 600.w: 300.w,
                                        alignment: Alignment.center,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 15.w,
                                              strokeAlign: BorderSide.strokeAlignOutside,
                                              color: Colors.white,
                                            ),
                                            borderRadius: BorderRadius.circular(10.r),
                                          ),
                                        ),
                                        child: Container(
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 8.w,
                                                strokeAlign: BorderSide.strokeAlignOutside,
                                                color: const Color(0xFFd3eeff),
                                              ),
                                              borderRadius: BorderRadius.circular(10.r),
                                            ),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.white,
                                                const Color(0xFFd3eeff),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.all(5.w),
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 4.w,
                                                  strokeAlign: BorderSide.strokeAlignOutside,
                                                  color: Colors.white,
                                                ),
                                                borderRadius: BorderRadius.circular(10.r),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 30.h,
                                                  alignment: Alignment.centerRight,
                                                  padding: EdgeInsets.only(right: 20.w),
                                                  child: GestureDetector(
                                                    onTap: () => annualReportController.onTitlePopUp(),
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 20,
                                                      color: const Color(0x66878EBB),

                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    child: ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      itemCount: annualReportController.annualUserTitle.length,
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.vertical,
                                                      physics: const BouncingScrollPhysics(),
                                                      itemBuilder: (context, Index) {
                                                        return Container(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(left: 15.w,right: 15.w,top: 10.h),
                                                                alignment: Alignment.centerLeft,
                                                                child: Text(
                                                                  Get.locale?.countryCode == 'CN' ?  annualReportController.annualUserTitle[Index].titleNameCn :Get.locale?.countryCode == 'TW' ?  annualReportController.annualUserTitle[Index].titleNameTw : annualReportController.annualUserTitle[Index].titleNameEn,
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                    color: Color(0xFF2C325E),
                                                                    fontSize: 18.sp,
                                                                    fontFamily: 'PingFang SC',
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(left: 15.w,right: 15.w,top: 10.h),
                                                                alignment: Alignment.centerLeft,
                                                                child: Text(
                                                                  Get.locale?.countryCode == 'CN' ?  annualReportController.annualUserTitle[Index].titleDescribeCn :Get.locale?.countryCode == 'TW' ?  annualReportController.annualUserTitle[Index].titleDescribeTw : annualReportController.annualUserTitle[Index].titleDescribeEn,
                                                                  textAlign: TextAlign.start,
                                                                  maxLines: 3,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                    color: Color(0xFF878EBB),
                                                                    fontSize: 14.sp,
                                                                    fontFamily: 'PingFang SC',
                                                                    fontWeight:
                                                                    FontWeight.w400,
                                                                  ),
                                                                ),
                                                              ),

                                                              Container(
                                                                width: double.infinity,
                                                                decoration: ShapeDecoration(
                                                                  shape: RoundedRectangleBorder(
                                                                    side: BorderSide(
                                                                      width: 0.2.h,
                                                                      strokeAlign: BorderSide.strokeAlignCenter,
                                                                      color: const Color(0x66878EBB),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ).marginOnly(top: 10.h),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              )


                            ],
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
            ),


          ],
        ),
      ),
    );
  }
}
