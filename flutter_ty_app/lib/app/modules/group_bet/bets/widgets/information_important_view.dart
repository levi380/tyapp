

import '../../../../../main.dart';
import '../../../login/login_head_import.dart';

class InformationImportantView extends StatelessWidget {
  const InformationImportantView({
    Key? key,
  }) : super(key: key);

 // final String information, outcome, scoreBenchmark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color( 0xff179CFF),
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.r,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isIPad ? 20.h : 15.h,
        horizontal: 10.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '早盘 大/小-上半场',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 3.h,
          ),
          Text(
            '大3.5 @2.16',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
