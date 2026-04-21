import 'package:flutter_ty_app/app/extension/map_extension.dart';

import '../../../../../../main.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/format_score_util.dart';
import '../../../../login/login_head_import.dart';
import '../../../constants/detail_constant.dart';
import '../../../controllers/match_detail_controller.dart';
import '../../../controllers/match_tools_methods.dart';
import '../middle/stage/match_stage.dart';
import '../../common_widget/team_logo.dart';

// 置顶头部
class PinnedAppbar extends StatefulWidget {
  const PinnedAppbar(
      {super.key, required this.match, required this.controller, this.tag});

  final MatchEntity match;
  final MatchDetailController controller;
  final String? tag;

  @override
  State<PinnedAppbar> createState() => _PinnedAppbarState();
}

class _PinnedAppbarState extends State<PinnedAppbar> {
  // 比分和红牌数值变化时设置时间
  Map<String, int> scoreTime = {"S1": 0, "S11": 0};

  // 是否显示主队红牌动画
  bool isShowHomeRed = false;

  // 是否显示客队红牌动画
  bool isShowAwayRed = false;

  @override
  void initState() {
    calRedStatus();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PinnedAppbar oldWidget) {
    if (widget.match.mid == oldWidget.match.mid && widget.match.csid == "1") {
      calRedStatus();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            /// 返回 增大触摸区域
            InkWell(
              onTap: () => widget.controller.back(),
              child: Container(
                width: 24.w,
                height: obtyAppbarHeight,
                alignment: Alignment.center,
                child: ImageView(
                  "assets/images/detail/icon_arrowleft_nor_night.svg",
                  boxFit: BoxFit.fill,
                  width: isIPad ? 14.w : 8.w,
                ),
              ),
            ),
          ],
        ),

        /// 赛事阶段状态
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TeamLogo(
              isHome: true,
              match: widget.match,
              isDJDetail: widget.controller.detailState.isDJDetail,
              size: 32.7.w,
              offset: 24.w,
            ),
            Container(
              width: 180.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isTopShowScore(widget.match) &&
                      !eSportsScoring(widget.match))
                    Text(
                      FormatScore.formatTotalScore(widget.match, 0).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isIPad ? 20.sp : 18.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'DIN',
                        height: 1.2,
                      ),
                    ).marginOnly(left: 8.w),
                  // 红牌
                  if (isShowHomeRed && widget.match.csid == "1")
                    IntrinsicHeight(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF53F3F),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.r)),
                        ),
                        margin: EdgeInsets.only(left: 4.w),
                        alignment: Alignment.center,
                        child: Text(
                          s11Score(widget.match).safe('home').toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isIPad ? 17.sp : 13.sp,
                            height: 1.1,
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      margin: EdgeInsets.only(top: 4.h, left: 4.w),
                    ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        widget.controller.detailState.scrollController
                            .jumpTo(0);
                      },
                      child: MatchStage(
                        match: widget.match,
                        isPinnedAppbar: true,
                      ),
                    ),
                  ),
                  // 红牌
                  if (isShowAwayRed && widget.match.csid == "1")
                    IntrinsicHeight(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF53F3F),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.r)),
                        ),
                        margin: EdgeInsets.only(right: 4.w),
                        alignment: Alignment.center,
                        child: Text(
                          s11Score(widget.match).safe('away').toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isIPad ? 17.sp : 13.sp,
                            height: 1.1,
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      margin: EdgeInsets.only(top: 4.h, right: 4.w),
                    ),
                  if (isTopShowScore(widget.match) &&
                      !eSportsScoring(widget.match))
                    Text(
                      FormatScore.formatTotalScore(widget.match, 1).toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: isIPad ? 20.sp : 18.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DIN'),
                    ).marginOnly(right: 8.w),
                ],
              ),
            ),
            TeamLogo(
              isHome: false,
              match: widget.match,
              isDJDetail: widget.controller.detailState.isDJDetail,
              size: 32.7.w,
              offset: 24.w,
            ),
          ],
        ),
      ],
    );
  }

  calRedStatus() {
    // 红牌
    Map<String, dynamic> newS11Score = s11Score(widget.match);

    // 主客队比分数值变化，则更新对应时间
    if (newS11Score["home"] > 0 || newS11Score["away"] > 0) {
      scoreTime["S11"] = DateTime.now().millisecondsSinceEpoch;
    }

    // 主队
    if (newS11Score["home"] > 0) {
      isShowHomeRed = true;
    } else {
      isShowHomeRed = false;
    }
    // 客队
    if (newS11Score["away"] > 0) {
      isShowAwayRed = true;
    } else {
      isShowAwayRed = false;
    }
  }

  // 红牌比分
  Map<String, int> s11Score(MatchEntity match) {
    final score = {'home': 0, 'away': 0};
    List<String> msc = match.msc;
    for (final item in msc) {
      if (item.contains('|')) {
        final parts = item.split('|');
        if (parts.length >= 2 && parts[0] == 'S11') {
          final scoreParts = parts[1].split(':');
          if (scoreParts.length == 2) {
            score['home'] = int.tryParse(scoreParts[0]) ?? 0;
            score['away'] = int.tryParse(scoreParts[1]) ?? 0;
            break; // 找到就退出循环
          }
        }
      }
    }

    return score;
  }
}
