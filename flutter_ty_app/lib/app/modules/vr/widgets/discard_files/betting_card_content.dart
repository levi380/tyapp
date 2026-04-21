import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_card_model.dart';

/// 投注卡片内容详情组件
/// 展示比赛信息、玩法、盘口等详细内容
class BettingCardContent extends StatelessWidget {
  /// 数据模型
  final BettingCardModel model;

  const BettingCardContent({
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
              _buildMatchInfo(),
              _buildLeagueInfo(),
            ],
          ),
        ),
        _buildLeftIndicator(),
      ],
    );
  }

  /// 构建投注玩法信息
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

  /// 构建比赛对阵信息
  Widget _buildMatchInfo() {
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

  /// 构建联赛信息
  Widget _buildLeagueInfo() {
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

  /// 构建左侧指示条
  Widget _buildLeftIndicator() {
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
