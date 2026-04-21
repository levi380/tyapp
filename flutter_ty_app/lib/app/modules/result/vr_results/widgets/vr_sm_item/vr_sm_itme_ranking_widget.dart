
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';



/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 篮球列表 VrSmItemRankingWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 篮球列表 VrSmItemRankingWidget
    - VrSmItemRankingWidget
    ```
      VrSmItemRankingWidget(
        isDark: isDark,
        rankingIcon: VrRankIconUtils.getRankIcon(int.parse(vRMenuMenuId),extractNumbers(recordsList[index].scoreResult)[1]),
        rankingName:LocaleKeys.virtual_sports_runner_up.tr,
        showImg: recordsList[index].scoreResult.isNotEmpty
      )
    ```
    】】】
 *
 */

class VrSmItemRankingWidget extends StatelessWidget {
  const VrSmItemRankingWidget({
    super.key,
    required this.isDark,
    required this.rankingIcon,
    required this.rankingName,
    required this.showImg,
  });

  final bool isDark;
  final String rankingIcon;
  final String rankingName;
  final bool showImg;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // // Text(
        // //   rankingName,
        // //   style: TextStyle(
        // //     color: isDark
        // //         ? Colors.white
        // //         : const Color(0xFF333333),
        // //     fontSize: isIPad ? 14.sp : 12.sp,
        // //     fontFamily: 'PingFang SC',
        // //     fontWeight: FontWeight.w400,
        // //   ),
        // // ),
        // Container(height: 5.h,),
        if(showImg == true)
          ImageView(
            rankingIcon,
            width: 22.w,
            height: 22.w,
          ),
      ],
    );
  }
}
