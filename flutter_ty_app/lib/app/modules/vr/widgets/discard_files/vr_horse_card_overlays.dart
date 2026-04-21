import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/// VR 赛马卡片删除按钮
class VrHorseCardDeleteButton extends StatelessWidget {
  final VoidCallback? onTap;

  const VrHorseCardDeleteButton({
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

/// VR 赛马卡片禁用状态提示
class VrHorseCardDisableOverlay extends StatelessWidget {
  final String text;

  const VrHorseCardDisableOverlay({
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

/// VR 赛马卡片赔率变更提示
class VrHorseCardRatioChangedOverlay extends StatelessWidget {
  final String text;

  const VrHorseCardRatioChangedOverlay({
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
