import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/battle_array_controller.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../../../../../services/models/res/analyze_array_person_entity.dart';
import '../../../../../../login/login_head_import.dart';

/// 篮球球员列表项组件
/// 用于显示单个球员的详细信息
class BasketballBattleArrayPlayerItem extends StatelessWidget {
  /// 控制器
  final BattleArrayController controller;

  /// 球员数据
  final Up entity;

  /// 是否显示号码
  final bool showNumber;

  const BasketballBattleArrayPlayerItem({
    Key? key,
    required this.controller,
    required this.entity,
    this.showNumber = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
          border:
              Border.symmetric(vertical: BorderSide(color: Color(0xFFE4E6ED)))),
      height: 34.w,
      child: Row(
        children: [
          // 球员信息列（占4份）
          _buildPlayerInfoColumn(),
          // 分钟列（占1份）
          _buildDataColumn(entity.playTime ?? "-", flex: 1),
          // 篮球列（占1份）
          _buildDataColumn(entity.rebound ?? "-", flex: 1),
          // 助攻列（占1份）
          _buildDataColumn(entity.assist ?? "-", flex: 1),
          // 得分列（占1份）
          _buildDataColumn(entity.points ?? "-", flex: 1),
        ],
      ),
    );
  }

  /// 构建球员信息列
  Widget _buildPlayerInfoColumn() {
    return Expanded(
      flex: 4,
      child: Row(
        children: [
          // 球员号码
          if (showNumber) _buildPlayerNumber(),
          // 球员头像和名称
          _buildPlayerAvatarAndName(),
          // 球员位置
          _buildPlayerPosition(),
        ],
      ),
    );
  }

  /// 构建球员号码
  Widget _buildPlayerNumber() {
    return Expanded(
      flex: 1,
      child: Container(
        child: Text(
          " ${entity.shirtNumber ?? "-"} ",
          style: TextStyle(
              color: controller.state.tabController?.index == 0
                  ? Get.theme.secondTabPanelSelectedFontColor
                  : Color(0xFFF29041),
              fontSize: isIPad ? 15.sp : 11.sp,
              fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  /// 构建球员头像和名称
  Widget _buildPlayerAvatarAndName() {
    return Expanded(
      flex: 8,
      child: Row(
        children: [
          // 球员头像
          _buildPlayerAvatar(),
          SizedBox(width: 2.w),
          // 球员名称
          _buildPlayerName(),
          SizedBox(width: 12.w),
        ],
      ),
    );
  }

  /// 构建球员头像
  Widget _buildPlayerAvatar() {
    return Container(
      width: 28.w,
      height: 28.w,
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F6),
        borderRadius: BorderRadius.all(Radius.circular(28.w)),
      ),
      child: entity.thirdPlayerPicUrl?.isEmpty == true
          ? Icon(
              Icons.person,
              size: 28.w,
            )
          : ClipOval(
              child: Container(
                child: ImageView(
                  boxFit: BoxFit.fill,
                  (entity.thirdPlayerPicUrl ?? ""),
                  errorWidget: Icon(
                    Icons.person,
                    size: 28.w,
                  ),
                  width: 28.w,
                  height: 28.w,
                  cornerRadius: 32.w,
                ),
              ),
            ),
    );
  }

  /// 构建球员名称
  Widget _buildPlayerName() {
    return Container(
      constraints: BoxConstraints(maxWidth: 70.w),
      alignment: Alignment.center,
      child: Text(
        entity.thirdPlayerName ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Get.theme.tabPanelSelectedColor,
          fontSize: isIPad ? 15.sp : 11.sp,
        ),
      ),
    );
  }

  /// 构建球员位置
  Widget _buildPlayerPosition() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        entity.positionName ?? "",
        style: TextStyle(
            color: Color(0xFF7881A3), fontSize: isIPad ? 15.sp : 11.sp),
      ),
    );
  }

  /// 构建数据列
  Widget _buildDataColumn(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Container(
        child: Text(
          " $text ",
          style: TextStyle(
              color: Get.theme.tabPanelSelectedColor, fontSize: 12.sp),
        ),
      ),
    );
  }
}

