import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/booking/booking_bets_logic.dart';
import '../../../../generated/locales.g.dart';
import '../../../../main.dart';
import '../../../extension/color_extension.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';

import '../../login/login_head_import.dart';

import 'modify_odds_keyboard_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(预约中)修改本金和赔率Widget视图 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能提供一个界面用于修改投注金额和赔率，支持动态显示和键盘输入。
    - `ModifyOddsView`：接收两个参数：
    - `index`：整数类型，表示当前注单的索引。
    - `data`：类型为 `GetH5PreBetOrderlistDataRecordxData`，包含相关数据。
    - 根据 `canBeModified` 状态决定是否显示金额和赔率输入框。
    - 使用 `Obx` 监听 `isOnKeyboard` 状态，以决定是否显示键盘。
    - 显示操作按钮（取消和确认）。
    - `amountsOddsDisplay` 方法用于展示金额和赔率的输入框。
    - `amountsDisplay` 和 `oddsDisplay` 方法分别用于显示金额和赔率的具体内容。
    - 点击金额框或赔率框时，切换到相应的键盘输入模式。
    - 提供增加和减少赔率的功能。
    - `_actionBox` 方法提供取消和确认按钮，调用 `logic.setModifyOdds` 方法处理相应的操作。
    】】】
 *
 */
class ModifyOddsView extends StatelessWidget {
  ModifyOddsView({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);
  final int index;
  final GetH5PreBetOrderlistDataRecordxData data;
  final logic = BookingBetsLogic.to;

  @override
  Widget build(BuildContext context) {
    bool canBeModified = data.canBeModified;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ///金额，盘口，赔率
        if (canBeModified)
          amountsOddsDisplay(context).marginOnly(
            bottom: 12.h,
          ),
        //赔率键盘
        if (canBeModified)
          Obx(() {
            bool isOnKeyboard = data.isOnKeyboard.value; // 确保这个是可观察的
            if (isOnKeyboard) {
              ///注单修改本金键盘
              return ModifyOddsKeyboardView(
                data: data,
              ).marginOnly(bottom: 12.h);
            } else {
              return Container();
            }
          }),

        ///注单  取消预约   修改本金按钮
        _actionBox(context, canBeModified),
      ],
    ).marginOnly(top: 8.h);
  }

  /*
   *金额，盘口，赔率
   */
  Widget amountsOddsDisplay(BuildContext context) {
    return Column(
      children: [
        ///金额框
        Obx(() {
          GetH5PreBetOrderlistDataRecordxDataDetailList detailList =
              data.detailList[0];
          var prompt =
              '${LocaleKeys.app_h5_bet_limit.tr}${detailList.orderLeastPay.value}-${detailList.orderMaxPay.value}';
          var modifyBetAmount = detailList.modifyBetAmount.value;
          return amountsDisplay(context, prompt, modifyBetAmount)
              .marginOnly(bottom: 6.w);
        }),

        ///锚点 4455需求屏蔽，预约注单修改盘口，暂时不上.......屏蔽就注释(95--99)
        ///盘口(只有部分注单才能修改盘口)
        /*   if (logic.isWhetherRulesChanged(
            data.detailList[0].sportId, data.detailList[0].playId))
          Obx(() {
            return gameMarket(context).marginOnly(bottom: 6.w);
          }),*/

        ///赔率框
        Obx(() {
          return oddsDisplay(context);
        }),
      ],
    );
  }

  /*
  *金额
  */
  Widget amountsDisplay(
      BuildContext context, String prompt, String modifyBetAmount) {
    var sideColor = Colors.transparent;
    if (data.isChangeAmount.value) {
      sideColor = Colors.red;
    } else if (data.isCutoverAmountodds.value == 0) {
      sideColor = Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF);
    }
    return SizedBox(
      width: double.maxFinite,
      height: 38.h,
      child: InkWell(
        ///点击金额，键盘切换到修改金额，并且展开键盘
        onTap: () => {
          data.isOnKeyboard.value = true,
          data.isCutoverAmountodds.value = 0,
        },
        child: Container(
          height: double.infinity,
          decoration: ShapeDecoration(
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.03999999910593033)
                : const Color(0xFFF2F2F6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
              side: BorderSide(width: 1.5, color: sideColor),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                modifyBetAmount.isNotEmpty ? modifyBetAmount : prompt,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.isDarkMode
                      ? modifyBetAmount.isEmpty
                          ? Colors.white.withValues(alpha: 0.20000000298023224)
                          : Colors.white.withValues(alpha: 0.8999999761581421)
                      : modifyBetAmount.isEmpty
                          ? const Color(0xFFAFB3C8)
                          : const Color(0xFF303442),
                  fontSize: modifyBetAmount.isEmpty ? 13.sp : 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                TYUserController.to.currCurrency(),
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442),
                  fontSize: isIPad ? 14.sp : 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ).paddingOnly(
            left: modifyBetAmount.isNotEmpty ? 15.w : 5.w,
            right: 8.w,
          ),
        ),
      ),
    );
  }

  /*
   *赔率
   */
  Widget oddsDisplay(BuildContext context) {
    var sideColor = Colors.transparent;
    if (data.isChangeOdds.value) {
      sideColor = Colors.red;
    } else if (data.isCutoverAmountodds.value == 2) {
      sideColor = Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF);
    }

    return SizedBox(
      width: double.maxFinite,
      height: 38.h,
      child: InkWell(
        ///点击赔率，键盘切换到修改赔率，并且展开键盘
        onTap: () => {
          data.isOnKeyboard.value = true,
          data.isCutoverAmountodds.value = 2,
        },
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          decoration: ShapeDecoration(
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.03999999910593033)
                : const Color(0xFFF2F2F6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
              side: BorderSide(width: 1.5, color: sideColor),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                ///减少赔率
                onTap: () => {
                  data.isCutoverAmountodds.value = 2,
                  logic.setModifyOdds(index, 0),
                },
                child: ImageView(
                  context.isDarkMode
                      ? 'assets/images/bets/component_darkmode_increase.png'
                      : 'assets/images/bets/component_decrease.png',
                  width: 16.w,
                  height: 16.h,
                ),
              ),
              Expanded(
                child: Text(
                  '@${data.detailList[0].oddFinallyChange.value}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.8999999761581421)
                        : const Color(0xFF303442),
                    fontSize: 13.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              InkWell(
                ///增加赔率
                onTap: () => {
                  data.isCutoverAmountodds.value = 2,
                  logic.setModifyOdds(index, 1),
                },
                child: ImageView(
                  context.isDarkMode
                      ? 'assets/images/bets/component_darkmode_decrease.png'
                      : 'assets/images/bets/component_increase.png',
                  width: 16.w,
                  height: 16.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*
 *盘口
 */
  Widget gameMarket(BuildContext context) {
    var sideColor = Colors.transparent;
    if (data.isCutoverAmountodds.value == 1) {
      sideColor = Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF);
    }

    return SizedBox(
      width: double.maxFinite,
      height: 38.h,
      child: InkWell(
        ///点击赔率，键盘切换到修改盘口，并且展开键盘
        onTap: () => {
          // data.isOnKeyboard.value = false,
          data.isCutoverAmountodds.value = 1,
        },
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          decoration: ShapeDecoration(
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.03999999910593033)
                : const Color(0xFFF2F2F6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
              side: BorderSide(width: 1.5, color: sideColor),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                ///减少赔率
                onTap: () => {
                  data.isCutoverAmountodds.value = 1,
                  logic.setModifyOdds(index, 6),
                },
                child: ImageView(
                  context.isDarkMode
                      ? 'assets/images/bets/component_darkmode_increase.png'
                      : 'assets/images/bets/component_decrease.png',
                  width: 16.w,
                  height: 16.h,
                ),
              ),
              Expanded(
                child: Text(
                  data.detailList[0].marketValueChange.value.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.8999999761581421)
                        : const Color(0xFF303442),
                    fontSize: 13.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              InkWell(
                ///增加赔率
                onTap: () => {
                  data.isCutoverAmountodds.value = 1,
                  logic.setModifyOdds(index, 7),
                },
                child: ImageView(
                  context.isDarkMode
                      ? 'assets/images/bets/component_darkmode_decrease.png'
                      : 'assets/images/bets/component_increase.png',
                  width: 16.w,
                  height: 16.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*
   *注单  取消预约   修改本金按钮
   */
  Widget _actionBox(BuildContext context, bool canBeModified) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          ///“取消”和“取消预约”按钮共同一个widget
          onTap: () => {
            logic.setModifyOdds(index, canBeModified ? 4 : 2),
          },
          child: Container(
            height: 35.h,
            padding: EdgeInsets.only(
                left: isIPad ? 50.w : 10.w, right: isIPad ? 50.w : 10.w),
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.w,
                  color: isFootballBasketballTemplate
                      ? HexColor(footballBasketballTemplateThemeColor)
                      : Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              canBeModified
                  ? LocaleKeys.common_cancel.tr
                  : LocaleKeys.app_h5_bet_cancel_appoint.tr,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isFootballBasketballTemplate
                    ? HexColor(footballBasketballTemplateThemeColor)
                    : Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                fontSize: 12.sp,
                height: 1.0,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ).marginOnly(right: 8.w),
        Expanded(
          child: InkWell(
            ///确定和修改赔率共同一个widget
            onTap: () => {logic.setModifyOdds(index, canBeModified ? 5 : 3)},
            child: Container(
              height: 35.h,
              decoration: ShapeDecoration(
                color: isFootballBasketballTemplate
                    ? HexColor(footballBasketballTemplateThemeColor)
                    : Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    canBeModified
                        ? LocaleKeys.app_h5_bet_confirm.tr
                        : LocaleKeys.common_edit.tr,
                    maxLines: 1,
                    minFontSize: 8,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
