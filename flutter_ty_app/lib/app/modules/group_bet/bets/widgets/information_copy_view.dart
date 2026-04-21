
import '../../../../../generated/locales.g.dart';
import '../../../../../main.dart';
import '../../../login/login_head_import.dart';

class InformationCopyView extends StatelessWidget {
  const InformationCopyView({
    Key? key,
    required this.information,
    required this.outcome,
  }) : super(key: key);
  final String information, outcome;

  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xFF303442);

    if (context.isDarkMode) {
      color = Colors.white.withValues(alpha:0.8999999761581421);
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              information,
              style: TextStyle(
                color: color,
                fontSize: isIPad ? 14.sp : 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          InkWell(
            onTap: () => {
             // Clipboard.setData(
             //   ClipboardData(
             //     text: outcome,
             //   ),
             // ),
              ToastUtils.showGrayBackground(
                  "${LocaleKeys.bet_record_copy_suc.tr}！"),
            },
            child: Row(
              children: [
                Text(
                  outcome,
                  style: TextStyle(
                    color: color,
                    fontSize: isIPad ? 14.sp : 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ).paddingOnly(
                  right: 4.w,
                ),
                ImageView(
                  'assets/images/bets/icon_copy.png',
                  width: isIPad ? 18.w : 16.w,
                  height: isIPad ? 18.h : 16.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
