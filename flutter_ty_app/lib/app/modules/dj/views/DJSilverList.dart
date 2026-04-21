import 'dart:collection';

import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../utils/change_skin_tone_color_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/controllers/pin_controller.dart';
import '../../home/models/section_group_enum.dart';
import '../../home/widgets/item/header/seaction_header_widget.dart';
import '../../home/widgets/item/header/sport_header_widget.dart';
import '../../home/widgets/item/profession/bet_title_group_widget.dart';
import '../controllers/dj_controller.dart';
import '../widgets/item/dj_match_list_item_header_widget.dart';
import '../widgets/item/o_match_list_item_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 分组列表显示 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 分组列表显示
    # `_sliverList`



    - 根据ms区分未开赛，进行中，全部
    - ms == 0 未开赛
    - ms == 1 进行中

    ```
    switch (sectionGroupEnum) {
    case SectionGroupEnum.IN_PROGRESS:

    case SectionGroupEnum.NOT_STARTED:

    case SectionGroupEnum.ALL:

    case SectionGroupEnum.Pin:
    }
    ```

    ` - 点击 未开赛/进行中 折叠/展开 每个联赛分组`

    ```dart
    data.forEach((matchEntity) {
    DJController.to
    .clickCollop(isExpand, matchEntity, sectionGroupEnum);
    });
    ```

    # `GroupList`

    -联赛标题

    ```
    DJMatchListItemHeaderWidget(
    matchEntity: items.first!,
    onExpandChange: (value) {
    ///收起/展开 同组联赛信息
    logic.clickCollop(value, items.first!, sectionGroupEnum);
    },
    count: items.length,
    isPinned: state.isPinned,
    );
    ```

    -赔率分组标题 专业版显示

    ```
    BetTitleGroupWidget(
    hps: items.first!.hps,
    matchEntity: items.first!,
    isPinned: state.isPinned,
    isDj: true,
    );
    ```

    约束条件

    ```
    if (tyHomeController.homeState.isProfess &&
    DJController.to.DJState.selectDate?.menuType != 100)
    ```

    】】】
 *
 */
class DJSilverList extends StatefulWidget {
  final SectionGroupEnum sectionGroupEnum;

  @override
  State<DJSilverList> createState() {
    return DJSilverListState();
  }

  DJSilverList({super.key, required this.sectionGroupEnum});
}

class DJSilverListState extends State<DJSilverList> {
  @override
  Widget build(BuildContext context) {
    final controller = DJController.to;
    final sectionGroupEnum = widget.sectionGroupEnum;

    /// 提取过滤逻辑
    List<MatchEntity?> data = _filterMatches(controller.DJState.djListEntity, sectionGroupEnum);

    /// 构建分组 map
    final LinkedHashMap<String, List<MatchEntity?>> dataMap = _groupByTid(data);

    /// 构建 UI
    final list = <Widget>[];
    if (data.isNotEmpty) {
      final title = "${data[0]?.csna}(${data.length})";
      list.add(_buildSection(context, controller, sectionGroupEnum, data, dataMap, title));
    }

    return MultiSliver(children: list);
  }

  /// ------------------ 抽取出的通用逻辑 ------------------

  /// 按 section 类型筛选比赛数据
  List<MatchEntity?> _filterMatches(List<MatchEntity?> all, SectionGroupEnum type) {
    switch (type) {
      case SectionGroupEnum.IN_PROGRESS:
        return all.where((e) => e?.ms == 1).toList();
      case SectionGroupEnum.NOT_STARTED:
        return all.where((e) => e?.ms == 0).toList();
      case SectionGroupEnum.ALL:
        TyHomeController.to.homeState.dateTime = 0;
        return all;
      case SectionGroupEnum.Pin:
        final pinMatchList = PinController.to?.pinMatchList() ?? [];
        return all.where((e) =>
            pinMatchList.any((pin) => pin.mid == e?.mid)).toList();
      default:
        return [];
    }
  }

  /// 按 tid 分组
  LinkedHashMap<String, List<MatchEntity?>> _groupByTid(List<MatchEntity?> data) {
    final nonNull = data.whereType<MatchEntity>();
    final grouped = CollectionTools.groupBy<MatchEntity, String>(
      nonNull,
      (e) => e.tid,
    );

    final res = LinkedHashMap<String, List<MatchEntity?>>();
    grouped.forEach((key, value) {
      res[key] = value.cast<MatchEntity?>();
    });
    return res;
  }

  /// 构建 Section UI
  Widget _buildSection(
      BuildContext context,
      DJController controller,
      SectionGroupEnum sectionGroupEnum,
      List<MatchEntity?> data,
      LinkedHashMap<String, List<MatchEntity?>> dataMap,
      String title,
      ) {
    return SliverStickyHeader(
      header: Container(
        color: context.isDarkMode
            ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(
            colorStyle_1: const Color(0xFF2B2D33),
            colorStyle_2: const Color(0xFF23292D),
            colorStyle_3: const Color(0xFF26242A))
            : const Color(0xFFF8F9FA),
        child: Obx(() {
          final isExpand = _getExpandState(controller, sectionGroupEnum);
          return SectionHeaderWidget(
            sectionGroupEnum: sectionGroupEnum,
            isExpand: isExpand,
            onExpand: (value) {
              _setExpandState(controller, sectionGroupEnum, value);
              for (final match in data) {
                DJController.to.clickCollop(value, match, sectionGroupEnum);
              }
            },
          );
        }),
      ),
      sliver: MultiSliver(
        children: [
          if (controller.DJState.selectDate?.menuType != 100 &&
              !controller.isCollect())
            SliverToBoxAdapter(child: SportHeaderWidget(title: title)),
          if (controller.DJState.selectDate?.menuType == 100)
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
          MultiSliver(children: GroupList(dataMap, sectionGroupEnum)),
        ],
      ),
    );
  }

  bool _getExpandState(DJController controller, SectionGroupEnum type) {
    switch (type) {
      case SectionGroupEnum.IN_PROGRESS:
        return controller.DJState.isExpandProcess.value;
      case SectionGroupEnum.ALL:
        return controller.DJState.isExpandAll.value;
      case SectionGroupEnum.Pin:
        return controller.DJState.isExpandPin.value;
      default:
        return controller.DJState.isExpand.value;
    }
  }

  void _setExpandState(DJController controller, SectionGroupEnum type, bool val) {
    switch (type) {
      case SectionGroupEnum.IN_PROGRESS:
        controller.DJState.isExpandProcess.value = val;
        break;
      case SectionGroupEnum.ALL:
        controller.DJState.isExpandAll.value = val;
        break;
      case SectionGroupEnum.Pin:
        controller.DJState.isExpandPin.value = val;
        break;
      default:
        controller.DJState.isExpand.value = val;
    }
  }

  List<SliverStickyHeader> GroupList(
      LinkedHashMap<String, List<MatchEntity?>> dataMap,
      SectionGroupEnum sectionGroupEnum) {
    TyHomeController tyHomeController = TyHomeController.to;
    DJController controller = DJController.to;

    String? lastCsna = '';
    return dataMap.values.map((items) {
      bool isFirst = lastCsna != items.first?.csna;
      if (isFirst) {
      } else {}
      lastCsna = items.first?.csna;
      var title = "${items.first?.csna}(${items.length})";

      ///电竞联赛
      return SliverStickyHeader.builder(
        builder: (_, state) => Column(
          children: [
            if (controller.isCollect() && isFirst) //收藏显示
              SportHeaderWidget(
                title: title,
              ),
            /**联赛标题*/
            GetBuilder<DJController>(
                id: items.first!.tid + "_" + sectionGroupEnum.index.toString(),
                builder: (logic) {
                  return DJMatchListItemHeaderWidget(
                    matchEntity: items.first!,
                    onExpandChange: (value) {
                      ///收起/展开 同组联赛信息
                      logic.clickCollop(value, items.first!, sectionGroupEnum);
                    },
                    count: items.length,
                    isPinned: state.isPinned,
                  );
                }),
            if (tyHomeController.homeState.isProfess &&
                DJController.to.DJState.selectDate?.menuType != 100)
              /**赔率分组标题 专业版显示*/
              GetBuilder<DJController>(
                  id: items.first!.tid +
                      "_" +
                      sectionGroupEnum.index.toString(),
                  builder: (logic) {
                    if (logic.isCollop(items.first, sectionGroupEnum)) {
                      return SizedBox.shrink();
                    }
                    return BetTitleGroupWidget(
                      hps: items.first!.hps,
                      matchEntity: items.first!,
                      isPinned: state.isPinned,
                      isDj: true,
                    );
                  }),
          ],
        ),
        sliver: SliverList.builder(
          itemBuilder: (context, index) {
            return OMatchListItemWidget(
              matchEntity: items[index] ?? MatchEntity(),
              sectionGroupEnum: sectionGroupEnum,
              showGroupHead: false,
              isLast: index == items.length - 1,
              count: items.length,
              controller: tyHomeController,
            );
          },
          addRepaintBoundaries: false,
          itemCount: items.length,
        ),
      );
    }).toList();
  }
}
