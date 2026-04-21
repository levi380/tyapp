
import '../../../../../login/login_head_import.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-06de67a4-485b-4b00-91a1-b8c4546e388e-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 子玩法 】】】
    【【【 AUTO_PARAGRAPH_TITLE 特色组合指示器Widget组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 特色组合指示器Widget组件 featureTempIndicator
    - isSelected 是否在当前页面
    】】】
 *
 */
///指示器Widget抽取
Widget featureTempIndicator(BuildContext context, bool isSelected) {
  Color color = isSelected
      ? (context.isDarkMode
      ?  const Color(0xFF127DCC)
      : const Color(0xff179CFF))
      : (context.isDarkMode
      ? const Color(0xFF127DCC).withValues(alpha:0.4)
      : const Color(0xff179CFF).withValues(alpha:0.4));
  double width = isSelected ? 6.w : 4.w;
  return  Container(
    height: 2.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2.h),
      color: color,
    ),
    width: width,
  );
}