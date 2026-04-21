import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../utils/amount_util.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-409e307b-dbbb-44b3-97fa-a03a45f3b225-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞头部 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞头部 电竞标题控件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞标题控件
    # `_buildBalance`

    - `余额控件`
    根据不同金钱符号，显示不同图标

    ```
    Visibility(
    visible: TYUserController.to.currCurrency() == 'USDT',
    child: ImageView('assets/images/home/icon_trans_nor_USDT.svg',
    width: 16.w, height: 16.w),),
    Visibility(
    visible: TYUserController.to.currCurrency() == 'RMB',
    child: ImageView('assets/images/home/icon_trans_nor_RMB.svg',
    width: 16.w, height: 16.w),),
    ```
    - `未登录 默认显示0.00`，余额为空显示“-”

    ```
    RouteCheckUtil.checkIsLogin() == false ? '0.00':
    controller.balance.value != null
    ? controller.toAmountSplit(controller.balance.value!.amount.toStringAsFixed(2))
    : '-',
    ```

    】】】
 *
 */
class DJHeaderWidget extends StatefulWidget {
  const DJHeaderWidget({super.key});


  @override
  State<DJHeaderWidget> createState() => _DJHeaderWidgetState();
}
/// 电竞标题控件
class _DJHeaderWidgetState extends State<DJHeaderWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      padding:  EdgeInsets.symmetric(horizontal: 14.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
              ///底部菜单刷新
              MainTabController.to.update();
              MainTabController.to.startAutoScroll();
            },
            child: Container(
              width: 24.w,
              height: 24.w,
              alignment: Alignment.center,
              child: ImageView(
                DJController.to.DJState.djBackArrow,
                boxFit: BoxFit.fill,
                width: 20.w,
                svgColor:  context.isDarkMode? Colors.white:Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                LocaleKeys.menu_itme_name_esports.tr,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: context.isDarkMode? Colors.white.withValues(alpha:0.9): Colors.black,
                  fontSize: 18.sp.scale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          _buildBalance(),
        ],
      ),
    );
  }
/// 余额控件
  Widget _buildBalance() {
    return GetBuilder<TYUserController>(builder: (controller) {
      return Container(
        height: 22.w,
        padding: EdgeInsets.only(
          left: 6.w,
          right: 6.w,
        ),
        margin: EdgeInsets.only(left: 8.w),
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha:0.03999999910593033)
              : const Color(0xFFF2F2F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            TYUserController.to.getBalance();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: TYUserController.to.currCurrency() == 'USDT',
                child: ImageView(DJController.to.DJState.currencyUsdtIcon,
                    width: 16.w, height: 16.w),
              ),
              Visibility(
                visible: TYUserController.to.currCurrency() == 'RMB',
                child: ImageView(DJController.to.DJState.currencyRmbIcon,
                    width: 16.w, height: 16.w),
              ),
              Container(
                width: 5.w,
              ),
              Container(
                ///80498产品要求 余额过长省略显示
                alignment: Alignment.center,
                child: Text(
                  ///未登录 默认显示0.00
                  RouteCheckUtil.checkIsLogin() == false
                      ? '0.00'
                      : controller.balance.value != null
                      ? controller.toAmountSplit(AmountUtil.numberFormat(
                      controller.balance.value!.amount))
                      : '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.isDarkMode
                        ? const Color(0xE5FFFFFF)
                        : const Color(0xFF303442),
                    fontSize: 14.sp.scale,
                    fontFamily: 'DIN Alternate',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
