
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/main.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 篮球列表比分组件 VrLqItemTeamScoreWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 篮球列表比分组件 VrLqItemTeamScoreWidget
    - VrLqItemTeamScoreWidget
    ```
    VrLqItemTeamScoreWidget(
      isDark: isDark,
      teamIcon: recordsList[index].awayUrl,
      teamName: recordsList[index].awayName,
      score: recordsList[index].scoreResult.split(':')[1].toString()，
    )
    ,
    ```
    】】】
 *
 */

class VrLqItemTeamScoreWidget extends StatelessWidget {
  const VrLqItemTeamScoreWidget({
    super.key,
    required this.isDark,
    required this.teamIcon,
    required this.teamName,
    required this.score,
  });

  final bool isDark;
  final String teamIcon;
  final String teamName;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.only(
              right: 20.w,
            ),
            height: 34.h,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                ImageView(
                  teamIcon,
                  cdn: true,
                  width: 20.w,
                  height: 20.w,
                ).marginOnly(right: 8.w),
                Text(
                  teamName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white
                        : const Color(0xFF303442),
                    fontSize: isIPad ? 14.sp : 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 32.h,
                    padding: const EdgeInsets.symmetric(vertical: 1),
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
                      score,
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

              ],
            ),
          ),
        ),
      ],
    );
  }
}