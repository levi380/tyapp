
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/easy_debounce_throttle/easy_debounce.dart';

import 'package:flutter_ty_app/generated/json/match_entity.g.dart';
import '../../../services/models/res/match_entity.dart';
import '../../main_tab/main_tab_controller.dart';
import '../models/section_group_enum.dart';
import '../states/home_state.dart';
import '../widgets/item/champion/champion_item_widget.dart';
import '../widgets/item/header/seaction_header_widget.dart';
import '../widgets/home_back_top_button.dart';

/// 冠军列表
class ChampionMatchListView extends StatefulWidget {
  const ChampionMatchListView({super.key});

  @override
  State<ChampionMatchListView> createState() => _ChampionMatchListViewState();
}

class _ChampionMatchListViewState extends State<ChampionMatchListView> {
  static const double _showTopThreshold = HomeState.championShowTopThreshold;
  static const Duration _hideTopDelay = HomeState.championHideTopDelay;

  late final ScrollController _scrollController;
  bool showTop = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// 滚动监听优化版
  void _scrollListener() {
    final shouldShow = _scrollController.offset > _showTopThreshold;

    if (shouldShow != showTop) {
      setState(() => showTop = shouldShow);
    }

    /// 3 秒后自动隐藏
    if (shouldShow) {
      EasyDebounce.debounce(
        'scrollListenerDebounce',
        _hideTopDelay,
        () => mounted ? setState(() => showTop = false) : null,
      );
    }
  }

  /// 冠军主列表
  Widget _buildChampionSliver(TyHomeController controller) {
    final championList = mergeMatchEntities(controller.homeState.matchtSet);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final match = championList[index];
          return ChampionItemWidget(
            key: ValueKey("Champion${match.mid}"),
            match: match,
            sectionGroupEnum: SectionGroupEnum.ALL,
            expandStateCache: controller.homeState.expandStateCache,
          );
        },
        childCount: championList.length,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TyHomeController>(
      tag: MainTabController.to.uuid,
      builder: (controller) {
        return Container(
          color: context.isDarkMode ? null : HomeState.commonBackgroundColor,
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  /// 冠军联赛头部区域
                  SliverToBoxAdapter(
                    child: SectionHeaderWidget(
                      sectionGroupEnum: SectionGroupEnum.ALL,
                      isExpand: controller
                              .homeState.expandMap[SectionGroupEnum.ALL] ??
                          true,
                      onExpand: (isExpand) {
                        controller.homeState.expandMap[SectionGroupEnum.ALL] =
                            isExpand;

                        /// 更新子赛事展开状态
                        for (var item in controller.homeState.matchtSet) {
                          controller.homeState.expandStateCache[item.mid] =
                              isExpand;
                        }
                        controller.update();
                      },
                    ),
                  ),

                  /// 冠军主列表
                  _buildChampionSliver(controller),
                ],
              ),

              /// 返回顶部按钮
              if (showTop)
                HomeBackTopButton(
                  bottom: HomeState.outrightBottomPadding.w,
                  onTap: () {
                    _scrollController.animateTo(
                      0,
                      duration: HomeState.commonScrollToTopDuration,
                      curve: Curves.easeInOut,
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  /// 冠军赛事合并数据
  List<MatchEntity> mergeMatchEntities(List<MatchEntity> list) {
    final Map<String, MatchEntity> map = {};

    for (final match in list) {
      if (map.containsKey(match.tid)) {
        map[match.tid]!.hps.addAll(match.hps);
      } else {
        map[match.tid] = match.copyWith(
          hps: List.of(match.hps),
        );
      }
    }
    return map.values.toList();
  }
}

