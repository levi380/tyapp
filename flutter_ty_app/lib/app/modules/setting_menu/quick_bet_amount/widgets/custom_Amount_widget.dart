import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../global/ty_user_controller.dart';
import '../../../shop_cart/widgets/number_keyboard.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5177174d-b3ac-44f9-89be-505cb4a6b44a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 自定义快捷投注金额】】】
    【【【 AUTO_PARAGRAPH_TITLE 自定义快捷投注金额  自定义金额栏 组件 CustomAmountWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 自定义快捷投注金额  自定义金额栏 组件 CustomAmountWidget
    - CustomAmountWidget
    ```
    CustomAmountWidget(
        ///主题色
        isDark: context.isDarkMode,
        ///金额
        betAmount: controller.betAmount,
        onCloseVisibility: () => controller.onCloseVisibility(),
        textEditingController: controller.textEditingController,
        focusNode: controller.focusNode,
        onBackspace: () => controller.onBackspace(),
        onMaxInputText: () => controller.onMaxInputText(),
        onOK: () => controller.onOK(),
        onInsertText: (myText) => controller.onInsertText(myText),
    )
    ```
    】】】
 *
 */
class CustomAmountWidget extends StatelessWidget {
  const CustomAmountWidget({
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

  @override
  Widget build(BuildContext context) {
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
                  color: isDark ? const Color(0xFF1E2029) : Colors.white,
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
                      margin: EdgeInsets.only(
                          left: 15.w, right: 15.w, top: 15.h, bottom: 5.h),
                      padding: const EdgeInsets.all(12),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: isDark ? const Color(0xFF272931) : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5.w),
                            height: 30,
                            width: 2.w,
                            color: Colors.blue,
                          ),
                          Text(
                            LocaleKeys.app_h5_filter_customized_amount.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF303442),
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.bet_record_bet_val.tr,
                                  style: TextStyle(
                                    color: const Color(0xFF7981A3),
                                    fontSize: 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${LocaleKeys.app_h5_filter_lowest_money.tr} 10￥',
                                  style: TextStyle(
                                    color: const Color(0xFF7981A3),
                                    fontSize: 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 10.w,
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 40.h,
                              margin: EdgeInsets.only(
                                top: 10.w,
                                bottom: 10.h,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF272931)
                                    : const Color(0xFFF3FAFF),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                  left: 10.w,
                                  right: 10.h,
                                ),
                                child: TextField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  keyboardType: TextInputType.number,
                                  readOnly: true,
                                  autofocus: true,
                                  showCursor: true,
                                  cursorColor: Colors.blue,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : AppColor.backgroundColor,
                                    fontSize: 14.sp,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10.h),
                                    hintText:
                                        '${LocaleKeys.bet_record_bet_val.tr}  0',
                                    hintStyle: TextStyle(
                                      color: const Color(0xFF7981A3),
                                      fontSize:12.sp,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white.withValues(alpha:0.0)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white.withValues(alpha:0.0)),
                                    ),
                                    suffixIcon: Container(
                                      margin: EdgeInsets.all(
                                        10.h,
                                      ),
                                      child: Text(
                                        TYUserController.to.currCurrency(),
                                        style: TextStyle(
                                          color: const Color(0xFF7981A4),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    NumberKeyboard(
                      currentValue: textEditingController.text,
                      onTextInput: (myText) => onInsertText(myText),
                      onBackspace: onBackspace,
                      onCollapse: onCloseVisibility,
                      onMaxValue: onMaxInputText,
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
