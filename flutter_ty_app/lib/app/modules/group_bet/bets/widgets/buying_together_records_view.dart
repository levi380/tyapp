import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'buying_together_records_child_view.dart';
import 'dividing_line_view.dart';
import 'extend_view.dart';

class BuyingTogetherRecordsView extends StatelessWidget {
  BuyingTogetherRecordsView({
    Key? key,
  }) : super(key: key);
  final RxBool preSettleExpand = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            ///提前兑现详情数据
            if (preSettleExpand.value)
              Column(children: [
                ///分割线
                const DividingLineView(),

                ///提前兑现列表详情数据
                ...List<BuyingTogetherRecordsChildView>.generate(5, (index) {
                  return BuyingTogetherRecordsChildView();
                }).toList(),
              ]),

            ///分割线
            const DividingLineView(),
            ExtendView(
              preSettleExpand: preSettleExpand.value,
              buyingTogetherRecordsView: this,
            ),
          ],
        ),
      ),
    );
  }
}
