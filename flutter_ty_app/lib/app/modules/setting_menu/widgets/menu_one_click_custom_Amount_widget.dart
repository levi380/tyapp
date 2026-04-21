import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import '../../../../../generated/locales.g.dart';
import '../../../core/format/common/module/format-currency.dart';
import '../../../global/ty_user_controller.dart';
import '../../shop_cart/widgets/balance_refresh_widget.dart';
import 'menu_one_click_number_keyboard.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-f8e965b2-b88c-4808-9861-fc1a918660f9-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 一键投注】】】
    【【【 AUTO_PARAGRAPH_TITLE 设置菜单 一键投注金额设置 组件  MenuOneClickCustomAmountWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 设置菜单 一键投注金额设置 组件 MenuOneClickCustomAmountWidget
    - MenuOneClickCustomAmountWidget
    ```
    ///一键投注金额设置
    MenuOneClickCustomAmountWidget(
      isDark: context.isDarkMode,
      betAmount: controller.betAmount,
      onCloseVisibility: () => controller.onCloseVisibility(),
      textEditingController: controller.textEditingController,
      focusNode: controller.focusNode,
      onBackspace: () => controller.onBackspace(),
      onMaxInputText: () => controller.onMaxInputText(),
      onOK: () => controller.onOK(),
      onInsertText: (myText) => controller.onInsertText(myText),
      replaceText: (myText) => controller.replaceText(myText),
      min: controller.min,
      singleList: controller.singleList,
    )
    ```
    】】】
 *
 */
class MenuOneClickCustomAmountWidget extends StatelessWidget {
  const MenuOneClickCustomAmountWidget({
    super.key,
    required this.isDark,
    required this.betAmount,
    required this.onCloseVisibility,
    required this.textEditingController,
    required this.focusNode,
    required this.onBackspace,
    required this.onMaxInputText,
    required this.onOK,
    required this.onInsertText,
    required this.replaceText,
    required this.min,
    required this.singleList,
  });

  final bool isDark;
  final bool betAmount;
  final VoidCallback? onCloseVisibility;
  final dynamic textEditingController;
  final dynamic focusNode;
  final VoidCallback? onBackspace;
  final VoidCallback? onMaxInputText;
  final VoidCallback? onOK;
  final void Function(dynamic) onInsertText;
  final void Function(dynamic) replaceText;
  final int min;
  final List<int> singleList;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Visibility(
      visible: betAmount,
      child: Stack(
        children: [
          GestureDetector(
            onTap: onCloseVisibility,
            child: Container(
              height: double.maxFinite,
              color: Colors.black.withValues(alpha:0.6),
            ),
          ),
          Column(
            children: [
              const Expanded(child: SizedBox()),
              Container(
                margin: EdgeInsets.only(
                  bottom: 15.h,
                  right: 15.w,
                ),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    InkWell(
                      onTap: onCloseVisibility,
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withValues(alpha:0.4),
                        ),
                        child: const Icon(
                          Icons.close_sharp,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: ShapeDecoration(
                  color: context.isDarkMode
                      ? const Color(0xFF1E2029)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 12.h, bottom: 8.h),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: context.isDarkMode
                            ? const Color(0xFF272931)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                LocaleKeys.bet_one_click_bet.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: context.isDarkMode
                                      ? Colors.blue
                                      : Color(0xFF303442),
                                  fontSize: 16.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Container(
                              height: 28,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: ShapeDecoration(
                                color: themeData.shopcartContentBackgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => Text(
                                      TYFormatCurrency.formatCurrency(
                                          TYUserController
                                              .to.balanceAmount.value),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: const Color(0xFF303442),
                                        fontSize: 20.sp,
                                        fontFamily: 'Akrobat',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  BalanceRefreshWidget(
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                      ),
                      padding: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                      ),
                      decoration: ShapeDecoration(
                        color: context.isDarkMode
                            ? const Color(0xFF272931)
                            : const Color(0xFFF3FAFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.bet_record_bet_val.tr,
                                style: TextStyle(
                                  color: context.isDarkMode
                                      ? const Color(0xFF303442)
                                      : themeData.shopcartTextColor,
                                  fontSize: 14.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 5.w),
                                    height: 16.h,
                                    width: 2.w,
                                    color: const Color(0xFF179CFF),
                                  ),
                                  Text(
                                    '${LocaleKeys.app_h5_filter_lowest_money.tr} ',
                                    style: TextStyle(
                                      color: const Color(0xFF7981A3),
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${min}${' '}',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '${' (${TYUserController.to.currCurrency()})'}',
                                    style: TextStyle(
                                      color: const Color(0xFF7981A3),
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Expanded(child:SizedBox()),
                          Container(
                            height: 40.h,
                            width: 164.w,
                            margin: EdgeInsets.only(
                              top: 10.h,
                              bottom: 10.h,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: context.isDarkMode
                                  ? const Color(0xFF272931)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                left: 10.w,
                                right: 10.h,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: textEditingController,
                                      focusNode: focusNode,
                                      keyboardType: TextInputType.number,
                                      readOnly: true,
                                      autofocus: true,
                                      showCursor: true,
                                      cursorColor: Colors.blue,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: context.isDarkMode
                                            ? Colors.white
                                            : AppColor.backgroundColor,
                                        fontSize: 14.sp,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                                        hintText: LocaleKeys.bet_record_bet_val.tr,
                                        hintStyle: TextStyle(
                                          color: const Color(0xFF7981A3),
                                          fontSize: 12.sp,
                                        ),

                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white.withValues(alpha:0.0)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white.withValues(alpha:0.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      TYUserController.to.currCurrency(),
                                      style: TextStyle(
                                        color: const Color(0xFF7881A3),
                                        fontSize: 14.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    MenuOneClickNumberKeyboard(
                      currentValue: textEditingController.text,
                      quickValues: singleList,
                      onTextInput: (myText) => onInsertText(myText),
                      onBackspace: onBackspace,
                      onCollapse: onCloseVisibility,
                      onMaxValue: onMaxInputText,
                      onTextSet: (myText) => replaceText(myText),
                    ),
                    InkWell(
                      onTap: onOK,
                      child: Container(
                        height: 45.h,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                            left: 15.w, right: 15.w, bottom: 30.h),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF179CFF), Color(0xFF45B0FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            LocaleKeys.common_ok.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
