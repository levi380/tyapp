import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../utils/oss_util.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结注单(未结算)提前结算说明Dialog弹框 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示有关现金规则的说明，提供用户理解相关条款的界面。
    - 无特定属性，所有内容均在状态类中定义。
    - 创建与该对话框关联的状态类 `_RuleStatementDialogState`。
    - 创建一个透明背景的 `AlertDialog`，包含自定义内容。
    - 创建对话框的主体内容，包括背景图、标题、说明文本和关闭按钮。
    - 设置对齐、内边距和背景颜色。
    - 设置宽度、圆角和背景图像，根据当前主题选择不同的背景。
    - 包含标题文本、分隔线、说明文本和关闭按钮。
    - 显示规则标题，字体样式根据主题调整。
    - 用于视觉上分隔标题和说明部分。
    - 显示规则说明，支持多行文本格式。
    - 点击后关闭对话框，具有边框和背景色。
    】】】
 *
 */
class RuleStatementDialogPage extends StatefulWidget {
  const RuleStatementDialogPage({Key? key}) : super(key: key);

  @override
  State<RuleStatementDialogPage> createState() => _RuleStatementDialogState();
}

class _RuleStatementDialogState extends State<RuleStatementDialogPage> {
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
      content: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      width: 256.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.r,
            ),
          ),
          image: DecorationImage(
            image: NetworkImage(
              OssUtil.getServerPath(
                context.isDarkMode
                    ? 'assets/images/bets/nighttime_bg.png'
                    : 'assets/images/bets/daytime_bg.png',
              ),
            ),
            fit: BoxFit.cover,
          ),
          color: Colors.white),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 16.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.app_h5_cathectic_cash_rules.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.8999999761581421)
                  : const Color(0xFF303442),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.07999999821186066)
                    : const Color(0xFFE4E6ED)),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    child: Text(
                      '${LocaleKeys.app_h5_cathectic_explain1.tr}\n${LocaleKeys.app_h5_cathectic_explain2.tr}',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                                  .withValues(alpha: 0.8999999761581421)
                              : const Color(0xFF303442),
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                          height: 1.75.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          InkWell(
            onTap: () => {
              Navigator.of(context).pop(),
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Color(
                      context.isDarkMode ? 0xFF127DCC : 0xff179CFF,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.ac_rules_understand.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(
                        context.isDarkMode ? 0xFF127DCC : 0xff179CFF,
                      ),
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
