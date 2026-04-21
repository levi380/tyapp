import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../../../../models/odds_button_enum.dart';
import '../odds_button.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_item_util.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注列表+赛果列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 详情玩法组件集合】】】
    【【【 AUTOMATIC_GENERATE_DOCUMENT_PARAGRAPH_CONTENT
    -  新版18
    】】】
 *
 */
class Temp18New extends StatelessWidget {
  const Temp18New({
    super.key,
    required this.matchHps,
    required this.fullscreen,
    this.isESport = false,
    this.isDov = false,
  });

  final MatchHps matchHps;
  final bool fullscreen;

  /// 是否是电竞
  final bool isESport;
  final bool isDov;

  @override
  Widget build(BuildContext context) {
    MatchEntity? match = DataStoreController.to.getMatchById(matchHps.mid);
    List<List<MatchHpsTitle>?> titleList2 =
        matchHps.title as List<List<MatchHpsTitle>?>;

    List<BetItemCollection> collection = matchHps.collection;

    if (isDov) {
      // 只保留增值赔率（dov != 0）
      collection = collection.where((e) => e.ol.dov != 0).toList();
    }

    List list = [];
    titleList2.forEach((List<MatchHpsTitle>? titleList) {
      // 左
      List<BetItemCollection> collectionA = collection
          .where((element) => element.ol.otd == titleList?[0].otd)
          .toList();
      // 中
      List<BetItemCollection> collectionB = collection
          .where((element) => element.ol.otd == titleList?[1].otd)
          .toList();
      // 右
      List<BetItemCollection> collectionC = [];
      collectionC = collection
          .where((element) => element.ol.otd == titleList?[2].otd)
          .toList();
      list.addAll([...collectionA, ...collectionB, ...collectionC]);
    });

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: childAspectRatio(2, fullscreen),
          ),
          itemBuilder: (BuildContext context, int index) {
            if (list[index] == null) {
              return Container();
            }
            BetItemCollection c = list[index] as BetItemCollection;
            List<String> names = c.ol.on.trim().split(" ");
            return OddsButton(
              key:
                  ValueKey(c.ol.oid + matchHps.mid + matchHps.index.toString()),
              match: match,
              hps: matchHps,
              ol: c.ol,
              hl: c.hl,
              name: names.length > 1 ? (names[0] + names[1]) : c.ol.on,
              isDetail: true,
              fullscreen: fullscreen,
              betType: isESport ? OddsBetType.esport : OddsBetType.common,
            );
          },
          itemCount: list.length,
        ),
      ],
    );
  }

  // 附加盘投注项集合
  List<BetItemCollection> getAppendSingleList(
      MatchHps data, MatchEntity? match) {
    List<BetItemCollection> result = [];
    List<MatchHpsHl> hl = data.hl;
    for (var i = 0; i < hl.length; i++) {
      List<MatchHpsHlOl> ol = hl[i].ol;
      for (var j = 0; j < ol.length; j++) {
        MatchHpsHlOl newOl =
            DataStoreController.to.getOlById(ol[j].oid) ?? ol[j];
        MatchHpsHl newHl = DataStoreController.to.getHlById(hl[i].hid) ?? hl[i];
        var item = BetItemCollection(
          ol: newOl,
          hl: newHl,
        );
        result.add(item);
      }
    }
    return result;
  }

  /// 补充空白占位 不足total个 补到total个
  List fillBlankPlaceholder(List list, int total) {
    List newList = [...list];
    if (list.length < total) {
      int length = list.length;
      newList.addAll(List.filled(total - length, null).toList());
    }
    return newList;
  }

  List getMixedList(
      int total,
      List<BetItemCollection> collectionA,
      List<BetItemCollection> collectionB,
      List<BetItemCollection> collectionC) {
    List list = [];
    List list1 = fillBlankPlaceholder(collectionA, total);
    List list2 = fillBlankPlaceholder(collectionB, total);
    List list3 = fillBlankPlaceholder(collectionC, total);
    for (int i = 0; i < total; i++) {
      // 改列为空则不进行混入
      if (list1[0] != null) list.add(list1[i]);
      if (list2[0] != null) list.add(list2[i]);
      if (list3[0] != null) list.add(list3[i]);
    }
    return list;
  }
}
