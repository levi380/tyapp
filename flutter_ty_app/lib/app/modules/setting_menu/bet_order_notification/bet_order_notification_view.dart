import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/bet_order_notification/widgets/bet_order_notification_switch_button_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/bet_order_notification/widgets/bet_order_notification_switch_item_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/bet_order_notification/widgets/bet_order_notification_title_widget.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../../main.dart';

import 'bet_order_notification_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 设置菜单 注单通知视图 BetOrderNotificationPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 设置菜单 注单通知视图
    - BetOrderNotificationPage
    - 设置菜单 注单通知视图
    】】】
 *
 */
class BetOrderNotificationPage extends StatefulWidget {
  const BetOrderNotificationPage({Key? key}) : super(key: key);

  @override
  State<BetOrderNotificationPage> createState() => _BetOrderNotificationPageState();
}

class _BetOrderNotificationPageState extends State<BetOrderNotificationPage> {
  final controller = Get.find<BetOrderNotificationController>();
  final logic = Get.find<BetOrderNotificationController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BetOrderNotificationController>(
      builder: (controller) {
        return Container(
          color: context.isDarkMode
              ? const Color(0xFF1E2029)
              : const Color(0xFFF2F2F6),
          height: isSDK == false ? 680.h : 600.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///头部组件
                _title(),

                ///允许通知
                _allowNotifications(),

                ///公告
                _announcement(),

                ///通知列表
                if (controller.allowNotifications) _notifications(),
              ],
            ),
          ),
        );
      },
    );
  }

  ///头部
  Widget _title() {
    return BetOrderNotificationTitleWidget(
      isDark: context.isDarkMode,

      ///注单通知
      //title: LocaleKeys.app_betOrderNotification.tr,
      title:"",

      ///设置菜单
      subtitle: LocaleKeys.footer_menu_set_menu.tr,
    );
  }

  ///允许通知
  Widget _allowNotifications() {
    return BetOrderNotificationSwitchButtonWidget(
      ///允许通知
      title: LocaleKeys.app_allowNotifications.tr,
      isDark: context.isDarkMode,
      isSwitch: controller.allowNotifications,
      onTap:  () =>  controller.onButtonPressed(0),
      dividing: true,
    );
  }

  ///公告
  Widget _announcement() {
    return Container(
      margin: EdgeInsets.only(
        left: 30.w,
        right: 30.w,
        top: 5.h,
        bottom: 5.h,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        ///打开通知开关可及时获取注单状态更新
        LocaleKeys.app_turnOnNotificationsToGetBetStatusUpdates.tr,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: context.isDarkMode ? Colors.white : const Color(0xFF7981A4),
          fontSize: 14.sp,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  ///通知列表
  Widget _notifications() {
    return Container(
      margin: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
      ),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.03999999910593033)
            : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///投注成功
          _successfulBetting(),

          ///投注失败
          _lostBets(),

          ///预约单下注成功
          _theReservationOrderBetIsSuccessful(),

          ///预约失效
          _appointmentExpired(),
        ],
      ),
    );
  }

  ///投注成功
  Widget _successfulBetting() {
    return BetOrderNotificationSwitchItemWidget(
      ///投注成功,
      title: LocaleKeys.app_betSuccessful.tr,
      isDark: context.isDarkMode,
      isSwitch: controller.successfulBetting,
      onTap: () =>  controller.onButtonPressed(1),
      dividing: false,
    );
  }

  ///投注失败
  Widget _lostBets() {
    return BetOrderNotificationSwitchItemWidget(
      ///投注失败
      title: LocaleKeys.app_betFailed.tr,
      isDark: context.isDarkMode,
      isSwitch: controller.lostBets,
      onTap: () =>  controller.onButtonPressed(2),
      dividing: true,
    );
  }

  ///预约单下注成功
  Widget _theReservationOrderBetIsSuccessful() {
    return BetOrderNotificationSwitchItemWidget(
      ///预约单下注成功
      title: LocaleKeys.app_reservedBetPlacedSuccessfully.tr,
      isDark: context.isDarkMode,
      isSwitch: controller.theReservationOrderBetIsSuccessful,
      onTap:  () =>  controller.onButtonPressed(3),
      dividing: true,
    );
  }

  ///预约失效
  Widget _appointmentExpired() {
    return BetOrderNotificationSwitchItemWidget(
      ///预约失效
      title: LocaleKeys.app_reservationExpired.tr,
      isDark: context.isDarkMode,
      isSwitch: controller.appointmentExpired,
      onTap:  () =>  controller.onButtonPressed(4),
      dividing: true,
    );
  }

  @override
  void dispose() {
    Get.delete<BetOrderNotificationController>();
    super.dispose();
  }
}
