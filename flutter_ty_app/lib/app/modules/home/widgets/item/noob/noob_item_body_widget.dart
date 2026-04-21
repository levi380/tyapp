
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import '../../../../../routes/route_manager.dart';
import '../../../../../services/models/res/match_entity.dart';

import '../../../../../utils/format_score_util3.dart';
import '../../../../../utils/sport.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/combine_info.dart';
import '../profession/score_list.dart';
import 'noob_item_body/noob_item_body_widget_bet_group.dart';
import 'noob_item_body/noob_item_body_widget_header.dart';
import 'noob_item_body/noob_item_body_widget_team.dart';

/*
* 新手版 赛事列表条目
* */

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-7d3a63c7-df94-4a5e-a079-48f44ab7b750-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 新手版 】】】
    【【【 AUTO_PARAGRAPH_TITLE 新手版UI组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    # NoobItemBodyWidget 类

    ## 功能
    `NoobItemBodyWidget` 是一个无状态组件，用于展示比赛的详细信息，包括比赛头部、投注信息和比分等。用户可以点击该组件以查看赛事详情。

    - 列表头部 NoobbuildHeader
    - 列表队伍名称 NoobbuildBetGroupTeam
    - 列表投注按钮 NoobbuildBetGroup
    - 比分 ScoreList

    ## 构造函数
    ```dart

    ///列表头部
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.w),
    child: NoobbuildHeader(match, context),
    ),

    ///列表名称
    NoobbuildBetGroupTeam(match, context),
    ///列表投注按钮
    NoobbuildBetGroup(match, context.isDarkMode),
    ///比分
    ScoreList(
    match: match,
    edition: 2,
    ).marginOnly(top: 8.h),

    ```
    】】】
 *
 */
class NoobItemBodyWidget extends StatelessWidget {
  const NoobItemBodyWidget(
      {super.key, required this.matchEntity, required this.combineType, this.isDetail = false});

  final CombineType combineType;
  final MatchEntity matchEntity;
  final bool isDetail;
  ///是否是发球方
  bool set_serving_side(MatchEntity item,String side) {
    return item.ms == 1 && item.mat == side;
  }

  bool _isThree() {
    return SportData.getSportsCsid([
      SportData.sportCsid_1,
      SportData.sportCsid_4,
      SportData.sportCsid_11,
      SportData.sportCsid_16,
      SportData.sportCsid_37
    ])!
        .contains(int.tryParse(matchEntity.csid));
  }

  @override
  Widget build(BuildContext context) {
    DataStoreController controller = DataStoreController.to;
    String punishHome = _getPunishScore(0);
    String punishAway = _getPunishScore(1);
    return GetBuilder<DataStoreController>(
      id: controller.getMatchId(matchEntity.mid),
      builder: (logic) {
        MatchEntity match =
            controller.getMatchById(matchEntity.mid) ?? matchEntity;
        if (match.isEnd) return 0.verticalSpaceFromWidth;
        return RepaintBoundary(
          child: InkWell(
            //去赛事详情
            onTap: () => RouteManager.goMatchDetail(
                mid: match.mid,
                csid: match.csid,
                isESports: MatchUtil.isEsport(match)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            combineType == CombineType.match ? 8.w : 0.w),
                    child: Divider(
                      height: 0.5,
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha:0.07999999821186066)
                          : const Color(0xffE4E6ED),
                    )),
                4.verticalSpaceFromWidth,

                ///列表头部
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  //_buildHeader(match, context),
                  child: NoobItemBodyWidgetHeader(matchEntity: match),
                ),


                ///列表名称
                NoobItemBodyWidgetTeam(matchEntity: match, punishHome: punishHome, punishAway: punishAway,),
                // _buildTeam(match, context),
                // _buildBetGroup(match, context.isDarkMode),
                NoobItemBodyWidgetBetGroup(
                  matchEntity: match,
                  isThree: _isThree(),
                  isDetail: isDetail,
                  isDarkMode: context.isDarkMode,
                ),
                ///比分
                ScoreList(
                  match: match,
                  edition: 2,
                ).marginOnly(top: 8.h),
                // MultiScoreWidget(match),
                SizedBox(
                  height: 6.w,
                ),
                // Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 8.w),
                //     child:
                //         GuanjunYindao(tid: match.tid.toString(), mid: match.mid)
                //     // Text("冠军引导盘")
                //     )
              ],
            ),
          ),
        );
      },
    );
  }

  String _getPunishScore(int index) {
    if (int.tryParse(matchEntity.csid) != SportData.sportCsid_1) return '0';
    if (!TyHomeController.to.visiable) return '0';
    if (matchEntity.msc.isEmpty) return '0';
    return FormatScore3.footballScoreStatusArray(matchEntity, index);
    // if (matchEntity.msc.isNotEmpty &&
    //     int.parse(matchEntity.csid) == SportData.sportCsid_1 &&
    //     TyHomeController.to.visiable) {
    //   return FormatScore.footballScoreStatusArray(matchEntity, index);
    // }
    // return '0';
  }
}
