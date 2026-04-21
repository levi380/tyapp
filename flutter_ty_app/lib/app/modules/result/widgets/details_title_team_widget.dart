import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';

import '../../../services/models/res/match_entity.dart';
import '../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果 赛果详情战队 组件 DetailsTitleTeamWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果 赛果详情战队  组件 DetailsTitleTeamWidget
    - DetailsTitleTeamWidget
    ```
    /// 赛果详情战队
    DetailsTitleTeamWidget(titleIndex: titleIndex, matchItem: matchItem, isDark: isDark, isHome: true),
    ```
    】】】
 *
 */
class DetailsTitleTeamWidget extends StatelessWidget {
  const DetailsTitleTeamWidget({
    super.key,
    required this.titleIndex,
    required this.matchItem,
    required this.isDark,
    required this.isHome,
  });

  final int titleIndex;
  final MatchEntity matchItem;
  final bool isDark;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    var imgList = isHome ? matchItem.mhlu : matchItem.malu;
    var teamText = isHome ? matchItem.mhn : matchItem.man;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        titleIndex == 1
            ? ImageView(
                imgList[0] ?? '',
                width: 33.w,
                height: 33.h,
                dj: true,
              )
            : ImageView(
                ObjectUtil.isNotEmpty((imgList as List).safe(0))
                    ? (imgList).safe(0)
                    : 'assets/images/home/home_team_logo.svg',
                cdn: true,
                width: 33.w,
                height: 33.h,
              ),
        Container(
          height: 10.w,
        ),
        Container(
          width: 115.w,
          height: 30.h,
          alignment: Alignment.topCenter,
          child: Text(
            teamText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF303442),
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
