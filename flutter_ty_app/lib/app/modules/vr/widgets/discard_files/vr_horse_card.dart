
import 'package:flutter_ty_app/app/extension/string_extension.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_card_content.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_card_header.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_card_model.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_card_overlays.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_view_common_decoration.dart';

/// VR赛马视图投注项卡片组件
/// 显示单个投注项的详细信息，包括：
/// - 头部（队伍名称、赔率）
/// - 内容（比赛信息、盘口）
/// - 覆盖层（删除按钮、禁用提示、赔率变更提示）
class VrHorseCard extends StatelessWidget {
  /// 是否显示删除按钮
  final bool showDelete;

  /// 是否禁用（不支持串关投注）
  final bool disable;

  /// 赔率是否已变更
  final bool ratioChanged;

  /// 卡片数据模型
  /// 如果未提供，将使用 mock 数据
  final VrHorseCardModel? model;

  /// 删除按钮点击回调
  final VoidCallback? onDelete;

  /// 构造函数
  const VrHorseCard({
    Key? key,
    this.showDelete = false,
    this.disable = false,
    this.ratioChanged = false,
    this.model,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取或创建模型数据
    final cardModel = model ?? VrHorseCardModel.mock();

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.w),
      child: Stack(
        children: [
          // 卡片主体内容背景
          VrHorseViewCommonDecoration(
            padding: EdgeInsets.all(12.w),
            // 禁用状态下显示灰色背景
            color: disable ? '#F8F9FA'.hexColor : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 头部区域
                VrHorseCardHeader(
                  model: cardModel,
                  ratioChanged: ratioChanged,
                ),
                SizedBox(height: 6.w),
                // 内容区域
                VrHorseCardContent(
                  model: cardModel,
                ),
              ],
            ),
          ),
          
          // 各种覆盖层
          if (showDelete) 
            VrHorseCardDeleteButton(onTap: onDelete),
          
          if (disable) 
            const VrHorseCardDisableOverlay(),
          
          if (ratioChanged) 
            const VrHorseCardRatioChangedOverlay(),
        ],
      ),
    );
  }
}
