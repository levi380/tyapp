import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';
import '../../../bet_ty_cp_zr/ty/bets/booking/booking_bets_logic.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结注单(预约中)取消Dialog弹框 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于确认用户是否取消预约，提供用户选择的界面。
    - `key`：可选的键，用于标识此组件。
    - `index`：整数，表示要取消的预约索引。
    - `final int index`：用于标识要取消的预约。
    - 创建一个透明背景的 `AlertDialog`，包含自定义内容。
    - `BuildContext context`：构建上下文。
    - `BookinBetsLogic logic`：用于处理取消预约的逻辑。
    - **功能**：
    - 创建对话框的主体内容，包括提示文本和确认/取消按钮。
    】】】
 *
 */
class CancelAppointmentDialogPage extends StatelessWidget {
  const CancelAppointmentDialogPage({Key? key, required this.index})
      : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final logic = BookingBetsLogic.to;
    return AlertDialog(
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        0,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        0,
      ),
      titlePadding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        0,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      //SingleChildScrollView
      content: _body(context, logic),
    );
  }

  Widget _body(BuildContext context, BookingBetsLogic logic) {
    return Container(
      width: 256.w,
      height: 180.h,
      decoration: ShapeDecoration(
        color: context.isDarkMode ? const Color(0xFF1E2029) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x4C000000),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.app_h5_cathectic_kind_tips.tr,
                  style: TextStyle(
                    color: Color(context.isDarkMode ? 0xFFE9E9EA : 0xFF303442),
                    fontSize: 16.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.h, right: 10.h),
                  alignment: Alignment.topCenter,
                  child: Text(
                    LocaleKeys.app_h5_cathectic_confirm_cancel_reservation.tr,
                    style: TextStyle(
                      color: const Color(0xFF7981A4),
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 44.h,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Color(context.isDarkMode ? 0xFF272931 : 0xFFF3FAFF),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => {
                      Navigator.of(context).pop(),
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        LocaleKeys.common_cancel.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(
                              context.isDarkMode ? 0xFF67696F : 0xFFAFB3C8),
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 44.h,
                  width: 1.w,
                  color: Color(context.isDarkMode ? 0xFF272931 : 0xFFF3FAFF),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => {
                      logic.cancelPreBetOrder(index),
                      Navigator.of(context).pop(),
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        LocaleKeys.common_ok.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(
                              context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
