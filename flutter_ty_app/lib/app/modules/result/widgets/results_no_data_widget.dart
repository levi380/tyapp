import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';


import '../../../widgets/image_view.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 暂无数据组件 组件   ResultsNoDataWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 暂无数据组件 组件   ResultsNoDataWidget
    - ResultsNoDataWidget
    ```
    ResultsNoDataWidget()
    ```
    】】】
 *
 */

class ResultsNoDataWidget extends StatelessWidget {
  const ResultsNoDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 100.h,
      ),
      child: Column(
        children: [
          ImageView(
            'assets/images/icon/def_common.png',
            width: 240.w,
            height: 240.h,
          ),
          Container(
            width: 8.w,
          ),
          Text(
            LocaleKeys.common_no_data.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF7981A3),
              fontSize: 16.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
