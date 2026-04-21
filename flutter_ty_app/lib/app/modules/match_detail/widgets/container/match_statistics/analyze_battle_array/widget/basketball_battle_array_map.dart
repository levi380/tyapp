
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/analyze_battle_position_item.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/basketball_battle_array_utils.dart';

import '../../../../../../../services/models/res/analyze_array_person_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/battle_array_controller.dart';

import '../../../../../../login/login_head_import.dart';
/// 篮球阵容图组件
/// 用于展示篮球场上的球员位置分布图
class BasketballBattleArrayMap extends StatelessWidget {
  /// 控制器
  final BattleArrayController controller;

  const BasketballBattleArrayMap({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 如果没有数据，显示默认图片
    if ((controller.state.basketball_data?.length ?? 0) == 0) {
      return _buildEmptyMap();
    }

    // 对球员数据进行分组
    final groupedData = BasketballBattleArrayUtils.groupPlayersByPosition(
        controller.state.basketball_data);

    return _buildMapWithPlayers(groupedData);
  }

  /// 构建空阵容图（无数据时显示）
  Widget _buildEmptyMap() {
    return Container(
      width: controller.state.bgImgWidth,
      height: controller.state.bgImgHeight,
      child: ImageView(
        "assets/images/home.png",
        boxFit: BoxFit.fill,
        width: controller.state.bgImgWidth,
        height: controller.state.bgImgHeight,
      ),
    );
  }

  /// 构建带球员的阵容图
  Widget _buildMapWithPlayers(Map<String, List<Up>> groupedData) {
    final first = groupedData['first'] ?? [];
    final second = groupedData['second'] ?? [];
    final three = groupedData['three'] ?? [];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      width: controller.state.bgImgWidth,
      height: controller.state.bgImgHeight,
      child: Stack(
        children: [
          // 背景图片
          _buildBackgroundImage(),
          // 球员位置分布
          _buildPlayerPositions(first, second, three),
        ],
      ),
    );
  }

  /// 构建背景图片
  Widget _buildBackgroundImage() {
    return Container(
      width: controller.state.bgImgWidth,
      height: controller.state.bgImgHeight,
      child: ImageView(
        controller.state.curMainTab == 0
            ? "assets/images/home.png"
            : "assets/images/away.png",
        boxFit: BoxFit.fill,
        width: controller.state.bgImgWidth,
        height: controller.state.bgImgHeight,
      ),
    );
  }

  /// 构建球员位置分布
  Widget _buildPlayerPositions(
      List<Up> first, List<Up> second, List<Up> three) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // 第一行球员
        _buildPlayerRow(first),
        // 第二行球员
        _buildPlayerRow(second, isSecondRow: true),
        // 第三行球员
        _buildPlayerRow(three, isThirdRow: true),
      ],
    );
  }

  /// 构建球员行
  Widget _buildPlayerRow(List<Up> players,
      {bool isSecondRow = false, bool isThirdRow = false}) {
    if (isThirdRow) {
      // 第三行需要特殊处理，添加左右边距
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 100.w),
        child: Row(
          mainAxisAlignment: players.length <= 1
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          children: players.map((e) => AnalyzeBattlePositionItem(e)).toList(),
        ),
      );
    }

    // 第一行和第二行
    return Row(
      mainAxisAlignment: isSecondRow && players.length <= 1
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceBetween,
      children: players.map((e) => AnalyzeBattlePositionItem(e)).toList(),
    );
  }
}

