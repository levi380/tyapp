
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../widgets/action_box_view.dart';
import '../widgets/buying_together_records_view.dart';
import '../widgets/information_copy_view.dart';
import '../widgets/information_important_view.dart';
import '../widgets/information_line_view.dart';
import '../widgets/information_view.dart';
import '../widgets/title_view.dart';

class Item extends StatelessWidget {
  const Item({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(10),
      child: _information(),
    );
  }

  Widget _information() {
    return Column(
      children: [
        TitleView().marginOnly(bottom: 10.w),
        InformationImportantView().marginOnly(bottom: 10.w),
        InformationView(
          information: '合买序号：',
          outcome: '202501010001',
        ).marginOnly(bottom: 10.w),
        InformationCopyView(
          information: '合买单号：',
          outcome: '17892222215651203',
        ).marginOnly(bottom: 10.w),
        InformationView(
          information: '投注时间：',
          outcome: '2023-08-17 03:00 (欧洲盘)',
        ).marginOnly(bottom: 10.w),
        InformationLineView(
          information: '[足球]巴拉圭后备联赛预选赛SOE',
        ).marginOnly(bottom: 10.w),
        InformationView(
          information: '投注额：',
          outcome: '50.00元',
          isAmount: true,
        ).marginOnly(bottom: 10.w),
        InformationView(
          information: '可赢额：',
          outcome: '50.00元',
          titleColorType: 2,
          InformationColorType: 2,
          isAmount: true,
        ).marginOnly(bottom: 10.w),
        ActionBoxView().marginOnly(bottom: 6.w),
        BuyingTogetherRecordsView().marginOnly(bottom: 10.w),
      ],
    );
  }
}
