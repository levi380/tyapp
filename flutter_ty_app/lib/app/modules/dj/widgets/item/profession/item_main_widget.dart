import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-score.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/media_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/profession/odd_group_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/profession/score_widget.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/pin_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child101.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../routes/route_manager.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/format_score_util.dart';
import '../../../../../utils/time_zone/timeZoneUtils.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞列表 专业版item组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 专业版item控件
    # 1 `_buildHeader`函数

    ## 功能：`实现时间，比赛状态，比赛数目`显示

    ```
    ///时间显示
    matchEntity.ms != 110 &&
    !show_start_counting_down(matchEntity) &&
    !show_counting_down(matchEntity)
    ? Text(
    DateUtil.formatDateMs(int.tryParse(matchEntity.mgt) ?? 0,
    format:
    isZh() ? LocaleKeys.time11.tr : LocaleKeys.time4.tr),
    style: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: /*isIPad ? 20.sp.scale : */ 12.sp.scale,
    color: const Color(0xffAFB3C8),
    ),
    )
    : StageChild101(
    djEntrance: true,
    isPinnedAppbar: true,
    match: matchEntity,
    isMatchSelect: true,
    ),
    ///比赛数目
    Text(
    '${matchEntity.mc}+',
    style: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: isIPad ? 16.sp.scale : 12.sp.scale,
    color: const Color(0xffAFB3C8),
    ),
    ),
    ```

    】】】
 *
 */
class ItemMainWidget extends StatefulWidget {
  const ItemMainWidget({
    super.key,
    required this.sectionGroupEnum,
    required this.matchEntity,
    this.showGroupHead = true,
    this.isLast = false,
    this.count = 0,
  });

  final SectionGroupEnum sectionGroupEnum;
  final MatchEntity matchEntity;
  final bool showGroupHead;
  final int count;
  final bool isLast;

  @override
  State<ItemMainWidget> createState() => _ItemMainWidgetState();
}

class _ItemMainWidgetState extends State<ItemMainWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
      id: MATCH_ID + widget.matchEntity.mid,
      builder: (DataStoreController controller) {
        MatchEntity matchEntity =
            controller.getMatchById(widget.matchEntity.mid) ??
                widget.matchEntity;
        // bool isClose = MatchDataBaseWS.closeMatch(
        //     mhs: matchEntity.mhs, mmp: matchEntity.mmp, ms: matchEntity.ms);
        bool isClose = DJController.to.isClose(matchEntity);

        // AppLogger.debug(
        //     "DJ = ItemBodyWidget matchEntity.mid = ${matchEntity.mid} match.ms = ${matchEntity.ms}");

        /// 赛事结束 或者收起
        if (isClose ||
            DJController.to.isCollop(matchEntity, widget.sectionGroupEnum)) {
          return const SizedBox();
        }
        return InkWell(
          onTap: () => RouteManager.goMatchDetail(
              mid: matchEntity.mid, csid: matchEntity.csid, isESports: true),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.03999999910593033)
                    : Colors.white.withValues(alpha: 0.5),
                borderRadius: widget.isLast
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(8.r),
                        bottomRight: Radius.circular(8.r),
                      )
                    : null,
                border: Border(
                  bottom: !widget.isLast
                      ? BorderSide.none
                      : BorderSide(
                          width: 1,
                          color: !Get.isDarkMode
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.08),
                        ),
                  left: BorderSide(
                    width: 1,
                    color: !Get.isDarkMode
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.08),
                  ),
                  right: BorderSide(
                    width: 1,
                    color: !Get.isDarkMode
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // !widget.showGroupHead
                  //     ? const SizedBox.shrink()
                  //     : Column(
                  //         children: [
                  //           /**联赛标题*/
                  //           DJMatchListItemHeaderWidget(
                  //               matchEntity: matchEntity,
                  //               onExpandChange: (value) {
                  //                 ///收起/展开 同组联赛信息
                  //                 DJController.to.clickCollop(value,
                  //                     matchEntity, widget.sectionGroupEnum);
                  //               },
                  //               // onCollectionChange: (bool value) {
                  //               //   matchEntity.isCollection = value;
                  //               //   setState(() {});
                  //               // },
                  //               count: widget.count),
                  //         ],
                  //       ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      children: [
                        // !widget.showGroupHead
                        //     ? const SizedBox.shrink()
                        //     :
                        //     /**赔率分组标题*/
                        //     BetTitleGroupWidget(
                        //         hps: matchEntity.hps,
                        //         matchEntity: matchEntity,
                        //       ),
                        Divider(
                          height: 1,
                          color: context.isDarkMode
                              ? Colors.white
                                  .withValues(alpha: 0.03999999910593033)
                              : DJController.to.DJState.djDividerLightColor,
                        ),
                        /**时间，比赛状态，比赛数目*/
                        _buildHeader(matchEntity).marginOnly(top: 2.h),
                        SizedBox(
                          // height:   68.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        ScoreWidget(
                                            matchEntity: matchEntity,
                                            name: matchEntity.mhn,
                                            score:
                                                TYFormatScore.formatTotalScore(
                                                        matchEntity)
                                                    .home
                                                    .toString()),
                                        ScoreWidget(
                                            matchEntity: matchEntity,
                                            name: matchEntity.man,
                                            score:
                                                TYFormatScore.formatTotalScore(
                                                        matchEntity)
                                                    .away
                                                    .toString()),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  OddGroupWidget(matchEntity: matchEntity),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        MediaWidget(matchEntity: matchEntity),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-23fa620e-e0a5-40e9-910b-91a2b3d327c2-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 电竞 】】】
      【【【 AUTO_DOCUMENT_TITLE 电竞列表 专业版item组件 】】】
      【【【 AUTO_PARAGRAPH_TITLE ItemGuanjunWidget】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 时间，比赛状态，比赛数目
      】】】
   *
   */
  ///电竞主列表顶部赛事信息
  Widget _buildHeader(MatchEntity matchEntity) {
    bool Scoring = eSportsScoring(matchEntity);
    bool isShowDateTime = matchEntity.ms != 110 &&
        !show_start_counting_down(matchEntity) &&
        !show_counting_down(matchEntity);
    return SizedBox(
      // height: 20.h,
      child: Row(children: [
        // ConfigController.to.accessConfig.value.collectSwitch
        //     ? GestureDetector(
        //         onTap: () {
        //          DJController.to.collectMatch(matchEntity);
        //         },
        //         child: ImageView(
        //           matchEntity.mf
        //               ? 'assets/images/home/ico_fav_nor_sel.svg'
        //               : context.isDarkMode
        //                   ? 'assets/images/home/ico_fav_nor.png'
        //                   : 'assets/images/home/ico_fav_nor_light.png',
        //           width: 16.w,
        //           height: 16.w,
        //         ),
        //       )
        //     : SizedBox.shrink(),
        Obx(() {
          ///收藏数据开关
          if (ConfigController.to.accessConfig.value.collectSwitch) {
            return GetBuilder<CollectionController>(builder: (logic) {
              bool isFav =
                  (logic.isCollection(matchEntity) || matchEntity.mf) &&
                      RouteCheckUtil.checkIsLogin();
              // AppLogger.debug('isFav $isFav ${logic.commonCollectionTidList} ${logic.commonCollectionMidList}');
              return InkWell(
                onTap: () {
                  logic.addOrCancelMatchDJ(matchEntity);
                },

                ///专业版收藏和取消收藏图标
                child: ImageView(
                  getFavIcon(isFav, context),
                  width: 16.w,
                  height: 16.w,
                ).marginOnly(right: 4.w),
              );
            });
          } else {
            return 0.verticalSpaceFromWidth;
          }
        }),
        SizedBox(
          width: 4.w,
        ),

        ///电竞比分判定中
        if (Scoring)
          Text(
            LocaleKeys.mmp_eports_scoring.tr,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp.scale,
              color: const Color(0xffAFB3C8),
            ),
          ),
        if (!Scoring && isShowDateTime)
          Text(
            DateUtil.formatDateMs(
                    TimeZoneUtils.convertTimeToTimestamp(matchEntity.mgt,
                            isMilliseconds: true, returnMilliseconds: true) ??
                        0,
                    format: isZh() ? LocaleKeys.time11.tr : LocaleKeys.time4.tr,
                    isUtc: true) +
                "(" +
                TimeZoneUtils.getTimeZoneString() +
                ")",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: /*isIPad ? 20.sp.scale : */ 12.sp.scale,
              color: const Color(0xffAFB3C8),
            ),
          ),
        if (!Scoring && !isShowDateTime)
          StageChild101(
            djEntrance: true,
            isPinnedAppbar: true,
            match: matchEntity,
            isMatchSelect: true,
          ),
        if (ObjectUtil.isNotEmpty(matchEntity.mfo))
          Text(
            matchEntity.mfo.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp.scale,
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.5)
                  : DJController.to.DJState.djSecondaryTextColor,
            ),
          ).marginOnly(left: 4.w),
        isShowChuan()
            ? Container(
                margin: EdgeInsets.only(left: 10.w),
                padding: EdgeInsets.symmetric(
                  horizontal: isIPad ? 3.w : 2.w,
                ),
                constraints: BoxConstraints(
                  minWidth: 16.w,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  border: Border.all(
                    color: Color(0xFF179CFF),
                    width: 1.w,
                  ),
                ),
                child: Text(
                  Get.locale?.languageCode == 'zh' ||
                          Get.locale?.languageCode == 'tw'
                      ? '串'
                      : 'P',
                  style: TextStyle(
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF179CFF) /*Colors.blue*/,
                      fontSize: isIPad ? 15.sp.scale : 10.sp.scale),
                ),
              )
            : const SizedBox(),

        PinWidget(
          isLeague: false,
          matchEntity: matchEntity,
          isDjInCommon: true,
        ),
        const Spacer(),
        Text(
          '${matchEntity.mc}+',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: isIPad ? 16.sp.scale : 12.sp.scale,
            color: DJController.to.DJState.djSecondaryTextColor,
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        ImageView(
          context.isDarkMode
              ? DJController.to.DJState.leagueArrowRightDark
              : DJController.to.DJState.leagueArrowRightLight,
          width: 12.w,
          height: 12.w,
        ),
      ]),
    );
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

  /// @description: 多少分钟后开赛显示
  /// @param {Object} item 赛事对象
  /// @return {String}
  bool show_start_counting_down(MatchEntity item) {
    var r = false;
// 滚球中不需要显示多少分钟后开赛
    if (item.ms == 1) {
      return r;
    }
    return r;
  }

//赛事状态 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断
  /// @description: 进行中(但不是收藏页)的赛事显示累加计时|倒计时
  /// @param {Object} item 赛事对象
  /// @return {Boolean}
  bool show_counting_down(MatchEntity item) {
    return [1, 2, 10].contains(item.ms * 1);
  }

  isShowChuan() {
    return widget.matchEntity.hps.safeFirst?.hl.safeFirst?.hipo == 1;
  }

  ///电竞专业版  收藏和取消收藏icon
  String getFavIcon(bool isFav, BuildContext context) {
    if (isFav) return DJController.to.DJState.favSelectedSvg;
    return context.isDarkMode
        ? DJController.to.DJState.favNormalDark
        : DJController.to.DJState.favNormalLight;
  }
}
