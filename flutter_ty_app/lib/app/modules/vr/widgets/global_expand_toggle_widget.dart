import 'dart:math';

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

import '../../../utils/change_skin_tone_color_util.dart';
import '../vr_sport_state.dart';

///vr全部联赛 展开收起
class GlobalExpandToggleWidget extends StatefulWidget {
  const GlobalExpandToggleWidget({
    super.key,
    required this.iconSrc,
    required this.title,
    required this.isExpand,
    required this.borderColor,
    this.onExpandChanged,
  });

  final String iconSrc;
  final String title;
  final bool isExpand;
  final Color borderColor;
  final ValueChanged<bool>? onExpandChanged;

  factory GlobalExpandToggleWidget.all({
    Key? key,
    required bool isExpand,
    String? iconSrc,
    String? title,
    Color? borderColor,
    ValueChanged<bool>? onExpandChanged,
  }) {
    return GlobalExpandToggleWidget(
      iconSrc: iconSrc ?? VRSportState.iconAll,
      title: title ?? LocaleKeys.filter_all_leagues.tr,
      borderColor: borderColor ?? '#FEAE2B'.hexColor.withValues(alpha: 0.4),
      isExpand: isExpand,
      onExpandChanged: onExpandChanged,
    );
  }

  @override
  State<GlobalExpandToggleWidget> createState() =>
      _GlobalExpandToggleWidgetState();
}

class _GlobalExpandToggleWidgetState extends State<GlobalExpandToggleWidget> {
  late bool _isExpand;

  @override
  void initState() {
    super.initState();
    _isExpand = widget.isExpand;
  }

  @override
  void didUpdateWidget(covariant GlobalExpandToggleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpand != widget.isExpand) {
      _isExpand = widget.isExpand;
    }
  }

  void _toggle() {
    setState(() => _isExpand = !_isExpand);
    widget.onExpandChanged?.call(_isExpand);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return InkWell(
      onTap: _toggle,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.w),
        decoration: BoxDecoration(
          color: isDark
              ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
              : AppColor.colorWhite,
          border: Border(
            top: BorderSide(
              color: widget.borderColor,
              width: 2.w,
            ),
          ),
        ),
        child: Row(
          children: [
            ImageView(widget.iconSrc, width: 12.w, height: 12.w),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 12.sp.scale,
                  fontWeight: FontWeight.w400,
                  color: isDark ? AppColor.colorWhite : '#303442'.hexColor,
                ),
              ),
            ),

            /// 展开收起 动画
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) =>
                  FadeTransition(opacity: anim, child: child),
              child: _buildToggleItem(isDark, key: ValueKey(_isExpand)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem(bool isDark, {required Key key}) {
    return Container(
      key: key,
      height: 20.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: ShapeDecoration(
        color: isDark
            ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
            : const Color(0xFFF8F9FA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isExpand ? LocaleKeys.tips_close.tr : LocaleKeys.tips_expand.tr,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.4)
                  : const Color(0xFF949AB6),
              fontSize: 12.sp.scale,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 2),
          Transform.rotate(
            angle: _isExpand ? 0 : -pi / 2,
            child: ImageView(
              isDark ? VRSportState.tipsExpandDark : VRSportState.tipsExpandLight,
              width: 10.w,
              height: 10.w,
            ),
          ),
        ],
      ),
    );
  }
}
