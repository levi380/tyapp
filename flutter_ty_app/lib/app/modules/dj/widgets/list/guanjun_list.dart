import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/champion/champion_item_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/header/seaction_header_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../main_tab/main_tab_controller.dart';

class GuanjunListView extends StatelessWidget {
  const GuanjunListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TyHomeController>(
        tag: MainTabController.to.uuid,
        builder: (controller) {
          return Container(
            color: context.isDarkMode
                ? Colors.white.withValues(alpha:0.03999999910593033)
                : const Color(0xfff2f2f6),
            child: CustomScrollView(
              slivers: [
                ..._sliverList(controller, SectionGroupEnum.ALL),
              ],
            ),
          );
        });
  }

  List<Widget> _sliverList(
      TyHomeController controller, SectionGroupEnum sectionGroupEnum) {
    List<Widget> list = [];
    list.add(
      SliverToBoxAdapter(
        child: SectionHeaderWidget(
          sectionGroupEnum: sectionGroupEnum,
          isExpand: controller.homeState.expandMap[sectionGroupEnum] ?? true,
          onExpand: (isExpand) {
            controller.homeState.expandMap[sectionGroupEnum] = isExpand;
            controller.homeState.matchtSet.forEach((element) {
              MatchEntity matchEntity =
                  DataStoreController.to.getMatchById(element.mid) ?? element;
              matchEntity.isExpand = isExpand;
              DataStoreController.to
                  .updateMatch(matchEntity, ishomebyMyId: true);
            });
          },
        ),
      ),
    );
    list.add(
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ChampionItemWidget(
              match: controller.homeState.matchtSet[index],
              sectionGroupEnum: sectionGroupEnum,
              expandStateCache: controller.homeState.expandStateCache,
            );
          },
          childCount: controller.homeState.matchtSet.length,
        ),
      ),
    );
    return list;
  }
}
