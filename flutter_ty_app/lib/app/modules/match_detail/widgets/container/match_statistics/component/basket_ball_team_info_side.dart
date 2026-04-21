import 'package:common_utils/common_utils.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';

import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import 'package:flutter_ty_app/main.dart';

/// 篮球队伍信息 - 单侧（主队或客队）
///
/// 展示队徽、队名及胜/平/负统计；[isAway] 为 true 时右对齐
class BasketBallTeamInfoSide extends StatelessWidget {
  final String teamName;
  final String? teamLogo;
  final int win;
  final int draw;
  final int lose;
  final bool isAway;

  const BasketBallTeamInfoSide({
    super.key,
    required this.teamName,
    this.teamLogo,
    required this.win,
    required this.draw,
    required this.lose,
    this.isAway = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment:
              isAway ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            _buildTeamRow(),
            SizedBox(height: 4.w),
            _buildTeamStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamRow() {
    return Row(
      mainAxisAlignment:
          isAway ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isAway) ...[
          _buildTeamLogo(),
          SizedBox(width: 4.w),
          _buildTeamName(),
        ] else ...[
          _buildTeamName(),
          SizedBox(width: 4.w),
          _buildTeamLogo(),
        ],
      ],
    );
  }

  Widget _buildTeamLogo() {
    final logoUrl = ObjectUtil.isNotEmpty(teamLogo)
        ? teamLogo!
        : 'assets/images/home/home_team_logo.svg';
    return Container(
      width: 30.w,
      height: 30.w,
      alignment: Alignment.center,
      child: ImageView(
        logoUrl,
        width: isIPad ? 30.w : 40.w,
        height: isIPad ? 30.w : 40.w,
        cdn: true,
        errorWidget: ImageView(
          'assets/images/detail/default_team_home.svg',
          width: 40.w,
          height: 40.w,
        ),
      ),
    );
  }

  Widget _buildTeamName() {
    return Container(
      alignment: isAway ? Alignment.centerRight : Alignment.centerLeft,
      constraints: BoxConstraints(maxWidth: 100.w),
      child: Text(
        teamName,
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        textAlign: isAway ? TextAlign.right : TextAlign.left,
        style: TextStyle(
          color: Get.theme.tabPanelSelectedColor,
          fontSize: isIPad ? 20.sp : 14.sp,
          fontFamily: 'PingFang SC',
        ),
      ),
    );
  }

  Widget _buildTeamStats() {
    return Text(
      '$win${LocaleKeys.analysis_football_matches_victory.tr}$draw${LocaleKeys.analysis_football_matches_flat.tr}$lose${LocaleKeys.analysis_football_matches_negative.tr}',
      maxLines: 1,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textAlign: isAway ? TextAlign.right : TextAlign.left,
      style: TextStyle(
        color: Get.theme.tabPanelSelectedColor,
        fontSize: isIPad ? 20.sp : 14.sp,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
