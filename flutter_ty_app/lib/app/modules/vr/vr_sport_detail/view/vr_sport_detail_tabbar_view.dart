import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info_container.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/tab/bet_mode_tab_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/view/vr_sport_history_data.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/view/vr_sport_history_dog.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/view/vr_sport_rank_disuse_page.dart';

import '../../../../utils/change_skin_tone_color_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-528b398c-8958-44e0-9713-fb7030115573-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE vr详情】】】
    【【【 AUTO_PARAGRAPH_TITLE vr详情-tabview内容组件】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - tabview内容组件
    - 包含历史战绩、投注、排行榜
    -根据tab显示分成3大类，tab显示如下

    | | 足球| 篮球| 赛狗类|
    | --- | --- | --- | --- |
    |  `menuId`|`1001`| `1004`| `1011`，`1002`，`1010`，`1009`|
    |`matchDetailList`  | `历史战绩`，`投注`，`排名` | 投注 |`投注`， `排名` |

    - 历史战绩

    ```
    SizedBox(
    height: MediaQuery.of(context).size.height,
    child: controller.state.topMenu?.menuId == '1001'
    ? sportHistoryDataView()
    : controller.state.topMenu?.menuId == '1004'
    ? const SizedBox()
    : sportHistoryDogView(),
    );
    ```

    - 投注
    -投注有BetModeTab()投注的头部，和OddsInfoContainer() 投注项组成

    ```
    Column(
    children: [
    BetModeTab(),
    OddsInfoContainer( refresh: true)
    ]);
    ```

    - 排行榜

    ```
    SizedBox(
    height: MediaQuery.of(context).size.height,
    child: const rankDisusePage(),
    )
    ```
    】】】
 *
 */
class VrSportDetailTabBarView extends StatelessWidget {
  const VrSportDetailTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VrSportDetailLogic>(
      init: VrSportDetailLogic(),
      builder: (controller) {
        return _buildContent(context, controller);
      },
    );
  }

  Widget _buildContent(BuildContext context, VrSportDetailLogic controller) {
    // 如果没有配置详情列表，显示默认的投注页面
    if (controller.state.matchDetailList.isEmpty) {
      final matchId = controller.state.match?.mid ?? '';
      return _buildBetView(controller, matchId);
    }

    final currentIndex = controller.state.matchTabController?.index ?? 0;
    final currentTitle = controller.state.matchDetailList[currentIndex];
    final matchId = controller.state.match?.mid ?? '';

    return _buildTabContent(context, controller, currentTitle, matchId);
  }

  /// 根据当前选中的tab标题构建对应内容
  Widget _buildTabContent(
    BuildContext context,
    VrSportDetailLogic controller,
    String title,
    String matchId,
  ) {
    // 使用本地化后的字符串进行比较
    final historicalResultsTr =
        LocaleKeys.virtual_sports_match_detail_historical_results.tr;
    final betTr = LocaleKeys.virtual_sports_match_detail_bet.tr;

    switch (title) {
      case _ when title == historicalResultsTr:
        return _buildHistoricalResultsView(context, controller);
      case _ when title == betTr:
        return _buildBetView(controller, matchId);
      default:
        return _buildRankingView();
    }
  }

  /// 构建历史战绩视图
  Widget _buildHistoricalResultsView(
    BuildContext context,
    VrSportDetailLogic controller,
  ) {
    final menuId = controller.state.topMenu?.menuId;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: _getHistoricalResultsWidget(menuId),
    );
  }

  /// 根据菜单ID获取对应的历史战绩组件
  Widget _getHistoricalResultsWidget(String? menuId) {
    switch (menuId) {
      case '1001': // 足球
        return sportHistoryDataView();
      case '1004': // 篮球
        return const SizedBox(); // 篮球不显示历史战绩
      default: // 赛狗类等其他运动
        return sportHistoryDogView();
    }
  }

  /// 构建投注视图
  Widget _buildBetView(
    VrSportDetailLogic controller,
    String matchId,
  ) {
    return Column(
      children: [
        BetModeTab(key: ValueKey("tab-$matchId"), tag: matchId),
        Expanded(
          child: Container(
            decoration: _getBetContainerDecoration(),
            child: OddsInfoContainer(
              key: ValueKey("oddsInfo-$matchId"),
              refresh: true,
              tag: matchId,
            ),
          ),
        ),
      ],
    );
  }

  /// 获取投注容器的装饰
  BoxDecoration _getBetContainerDecoration() {
    if (Get.isDarkMode) {
      return BoxDecoration(
        color: ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(),
      );
    } else {
      return const BoxDecoration(color: Colors.transparent);
    }
  }

  /// 构建排行榜视图
  Widget _buildRankingView() {
    return SizedBox(
      height: 1.sh,
      child: rankDisusePage(),
    );
  }
}
