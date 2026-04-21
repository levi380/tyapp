import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';

///切换按钮，‘现场','荷官','路纸','极简’
class SwitchButtonLong extends StatelessWidget {
  SwitchButtonLong(
      {Key? key,
      required this.data,
      required this.onChanged,
      this.hasIcon = false,
      required this.value,
      this.enable = true,
      this.width})
      : super(key: key);
  final bool hasIcon;
  final int value;
  final ValueChanged<int> onChanged;
  final bool enable;
  List<String> data = [
    LocaleKeys.zr_cp_settings_Menu_zr_on_site.tr,
    LocaleKeys.zr_cp_settings_Menu_zr_dealer.tr,
    LocaleKeys.zr_cp_settings_Menu_zr_road_paper.tr,
    LocaleKeys.zr_cp_settings_Menu_zr_minimalist.tr,
  ];
  double? width;

  @override
  Widget build(BuildContext context) {
    width ??= (Get.width - ZrState.space32) * 4 / 8;

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
                    ZrState.switchBgImageLong,
                  ),
                ),
                fit: BoxFit.fill,
              ),
            ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: generateChild(context, width),
      ),
    );
  }

  ///实现按钮样式，选中和未选中，‘现场','荷官','路纸','极简’
  List<Widget> generateChild(BuildContext context, width) {
    List<Widget> children = [];
    for (int i = 0; i < data.length; i++) {
      var title = data[i];
      var child = InkWell(
        onTap: () {
          if (!enable) return;
          onChanged(i);
        },
        child: DefaultTextStyle(
          style: value == i && enable
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
            decoration: (value == i && context.isDarkMode && enable)
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
                : value == i && enable
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
            width: width / data.length - 4,
            child: Container(
              margin: const EdgeInsets.all(ZrState.shortSwitchPadding),
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, height: 1.0),
              ),
            ),
          ),
        ),
      );
      children.add(child);
    }
    return children;
  }
}
