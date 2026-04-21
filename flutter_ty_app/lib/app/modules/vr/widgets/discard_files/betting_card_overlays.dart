import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/// 投注卡片删除按钮覆盖层
class BettingCardDeleteButton extends StatelessWidget {
  final VoidCallback? onTap;

  const BettingCardDeleteButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: onTap,
        child: ImageView(
          'assets/images/vr/icon_bottom_right_delete.png',
          width: 30.w,
          height: 30.w,
        ),
      ),
    );
  }
}

/// 投注卡片禁用状态覆盖层
class BettingCardDisableOverlay extends StatelessWidget {
  final String text;

  const BettingCardDisableOverlay({
    Key? key,
    this.text = '不支持串关投注',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 12.w,
      top: 0,
      bottom: 0,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp.scale,
            fontWeight: FontWeight.w500,
            color: '#F53F3F'.hexColor.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

/// 投注卡片赔率变更提示覆盖层
class BettingCardRatioChangedOverlay extends StatelessWidget {
  final String text;

  const BettingCardRatioChangedOverlay({
    Key? key,
    this.text = '赔率已更变',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 12.w,
      top: 0,
      bottom: 0,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp.scale,
            fontWeight: FontWeight.w500,
            color: '#F53F3F'.hexColor,
          ),
        ),
      ),
    );
  }
}
