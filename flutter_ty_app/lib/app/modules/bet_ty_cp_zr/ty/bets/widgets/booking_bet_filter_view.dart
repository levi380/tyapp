import '../../../../../../generated/locales.g.dart';
import '../../../../../../main.dart';
import '../../../../../extension/color_extension.dart';
import '../../../../login/login_head_import.dart';

class BookingBetFilterView extends StatelessWidget {
  BookingBetFilterView({
    required this.selectType,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final int selectType;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.w,
      decoration: ShapeDecoration(
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.04)
                : Colors.white,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          _single(
            context,
            0,
            LocaleKeys.pre_record_booking.tr,
          ),
          _single(
            context,
            1,
            LocaleKeys.pre_record_expired.tr,
          )
        ],
      ),
    );
  }

  Widget _single(BuildContext context, int singleType, String title) {
    return Flexible(
      flex: 1,
      child: InkWell(
        onTap: () => {
          onChanged(singleType),
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 4.w,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.5.sp,
                        fontWeight: selectType == singleType
                            ? FontWeight.w600
                            : FontWeight.w400,
                        fontFamily: 'PingFang SC',
                        color: selectType == singleType
                            ? context.isDarkMode
                                ? Colors.white
                                    .withValues(alpha: 0.8999999761581421)
                                : const Color(0xFF303442)
                            : context.isDarkMode
                                ? Colors.white
                                    .withValues(alpha: 0.4000000059604645)
                                : const Color(0xFF7981A3),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Container(
                      width: 32.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2.r),
                            topRight: Radius.circular(2.r),
                          ),
                          color: selectType == singleType
                              ? isFootballBasketballTemplate
                                  ? HexColor(
                                      footballBasketballTemplateThemeColor)
                                  : Color(context.isDarkMode
                                      ? 0xFF127DCC
                                      : 0xFF179cff)
                              : Colors.transparent))
                  .marginOnly(bottom: 1.h)
            ],
          ),
        ),
      ),
    );
  }
}
