import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分 】】】
    【【【 AUTO_PARAGRAPH_TITLE 数据 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 背景卡片
    】】】
 *
 */
class BoxShadowContainer extends StatelessWidget {
  final Widget? child;
  final Color? background;
  final Color? color;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  BoxShadowContainer(
      {super.key,
      this.color,
      this.constraints,
      this.alignment,
      this.background,
      this.width,
      this.radius,
      this.margin,
      this.child,
      this.height,
      this.padding});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.centerLeft,
      width: width ?? 1.sw,
      height: height,
      constraints: constraints,
      margin: margin ?? EdgeInsets.symmetric(horizontal: 0.w),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: color ?? Get.theme.tabPanelBackgroundColor,
        boxShadow: [
          // 阴影
          BoxShadow(
              color: background ?? Color.fromRGBO(0, 0, 0, 0.04),
              blurRadius: 8,
              offset: Offset(0, 4.w),
              spreadRadius: 0,
              blurStyle: BlurStyle.normal),
        ],
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
      ),
      child: child,
    );
  }
}
