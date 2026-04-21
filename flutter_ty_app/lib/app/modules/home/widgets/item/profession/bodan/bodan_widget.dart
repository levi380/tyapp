// ignore_for_file: must_be_immutable

import 'dart:collection';

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';
import '../../../../../../../main.dart';
import '../../../../../../routes/route_manager.dart';
import '../../../../../match_detail/widgets/container/odds_info/odds_button.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../logic/bold_util.dart';
import '../../../../logic/other_player_name_to_playid.dart';
import 'bodan_Item_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-06de67a4-485b-4b00-91a1-b8c4546e388e-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 子玩法 】】】
    【【【 AUTO_PARAGRAPH_TITLE 波胆UI组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - isTbold 是否加时波胆
    - btnHeight 投注按钮宽度
    - 绘制波胆队伍标题
    ```
    //过滤掉没有标题的
    List<MatchHps>  targethps = [];
    if(isTbold){
    targethps = targetMatch.hpsTBold;
    }else{
    targethps = targetMatch.hpsBold;
    }
    ///  targetMatch.hpsTBold  加时波胆数据
    targethps.forEach((element) {
    if (element.hl.isNotEmpty &&
    element.hl.first.title.isNotEmpty &&
    element.hl.first.ol.isNotEmpty) {
    targetHpsList.add(element);
    }
    });
    ```
    - olMap.isEmpty 波胆空数据填充
    ```
    olMap = BoldUtil.getFromBoldMatchHps(boldHps);
    ///空数据填充
    if (olMap.isEmpty) {
    olMap[1] = [
    MatchHpsHlOl(),
    MatchHpsHlOl(),
    MatchHpsHlOl(),
    ];
    olMap[2] = [
    MatchHpsHlOl(),
    MatchHpsHlOl(),
    MatchHpsHlOl(),
    ];
    olMap[0] = [
    MatchHpsHlOl(),
    MatchHpsHlOl(),
    MatchHpsHlOl(),
    ];
    }
    ```
    - bodan_Item 波胆赔率数据填充
    ```
    bodan_Item(
    match: match,
    title: map[index]?.osn ?? '',
    list: olMap[index] ?? [],
    hps: boldHps,
    type: type,
    maxLine: maxLine,
    ),
    ```
    - 主客队 width 宽度计算
    ```
    //计算其他按钮宽度 去除间距后 占一半宽度
    double width = ((Get.width - 28.w - 12.w) / 2).toInt().toDouble();
    ```
    ## BoDanWidget 类

    BoDanWidget` 是一个 Flutter 的 StatelessWidget，用于显示比赛的波胆数据。

    - **参数**
    - `match`: 当前比赛的实体。
    - `hps`: 比赛的波胆数据列表。
    - `isTbold`: 是否显示加粗的波胆数据。

    ## 属性

    - `hps`: 存储比赛的波胆数据。
    - `match`: 当前比赛的实体。
    - `isTbold`: 判断是否为加粗数据。
    - `targetHpsList`: 存储过滤后的波胆数据列表。
    - `maxLine`: 最大行数，默认为 3。
    - `btnHeight`: 按钮高度，默认为 35。

    ## 方法

    ### build

    构建 UI 组件。

    - 使用 `GetBuilder` 监听数据变化。
    - 根据 `isTbold` 选择对应的波胆数据。
    - 过滤掉没有标题的波胆数据。
    - 根据数据数量设置安全的第一个和最后一个波胆数据。

    ### _buildGroud

    构建波胆数据的显示区域。

    - **参数**
    - `boldHps`: 当前波胆数据。
    - `type`: 数据类型（全场或半场）。

    - 创建一个 `LinkedHashMap` 用于存储波胆标题。
    - 填充空数据以确保 UI 的完整性。
    - 计算按钮的宽度并返回构建好的列。


    】】】
 *
 */

///波胆
class BoDanWidget extends StatelessWidget {
  BoDanWidget({
    super.key,
    required this.match,
    required this.hps,
    required this.isTbold,
    this.playId = '',
    this.pids = '',
  });

  double btnHeight = 35;
  MatchHpsHlOl? first;
  final List<MatchHps> hps;
  final bool isTbold;
  MatchHpsHlOl? last;
  final MatchEntity match;
  int maxLine = 3;
  List<MatchHps> targetHpsList = [];
  final String playId;
  final String pids;

  _buildGroud(MatchHps boldHps, int type) {
    LinkedHashMap<int, MatchHpsTitle> map = LinkedHashMap();
    Map<int, List<MatchHpsHlOl>> olMap = {};
    boldHps.hl.safeFirst?.title.forEach((element) {
      map[element.otd] = element;
    });

    if (map.isEmpty) {
      map[1] = MatchHpsTitle()
        ..osn = match.mhn
        ..otd = 1;
      map[2] = MatchHpsTitle()
        ..osn = match.man
        ..otd = 2;

      map[0] = MatchHpsTitle()
        ..osn = '半场平局'
        ..otd = 0;
    }
    olMap = BoldUtil.getFromBoldMatchHps(boldHps);

    ///空数据填充
    if (olMap.isEmpty) {
      olMap[1] = [
        MatchHpsHlOl(),
        MatchHpsHlOl(),
        MatchHpsHlOl(),
      ];
      olMap[2] = [
        MatchHpsHlOl(),
        MatchHpsHlOl(),
        MatchHpsHlOl(),
      ];
      olMap[0] = [
        MatchHpsHlOl(),
        MatchHpsHlOl(),
        MatchHpsHlOl(),
      ];
    }

    olMap.values.forEach((element) {
      if (element.length > maxLine) {
        maxLine = element.length;
      }
    });

    //波胆客队和主队是否有数据填充
    if (type == 0) {
      first = olMap[-1]?.first;
      TyHomeController.to.setFirstMap(first);
    } else {
      last = olMap[-1]?.first;
      TyHomeController.to.setLastMap(last);
    }
    //计算其他按钮宽度 去除间距后 占一半宽度
    double width = ((Get.width - 28.w - 12.w) / 2).toInt().toDouble();

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BodanItemWidget(
              match: match,
              title: map[1]?.osn ?? '',
              list: olMap[1] ?? [],
              hps: boldHps,
              type: type,
              maxLine: maxLine,
            ),
            SizedBox(
              width: 2.w,
            ),
            BodanItemWidget(
              match: match,
              title: type == 0
                  ? LocaleKeys.football_playing_way_full_time_draw.tr
                  : LocaleKeys.football_playing_way_half_time_draw.tr,
              list: olMap[0] ?? [],
              hps: boldHps,
              maxLine: maxLine,
              type: type,
            ),
            SizedBox(
              width: 2.w,
            ),
            BodanItemWidget(
              match: match,
              title: map[2]?.osn ?? '',
              list: olMap[2] ?? [],
              hps: boldHps,
              type: type,
              maxLine: maxLine,
            ),
          ],
        ),
        if (first != null || last != null)
          OddsButton(
            //type: 3,///波胆 其他
            playId: playIdConfig.hpsBold,
            name: LocaleKeys.list_other.tr,
            //IPad单独适配
            height: (isIPad ? btnHeight.w : btnHeight) +
                (TyTextScaler.instance().isScale ? 6 : 0),
            width: width,
            radius: 4.w,
            match: match,
            hl: boldHps.hl.safeFirst,
            hps: boldHps,
            ol: olMap[-1]?.first,
            nameColor: const Color(0xff3AA6FC),
            betType: MatchUtil.isEsport(match)
                ? OddsBetType.esport
                : OddsBetType.common,
          ).marginOnly(top: 2.w)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
      id: DataStoreController.to.getMatchId(match.mid),
      builder: (logic) {
        // MatchEntity targetMatch = logic.getMatchById(match.mid) ?? match ;
        MatchEntity targetMatch = match;
        //过滤掉没有标题的
        List<MatchHps> targethps = [];
        if (isTbold) {
          targethps = targetMatch.hpsTBold;
        } else {
          targethps = targetMatch.hpsBold;
        }

        ///  targetMatch.hpsTBold  加时波胆数据
        targethps.forEach((element) {
          if (element.hl.isNotEmpty &&
              element.hl.first.title.isNotEmpty &&
              element.hl.first.ol.isNotEmpty) {
            targetHpsList.add(element);
          }
        });

        MatchHps targetHpsListSafeFirst = targetHpsList.safeFirst ?? MatchHps();
        MatchHps targetHpsListSafeLast = MatchHps();
        if (targetHpsList.isNotEmpty) {
          if (targetHpsList.length > 2) {
            targetHpsListSafeLast = targetHpsList[1];
          } else {
            targetHpsListSafeFirst = targetHpsList.safeFirst ?? MatchHps();
          }
        }

        return InkWell(
          onTap: playId.isNotEmpty
              ? () {
                  if (playId.isNotEmpty) {
                    // 次要玩法跳转指定玩法集tab
                    RouteManager.goMatchDetail(
                      mid: match.mid,
                      playId: playId,
                      pids: pids,
                      csid: match.csid,
                    );
                  }
                }
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // bodanBuildGroud(targetHpsListSafeFirst, 0,match,maxLine,btnHeight),
                  ///全场数据
                  _buildGroud(targetHpsListSafeFirst, 0),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // print('点击右边');
                    },
                    // child: bodanBuildGroud(targetHpsListSafeLast, 1,match,maxLine,btnHeight),
                    ///半场数据
                    child: _buildGroud(targetHpsListSafeLast, 1),
                  )
                ],
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  // print('点击右边');
                },
                child: SizedBox(
                  height: 8.w,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
