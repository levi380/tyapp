import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../../generated/locales.g.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结注单(未结算)提前结算提示Dialog弹框 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示提前结算的结果或提示，提供用户确认的界面。
    - `state`：布尔值，表示提前结算的状态（成功或失败）。
    - `final bool state`：用于指示当前的状态，决定对话框中显示的内容。
    - 创建一个透明背景的 `AlertDialog`，包含自定义内容。
    - 创建对话框的主体内容，包括状态图标、提示文本和确认按钮。
    】】】
 *
 */
class EarlySettlementDialogPage extends StatelessWidget {
  const EarlySettlementDialogPage({Key? key, required this.state})
      : super(key: key);

  final bool state;

  @override
  Widget build(BuildContext context) {
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
      content: _body(
        context,
      ),
    );
  }

  /**
   * 弹框结构
   */
  Widget _body(BuildContext context) {
    return Container(
      width: 256.w,
      height: 160.h,
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
          ///内容说明
          _content(context),

          ///状态按钮
          _statusBox(context),
        ],
      ),
    );
  }

  /**
   * 内容说明
   */
  Widget _content(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (state)
            ImageView(
              'assets/images/bets/tandem_success.png',
              width: 22.w,
              height: 22.h,
            ),
          if (state)
            SizedBox(
              width: 12.w,
            ),
          Text(
            state
                ? LocaleKeys.early_btn5.tr
                : LocaleKeys.early_btn2.tr + LocaleKeys.early_btn4.tr,
            style: TextStyle(
              color: Color(
                context.isDarkMode ? 0xFFE9E9EA : 0xFF303442,
              ),
              fontSize: 16.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /**
   * 状态按钮
   */
  Widget _statusBox(BuildContext context) {
    return Container(
      height: 44.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color(
              context.isDarkMode ? 0xFF272931 : 0xFFF3FAFF,
            ),
          ),
        ),
      ),
      child: InkWell(
        onTap: () => {
          Navigator.of(context).pop(),
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            LocaleKeys.common_ok.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(
                context.isDarkMode ? 0xFF127DCC : 0xff179CFF,
              ),
              fontSize: 16.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
