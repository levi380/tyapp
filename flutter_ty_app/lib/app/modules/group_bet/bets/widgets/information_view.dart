
import '../../../../../main.dart';
import '../../../login/login_head_import.dart';

class InformationView extends StatelessWidget {
  const InformationView({
    Key? key,
    required this.information,
    required this.outcome,
    this.titleColorType = 0,
    this.InformationColorType = 0,
    this.isAmount = false,
  }) : super(key: key);
  final String information;
  final String outcome;
  /*
  titleColorType,InformationColorType
   0 ： 默认的黑色
   1 ： 灰色
   2 ： 蓝色
   3 ： 红色
   */
  final int titleColorType, InformationColorType;
  ///当是金额
  final bool isAmount;

  @override
  Widget build(BuildContext context) {
    List<Color> listColor = [
       Color(0xFF303442),
       Color(0xFFAFB3C8),
       Color(0xFF179CFF),
       Color(0xFFF53F3F)
    ];
    if (context.isDarkMode) {
      listColor[0] = Colors.white.withValues(alpha:0.8999999761581421);
      listColor[2] = const Color(0xFF127DCC);
    }
    return Container(

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              information,
              style: TextStyle(
                color: listColor[titleColorType],
                fontSize: isIPad?14.sp:12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            outcome,
            style: TextStyle(
              color: listColor[InformationColorType],
              fontSize: isIPad?14.sp:12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: isAmount ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
