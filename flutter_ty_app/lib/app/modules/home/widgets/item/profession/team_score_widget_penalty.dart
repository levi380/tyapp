import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-score.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/format_score_util.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../core/MatchListClass.dart';
import '../../../../../routes/app_pages.dart';

import '../../../../../utils/format_score_util3.dart';
import '../../../../../utils/sport.dart';
import '../../../../../widgets/GlobalFadeTransition.dart';
import '../../../../../widgets/image_view.dart';
import '../../../controllers/home_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 常规赛事 】】】
    【【【 AUTO_PARAGRAPH_TITLE 列表队伍比分条 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 显示进球动画 isShowGoal
    - 是否显示红牌 isShowRed
    - 显示伤停补时 isShowMststi
    - 显示各种提示动画 hint
    - 计算15分钟比分参数 hSpecial
    - 主客队名称和比分数据填充 UI展示
    】】】
 *
 */
// ignore: must_be_immutable
class TeamScoreWidgetPenalty extends StatelessWidget {
  TeamScoreWidgetPenalty(
      {super.key,
        required this.matchEntity,
        required this.index,
        this.isMainPlay = false,
        this.isShowGoal = false,
        this.isShowRed = false,
        this.isShowMststi = false,
        this.hint = '',
        this.playId = '',
        this.hSpecial = ''});

  final String hSpecial; // 计算15分钟比分参数
  final String hint; // 显示弹出提示
  final int index; // 0 主队 1 客队
  final bool isMainPlay;
  // 是否显示进球动画
  bool isShowGoal;

  // 是否显示伤停补时
  bool isShowMststi;

  // 是否显示红牌
  final bool isShowRed;

  final MatchEntity matchEntity;
  final String playId;
  late String score = '';

  Color _getScoreColor(BuildContext context) {
    if (playId == playIdConfig.hps15Minutes) {
      return const Color(0xffF2C037);
    }
    return context.isDarkMode
        ? Colors.white.withValues(alpha:0.8999999761581421)
        : const Color(0xff303442);
  }

  Color? _getTeamColor(BuildContext context) {
    // 选择队伍颜色
    int result = MatchUtil.getHandicapIndexBy(matchEntity);
    Color mhnColor = result == 1
        ? const Color(0xff74c4ff)
        : (context.isDarkMode
        ? Colors.white.withValues(alpha:0.9)
        : const Color(0xFF303442));
    Color manColor = result == 2
        ? const Color(0xff74c4ff)
        : (context.isDarkMode
        ? Colors.white.withValues(alpha:0.9)
        : const Color(0xFF303442));
    return index == 0 ? mhnColor : manColor;
  }

  String _getPunishScore() {
    if (matchEntity.msc.isNotEmpty &&
        int.parse(matchEntity.csid) == SportData.sportCsid_1 &&
        TyHomeController.to.visiable) {
      return FormatScore3.footballScoreStatusArray(matchEntity, index);
    }
    return '0';
  }

  String _calculateScore() {
    bool isSpecialPlay = [
      playIdConfig.hpsCorner,
      playIdConfig.hps15Minutes,
      playIdConfig.hpsPunish,
    ].contains(playId);

    bool isNotShowScore = [
      playIdConfig.hpsOutright,
      // playIdConfig.hpsPenalty,
      playIdConfig.hpsPromotion,
      // playIdConfig.hpsOvertime,
    ].contains(playId);

    // 特殊玩法比分
    if (isSpecialPlay) {
      return TYFormatScore.getScoreSecond(
          index == 0 ? 1 : 2, playId, matchEntity, hSpecial)
          .toString();
    } else if (isNotShowScore) {
      return '';
    } else {
      // 总比分
      if (int.parse(matchEntity.csid) == SportData.sportCsid_5) {
        // 网球比分
        score = "";
        if (matchEntity.msc.isNotEmpty) {
          return FormatScore3.formatminScore(matchEntity,
              index: index, isMain: true);
        }
      } else {
        return FormatScore.formatTotalScorePenalty(matchEntity, index, playId: playId);
        // if ((matchEntity.csid == '1' || matchEntity.csid == '11') && (playId == playIdConfig.hpsOvertime)){
        //   return FormatScore.formatTotalScoreOvertime(matchEntity, index, playId: playId);
        // }else{
        //   return FormatScore.formatTotalScore(matchEntity, index, playId: playId)
        //       .toString();
        // }
      }
    }
    return '';
  }

  // // 比分 只有滚球 ms == 1 时才有，其他情况下为空。显示的是msc的匹配出来的
  // // format-msc.js
  // final String score;
  /// 15分钟玩法 1007  罚牌 1003
  ///
  @override
  Widget build(BuildContext context) {
    String matStr = index == 0 ? 'home' : 'away';
    String name = index == 0 ? matchEntity.mhn : matchEntity.man;

    String punish = _getPunishScore();


    if (matchEntity.mcg == 1 && (TyHomeController.to.visiable || Get.currentRoute == Routes.matchResultsDetails)) {
      score = _calculateScore();
    }

    ///isServingSideCsidList 足篮不显示让球方
    List isServingSideCsidList = [SportData.sportCsid_1,SportData.sportCsid_2];
    ///是否是发球方
    bool isServingSide = (
        matchEntity.ms == 1
            && matchEntity.mat == matStr
            && !isServingSideCsidList.contains(matchEntity.csid) );

    ///比分颜色
    Color scoreColor = _getScoreColor(context);
    Color? textColor = _getTeamColor(context);

    return Container(
      height: 40.w + (TyTextScaler.instance().isScale ? 6 : 0),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                //计算动画折叠文字宽度
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: name.length > 12
                              ? (isIPad ? 13.sp.scale : 11.sp.scale)
                              : (isIPad ? 14.sp.scale : 12.sp.scale),
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${!isMainPlay ? " - ${LocaleKeys.football_playing_way_penalty_shootout.tr}" : ''}",
                        style: TextStyle(
                          fontSize: name.length > 12
                              ? (isIPad ? 13.sp.scale : 11.sp.scale)
                              : (isIPad ? 14.sp.scale : 12.sp.scale),
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                //isServingSide 棒球 绿点
                if (isServingSide)
                  Container(
                    width: 4.w,
                    height: 4.w,
                    margin: EdgeInsets.only(left: 3.w),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                if (punish.isNotEmpty &&
                    punish != '0' &&
                    // isMainPlay &&
                    TyHomeController.to.visiable)
                  isShowRed

                  ///进球动画
                      ? GlobalFadeTransition(
                    child: Container(
                      margin: EdgeInsets.only(left: 3.w),
                      width: 15.w,
                      height: 16.w,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF53F3F),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.r)),
                      ),
                      child: Text(
                        punish,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ).marginOnly(right: 4.w)

                  ///红牌动画
                      : Container(
                    margin: EdgeInsets.only(left: 3.w),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    alignment: Alignment.center,
                    width: 15.w,
                    height: 16.w,
                    child: Text(
                      punish,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).marginOnly(right: 4.w),

                ///伤停补时等文字动画
                if (int.parse(matchEntity.csid) == SportData.sportCsid_1 &&
                    isMainPlay &&
                    isShowMststi &&
                    hint.isNotEmpty &&
                    TyHomeController.to.visiable &&
                    TyHomeController.to.homeState.endScroll)
                //计算动画折叠文字宽度
                  GlobalFadeTransition(
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: ((Get.width - 60.w) * 0.5) / 2),
                      margin: EdgeInsets.only(left: 3.w),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        hint,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.amber,
                          height: 1.2,
                          fontSize: 12.sp,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ).marginOnly(right: 4.w),

                ///足球进球动画
                ///  /// @description: 赛事异常不显示进球
                /// 0未开始 1滚球阶段 2暂停 7延迟 10比赛中断 110即将开赛 3结束 4关闭 5取消 6比赛放弃 8未知 9延期
                if (matchEntity.csid == "${SportData.sportCsid_1.toString()}" &&
                    isMainPlay &&
                    isShowGoal &&
                    TyHomeController.to.visiable &&
                    MatchListClass.isMatchPlayingShowGoal(
                        int.parse(matchEntity.mmp)) ==
                        false)
                  Row(
                    children: [
                      5.horizontalSpace,
                      ImageView(
                        'assets/images/shopcart/icon_goal.gif',
                        width: 10.w,
                        height: 10.w,
                      ),
                      3.horizontalSpace,
                      Text(
                        LocaleKeys.match_result_goal.tr,
                        style: TextStyle(
                          height: 1.2,
                          fontSize: 11.sp,
                          // color: context.isDarkMode ? Colors.white : Colors.black,
                          color: Colors.amber,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (matchEntity.ms != SportData.sportMs_110)
          //比分
            Text(
              score,
              style: TextStyle(
                fontSize: 14.sp.scale,
                color: scoreColor,
                fontWeight: FontWeight.w700,
                fontFamily: 'DIN Alternate',
              ),
            ),
        ],
      ),
    );
  }
}
