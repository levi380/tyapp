
import 'package:flutter_ty_app/app/extension/string_extension.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_card_content.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_card_header.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_card_model.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_card_overlays.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_dialog_common_decoration.dart';

/// 投注详情对话框中的投注卡片组件
///
/// 用于在购物车详情弹窗中展示单个投注项。
/// 包含头部（队伍、赔率）、内容（比赛详情）、以及各种状态覆盖层（删除、禁用、赔率变化）。
class BettingCardDetailDialogItemCard extends StatelessWidget {
  /// 是否显示删除按钮
  final bool showDelete;

  /// 是否禁用（不支持串关）
  final bool disable;

  /// 赔率是否变更
  final bool ratioChanged;

  /// 投注卡片数据模型
  /// 若未提供，则使用 mock 数据
  final BettingCardModel? model;

  /// 删除回调
  final VoidCallback? onDelete;

  /// 构造函数
  const BettingCardDetailDialogItemCard({
    Key? key,
    this.showDelete = false,
    this.disable = false,
    this.ratioChanged = false,
    this.model,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取数据模型
    final cardModel = model ?? BettingCardModel.mock();

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.w),
      child: Stack(
        children: [
          // 卡片背景及主要内容
          BettingDialogCommonDecoration(
            padding: EdgeInsets.all(12.w),
            color: disable ? '#F8F9FA'.hexColor : null,
            child: Column(
              children: [
                // 头部区域：队伍名 + 赔率
                BettingCardHeader(
                  model: cardModel,
                  ratioChanged: ratioChanged,
                ),
                SizedBox(height: 6.w),
                // 内容区域：比赛信息
                BettingCardContent(
                  model: cardModel,
                ),
              ],
            ),
          ),
          
          // 删除按钮
          if (showDelete) 
            BettingCardDeleteButton(onTap: onDelete),
          
          // 禁用状态提示
          if (disable) 
            const BettingCardDisableOverlay(),
          
          // 赔率变更提示
          if (ratioChanged) 
            const BettingCardRatioChangedOverlay(),
        ],
      ),
    );
  }
}
