/// 赔率列表视图：基于当前赛事状态决定展示玩法集合与赔率容器，
/// 并在不符合条件或玩法阶段码无效时触发赛事切换。

import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/tab/bet_mode_tab_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/sport.dart';
import 'package:flutter_ty_app/app/widgets/loading.dart';


import '../../../../generated/locales.g.dart';
import '../../../widgets/empty/no_data.dart';
import '../../login/login_head_import.dart';
import '../controllers/match_detail_controller.dart';
import '../extension/detail_api_service.dart';
import '../widgets/container/odds_info_container.dart';

/**
 * 赔率列表组件
 *
 * 核心功能：
 * 1. 根据赛事状态动态展示对应的赔率内容
 * 2. 监听数据仓库中的赛事数据变化，实时更新UI
 * 3. 当赛事状态不可投注或玩法阶段码无效时，自动触发赛事切换
 * 4. 区分可投注状态（未开始/进行中/即将开赛）和其他状态，展示不同UI
 */
class OddsListView extends StatelessWidget {
  const OddsListView({super.key, required this.tag});

  /// 控制器标识标签，用于区分不同页面的控制器实例
  final String tag;

  @override
  Widget build(BuildContext context) {
    // 1. 控制器存在性检查
    if (!Get.isRegistered<MatchDetailController>(tag: tag)) {
      return const Loading();
    }

    // 2. 获取控制器和当前赛事数据
    final MatchDetailController controller =
        Get.find<MatchDetailController>(tag: tag);
    final MatchEntity? match = controller.detailState.match;

    // 3. 空数据状态处理
    if (match == null) {
      return NoData(
        content: LocaleKeys.analysis_football_matches_no_data.tr,
        top: 30.h,
      );
    }

    // 4. 使用GetBuilder监听数据仓库中该赛事的实时数据
    return GetBuilder<DataStoreController>(
      // 构建唯一的监听ID：基于赛事ID生成，确保只监听当前赛事的数据变化
      id: DataStoreController.to.getMatchId(match.mid),
      builder: (dataStoreController) {
        // 4.1 优先使用数据仓库中的最新赛事信息（可能已经更新）
        final MatchEntity matchEntity =
            dataStoreController.getMatchById(match.mid) ?? match;

        // 4.2 检查赛事状态是否有效，无效则触发赛事切换
        _handleInvalidMatchStatus(controller, matchEntity);

        // 4.3 根据赛事状态决定展示内容
        return _buildContentByMatchStatus(controller, matchEntity);
      },
    );
  }

  /**
   * 处理无效赛事状态：当玩法阶段无效或赛事状态不在允许范围内时，触发赛事切换
   *
   * 允许的赛事状态码：
   * - 0: 未开始
   * - 1: 滚球阶段（进行中）
   * - 2: 暂停
   * - 7: 延迟
   * - 10: 中断
   * - 110: 即将开赛
   *
   * @param controller 赛事详情控制器
   * @param matchEntity 当前赛事实体
   */
  void _handleInvalidMatchStatus(
      MatchDetailController controller, MatchEntity matchEntity) {
    // 玩法阶段码（mmp）和赛事状态码（ms）
    final String mmp = matchEntity.mmp;
    final int ms = matchEntity.ms;

    // 定义可接受的赛事状态集合（这些状态下赛事仍然存在于列表中）
    final acceptedMatchStates = [
      SportData.sportMs_0, // 未开始
      SportData.sportMs_1, // 进行中
      SportData.sportMs_2, // 暂停
      SportData.sportMs_7, // 延迟
      SportData.sportMs_10, // 中断
      SportData.sportMs_110, // 即将开赛
    ];

    // 判断条件：玩法阶段无效（mmp=999）或赛事状态不在可接受集合中
    final bool isInvalid = mmp == "999" || !acceptedMatchStates.contains(ms);

    if (isInvalid) {
      // 使用addPostFrameCallback确保在当前帧构建完成后执行，
      // 避免在构建过程中直接修改状态（违反Flutter构建生命周期）
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.eventSwitch();
      });
    }
  }

  /**
   * 根据赛事状态构建对应的UI内容
   *
   * 可投注状态：展示玩法标签和赔率容器
   * - 未开始 (0)
   * - 进行中 (1)
   * - 即将开赛 (110)
   *
   * 其他状态：展示空数据占位
   *
   * @param controller 赛事详情控制器
   * @param matchEntity 当前赛事实体
   * @return 对应的UI组件
   */
  Widget _buildContentByMatchStatus(
      MatchDetailController controller, MatchEntity matchEntity) {
    // 定义可投注的赛事状态集合
    final bettableMatchStates = [
      SportData.sportMs_0, // 未开始
      SportData.sportMs_1, // 进行中
      SportData.sportMs_110, // 即将开赛
    ];

    if (bettableMatchStates.contains(matchEntity.ms)) {
      // 可投注状态：显示玩法标签和赔率容器
      return Column(
        children: [
          // 玩法集标签页（如：全场、上半场等）
          BetModeTab(
            tag: tag,
          ),
          // 赔率内容容器（展开填充剩余空间）
          Expanded(
            child: OddsInfoContainer(
              tag: tag,
            ),
          ),
        ],
      );
    } else {
      // 不可投注状态：显示空数据占位
      return NoData(
        content: LocaleKeys.analysis_football_matches_no_data.tr,
        top: 30.h,
      );
    }
  }
}
