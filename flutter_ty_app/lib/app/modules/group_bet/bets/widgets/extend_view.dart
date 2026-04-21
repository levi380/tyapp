import 'package:flutter_ty_app/app/modules/group_bet/bets/widgets/buying_together_records_view.dart';

import '../../../login/login_head_import.dart';

class ExtendView extends StatelessWidget {
  ExtendView({
    Key? key,
    required this.preSettleExpand,
    required this.buyingTogetherRecordsView,
  }) : super(key: key);
  final bool preSettleExpand;
  final BuyingTogetherRecordsView buyingTogetherRecordsView;

  @override
  Widget build(BuildContext context) {
    Color color = Color(0xFF303442);
    return InkWell(
      onTap: () => {
        buyingTogetherRecordsView.preSettleExpand.value =
            !buyingTogetherRecordsView.preSettleExpand.value,
      },
      child: Container(
        margin: EdgeInsets.only(top: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '查看合买记录',
              style: TextStyle(
                color: color,
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ).marginOnly(right: 2.w),
            ImageView(
              preSettleExpand
                  ? 'assets/images/bets/icon_up.gif'
                  : 'assets/images/bets/icon_down.gif',
              width: 18.w,
              height: 18.h,
            ),
          ],
        ),
      ),
    );
  }
}
