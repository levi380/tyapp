import 'package:flutter_ty_app/app/extension/num_extension.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../login/login_head_import.dart';
import '../../../models/play_info.dart';

class MoreSecondaryGameWidget extends StatefulWidget {
  final bool isMoreSelect;
  final GlobalKey menuItemKey;
  final PlayInfo playInfo;
  final bool isSelect;
  final GestureTapDownCallback? onTapDown;
  MoreSecondaryGameWidget(
      this.isMoreSelect, this.isSelect, this.menuItemKey, this.playInfo,
      {super.key, this.onTapDown});
  @override
  State<StatefulWidget> createState() {
    return MoreSecondaryGameWidgetState();
  }
}

class MoreSecondaryGameWidgetState extends State<MoreSecondaryGameWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        key: widget.menuItemKey,
        decoration: BoxDecoration(
          color: (widget.isSelect == false && widget.isMoreSelect == false)
              ? Colors.transparent
              : (context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.03999999910593033)
                  : Colors.white),
          borderRadius: BorderRadius.circular(4.r),
          border: (widget.isSelect == false && widget.isMoreSelect == false)
              ? Border.all(
                  color: Colors.transparent,
                  width: 1.w,
                )
              : (widget.isMoreSelect
                  ? Border.all(
                      color: const Color(0xff3AA6FC),
                      width: 1.w,
                    )
                  : Border.all(
                      color: Colors.transparent,
                      width: 1.w,
                    )),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        height: 28.w,
        child: InkWell(
          onTapDown: widget.onTapDown,
          child: Row(
            children: [
              if (widget.isMoreSelect == false)
                Icon(
                  Icons.add,
                  size: 8.w,
                  color: const Color(0xffC9CDDB),
                ),
              Text(
                widget.playInfo.title.isNotEmpty && widget.isMoreSelect
                    ? widget.playInfo.title
                    : LocaleKeys.app_more_play.tr,
                maxLines: 1,
                style: TextStyle(
                  overflow: TextOverflow.clip,
                  fontSize: 10.sp.scale,
                  fontWeight: FontWeight.w500,
                  color: widget.isMoreSelect
                      ? const Color(0xff3AA6FC)
                      : context.isDarkMode
                          ? Colors.white.withValues(alpha: 0.8999999761581421)
                          : const Color(0xff949AB6),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              if (widget.isMoreSelect)
                Icon(
                  Icons.keyboard_arrow_up,
                  size: 10.w,
                  color: const Color(0xff3AA6FC),
                ),
            ],
          ),
        ));
  }
}
