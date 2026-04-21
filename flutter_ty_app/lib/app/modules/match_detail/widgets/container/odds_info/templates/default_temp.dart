import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../../../main.dart';
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
    - 玩法集通用玩法模板，对应相关玩法hpt:0, 1, 2, 3, 4, 5, 6, 7, 13, 14, 15, 16
    - 展示几列特殊判断
    ```
    int getCrossAxisCount(int length) {
    int hpt = matchHps.hpt;
    String hpid = matchHps.hpid;
    if ([0, 3, 5, 14, 15, 9].contains(hpt)) {
    if ([
    "228",
    "72",
    "385",
    "6",
    "70",
    "1100401",
    "1100400",
    "20027",
    "20028",
    "333",
    ].contains(hpid)) {
    return 3;
    }
    return 2;
    }

    /// 赛果6模板后台问题 按照h5直接返回1列
    if (hpt == 6 && length > 2) {
    return 1;
    }

    return length;
    }
    ```
    】】】
 *
 */
class DefaultTemp extends StatelessWidget {
  const DefaultTemp({
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
    Map<int, List> mains = {};
    MatchEntity? match = DataStoreController.to.getMatchById(matchHps.mid);
    List<MatchHpsTitle> titleList = [];
    if (matchHps.title != null && matchHps.title!.isNotEmpty) {
      titleList = matchHps.title as List<MatchHpsTitle>;
    }

    // 其他
    List<BetItemCollection> other = [];
    List<BetItemCollection> collections = matchHps.allCollection;
    if (titleList.isNotEmpty) {
      for (MatchHpsTitle title in titleList) {
        mains[title.otd] = [];
      }
    }
    Map<int, bool> tempMains = {};
    for (BetItemCollection collection in collections) {
      if (isDov) {
        // 玩法集为增值赔率时，移除所有非增值赔率投注项
        if (collection.ol.dov == 0) continue;
      }

      if (mains.containsKey(collection.ol.otd)) {
        mains[collection.ol.otd]?.add(collection);
        tempMains[collection.ol.otd] = true;
      } else {
        if (matchHps.hpt == 4) {
          mains[0]?.add(collection);
        } else {
          other.add(collection);
        }
      }
    }
    if ([1, 13].contains(matchHps.hpt)) {
      // 这里剔除掉title里面多余项，即title里面的otd 在ol里未找到
      titleList.removeWhere((e) {
        return !tempMains.containsKey(e.otd);
      });
    }

    List<List> arrays = mains.values.toList();
    // 找到最长的数组长度
    int maxLength =
        arrays.fold(0, (max, array) => array.length > max ? array.length : max);
    List list = [];
    // 14模板 除 348 349 特殊处理
    if (matchHps.hpt == 14 && !['348', '349'].contains(matchHps.hpid)) {
      for (List item in mains.values) {
        list.addAll(item);
      }
    } else {
      for (int i = 0; i < maxLength; i++) {
        for (List array in arrays) {
          if (array.isEmpty) {
            continue;
          }
          if (i < array.length) {
            list.add(array[i]);
          } else {
            // vr篮球全场独赢特殊处理
            if (matchHps.hpt == 3 && matchHps.hpid == "20043") {
              continue;
            }
            list.add(null); // 数组长度不够时，补null
          }
        }
      }
    }

    int crossAxisCount = getCrossAxisCount(titleList.length);
    int otherCrossAxisCount = getCrossAxisCount(other.length);
    return Column(
      children: [
        // 标题
        if ([4, 6].contains(matchHps.hpt))
          Padding(
            padding: EdgeInsets.only(
                left: fullscreen ? 4 : 4.w, right: fullscreen ? 4 : 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...List.generate(titleList.length, (index) => index).map(
                  (e) => Expanded(
                    child: Container(
                      // width: fullscreen ? 100 : 116.h,
                      height: fullscreen
                          ? 35
                          : isIPad
                              ? 60.w
                              : 35.w,
                      alignment: Alignment.center,
                      child: Text(
                        titleList.safe(e)?.osn ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: fullscreen
                                ? 12
                                : isIPad
                                    ? 16.sp
                                    : 12.sp,
                            color: fullscreen
                                ? Colors.white.withValues(alpha:0.5)
                                : Get.theme.oddsTeamNameFontColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "PingFang SC"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        if (titleList.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
                left: fullscreen ? 8 : 8.sp,
                right: fullscreen ? 8 : 8.sp,
                bottom: fullscreen ? 8 : 8.sp,
                top: [4, 6].contains(matchHps.hpt)
                    ? 0
                    : fullscreen
                        ? 8
                        : 8.sp),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: childAspectRatio(crossAxisCount, fullscreen),
              ),
              itemBuilder: (BuildContext context, int index) {
                if (list[index] == null) {
                  return blankPlaceholder(fullscreen);
                }
                BetItemCollection c = list[index] as BetItemCollection;
                return OddsButton(
                  key: ValueKey(
                      c.ol.oid + matchHps.hid + matchHps.index.toString()),
                  match: match,
                  hps: matchHps,
                  ol: c.ol,
                  hl: c.hl,
                  isDetail: true,
                  fullscreen: fullscreen,
                  betType: isESport ? OddsBetType.esport : OddsBetType.common,
                );
              },
              itemCount: list.length,
            ),
          ),
        // 其他 或者 matchHps.title null
        if (other.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
                bottom: fullscreen ? 8 : 8.sp,
                left: fullscreen ? 8 : 8.sp,
                right: fullscreen ? 8 : 8.sp,
                top: titleList.isNotEmpty
                    ? 0
                    : fullscreen
                        ? 8
                        : 8.sp),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: otherCrossAxisCount,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio:
                    childAspectRatio(otherCrossAxisCount, fullscreen),
              ),
              itemBuilder: (BuildContext context, int index) {
                BetItemCollection c = other[index];
                return OddsButton(
                  key: ValueKey(
                      c.ol.oid + matchHps.mid + matchHps.index.toString()),
                  height: fullscreen ? 44.5 : 44.5.w,
                  match: match,
                  hps: matchHps,
                  ol: c.ol,
                  hl: c.hl,
                  isDetail: true,
                  fullscreen: fullscreen,
                  betType: isESport ? OddsBetType.esport : OddsBetType.common,
                );
              },
              itemCount: other.length,
            ),
          ),
      ],
    );
  }

  int getCrossAxisCount(int length) {
    int hpt = matchHps.hpt;
    String hpid = matchHps.hpid;
    if ([0, 3, 5, 14, 15, 9].contains(hpt)) {
      if ([
        "228",
        "72",
        "385",
        "6",
        "70",
        "1100401",
        "1100400",
        "20027",
        "20028",
        ///独赢 & 是否都进球 玩法id
        "20030",
        "333",
      ].contains(hpid)) {
        return 3;
      }
      return 2;
    }

    /// 赛果6模板后台问题 按照h5直接返回1列
    if (hpt == 6 && length > 2) {
      return 1;
    }

    return length;
  }
}
