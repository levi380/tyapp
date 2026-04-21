import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_card_model.dart';

/// 投注卡片头部组件
/// 展示队伍名称、赔率及变化指示
class BettingCardHeader extends StatelessWidget {
  /// 数据模型
  final BettingCardModel model;

  /// 赔率是否变更
  final bool ratioChanged;

  const BettingCardHeader({
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
        if (ratioChanged) _buildChangeIcon(),
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

  /// 构建赔率符号
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
  Widget _buildChangeIcon() {
    return Icon(
      Icons.arrow_drop_up,
      color: '#F53F3F'.hexColor,
      size: 20.w,
    );
  }
}
