import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../../main.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton(
      {Key? key,
      required this.onChild,
      required this.offChild,
      required this.onChanged,
      this.hasIcon = false,
      required this.value,
      this.enable = true,
      this.fitHeight = false})
      : super(key: key);
  final Widget onChild;
  final Widget offChild;
  final bool hasIcon;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enable;
  final bool fitHeight;

  @override
  Widget build(BuildContext context) {
    double width = ((isIPad ? 700.w : 360.w) - 32.w) / 3;

    bool isCn =  Get.locale?.languageCode == 'zh' ? true : false;
    /// 实现一个切换按钮
    return Container(
      decoration: ShapeDecoration(
        color: context.isDarkMode
            ? Colors.white.withValues(alpha:0.03999999910593033)
            : const Color(0xfff7f8f9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (value || !enable) return;
              onChanged(true);
            },
            child: DefaultTextStyle(
              style: value && enable
                  ? TextStyle(
                      fontSize:isCn ?  12.sp.scale : 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      height: 1,
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha:0.699999988079071)
                          : const Color(0xff303442),
                    )
                  : TextStyle(
                      fontSize: isCn ?  12.sp.scale : 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      height: 1,
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha:0.30000001192092896)
                          : const Color(0xff7981A4),
                    ),
              child: Container(
                margin: const EdgeInsets.all(2),
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 2),
                decoration: (value && context.isDarkMode && enable)
                    ? ShapeDecoration(
                        gradient: LinearGradient(
                          begin: const Alignment(0.00, -1.00),
                          end: const Alignment(0, 1),
                          colors: [
                            Colors.white.withValues(alpha:0.05000000074505806),
                            Colors.white.withValues(alpha:0.10000000149011612),
                            Colors.white.withValues(alpha:0.029999999329447746)
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      )
                    : value && enable
                        ? ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [
                                Colors.white,
                                Color(0xFFEEF1F8),
                                Color(0xFFF8FDFF)
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x337981A3),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          )
                        : null,
                width: width * 0.5,
                height: 24.h,
                child: hasIcon
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Center(child: onChild)),
                          // Container(
                          //   constraints: BoxConstraints(
                          //       maxWidth: width * 0.5 - 4 - 20.w - 4,
                          //       minWidth: 5),
                          //   child: onChild,
                          // ),
                          ImageView(
                              value && enable
                                  ? 'assets/images/home/icon_switch_sel.png'
                                  : context.isDarkMode
                                      ? 'assets/images/home/icon_switch_nor_night.png'
                                      : "assets/images/home/icon_switch_nor2.png",
                              width: 16.w)
                        ],
                      )
                    : onChild,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (!value || !enable) return;
              onChanged(false);
            },
            child: DefaultTextStyle(
              style: !value && enable
                  ? TextStyle(
                      fontSize: 12,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha:0.699999988079071)
                          : const Color(0xff303442),
                    )
                  : TextStyle(
                      fontSize: isCn ?  12.sp.scale : 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha:0.30000001192092896)
                          : const Color(0xff7981A4),
                    ),
              child: Container(
                margin: const EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: (!value && context.isDarkMode && enable)
                    ? ShapeDecoration(
                        gradient: LinearGradient(
                          begin: const Alignment(0.00, -1.00),
                          end: const Alignment(0, 1),
                          colors: [
                            Colors.white.withValues(alpha:0.05000000074505806),
                            Colors.white.withValues(alpha:0.10000000149011612),
                            Colors.white.withValues(alpha:0.029999999329447746)
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      )
                    : !value && enable
                        ? ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [
                                Colors.white,
                                Color(0xFFEEF1F8),
                                Color(0xFFF8FDFF)
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x337981A3),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          )
                        : null,
                height: 24.h,
                width: width * 0.5,
                child: hasIcon
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Center(child: offChild)),
                          // Container(
                          //   constraints: BoxConstraints(
                          //       maxWidth: width * 0.5 - 4 - 20.w,
                          //       minWidth: 5.w),
                          //   child: offChild,
                          // ),
                          ImageView(
                              !value && enable
                                  ? 'assets/images/home/icon_switch_sel.png'
                                  : context.isDarkMode
                                      ? 'assets/images/home/icon_switch_nor_night.png'
                                      : "assets/images/home/icon_switch_nor2.png",
                              width: 16.w)
                        ],
                      )
                    : offChild,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
