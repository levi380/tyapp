import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';
import '../../../../../../generated/locales.g.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/image_view.dart';
import '../../../../unsettled_bets/widgets/rounded_triangleicon_view.dart';

class LapseBetHeadView extends StatelessWidget {
  final List<String> statistics;
  final betsTypes;
  final VoidCallback onTap;
  final bool isOpenTips;

  const LapseBetHeadView({
    Key? key,
    required this.statistics,
    required this.betsTypes,
    required this.onTap,
    required this.isOpenTips,
  }) : super(key: key);

  bool get _isSpecial => [
        'zh',
        'ko',
        'ar',
        'hi',
      ].contains(Get.locale?.languageCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 46.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _single(
            betsTypes == 0
                ? LocaleKeys.app_total_bookings.tr
                : LocaleKeys.app_total_bets.tr,
            statistics[0],
          ),
          _div(),
          _single(
            betsTypes == 0
                ? LocaleKeys.app_total_revenue.tr
                : LocaleKeys.app_stake.tr,
            formatNumber(statistics[0]),
          ),
          if (betsTypes == 0) ...[
            _div(),
            _singleSpecial(
              betsTypes == 0 ? LocaleKeys.app_estimated_profit.tr : "",
              statistics[2],
            ),
          ]
        ],
      ),
    );
  }

  Widget _single(String title, String number) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Get.isDarkMode
                    ? Colors.white.withValues(
                        alpha: 0.5,
                      )
                    : const Color(
                        0xFF7981A4,
                      ),
                fontSize: 10.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ).marginZero.marginOnly(
                  bottom: 2.h,
                ),
            Text(
              number,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Get.isDarkMode
                    ? Colors.white.withValues(alpha: 0.9)
                    : const Color(0xFF303442),
                fontSize: 14.sp,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _div() {
    return Container(
      width: 1.w,
      height: 27.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Colors.white.withValues(
                alpha: 0.08,
              )
            : const Color(
                0xFFE4E6ED,
              ),
      ),
    );
  }

  Widget _singleSpecial(String title, String number) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Get.isDarkMode
                          ? Colors.white.withValues(
                              alpha: 0.5,
                            )
                          : const Color(
                              0xFF7981A4,
                            ),
                      fontSize: 10.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ).marginOnly(right: 2.w),

                  ///警号图标
                  ImageView(
                    'assets/images/shopcart/icon_exclamation_mark2.png',
                    width: 13.h,
                    color: Get.theme.shopcartLabelColor,
                  ),
                ],
              ).marginZero.marginOnly(
                    bottom: 2.h,
                  ),
              Text(
                number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Get.isDarkMode
                      ? Colors.white.withValues(alpha: 0.9)
                      : const Color(0xFF303442),
                  fontSize: 14.sp,
                  fontFamily: 'Akrobat',
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///统计提示框多语言适配
  Widget _statisticsSpecialStyles(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: _isSpecial
              ? Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Get.isDarkMode
                        ? Colors.white.withValues(
                            alpha: 0.5,
                          )
                        : const Color(
                            0xFF7981A4,
                          ),
                    fontSize: 10.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Container(
                  width: 60.w,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Get.isDarkMode
                          ? Colors.white.withValues(
                              alpha: 0.5,
                            )
                          : const Color(
                              0xFF7981A4,
                            ),
                      fontSize: 10.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
        ).marginOnly(top: 10.h, right: 1.w),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///提示框图标
            Container(
              height: 10.h,
              child: isOpenTips
                  ? RoundedTriangleIconView(
                      size: 7.h, // 图标大小
                      color: Colors.black.withValues(
                          alpha: Get.isDarkMode ? 0.95 : 0.9), // 图标颜色
                    )
                  : Container(),
            ),
            Container(
              height: 2.h,
            ),

            ///警号图标
            ImageView(
              'assets/images/shopcart/icon_exclamation_mark2.png',
              width: 13.h,
              color: Get.theme.shopcartLabelColor,
            ),
          ],
        ),
      ],
    );
  }
}
