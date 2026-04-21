import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/// 投注对话框通用装饰组件
class BettingDialogCommonDecoration extends StatelessWidget {
  const BettingDialogCommonDecoration({
    super.key,
    this.borderRadius = 0,
    this.padding,
    this.height,
    required this.child,
    this.color,
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color ?? '#F3FAFF'.hexColor,
      ),
      child: child,
    );
  }
}
