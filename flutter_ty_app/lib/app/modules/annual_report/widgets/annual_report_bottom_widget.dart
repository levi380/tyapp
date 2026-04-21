import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../../main.dart';
import '../../../utils/ty_text_scaler.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1509bbab-4a30-49cc-837f-3535741f55b4-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  年报】】】
    【【【 AUTO_PARAGRAPH_TITLE 年报 底部按钮组件 AnnualReportBottomWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 底部按钮组件 AnnualReportBottomWidget
    - AnnualReportBottomWidget
    ```
    AnnualReportBottomWidget(
      isWhite: true,
      onSaveToPhoto: onSaveToPhoto,
      upperSlipAnimation: upperSlipAnimation,
    )
    ```
    】】】
 *
 */
class AnnualReportBottomWidget extends StatelessWidget {
  const AnnualReportBottomWidget({
    super.key,
    required this.isWhite,
    required this.onSaveToPhoto,
    required this.upperSlipAnimation,
  });

  final bool isWhite;
  final VoidCallback? onSaveToPhoto;
  final Animation<double>  upperSlipAnimation;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                Container(
                  width: 100,
                ),
                Container(
                  child: Column(
                    children: [

                      AnimatedBuilder(
                        animation: upperSlipAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, upperSlipAnimation.value),
                            child: child,
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 0.h),
                          child: ImageView(
                            'assets/images/nb/nb_sh.png',
                            width: 17.w,
                            height: 17.w,
                            color: isWhite ? Colors.white : Color(0xFF2C325E),
                          ),
                        ),
                      ),
                      Text(
                       LocaleKeys.annual_user_report_0_swipe.tr,
                        style: TextStyle(
                          color: isWhite ? Colors.white : Color(0xFF2C325E),
                          fontSize: TyTextScaler.instance().scale(isIPad ? 16.sp : 14.sp),
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
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
                            color: isWhite ? Colors.white : Color(0xFF2C325E),
                            width: 15.w,
                            height: 15.w,
                          ),
                          Container(
                            width: 5.w,
                          ),
                          Text(
                            LocaleKeys.annual_user_report_0_save.tr,
                            style: TextStyle(
                              color: isWhite ? Colors.white : Color(0xFF2C325E),
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
    );
  }
}
