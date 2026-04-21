
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/battle_array_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../../login/login_head_import.dart';

/// 篮球阵容页面底部按钮组件
/// 用于展开/收起球员列表
class BasketballBattleArrayFooter extends StatelessWidget {
  /// 控制器
  final BattleArrayController controller;

  const BasketballBattleArrayFooter({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 12.w),
          _buildExpandButton(),
          SizedBox(height: 50.w),
        ],
      ),
    );
  }

  /// 构建展开/收起按钮
  Widget _buildExpandButton() {
    return InkWell(
      onTap: () {
        controller.setExpand();
      },
      child: Container(
        height: 23.w,
        constraints: BoxConstraints(maxWidth: 130.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
              color: Get.theme.secondTabPanelSelectedFontColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(23.w))),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
        child: controller.state.expand
            ? _buildCollapseButton()
            : _buildExpandButtonContent(),
      ),
    );
  }

  /// 构建收起按钮内容
  Widget _buildCollapseButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 2.w),
        Text(
          LocaleKeys.bet_pack_up.tr,
          style: TextStyle(
            color: Get.theme.secondTabPanelSelectedFontColor,
            fontSize: isIPad ? 16.sp : 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 2.w),
        Icon(
          Icons.arrow_drop_up_outlined,
          size: 20.w,
          color: Get.theme.secondTabPanelSelectedFontColor,
        )
      ],
    );
  }

  /// 构建展开按钮内容
  Widget _buildExpandButtonContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 2.w),
        Text(
          LocaleKeys.tips_expand.tr,
          style: TextStyle(
            color: Get.theme.secondTabPanelSelectedFontColor,
            fontSize: isIPad ? 16.sp : 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 2.w),
        Icon(
          Icons.arrow_drop_down,
          size: 20.w,
          color: Get.theme.secondTabPanelSelectedFontColor,
        ),
      ],
    );
  }
}

