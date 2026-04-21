import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../utils/oss_util.dart';
import '../../../utils/ty_text_scaler.dart';
import 'annual_report_title_widget.dart';

class Report0Widget extends StatelessWidget {
  const Report0Widget({
    super.key,
    required this.pandaAnimationController,
    required this.upperSlipAnimation,
    required this.pandaIsVisible,
    required this.nbAnimation,
    required this.bgAnimation,
    required this.onProductionReport,
    required this.animationController,
    required this.isPlaying,
    required this.pauseMusic,
    required this.playMusic,
    required this.onSaveToPhoto,
  });

  final AnimationController pandaAnimationController;
  final Animation<double> upperSlipAnimation;
  final bool pandaIsVisible;
  final Animation<double> nbAnimation;
  final Animation<double> bgAnimation;
  final VoidCallback? onProductionReport;

  final AnimationController animationController;
  final bool isPlaying;
  final VoidCallback? pauseMusic;
  final VoidCallback? playMusic;
  final VoidCallback? onSaveToPhoto;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            OssUtil.getServerPath(
              'assets/images/nb/nb_bg_0.jpg',
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
                        AnimatedBuilder(
                          animation: nbAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: nbAnimation.value,
                              child: Container(
                                margin: EdgeInsets.only(top: 50.h),
                                child: Column(
                                  children: [
                                    ImageView(
                                      'assets/images/nb/tittle1_2025.png',
                                      width: isIPad ? 400 : 220.w,
                                      height: isIPad ? 150 : 80.h,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10.h),
                                      child: Text(
                                        LocaleKeys
                                            .annual_user_report_0_report.tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: TyTextScaler.instance().scale(isIPad ? 18.sp : 16.sp) ,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        isIPad
                            ? Container(
                                margin: EdgeInsets.only(top: 40.h),
                                width: 600.w,
                                height: 600.h,
                                child: ImageView(
                                  'assets/images/nb/body1.png',
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 40.h),
                                width: 333.w,
                                height: 383.h,
                                child: ImageView(
                                  'assets/images/nb/body1.png',
                                ),
                              ),
                        AnimatedBuilder(
                          animation: bgAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: bgAnimation.value,
                              child: GestureDetector(
                                onTap: onProductionReport,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        OssUtil.getServerPath(
                                          'assets/images/nb/nb_sc.png',
                                        ),
                                      ),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      LocaleKeys
                                          .annual_user_report_0_generate.tr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0xFF2C325E),
                                        fontSize: 22.sp ,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 15.h,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 13.w, right: 13.w),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(),
                        ),

                        GestureDetector(
                          onTap: onSaveToPhoto,
                          child: Container(
                            height: 30.h,
                            decoration: ShapeDecoration(
                              color: Colors.white.withValues(alpha:0.5),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 10.w, right: 10.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ImageView(
                                    'assets/images/nb/nb_xz.png',
                                    color: Colors.white,
                                    width: 15.w,
                                    height: 15.w,
                                  ),
                                  Container(
                                    width: 5.w,
                                  ),
                                  Text(
                                    LocaleKeys.annual_user_report_0_save.tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: TyTextScaler.instance().scale(isIPad ? 14.sp :12.sp) ,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
