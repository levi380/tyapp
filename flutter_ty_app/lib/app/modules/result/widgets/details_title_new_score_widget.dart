import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果详情】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果详情  头部组件  热门赛事推荐 比分组件  DetailsTitleScoreWidget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果详情  头部组件  热门赛事推荐 比分组件    DetailsTitleScoreWidget
    - DetailsTitleScoreWidget
    】】】
 *
 */
class DetailsTitleNewScoreWidget extends StatelessWidget {
  const DetailsTitleNewScoreWidget({
    super.key,
    required this.isDark,
    required this.image,
    required this.title,
    required this.score,
    required this.titleIndex,
    required this.isHomeTeam,
  });

  final bool isDark;
  final String image;
  final String title;
  final String score;
  final int titleIndex;
  final bool isHomeTeam;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              titleIndex == 1
                  ? ImageView(
                      image,
                      dj: true,
                      width: 28.w,
                      height: 28.w,
                      errorWidget: ImageView(
                        isHomeTeam
                            ? 'assets/images/home/home_team_logo.svg'
                            : 'assets/images/detail/default_team_away.svg',
                        cdn: true,
                        width: 28.w,
                        height: 28.w,
                      ),
                    )
                  : ImageView(
                      image,
                      cdn: true,
                      width: 28.w,
                      height: 28.w,
                      errorWidget: ImageView(
                        isHomeTeam
                            ? 'assets/images/home/home_team_logo.svg'
                            : 'assets/images/detail/default_team_away.svg',
                        cdn: true,
                        width: 28.w,
                        height: 28.w,
                      ),
                    ),
              Container(
                width: 6.w,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: 180.w,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.90)
                        : const Color(0xFF303442),
                    fontSize: 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Text(
            score,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.90)
                  : const Color(0xFF303442),
              fontSize: 18.sp,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
