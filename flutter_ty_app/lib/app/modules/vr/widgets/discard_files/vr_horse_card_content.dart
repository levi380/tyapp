import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_card_model.dart';

/// VR 赛马卡片内容详情组件
/// 显示比赛名称、联赛名称及盘口信息
class VrHorseCardContent extends StatelessWidget {
  /// 数据模型
  final VrHorseCardModel model;

  const VrHorseCardContent({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBetInfo(),
              SizedBox(height: 6.w),
              _buildMatchName(),
              _buildLeagueName(),
            ],
          ),
        ),
        _buildVerticalLine(),
      ],
    );
  }

  /// 构建投注信息（盘口和类型）
  Widget _buildBetInfo() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '${model.betName} ',
            style: TextStyle(
              fontSize: 12.sp.scale,
              fontWeight: FontWeight.w500,
              color: '#7981A4'.hexColor,
            ),
          ),
          if (model.handicapType.isNotEmpty)
            TextSpan(
              text: '(${model.handicapType})',
              style: TextStyle(
                fontSize: 12.sp.scale,
                fontWeight: FontWeight.w500,
                color: '#179CFF'.hexColor,
              ),
            ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 构建比赛名称（对阵双方）
  Widget _buildMatchName() {
    return Text(
      model.matchName,
      style: TextStyle(
        fontSize: 12.sp.scale,
        fontWeight: FontWeight.w500,
        color: '#7981A4'.hexColor,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ).marginOnly(bottom: 2.w);
  }

  /// 构建联赛名称
  Widget _buildLeagueName() {
    return Text(
      model.leagueName,
      style: TextStyle(
        fontSize: 12.sp.scale,
        fontWeight: FontWeight.w500,
        color: '#7981A4'.hexColor,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 构建左侧垂直分割线
  Widget _buildVerticalLine() {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      child: Container(
        width: 2.w,
        decoration: BoxDecoration(
          color: '#179CFF'.hexColor,
          borderRadius: BorderRadius.circular(2.w),
        ),
      ),
    );
  }
}
