
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';



class TotalAmountBetsView extends StatelessWidget {
  const TotalAmountBetsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _single(
            '总投注单数',
            '16',
          ),
          _div(),
          _single(
            '总子单数',
            '8',
          ),
          _div(),
          _single(
            '总投注额',
            '50.00',
          ),
          _div(),
          _single(
            '总可赢额',
            '50.00',
          ),
        ],
      ),
    );
  }

  Widget _single(String title, String number) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7981A3),
              height: 1,
              fontSize: 10.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ).marginZero.marginOnly(
                bottom: 4.h,
              ),
          Text(
            number,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF303442),
              fontSize: 14.sp,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }

  Widget _div() {
    return Container(
      width: 1.w,
      height: 27.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Colors.white.withValues(alpha:
                0.07999999821186066,
              )
            : const Color(
                0xFFE4E6ED,
              ),
      ),
    );
  }
}
