import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
// import 'package:flutter_ty_app/app/modules/home/widgets/item/guanjun_yindao/guanjun_yindao.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/corner_play_temp.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/secodary/secondary_game_play_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/pin_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';

import '../../../../../routes/route_manager.dart';
import '../../../../../utils/sport.dart';
import '../../../../../utils/time_zone/timeZoneUtils.dart';
import '../counting-down/counting-down.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 常规赛事 】】】
    【【【 AUTO_PARAGRAPH_TITLE 列表UI部件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - Divider item分割线
    ```
    Divider(
    indent: 8.w,
    endIndent: 8.w,
    height: 0.4.w,
    color: context.isDarkMode
    ? Colors.white.withAlpha(10)
    : const Color(0xffE4E6ED),
    ).paddingOnly(
    bottom_nav: 2.w,
    ),

    ```
    - _buildHeader item顶部title
    ```
    _buildHeader(context, match)
    ```
    - CornerPlayTemp 赛事信息 比分
    ```
    CornerPlayTemp(match: match, hps: match.hps)
    ```
    - SecondayGamePlayWidget 子玩法部件
    ```
    SecondayGamePlayWidget(
    matchEntity: match,
    )
    ```
    】】】
 *
 */
class ItemBodyWidget extends StatelessWidget {
  const ItemBodyWidget(
      {super.key, required this.matchEntity, this.isDetail = false});

  final MatchEntity matchEntity;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    DataStoreController controller = DataStoreController.to;
    return NotificationListener(
      onNotification: (ScrollNotification value) {
        // 返回true 避免被ScrollIndexWidget 监听
        return true;
      },
      child: GetBuilder<DataStoreController>(
          init: controller,
          id: controller.getMatchId(matchEntity.mid),
          builder: (logic) {
            MatchEntity match =
                controller.getMatchById(matchEntity.mid) ?? matchEntity;
            if (match.isEnd) return 0.verticalSpaceFromWidth;
            return RepaintBoundary(
              child: InkWell(
                onTap: () => RouteManager.goMatchDetail(
                    mid: match.mid,
                    csid: match.csid,
                    isESports: MatchUtil.isEsport(match)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        ///  item分割线
                        Divider(
                          indent: 8.w,
                          endIndent: 8.w,
                          height: 0.4.w,
                          color: context.isDarkMode
                              ? Colors.white.withAlpha(10)
                              : const Color(0xffE4E6ED),
                        ).paddingOnly(
                          bottom: 2.w,
                        ),

                        /// item顶部title
                        /// 列表赛制  开赛时间
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: _buildHeader(context, match),
                        ),
                      ],
                    ),

                    ///赛事信息 比分
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: CornerPlayTemp(
                        match: match,
                        hps: match.hps,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child:
                          /// 子玩法
                          GestureDetector(
                        onTap: () {},
                        child: SecondayGamePlayWidget(
                          matchEntity: match,
                        ),
                      ),
                    ),
                    // Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 8.w),
                    //     child: GuanjunYindao(
                    //       tid: match.tid.toString(),
                    //       mid: match.mid,
                    //     )
                    //     // Text("冠军引导盘")
                    //     )
                  ],
                ),
              ),
            );
          }),
    );
  }

  ///首页列表顶部赛事时间 信息
  Widget _buildHeader(BuildContext context, MatchEntity matchEntity) {
    /// 1 开赛   110 即将开赛
    ///  ms = 1 110 才匹配（已开赛的）其他直接显示时间。
    ///  <!--开赛日期 ms != 110 (不为即将开赛)  subMenuType = 13网球(进行中不显示，赛前需要显示)-->
    ///  kyapp 没有显示即将开始 倒计时 这里不需要判断倒计时
    bool showCountingDown = MatchUtil.showCountingDown(matchEntity);
    bool showStartCountingDown = MatchUtil.showStartCountingDown(matchEntity);

    /// 即将开赛  ‘文字’显示阶段
    bool willMatchOpen = matchEntity.ms == 110;

    ///列表开赛 判断  mcg =1 滚球 | mcg=2 即将开赛| mcg=3 今日赛事| mcg=4 早盘
    bool matchOpen =
        !willMatchOpen && !showCountingDown && matchEntity.mcg != 2;

    ///一小时内开赛  并显示多少分钟后开赛
    bool isHomeOrmatchResultsDetailsPage = true;
    bool hourShowMinu = !willMatchOpen &&
        matchEntity.mcg == 2 &&
        showStartCountingDown &&
        isHomeOrmatchResultsDetailsPage;

    ///赛制  几局几胜  赛事回合数mfo match.ms != 1(不为开赛)
    bool shoMmfo = matchEntity.mfo != null &&
        ((SportData.getSportsMS([SportData.sportMs_0, SportData.sportMs_110])!
                .contains(matchEntity.ms) &&
            (SportData.getSportsCsid([
              SportData.sportCsid_1,
              SportData.sportCsid_5,
              SportData.sportCsid_7,
              SportData.sportCsid_8,
              SportData.sportCsid_9,
              SportData.sportCsid_10,
              SportData.sportCsid_37
            ])!
                .contains(matchEntity.csid.toInt()))));

    ///倒计时 倒计时或正计时   or   当前第几局
    bool currentTimeOrRound =
        !willMatchOpen && showCountingDown && isHomeOrmatchResultsDetailsPage;
    return Row(children: [
      if (!TyHomeController.to.homeState.menu.isMatchBet)
        Obx(
          () {
            ///收藏数据开关
            if (ConfigController.to.accessConfig.value.collectSwitch) {
              return GetBuilder<CollectionController>(builder: (logic) {
                bool isFav =
                    (logic.isCollection(matchEntity) || matchEntity.mf) &&
                        RouteCheckUtil.checkIsLogin();
                // AppLogger.debug('isFav $isFav ${logic.commonCollectionTidList} ${logic.commonCollectionMidList}');

                return InkWell(
                  onTap: () {
                    logic.addOrCancelMatch(matchEntity);
                  },
                  child: ImageView(
                    isFav
                        ? 'assets/images/home/ico_fav_nor_sel.svg'
                        : context.isDarkMode
                            ? 'assets/images/home/ico_fav_nor.png'
                            : 'assets/images/home/ico_fav_nor_light.png',
                    width: 16.w,
                    height: 16.w,
                  ).marginOnly(right: 4.w),
                );
              });
            } else {
              return 0.verticalSpaceFromWidth;
            }
          },
        ),
      Row(
        children: [
          // if (isjinZu)
          // 1 开赛   110 即将开赛
          //  ms = 1 110 才匹配（已开赛的）其他直接显示时间。
          //  <!--开赛日期 ms != 110 (不为即将开赛)  subMenuType = 13网球(进行中不显示，赛前需要显示)-->
          ///  kyapp 没有显示即将开始 倒计时 这里不需要判断倒计时
          /*       if (matchEntity.ms != 110 &&
                    !showStartCountingDown &&
                    !showCountingDown)*/
          if ((TyHomeController.to.homeState.league.sportConfigInfo.mi
                      .startsWith('50101') ||
                  TyHomeController.to.homeState.league.sportConfigInfo.mi
                      .startsWith('50102')) &&
              !ObjectUtil.isEmptyString(matchEntity.mcid))
            Text(
              matchEntity.mcid,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp.scale,
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.30000001192092896)
                    : const Color(0xffAFB3C8),
              ),
            ).marginOnly(right: 4.w),

          ///列表开赛 判断
          if (matchOpen)
            Row(
              children: [
                ///列表时区
                Text(
                  DateUtil.formatDateMs(
                          // int.parse(matchEntity.mgt) ?? 0 ,
                          TimeZoneUtils.convertTimeToTimestamp(matchEntity.mgt,
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
                        ? Colors.white.withValues(alpha: 0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                )
              ],
            ),

          ///一小时内开赛  分钟后开赛
          if (hourShowMinu)
            Row(
              children: [
                Text(
                  LocaleKeys.list_after_time_start.tr.replaceFirst('{0}',
                      MatchUtil.getStartCountTime(matchEntity).toString()),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                )
              ],
            ),

          ///  即将开赛 ms = 110  显示即将开赛
          if (willMatchOpen)
            Text(
              'ms_110'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp.scale,
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.30000001192092896)
                    : const Color(0xffAFB3C8),
              ),
            ).marginOnly(right: 4.w),

          ///  赛事回合数mfo match.ms != 1(不为开赛)
          if (shoMmfo)
            Row(
              children: [
                Text(
                  matchEntity.mfo,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp.scale,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                )
              ],
            ),

          ///倒计时 倒计时或正计时 和 第几局
          if (currentTimeOrRound)
            Countingdown(
              matchEntity,
              key: ValueKey('counting_${matchEntity.mid}'),
            ),
        ],
      ),
      // ///板球赛制
      // if ([SportData.sportCsid_37].contains(int.parse(matchEntity.csid))&&matchEntity.ms == 110)
      //   Text(
      //     "${matchEntity.mfo}",
      //     style: TextStyle(
      //       fontWeight: FontWeight.w400,
      //       fontSize: 12.sp.scale,
      //       color: context.isDarkMode
      //           ? Colors.white.withValues(alpha:0.30000001192092896)
      //           : const Color(0xffAFB3C8),
      //     ),
      //   ).marginOnly(left: 10.w),

      // if (matchEntity.csid.toInt() < 100)

      if (isDetail == false)
        PinWidget(
          matchEntity: matchEntity,
          isLeague: false,
          isDjInCommon: MatchUtil.isEsport(matchEntity),
        ),

      const Spacer(),
      Obx(() {
        return Text(
          ConfigController.to.accessConfig.value.handicapNum
              ? '${matchEntity.mc}+'
              : LocaleKeys.footer_menu_more.tr,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10.sp.scale,
            fontFamily: 'PingFang SC',
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.30000001192092896)
                : const Color(0xffAFB3C8),
          ),
        );
      }),

      ImageView(
        context.isDarkMode
            ? 'assets/images/league/ico_arrowright_nor_darkmode.png'
            : 'assets/images/league/ico_arrowright_nor.png',
        width: 12.w,
        height: 12.w,
      ),
    ]);
  }
}
