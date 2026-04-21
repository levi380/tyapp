import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_item_champion.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp8.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/models/res/match_entity.dart';
import '../../../../widgets/loading.dart';
import '../../../../widgets/empty/no_data.dart';
import '../../../../widgets/scroll_index_widget.dart';
import '../../constants/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import '../../models/request_status.dart';
import 'odds_info/odds_item.dart';
import 'odds_info/odds_item_added.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-9aa4b95e-cd9f-4385-a571-aff30a52c399 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注列表+赛果列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 复用组件】】】
    【【【 AUTOMATIC_GENERATE_DOCUMENT_PARAGRAPH_CONTENT
    - 普通赛事投注列表 、赛果详情展示 、vr、dj投注列表 公用组件
    - 接口请求loading
    ```
    return const Loading();
    ```
    - 请求时网络错误
    ```
    return NoData(
    fullscreen: fullscreen,
    top: 0,
    type: NoDataType.noWifi,

    /// 无网络时 三个接口都刷新
    onRefresh: () {
    Get.find<MatchDetailController>(tag: widgets.tag).refreshData();
    },
    );
    ```
    - 数据为空或者请求失败
    ```
    // 赛果显示暂无数据
    String content = "";
    if (route == Routes.matchResultsDetails) {
    content = LocaleKeys.analysis_football_matches_no_data.tr;
    return NoData(
    fullscreen: fullscreen,
    content: content,
    top: 0,
    type: NoDataType.none,
    );
    } else {
    content = detailState.curCategoryTabId == "0"
    ? "${LocaleKeys.detail_odd_closed.tr}\n\n${LocaleKeys.detail_no_way_bet.tr}"
    : LocaleKeys.detail_odd_closed.tr;
    }
    return NoData(
    fullscreen: fullscreen,
    content: content,
    top: 0,
    type: NoDataType.oddsClosed,
    );
    ```
    】】】
 *
 */
class OddsInfoContainer extends StatefulWidget {
  const OddsInfoContainer({super.key, required this.tag, this.refresh = false});

  final String tag;
  final bool refresh;

  @override
  State<OddsInfoContainer> createState() => _OddsInfoContainerState();
}

class _OddsInfoContainerState extends State<OddsInfoContainer> {
  // final GlobalKey<AnimatedListState> oddsInfoListKey = GlobalKey();

  /// 构建投注列表和赛果列表的UI
  /// 根据请求状态显示不同的UI：加载中、网络错误、无数据或正常列表
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
      tag: widget.tag,
      id: matchOddsInfoGetBuildId,
      initState: (_) {
        /// 初始化投注数据
        if (widget.refresh) {
          Get.find<MatchDetailController>(tag: widget.tag)
              .refreshOddsInfoData(refresh: widget.refresh);
        }
      },
      builder: (controller) {
        final detailState = controller.detailState;
        bool fullscreen = detailState.fullscreen.value;
        String route = Get.currentRoute;
        if (detailState.oddsInfoRequestStatus == RequestStatus.loading) {
          // 接口请求loading
          return const Loading();
        }

        /// 请求时网络错误
        else if (detailState.oddsInfoRequestStatus == RequestStatus.noNetwork) {
          return NoData(
            fullscreen: fullscreen,
            top: 0,
            type: NoDataType.noWifi,

            /// 无网络时 三个接口都刷新
            onRefresh: () {
              Get.find<MatchDetailController>(tag: widget.tag).refreshData();
            },
          );
        }

        /// 数据为空或者请求失败
        else if (detailState.oddsInfoIsNoData ||
            detailState.oddsInfoRequestStatus == RequestStatus.fail) {
          // 赛果显示暂无数据
          String content = "";
          if (route == Routes.matchResultsDetails) {
            content = LocaleKeys.analysis_football_matches_no_data.tr;
            return NoData(
              fullscreen: fullscreen,
              content: content,
              top: 0,
              type: NoDataType.none,
            );
          } else {
            content = detailState.curCategoryTabId == "0"
                ? "${LocaleKeys.detail_odd_closed.tr}\n\n${LocaleKeys.detail_no_way_bet.tr}"
                : LocaleKeys.detail_odd_closed.tr;
          }
          return NoData(
            fullscreen: fullscreen,
            content: content,
            top: 0,
            type: NoDataType.oddsClosed,
          );
        }
        return ScrollIndexWidget(
          endCallBack: (bool endScroll) {
            detailState.endScroll = endScroll;
          },
          callBack: (int firstIndex, int lastIndex) {},
          scrollDirection: Axis.vertical,
          child: ListView.builder(
            // key: oddsInfoListKey,
            padding: EdgeInsets.only(
                top: fullscreen ? 8 : 8.w,
                bottom: fullscreen
                    ? 80
                    : 60.h +
                        (route != Routes.vrSportDetail ? obtyBottomHeight : 0)),
            itemCount: detailState.filterOddsInfoList.length,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int i) {

              // 增值赔率
              if (controller.detailState.curCategoryTabId == ADDED_ODDS_CATEGORY_ID) {
                return OddsItemAdded(
                  tag: widget.tag,
                  item: detailState.filterOddsInfoList[i],
                  index: i,
                );
              }

              if (detailState.filterOddsInfoList[i] is MatchHps) {
                // 冠军盘口
                if ((detailState.filterOddsInfoList[i] as MatchHps)
                    .isChampion) {
                  return OddsItemChampion(
                    tag: widget.tag,
                    item: detailState.filterOddsInfoList[i],
                    index: i,
                  );
                }

                return _buildItem(
                    detailState.filterOddsInfoList[i], i, controller);
              } else {
                // 虚拟体育增加热门 只在所有投注第一个
                return Temp8(
                  item: detailState.vrHotEntity!,
                  match: detailState.match!,
                );
              }
            },
          ),
        );
      },
    );
  }

  /// 构建单个投注项
  /// [hps] 盘口数据
  /// [index] 索引
  /// [controller] 详情控制器
  /// [animation] 可选的动画对象，用于动画效果
  Widget _buildItem(MatchHps hps, int index, MatchDetailController controller,
      {Animation<double>? animation}) {
    if (animation == null) {
      return OddsItem(
        tag: widget.tag,
        item: hps,
        index: index,
      );
    }

    return SizeTransition(
      sizeFactor: animation,
      child: OddsItem(
        tag: widget.tag,
        item: hps,
        index: index,
      ),
    );
  }
}
