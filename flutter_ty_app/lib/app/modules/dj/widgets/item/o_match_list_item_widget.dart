
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/guanjun/item_guanjun_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/new/new_item_body_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/profession/item_main_widget.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';


import '../../../../services/models/res/match_entity.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞列表 电竞联赛布局分发 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞联赛布局分发
    - 冠军、专业版、新手版

 * `sectionGroupEnum` 分组的类型（未完成，进行中，全部）
 * `matchEntity`赛事数据实体
 * `showGroupHead`是否显示分组头部
 * `count`分组的数量
 * `isLast`是否是分组中最后一项

    ## 1 冠军Item布局


    ```
    if (DJController.to.DJState.selectDate?.menuType == 100) {
    //冠军
    return ItemGuanjunWidget(
    sectionGroupEnum: sectionGroupEnum,
    matchEntity: matchEntity,
    count: count,
    );
    }
    ```

    ## 2 专业版Item布局

    ```
    ItemMainWidget(
    sectionGroupEnum: sectionGroupEnum,
    matchEntity: matchEntity,
    showGroupHead: showGroupHead,
    count: count,
    isLast: isLast,
    );
    ```

    ## 3 新手版Item布局

    ```
    NewItemBodyWidget(
    matchEntity: matchEntity,
    showGroupHead: showGroupHead,
    sectionGroupEnum: sectionGroupEnum,
    count: count,
    isLast: isLast,
    );
    ```

    】】】
 *
 */
class OMatchListItemWidget extends StatelessWidget {
  const OMatchListItemWidget({
    super.key,
    required this.matchEntity,
    required this.sectionGroupEnum,
    this.showGroupHead = true,
    this.count = 0,
    this.isLast = false,
    required this.controller,
  });

  final MatchEntity matchEntity;
  final SectionGroupEnum sectionGroupEnum;
  final bool showGroupHead;
  final bool isLast;
  final int count;
  final TyHomeController controller;

  @override
  Widget build(BuildContext context) {
    final menuType = DJController.to.DJState.selectDate?.menuType;

    return Column(
      children: [
        GetBuilder<DJController>(
          id: '${matchEntity.tid}_${sectionGroupEnum.index}',
          builder: (_) => _buildItem(controller, menuType),
        ),
        if (menuType != 100 && isLast)
          Container(
            height: 8.h,
            color: context.isDarkMode ? null : const Color(0xfff2f2f6),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildItem(TyHomeController controller, int? menuType) {
    if (menuType == 100) {
      // 冠军
      return ItemGuanjunWidget(
        sectionGroupEnum: sectionGroupEnum,
        matchEntity: matchEntity,
        count: count,
      );
    }

    final commonArgs = (
    sectionGroupEnum: sectionGroupEnum,
    matchEntity: matchEntity,
    showGroupHead: showGroupHead,
    count: count,
    isLast: isLast,
    );

    return controller.homeState.isProfess
        ? ItemMainWidget(
      sectionGroupEnum: commonArgs.sectionGroupEnum,
      matchEntity: commonArgs.matchEntity,
      showGroupHead: commonArgs.showGroupHead,
      count: commonArgs.count,
      isLast: commonArgs.isLast,
    )
        : NewItemBodyWidget(
      sectionGroupEnum: commonArgs.sectionGroupEnum,
      matchEntity: commonArgs.matchEntity,
      showGroupHead: commonArgs.showGroupHead,
      count: commonArgs.count,
      isLast: commonArgs.isLast,
    );
  }
}

