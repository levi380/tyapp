import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-score.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/dj_match_list_item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/media_widget.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_button.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child101.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../utils/format_score_util.dart';
import '../../../../../utils/route_check_util.dart';
import '../../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../home/controllers/collection_controller.dart';
import '../../../../home/widgets/pin_widget.dart';
import '../../../../../routes/route_manager.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞列表 新手版item组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 新手版item组件
    # `_buildBetGroup`

    - `新手版 赔率布局`

    # `_buildTeam`

    - `新手版 队伍名字 布局`

    # `_buildHeader`

    - `新手版 标题布局`

    # `show_start_counting_down`

    - 多少分钟后开赛显示`

    # `show_counting_down`

    - `进行中(但不是收藏页)的赛事显示累加计时|倒计时`

    - 赛事状态 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断`

    】】】
 *
 */
class NewItemBodyWidget extends StatefulWidget {
  const NewItemBodyWidget(
      {super.key,
      required this.matchEntity,
      required this.sectionGroupEnum,
      this.showGroupHead = true,
      this.count = 0,
      this.isLast = false});

  final MatchEntity matchEntity;
  final bool showGroupHead;
  final SectionGroupEnum sectionGroupEnum;
  final int count;
  final bool isLast;

  @override
  State<NewItemBodyWidget> createState() => _NewItemBodyWidgetState();
}

class _NewItemBodyWidgetState extends State<NewItemBodyWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
        id: MATCH_ID + widget.matchEntity.mid,
        builder: (DataStoreController controller) {
          AppLogger.debug(
              "NewItemBodyWidget = ${controller.getMatchById(widget.matchEntity.mid)}");
          MatchEntity matchEntity =
              controller.getMatchById(widget.matchEntity.mid) ??
                  widget.matchEntity;
          // bool isClose = MatchDataBaseWS.closeMatch(
          //     mhs: matchEntity.mhs, mmp: matchEntity.mmp, ms: matchEntity.ms);

          // AppLogger.debug(
          //     "DJ = ItemBodyWidget matchEntity.mid = ${matchEntity.mid} match.ms = ${matchEntity.ms}");

          /// 赛事结束
          if (DJController.to.isClose(matchEntity)) return const SizedBox();
          return Container(
            padding: DJController.to
                        .isCollop(matchEntity, widget.sectionGroupEnum) &&
                    !widget.showGroupHead
                ? EdgeInsets.zero
                : EdgeInsets.only(left: 5.w, right: 5.w, bottom: 8.h),
            margin: EdgeInsets.only(left: 5.w, right: 5.w),
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.03999999910593033)
                  : const Color(0xffF8F9FA),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.showGroupHead ? 8.r : 0),
                topRight: Radius.circular(widget.showGroupHead ? 8.r : 0),
                bottomLeft: Radius.circular(widget.isLast ? 8.r : 0),
                bottomRight: Radius.circular(widget.isLast ? 8.r : 0),
              ),
              border: Border.all(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.08)
                      : const Color(0xffFFFFFF),
                  width: DJController.to
                              .isCollop(matchEntity, widget.sectionGroupEnum) &&
                          !widget.showGroupHead
                      ? 0
                      : 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                !widget.showGroupHead
                    ? const SizedBox.shrink()
                    : DJMatchListItemHeaderWidget(
                        matchEntity: matchEntity,
                        onExpandChange: (value) {
                          ///收起/展开 同组联赛信息
                          DJController.to.clickCollop(
                              value, matchEntity, widget.sectionGroupEnum);
                        },
                        // onCollectionChange: (bool value) {},
                        count: widget.count,
                      ),
                DJController.to.isCollop(matchEntity, widget.sectionGroupEnum)
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          _buildHeader(matchEntity),
                          _buildTeam(matchEntity),
                          _buildBetGroup(matchEntity),
                          SizedBox(
                            height: 6.h,
                          ),
                        ],
                      ),
              ],
            ),
          );
        });
  }

  ///新手版 赔率布局
  _buildBetGroup(MatchEntity item) {
    List<MatchHps> hps = item.hps;
    return Container(
      height: isIPad ? 50.h : 33.h,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  ///收藏数据开关
                  if (ConfigController.to.accessConfig.value.collectSwitch) {
                    return GetBuilder<CollectionController>(builder: (logic) {
                      bool isFav = (logic.isCollection(item) || item.mf) &&
                          RouteCheckUtil.checkIsLogin();
                      // AppLogger.debug('isFav $isFav ${logic.commonCollectionTidList} ${logic.commonCollectionMidList}');
                      return InkWell(
                        onTap: () {
                          logic.addOrCancelMatchDJ(item);
                        },
                        child: ImageView(
                          isFav
                              ? DJController.to.DJState.favSelectedSvg
                              : context.isDarkMode
                                  ? DJController.to.DJState.favNormalDark
                                  : DJController.to.DJState.favNormalLight,
                          width: 16.w,
                          height: 16.w,
                        ).marginOnly(right: 4.w),
                      );
                    });
                  } else {
                    return 0.verticalSpaceFromWidth;
                  }
                }),
                // ConfigController.to.accessConfig.value.collectSwitch
                //     ? InkWell(
                //         onTap: () {
                //           // MatchApi.instance()
                //           //     .addOrCancelMatch(TYUserController.to.getUid(),
                //           //         item.mid, item.mf ? 0 : 1)
                //           //     .then((value) {
                //           //   setState(() {
                //           //     item.mf = !item.mf;
                //           //   });
                //           // });
                //           DJController.to.collectMatch(item);
                //         },
                //         child: ImageView(
                //           item.mf
                //               ? 'assets/images/home/ico_fav_nor_sel.svg'
                //               : context.isDarkMode
                //                   ? context.isDarkMode
                //                       ? 'assets/images/home/ico_fav_nor.png'
                //                       : 'assets/images/home/ico_fav_nor_light.png'
                //                   : 'assets/images/home/ico_fav_nor_light.png',
                //           width: 16.w,
                //           height: 16.w,
                //         ),
                //       )
                //     : const SizedBox.shrink()
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              MatchHpsHlOl ol;
              ///加多玩法集和玩法集关联字段判断 
              if (hps.isEmpty || hps.first.hl.isEmpty || hps.first.hl.first.ol.length <= index) {
                return const SizedBox();
              }
              MatchHps element = hps.safeFirst!;
              if (element.hl[0].ol.isNotEmpty) {
                ol = element.hl[0].ol[index];
              } else {
                var fakeOl = MatchHpsHlOl();
                fakeOl.ov = -1;
                ol = fakeOl;
              }
              return OddsButton(
                  betType: OddsBetType.esport,
                  height: 60.h,
                  width: isIPad ? 200.w : 120.w,
                  match: item,
                  hps: hps[0],
                  ol: ol,
                  // name: ol.ott + ol.on,
                  hl: hps[0].hl.safeFirst,
                  radius: 4.0);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: isIPad ? 40.w : 2.w,
              );
            },
            itemCount: 2,
          ),
          Expanded(
            child: PinWidget(
              isLeague: false,
              matchEntity: item,
              isDjInCommon: true,
            ),
          ),
        ],
      ),
    );
  }

  ///新手版 队伍名字 布局
  _buildTeam(MatchEntity item) {
    final textColor = getTextColor(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: _DjTeamSide(
              teamName: item.mhn,
              teamLogo: (item.mhlu as List).safeFirst ?? "",
              textColor: textColor,
              logoPosition: _DjTeamLogoPosition.trailing,
            ),
          ),
          Container(
            width: 20.w,
            height: 20.w,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            alignment: Alignment.center,
            child: Text(
              'VS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 12.sp.scale,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: _DjTeamSide(
              teamName: item.man,
              teamLogo: safeFirstStr(item.malu as List),
              textColor: textColor,
              logoPosition: _DjTeamLogoPosition.leading,
            ),
          ),
        ],
      ),
    );
  }

  ///安全获取球队icon
  String safeFirstStr(List? list) => list?.isNotEmpty == true ? list!.first : "";

  ///新手版 标题布局
  _buildHeader(MatchEntity item) {
    bool Scoring = eSportsScoring(item);
    bool isShowDateTime =  item.ms != 110 &&
        !show_counting_down(item);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () => RouteManager.goMatchDetail(
                  mid: item.mid, csid: item.csid, isESports: true),
              child: MediaWidget(matchEntity: item)),
          SizedBox(
            width: 4.w,
          ),
          ///电竞比分判定中-新手版
          if(Scoring)  Text(
            LocaleKeys.mmp_eports_scoring.tr,
            style:  TextStyle(
              fontWeight: FontWeight.w400,
              fontSize:12.sp.scale,
              color: const Color(0xffAFB3C8),
            ),
          ),
          if(!Scoring && isShowDateTime) Text(
                  DateUtil.formatDateMs(
                          TimeZoneUtils.convertTimeToTimestamp(item.mgt,
                                  isMilliseconds: true,
                                  returnMilliseconds: true) ??
                              0,
                          format: isZh()
                              ? LocaleKeys.time11.tr
                              : LocaleKeys.time4.tr,
                          isUtc: true) +
                      "(" +
                      TimeZoneUtils.getTimeZoneString() +
                      ")",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp.scale,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.5)
                        : const Color(0xffAFB3C8),
                  ),
                ),
          if(!Scoring && !isShowDateTime)  StageChild101(
                  djEntrance: true,
                  isPinnedAppbar: false,
                  match: item,
                  isMatchSelect: true,
                ),
          if (ObjectUtil.isNotEmpty(item.mfo))
            Text(
              item.mfo.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp.scale,
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.5)
                    : const Color(0xffAFB3C8),
              ),
            ).marginOnly(left: 4.w),
          SizedBox(
            width: 4.w,
          ),
          item.ms != 0
              ? Text(
                  TYFormatScore.formatTotalScore(item).text,
                  style: TextStyle(
                    color: getTextColor(context),
                    fontSize: 10.sp.scale,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,
                  ),
                )
              : const SizedBox(),
          const Spacer(),
          GestureDetector(
            onTap: () => RouteManager.goMatchDetail(
                mid: item.mid, csid: item.csid, isESports: true),
            child: Row(
              children: [
                Text(
                  '${LocaleKeys.footer_menu_more.tr} (${item.mc})',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: const Color(0xFFAFB3C8),
                    fontSize: 10.sp.scale,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                ImageView(
                  context.isDarkMode
                      ? DJController.to.DJState.leagueArrowRightDark
                      : DJController.to.DJState.leagueArrowRightLight,
                  width: 12.w,
                  height: 12.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// @description: 多少分钟后开赛显示
  /// @param {Object} item 赛事对象
  /// @return {String}
//   bool show_start_counting_down(MatchEntity item) {
//     var r = false;
// // 滚球中不需要显示多少分钟后开赛
//     if (item.ms == 1) {
//       return r;
//     }
//     return r;
//   }

//赛事状态 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断
  /// @description: 进行中(但不是收藏页)的赛事显示累加计时|倒计时
  /// @param {Object} item 赛事对象
  /// @return {Boolean}
  bool show_counting_down(MatchEntity item) {
    return [1, 2, 10].contains(item.ms);
  }

  /// 如果是电竞，则进行比分判定处理   eSportsScoring 和详情统一判断
  bool eSportsScoring(MatchEntity match) {

    bool scoring = false;
    ///必须是开赛了
    int ms = match.ms;
    int mmp = int.tryParse(match.mmp) ?? 1;
    int home = FormatScore.formatTotalScore(match, 0);
    int away = FormatScore.formatTotalScore(match, 1);
    if (ms > 0 && mmp != (home + away + 1)) {
      scoring = true;
    }
    return scoring;
  }

  ///电竞新手版头部 状态 时间  队伍名称 统一文字颜色
  Color getTextColor(BuildContext context, {double alpha = 0.9}) =>
      context.isDarkMode ? Colors.white.withValues(alpha: alpha) : const Color(0xFF303442);

}

/// 队伍区域（左右通用）：把“队名 + 队标”的重复布局封装在当前文件内，方便复用与维护
enum _DjTeamLogoPosition { leading, trailing }

class _DjTeamSide extends StatelessWidget {
  const _DjTeamSide({
    required this.teamName,
    required this.teamLogo,
    required this.textColor,
    required this.logoPosition,
  });

  final String teamName;
  final String teamLogo;
  final Color textColor;
  final _DjTeamLogoPosition logoPosition;

  @override
  Widget build(BuildContext context) {
    final nameWidget = Expanded(
      child: Text(
        teamName,
        textAlign: logoPosition == _DjTeamLogoPosition.trailing
            ? TextAlign.right
            : TextAlign.left,
        style: TextStyle(
          color: textColor,
          fontSize: 12.sp.scale,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
        ),
        maxLines: 3,
      ),
    );

    final logoWidget = ImageView(
      teamLogo,
      width: 20.w,
      height: 20.w,
      dj: true,
    );

    final spacing = SizedBox(width: 4.w);

    return Row(
      mainAxisAlignment: logoPosition == _DjTeamLogoPosition.trailing
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: logoPosition == _DjTeamLogoPosition.trailing
          ? [nameWidget, spacing, logoWidget]
          : [logoWidget, spacing, nameWidget],
    );
  }
}
