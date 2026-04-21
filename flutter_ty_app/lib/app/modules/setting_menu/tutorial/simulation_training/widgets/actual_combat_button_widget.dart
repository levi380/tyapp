import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';





/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 大小球模拟训练 按钮组件 ActualCombatButtonWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 大小球模拟训练 按钮组件  ActualCombatButtonWidget
    - ActualCombatButtonWidget
    ```
    ActualCombatButtonWidget(
      isDark: context.isDarkMode,
      title: LocaleKeys.app_h5_handicap_tutorial_actual_combat.tr,
      onTap: () => controller.onBack(),
    )
    ```
    】】】
 *
 */
class ActualCombatButtonWidget extends StatelessWidget {
  const ActualCombatButtonWidget({
    super.key,
    required this.isDark,
    required this.title,
    this.onTap,
  });

  final bool isDark;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        width: 300.w,
        margin: EdgeInsets.only(top: 40.h),
        alignment: Alignment.center,
        decoration: context.isDarkMode
            ? ShapeDecoration(
                color: Colors.white.withValues(alpha:0.07999999821186066),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.white.withValues(alpha:0.11999999731779099),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              )
            : ShapeDecoration(
                color: const Color(0xFF333333),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
