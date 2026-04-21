import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';




///切换按钮，全部和历史
class SwitchButtonShort extends StatelessWidget {
  const SwitchButtonShort(
      {Key? key,
      required this.onChild,
      required this.offChild,
      required this.onChanged,
      this.hasIcon = false,
      required this.value,
      this.enable = true})
      : super(key: key);
  final Widget onChild;
  final Widget offChild;
  final bool hasIcon;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    double width = (Get.width - ZrState.space32) * 2 / 8;

    /// 实现一个切换按钮
    return Container(
      width: width,
      decoration: context.isDarkMode
          ? ShapeDecoration(
              color: ZrState.cardBgDarkAlpha04,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ZrState.shortSwitchRadius),
              ),
            )
          : BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    ZrState.switchBgImage,
                  ),
                ),
                fit: BoxFit.fill,
              ),
            ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              if (value || !enable) return;
              onChanged(true);
            },
            child: DefaultTextStyle(
              style: value && enable
                  ? TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      color: context.isDarkMode
                          ? ZrState.shortSwitchTextSelDark
                          : ZrState.shortSwitchTextSelLight,
                    )
                  : TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      color: context.isDarkMode
                          ? ZrState.shortSwitchTextUnselDark
                          : ZrState.shortSwitchTextUnselLight,
                    ),
              child: Container(
                margin: const EdgeInsets.all(ZrState.shortSwitchPadding),
                height: ZrState.shortSwitchHeight,
                alignment: Alignment.center,
                decoration: (value && context.isDarkMode && enable)
                    ? ShapeDecoration(
                        gradient: LinearGradient(
                          begin: const Alignment(0.00, -1.00),
                          end: const Alignment(0, 1),
                          colors: ZrState.shortSwitchGradientDark,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(ZrState.shortSwitchRadius),
                        ),
                      )
                    : value && enable
                        ? ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: ZrState.shortSwitchGradientLight,
                            ),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius:
                                  BorderRadius.circular(ZrState.shortSwitchRadius),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: ZrState.shortSwitchShadowColor,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          )
                        : null,
                width: width * 0.5 - 4,
                child: Container(
                  margin: const EdgeInsets.all(ZrState.shortSwitchPadding),
                  child: hasIcon
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            onChild,
                            ImageView(
                                value && enable
                                    ? ZrState.switchIconSelected
                                    : context.isDarkMode
                                        ? ZrState.switchIconNormalDark
                                        : ZrState.switchIconNormalLight,
                                width: 16.w)
                          ],
                        )
                      : onChild,
                ),
              ),
            ),
          ),
          _getView(context, width)
        ],
      ),
    );
  }

  Widget _getView(BuildContext context, double width) {
    return InkWell(
      onTap: () {
        if (!value || !enable) return;
        onChanged(false);
      },
      child: DefaultTextStyle(
        style: !value && enable
            ? TextStyle(
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
                color: context.isDarkMode
                    ? ZrState.shortSwitchTextSelDark
                    : ZrState.shortSwitchTextSelLight,
              )
            : TextStyle(
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
                color: context.isDarkMode
                    ? ZrState.shortSwitchTextUnselDark
                    : ZrState.shortSwitchTextUnselLight,
              ),
        child: Container(
          margin: const EdgeInsets.all(ZrState.shortSwitchPadding),
          alignment: Alignment.center,
          decoration: (!value && context.isDarkMode && enable)
              ? ShapeDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, -1.00),
                    end: const Alignment(0, 1),
                    colors: ZrState.shortSwitchGradientDark,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ZrState.shortSwitchRadius),
                  ),
                )
              : !value && enable
                  ? ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: ZrState.shortSwitchGradientLight,
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.white),
                        borderRadius:
                            BorderRadius.circular(ZrState.shortSwitchRadius),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: ZrState.shortSwitchShadowColor,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        )
                      ],
                    )
                  : null,
          height: ZrState.shortSwitchHeight,
          width: width * 0.5 - 4,
          child: hasIcon
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: width * 0.5 - 4 - 20.w, minWidth: 5),
                      child: offChild,
                    ),
                    ImageView(
                        !value && enable
                            ? ZrState.switchIconSelected
                            : context.isDarkMode
                                ? ZrState.switchIconNormalDark
                                : ZrState.switchIconNormalLight,
                        width: 16.w)
                  ],
                )
              : offChild,
        ),
      ),
    );
  }
}
