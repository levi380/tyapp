
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/widget/new_analyze_tab_bar.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import 'package:flutter_ty_app/app/widgets/empty/text_no_data.dart';
import '../../../../controllers/statistic/battle_array_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/analyze_divider.dart';
import 'package:flutter_ty_app/main.dart';
import 'widget/analyze_battle_array_head.dart';
import 'widget/football_battle_array_list_item_head.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/models/res/analyze_array_person_entity.dart';
import '../../../../../login/login_head_import.dart';
import 'widget/analyze_child_item.dart';
import '../../../../states/battle_array_state.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 阵容页面-足球
    】】】
 *
 */
class FootballBattleArrayPage extends StatefulWidget {
  FootballBattleArrayPage({Key? key, required this.tag}) : super(key: key);
  /// 赛事/控制器 tag，用于 GetX 绑定 [BattleArrayController]
  final String tag;

  @override
  State<FootballBattleArrayPage> createState() =>
      _FootballBattleArrayPageState();
}

class _FootballBattleArrayPageState extends State<FootballBattleArrayPage> {
  /// 构建阵容页：顶部 Tab（主客队）+ [TabBarView] 双页，每页为 [buildContent] 的 [CustomScrollView]（头部 + 首发/替补/伤停列表）。
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleArrayController>(
        tag: widget.tag,
        init: BattleArrayController(tag: widget.tag),
        builder: (controller) {
          return Column(
            children: [
              _buildTab(controller),
              SizedBox(height: BattleArrayState.footballTabBottomSpacing.w),
              Expanded(
                child: TabBarView(
                  controller: controller.state.tabController,
                  children: [
                    buildContent(controller),
                    buildContent(controller),
                  ],
                ),
              )
            ],
          );
        });
  }

  /// 构建主客队切换 Tab 栏。
  /// 使用 [controller.state.teamsNames] 作为 Tab 文案，[NewAnalyzeTabBar] 的宽高由 [BattleArrayState] 的 footballTab 相关常量控制。
  Widget _buildTab(BattleArrayController controller) {
    List<String> _tabs = controller.state.teamsNames;
    return NewAnalyzeTabBar(
      _tabs,
      controller.state.tabController,
      widgetWidth: ScreenUtil().screenWidth * BattleArrayState.footballTabWidthRatio,
      widgetHeight: BattleArrayState.footballTabHeight.w,
    );
  }

  /// 构建当前 Tab 下的滚动内容：头部 [AnalyzeBattleArrayHead] + [buildArrayCardContent] 返回的多个 Sliver（首发标题、首发列表、替补标题、分隔线、替补网格/伤停标题、伤停列表）。
  Widget buildContent(BattleArrayController controller) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: AnalyzeBattleArrayHead(controller: controller),
        ),
        // 这里 buildArrayCardContent 需要返回 Sliver 组件
        ...buildArrayCardContent(controller),
      ],
    );
  }

  /// 返回当前 Tab 下的 Sliver 列表：首发标题、[buildTeamLineupList]、替补标题、分隔线、替补网格（无数据时 [TextNoData]）、伤停标题、伤停列表（无数据时 [NoData]）。
  /// 替补网格与伤停列表使用 [BattleArrayState] 的 grid 常量；伤停项 [showNumber] 为 false。
  List<Widget> buildArrayCardContent(BattleArrayController controller) {
    return [
      SliverToBoxAdapter(
        child: FootballBattleArrayListItemHead(
          title: "${LocaleKeys.analysis_football_matches_starting_lineup.tr} ${controller.state.analyzeArrayPersonEntity?.homeFormation ?? ""}",
        ),
      ),
      buildTeamLineupList(controller),
      SliverToBoxAdapter(
        child: FootballBattleArrayListItemHead(
          title: LocaleKeys.analysis_bench_lineup.tr,
        ),
      ),
      SliverToBoxAdapter(child: AnalyzeDivider()),
      // 替补阵容内容
      if (controller.isBodyDownEmpty())
        SliverToBoxAdapter(child: TextNoData())
      else
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: BattleArrayState.footballSubstituteGridHorizontalPadding.w,
          ).copyWith(
            bottom: BattleArrayState.footballSubstituteGridBottomPadding.w,
          ),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: BattleArrayState.footballGridCrossAxisCount,
              mainAxisSpacing: BattleArrayState.footballGridMainAxisSpacing.w,
              crossAxisSpacing: BattleArrayState.footballGridCrossAxisSpacing.w,
              childAspectRatio: BattleArrayState.footballGridChildAspectRatio,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return AnalyzeChildItem(
                  controller: controller,
                  controller.getBodyDownData()?[index] ?? Up(),
                );
              },
              childCount: controller.getBodyDownData()?.length ?? 0,
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: FootballBattleArrayListItemHead(
            title: "${LocaleKeys.analysis_football_matches_Injury_situation.tr} ",
          ),
        ),
        // 伤停列表
      controller.getLayoffData()?.isNotEmpty==true?buildInjuryAndSuspensionList(controller):
      SliverToBoxAdapter(
        child: NoData(top:0),
      )
      ,
    ];
  }

  /// 构建首发阵容 Sliver：无数据时返回 [TextNoData]；否则 [SliverPadding] + [SliverGrid] 3 列，子项为 [AnalyzeChildItem]，数据来自 [controller.getBodyUpData]。
  Widget buildTeamLineupList(BattleArrayController controller) {
    if (controller.isBodyUpEmpty()) {
      return SliverToBoxAdapter(child: TextNoData());
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8.w,
          crossAxisSpacing: 8.w,
          childAspectRatio: 116 / 106,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return AnalyzeChildItem(
              controller.getBodyUpData()?[index] ?? Up(),
              controller: controller,
            );
          },
          childCount: controller.getBodyUpData()?.length ?? 0,
        ),
      ),
    );
  }

  /// 构建伤停名单 Sliver：[SliverPadding] + [SliverGrid]，子项为 [AnalyzeChildItem]（[showNumber] 为 false），数据来自 [controller.getLayoffData]。
  Widget buildInjuryAndSuspensionList(BattleArrayController controller) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: BattleArrayState.footballStartingGridHorizontalPadding.w,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: BattleArrayState.footballGridCrossAxisCount,
          mainAxisSpacing: BattleArrayState.footballGridMainAxisSpacing.w,
          crossAxisSpacing: BattleArrayState.footballGridCrossAxisSpacing.w,
          childAspectRatio: BattleArrayState.footballGridChildAspectRatio,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return AnalyzeChildItem(
              controller.getLayoffData()?[index] ?? Up(),
              controller: controller,
              showNumber: false,
            );
          },
          childCount: controller.getLayoffData()?.length ?? 0,
        ),
      ),
    );
  }
}
