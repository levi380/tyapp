import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/champion/champion_item_body_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/header/match_list_item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../../../global/data_store_controller.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../models/section_group_enum.dart';

/// 冠军页面 item
///
class ChampionItemWidget extends StatelessWidget {
  const ChampionItemWidget({
    super.key,
    required this.match,
    required this.sectionGroupEnum,
    required this.expandStateCache,
  });

  final MatchEntity match;
  final SectionGroupEnum sectionGroupEnum;
  final Map<String, bool> expandStateCache;

  ///样式抽离
  bool _isExpand(String mid) => expandStateCache[mid] ?? true;
  Color _backgroundColor(BuildContext context) =>
      context.isDarkMode
          ? Colors.white.withValues(alpha: 0.04)
          : const Color(0xffF8F9FA);
  Color _borderColor(BuildContext context) =>
      context.isDarkMode ? Colors.transparent : const Color(0xffFFFFFF);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
      ///冠军列表 联赛id和赛事id是同一级 数据合并后 不走ws推送    走7s定时器刷新
      // id: MATCH_ID + match.mid,
      builder: (_) {
        // MatchEntity matchEntity = logic.getMatchById(match.mid) ?? match;
        MatchEntity matchEntity = match;
        bool expanded = _isExpand(match.mid);
        return RepaintBoundary(
          child: Padding(
            padding:
            EdgeInsets.only(top: 8.w, left: 5.w, right: 5.w, bottom: 3.h),
            child: Container(
              decoration: BoxDecoration(
                color: _backgroundColor(context),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: _borderColor(context), width: 1),
              ),
              child: StickyHeader(
                header: _buildHeader(
                  context,
                  matchEntity,
                  expanded,
                      (value) {
                    expandStateCache[match.mid] = value;
                    TyHomeController.to.update();
                  },
                ),
                content: _buildContent(context, matchEntity, expanded),
              ),
            ),
          ),
        );
      },
    );
  }
  ///冠军列表 联赛头部
  Widget _buildHeader(
      BuildContext context,
      MatchEntity matchEntity,
      bool expanded,
      Function(bool) onExpandChange,
      ) {
    return Container(
      color: _backgroundColor(context),
      child: MatchListItemHeaderWidget(
        matchEntity: matchEntity,
        onExpandChange: onExpandChange,
        length: expanded ? "" : matchEntity.hps.length.toString(),
        isGuanjun: true,
      ).paddingSymmetric(vertical: 2.h),
    );
  }

  ///冠军列表 item
  Widget _buildContent(
      BuildContext context, MatchEntity matchEntity, bool expanded) {
    if (!expanded) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 0.5,
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.08)
              : const Color(0xffE4E6ED),
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: matchEntity.hps.length,
          itemBuilder: (_, index) => ChampionItemBodyWidget(
            matchHps: matchEntity.hps[index],
            matchEntity: matchEntity,
          ),
        ),
      ],
    );
  }

}

