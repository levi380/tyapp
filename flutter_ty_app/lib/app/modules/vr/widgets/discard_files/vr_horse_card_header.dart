import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_card_model.dart';

/// VR 赛马卡片头部组件
/// 显示队伍名称、赔率及赔率变化指示
class VrHorseCardHeader extends StatelessWidget {
  /// 数据模型
  final VrHorseCardModel model;

  /// 赔率是否变更
  final bool ratioChanged;

  const VrHorseCardHeader({
    Key? key,
    required this.model,
    this.ratioChanged = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTeamName(),
        _buildOddsSymbol(),
        SizedBox(width: 2.w),
        _buildOddsValue(),
        _buildOddsChangeIcon(),
      ],
    );
  }

  /// 构建队伍名称
  Widget _buildTeamName() {
    return Text(
      model.teamName.isNotEmpty ? model.teamName : '--',
      style: TextStyle(
        fontSize: 14.sp.scale,
        color: '#303442'.hexColor,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ).expanded();
  }

  /// 构建赔率符号 @
  Widget _buildOddsSymbol() {
    return Text(
      '@',
      style: TextStyle(
        fontSize: 14.sp.scale,
        color: ratioChanged ? '#F53F3F'.hexColor : '#303442'.hexColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// 构建赔率数值
  Widget _buildOddsValue() {
    return Text(
      model.odds.isNotEmpty ? model.odds : '0.00',
      style: TextStyle(
        fontSize: 22.sp.scale,
        color: ratioChanged ? '#F53F3F'.hexColor : '#303442'.hexColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  /// 构建赔率变化图标
  Widget _buildOddsChangeIcon() {
    if (!ratioChanged) return const SizedBox.shrink();

    // TODO: 根据上升还是下降来选择图标
    // 这里暂时使用简单的箭头图标
    return Icon(
      Icons.arrow_drop_up,
      color: '#F53F3F'.hexColor,
      size: 20.w,
    );
  }
}
