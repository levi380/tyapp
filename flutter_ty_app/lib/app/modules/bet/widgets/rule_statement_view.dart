

import '../../../../generated/locales.g.dart';
import '../../login/login_head_import.dart';
import '../../unsettled_bets/dialog/rule_statement_dialog/rule_statement_dialog.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(未结算)提前兑现规则说明视图Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能点击后弹出规则声明对话框。
    - `RuleStatementView`：无参数构造函数，使用默认的 `Key`。
    - `build` 方法返回一个可点击的容器，包含文本和图标。
    - 使用 `InkWell` 包裹整个组件，提供点击反馈。
    - 点击时，通过 `Get.dialog` 显示 `RuleStatementDialogPage` 对话框，设置背景色为半透明黑色。
    - 显示规则声明的文本，文本样式根据当前主题（暗黑模式或亮色模式）进行调整。
    - 文本支持国际化，使用 `LocaleKeys` 进行多语言处理。
    - 使用 `Row` 和 `Spacer` 进行水平布局，确保文本和图标的对齐。
    - 文本和图标的大小和间距使用响应式单位（如 `w` 和 `h`），确保在不同屏幕上的适配性。
    】】】
 *
 */
class RuleStatementView extends StatelessWidget {
  const RuleStatementView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Get.dialog(
          const RuleStatementDialogPage(),
          barrierColor: Colors.black.withValues(alpha:0.8),
        ),
      },
      child: Container(
        margin: EdgeInsets.only(top: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              width: 195.w,
              alignment: Alignment.centerRight,
              child: Text(
                LocaleKeys.app_h5_cathectic_cash_rules.tr,
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha:0.30000001192092896)
                      : const Color(0xFFAFB3C8),
                  fontSize: 11.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ).marginOnly(right: 2.w),
            ImageView(
              'assets/images/bets/prompt_nor.png',
              width: 13.w,
              height: 13.w,
            )
          ],
        ),
      ),
    );
  }
}
