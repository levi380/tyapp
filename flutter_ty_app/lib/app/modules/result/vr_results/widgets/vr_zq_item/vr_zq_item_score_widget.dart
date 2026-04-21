import '../../../../../../main.dart';
import '../../../../login/login_head_import.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 赛果足球比分小组件 VrZqItemScoreWidgetWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 赛果足球比分小组件 VrZqItemScoreWidgetWidget
    - VrZqItemScoreWidgetWidget
    ```
    ///赛果足球比分小组件
    VrZqItemScoreWidgetWidget(
      firstHalfScore: formatScore(
      recordsList[index].scoreResult2,"S2")[1].toString(),
      fullScore: recordsList[index].scoreResult.split(':')[1].toString(),
      penaltyScore:recordsList[index].penaltyScore.isEmpty? '-': recordsList[index].penaltyScore.split(':')[1].toString(),
      isDark: isDark
    )
    ```
    】】】
 *
 */
class VrZqItemScoreWidgetWidget extends StatelessWidget {
  const VrZqItemScoreWidgetWidget({
    super.key,
    required this.firstHalfScore,
    required this.fullScore,
    required this.penaltyScore,
    required this.isDark,
  });

  final String firstHalfScore;
  final String fullScore;
  final String penaltyScore;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 32.h,
              decoration: ShapeDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                shadows: [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Text(
                firstHalfScore,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.90)
                      : const Color(0xFF303442),
                  fontSize: isIPad ? 14.sp : 12.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Akrobat',
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 32.h,
              margin: EdgeInsets.only(left: 2.w),
              decoration: ShapeDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                shadows: [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Text(
                fullScore,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.90)
                      : const Color(0xFF303442),
                  fontSize: isIPad ? 14.sp : 12.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'DIN Alternate',
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 32,
              margin: EdgeInsets.only(left: 2.w),
              decoration: ShapeDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                shadows: [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Text(
                penaltyScore,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF66BAFD),
                  fontSize: isIPad ? 14.sp : 12.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'DIN Alternate',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
