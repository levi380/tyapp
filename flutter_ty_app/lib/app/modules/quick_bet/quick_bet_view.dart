import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/quick_bet/widgets/quick_bet_item.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';
import '../../../generated/locales.g.dart';
import '../../services/models/res/bet_result_entity.dart';
import '../../widgets/image_view.dart';
import 'quick_bet_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-371b80cf-eae4-4d1e-aa5e-bbccef933e87 】】】
    【【【 AUTO_DOCUMENT_MENU 一键投注弹窗 】】】
    【【【 AUTO_DOCUMENT_TITLE 视图层 】】】
    【【【 AUTO_PARAGRAPH_TITLE 组件拆分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - obx控制视图最外层状态
    - 视图支持全屏，全屏不可设置.h .w
    - 主要是一键投注列表展示
    】】】
 *
 */
class QuickBetComponent extends StatelessWidget {
  QuickBetComponent({Key? key}) : super(key: key);

  final controller = QuickBetController.to;
  final state = QuickBetController.to.state;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Obx(() {
        // 一键投注开关、新流程开关、组件控制开关
        if (controller.checkHide()) {
          return Container();
        }

        double boxWidth = controller.fullscreen.value
            ? (isIPad ? 240 : 240)
            : (isIPad
                ? 240.w
                : TyTextScaler.instance().textScaleFactor != 1
                    ? 240.w
                    : 240.w);
        boxWidth += getDiscountLength();

        return SafeArea(
          // left: controller.fullscreen.value ? true : false,
          left: false,
          top: false,
          right: false,
          bottom: false,
          child: SizedBox(
            width: boxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    controller.isClose.value = true;
                  },
                  child: ImageView(
                    Get.isDarkMode
                        ? 'assets/images/quick_bet/quick-bet-close-icon-night.svg'
                        : 'assets/images/quick_bet/quick-bet-close-icon.svg',
                    width: controller.fullscreen.value ? 24 : 24.w,
                  ).marginOnly(
                      bottom: controller.fullscreen.value ? 12 : 12.h,
                      left: controller.fullscreen.value ? 12 : 12.w),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.only(
                      top: controller.fullscreen.value ? 7 : 7.h),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                          controller.fullscreen.value ? 8 : 8.r),
                      bottomRight: Radius.circular(
                          controller.fullscreen.value ? 8 : 8.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      // 全屏5条  非全屏10条
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.orderRespList
                            .take(controller.fullscreen.value ? 5 : 10)
                            .toList()
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          BetResultOrderDetailRespList item =
                              controller.orderRespList[index];
                          return QuickBetItem(
                            item: item,
                            controller: controller,
                          );
                        },
                      ),
                      Container(
                        height: controller.fullscreen.value ? 1 : 1.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        // margin: EdgeInsets.only(
                        //     top: controller.fullscreen.value ? 2 : 2.h),
                      ),
                      // 注单开关
                      Container(
                        height: controller.fullscreen.value
                            ? (isIPad ? 44 : 44)
                            : (isIPad ? 44.h : 44.h),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            // vertical: controller.fullscreen.value ? 8 : 8.h,
                            horizontal: controller.fullscreen.value ? 8 : 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                LocaleKeys.bet_one_click_bet.tr,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: controller.fullscreen.value
                                      ? (isIPad ? 14 : 12)
                                      : (isIPad ? 14.sp.scale : 12.sp.scale),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'PingFang SC',
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.closeOneClickBetting();
                              },
                              child: ImageView(
                                Get.isDarkMode
                                    ? 'assets/images/quick_bet/quick-bet-switch-open-night.svg'
                                    : 'assets/images/quick_bet/quick-bet-switch-open.svg',
                                width: controller.fullscreen.value ? 32 : 32.w,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ).marginOnly(bottom: controller.fullscreen.value ? 0 : 91.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  bool isLastCharacterDigit(String input) {
    RegExp regExp = RegExp(r'\d$');
    return regExp.hasMatch(input);
  }

  double getDiscountLength() {
    double discountLength = controller.hasDiscountOdds
        ? (controller.fullscreen.value
            ? 40
            : (TyTextScaler.instance().textScaleFactor != 1 ? 80.w : 40.w))
        : 0;
    return discountLength;
  }
}
