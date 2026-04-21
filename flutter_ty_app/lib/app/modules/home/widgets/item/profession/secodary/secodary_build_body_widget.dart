import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller.dart';
import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../models/play_info.dart';
import '../../guanjun_yindao/guanjun_yindao.dart';
import '../bodan/bodan_widget.dart';
import '../corner_play_temp.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';

import '../feature/feature_temp.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-06de67a4-485b-4b00-91a1-b8c4546e388e-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 子玩法 】】】
    【【【 AUTO_PARAGRAPH_TITLE 子玩法活动添加 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛事已开启子玩法活动添加
    ## 组件概述
    `buildBodyWidget` 是一个用于展示比赛相关玩法的组件，支持多种玩法的显示，包括晋级赛、角球、罚牌、波胆等。

    ## 属性
    - **match**: 当前比赛数据。
    - **playInfo**: 当前玩法信息。
    - **isMoreSelect**: 是否为更多选择。
    - **isSelect**: 是否已选择。
    - **mid**: 比赛 ID。

    ## 方法
    ### build
    - 构建组件的 UI，使用 `GetBuilder` 监听状态变化。
    - 当状态更新时，重新构建组件。

    ### _buildBody
    - 根据不同的玩法 ID 和比赛状态，返回对应的子组件。
    - 如果没有选择或玩法 ID 为空，返回空组件。
    - 根据条件判断返回不同的玩法组件，例如晋级赛、角球、罚牌等。

    ## UI 逻辑
    - 使用 `Column` 布局展示不同玩法的组件。
    - 根据条件判断是否显示特定的玩法组件，确保只有在满足条件时才渲染对应的内容。

    】】】
 *
 */
// ignore: camel_case_types
class buildBodyWidget extends StatelessWidget {
  const buildBodyWidget({
    super.key,
    required this.match,
    required this.playInfo,
    required this.mid,
    this.isSelect = false,
    this.isMoreSelect = false,
  });

  final bool isMoreSelect;
  final bool isSelect;
  final match;
  final String mid;
  final PlayInfo playInfo;

  /// 晋级赛 1005      hpsOutright 1006    hpsCorner 1001
  /// 5分钟玩法 1009      15分钟玩法 1007    波胆 1008
  /// 特色组合 1010      罚牌 1003    加时赛 1002
  /// 点球大战 1004  十个
  Widget _buildBody(
    MatchEntity match,
  ) {
    if (playInfo.playId.isEmpty ||
        (isMoreSelect == false && isSelect == false)) {
      return const SizedBox();
    } else {
      /// 角球1001 加时赛1002 罚牌1003 点球大赛1004 晋级1005 冠军1006 15分钟 1007 波胆 1008 特色组合 1010
      /// 晋级1005
      if (match.cosPromotion && playInfo.playId == playIdConfig.hpsPromotion) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsPromotion,
          playId: playInfo.playId,
          pids: playInfo.pids,
          isMainPlay: false,
        );
      }

      ///冠军
      if (match.cosOutright && playInfo.playId == playIdConfig.hpsOutright) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsOutright,
          playId: playInfo.playId,
          pids: playInfo.pids,
          isMainPlay: false,
        );
      }

      ///角球
      if (match.cosCorner && playInfo.playId == playIdConfig.hpsCorner) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsCorner,
          playId: playInfo.playId,
          pids: playInfo.pids,
          isMainPlay: false,
        );
      }

      /// 加时角球
      if (match.cosTCorner &&
          playInfo.playId == playIdConfig.hpsTCorner) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsTCorner,
          playId: playInfo.playId,
          pids: playInfo.pids,
          isMainPlay: false,
        );
      }

      ///15分钟
      if (match.cos15Minutes && playInfo.playId == playIdConfig.hps15Minutes) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hps15Minutes,
          playId: playInfo.playId,
          pids: playInfo.pids,
          isMainPlay: false,
        );
      }

      ///罚牌
      if (match.cosPunish && playInfo.playId == playIdConfig.hpsPunish) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsPunish,
          playId: playInfo.playId,
          pids: playInfo.pids,
          isMainPlay: false,
        );
      }

      /// 加时罚牌
      if (match.cosTPunish &&
          playInfo.playId == playIdConfig.hpsTPunish) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsTPunish,
          playId: playInfo.playId,
          pids: playInfo.pids,
          isMainPlay: false,
        );
      }

      ///波胆
      if (match.cosBold && playInfo.playId == playIdConfig.hpsBold) {
        return BoDanWidget(
            key: ValueKey(playInfo.playId + mid),
            match: match,
            hps: match.hpsBold,
            // 波胆不需要跳转详情
            // playId: playInfo.playId,
            // pids: playInfo.pids,
            isTbold: false);
      }

      /// 加时波胆
      if (match.cosTBold && playInfo.playId == playIdConfig.hpsTBold) {
        return BoDanWidget(
            key: ValueKey(playInfo.playId + mid),
            match: match,
            hps: match.hpsTBold,
            // playId: playInfo.playId,
            // pids: playInfo.pids,
            isTbold: true);
      }

      ///特色组合
      if (match.compose && playInfo.playId == playIdConfig.hpsCompose) {
        return FeatureTemp(
          key: ValueKey(playInfo.playId + mid),
          matchEntity: match,
          hps: match.hpsCompose,
          // playId: playInfo.playId,
          // pids: playInfo.pids,
        );
      }

      ///加时赛
      if (match.cosOvertime && playInfo.playId == playIdConfig.hpsOvertime) {
        print('点了加时赛');
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsOvertime,
          playId: playInfo.playId,
          pids: playInfo.pids,
          isMainPlay: false,
        );
      }

      ///点球大战
      if (match.cosPenalty && playInfo.playId == playIdConfig.hpsPenalty) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsPenalty,
          playId: playInfo.playId,
          pids: playInfo.pids,
          isMainPlay: false,
        );
      }

      /// 6分钟
      if (match.cos6Minutes && playInfo.playId == playIdConfig.hps6Minutes){
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hps6Minutes,
          playId: playInfo.playId,
          isMainPlay: false,
        );
      }

      ///第X节 上半场 下半场
      if ((match.cosSection1 && playInfo.playId == playIdConfig.hpsSection1)
          || (match.cosSection2 && playInfo.playId == playIdConfig.hpsSection2)
          || (match.cosSection3 && playInfo.playId == playIdConfig.hpsSection3)
          || (match.cosSection4 && playInfo.playId == playIdConfig.hpsSection4)
          || (match.cosFristHalf && playInfo.playId == playIdConfig.hpsFirstHalf)
          || (match.cosSecondHalf && playInfo.playId == playIdConfig.hpsSecondHalf)
      ){
        List<MatchHps> hps = []
          ..addAll(match.hpsSectionPlay);
        //hps.removeWhere((element)=>!playInfo.pids.split(',').contains(element.hpid));
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: hps,
          playId: playInfo.playId,
          isMainPlay: false,
        );
      }
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TyHomeController>(
      tag: MainTabController.to.uuid,
      id: DataStoreController.to.getMatchId(mid),
      builder: (controller) {
        // AppLogger.debug("
        // ==========================>更新进球數據倉庫更新列表");
        // TyHomeController controller = TyHomeController.to;
        // MatchEntity? match = controller.homeState.outrightDisplayMap[tid];

        if (
            playInfo.playId == playIdConfig.championGuide
            && controller.homeState.league.sportConfigInfo.mi.startsWith('50101') == false
            && controller.homeState.league.sportConfigInfo.mi.startsWith('50102') == false
        )
        {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: GuanjunYindao(
              tid: match.tid.toString(),
              mid: match.mid,
            )
          // Text("冠军引导盘")
          );
        }else
        {
          return Column(
            children: [_buildBody(match)],
          );
        }
      },
    );
  }
}
