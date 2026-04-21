
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../config/getx_navigation.dart';
import '../../../../utils/bus/bus.dart';
import '../../../../utils/bus/event_enum.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3a9df28f-c590-402c-a99e-edc66a224cb3-dj 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果电竞冠军联赛筛选】】】
    【【【 AUTO_PARAGRAPH_TITLE  电竞赛果冠军赛果 联赛筛选头部组件 DjVrTitleWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  电竞赛果冠军赛果 联赛筛选头部组件 DjVrTitleWidget
    - DjVrTitleWidget
    ```
    ///联赛头部
    DjVrTitleWidget(
      isDark: context.isDarkMode,
      focusNode:controller.focusNode,
      title: LocaleKeys.filter_match_select_title.tr,
      onTap: () => controller.onFinish(),
    )
    ```
    】】】
 *
 */
class DjVrTitleWidget extends StatelessWidget {
  const DjVrTitleWidget({
    super.key,
    required this.isDark,
    required this.title,
    required this.onTap,
    required this.focusNode,
  });

  final bool isDark;
  final String title;
  final VoidCallback? onTap;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 14.w,
        right: 14.w,
      ),
      height: 62.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              focusNode.unfocus();
              Get_TY.back();
              Bus.getInstance().emit(EventType.tyCloseDialog);
            },
            child: Text(
              LocaleKeys.common_cancel.tr,
              style: TextStyle(
                color: const Color(0xFF179CFF),
                fontSize: 17.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  context.isDarkMode ? Colors.white : const Color(0xFF303442),
              fontSize: 18.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              LocaleKeys.common_finish.tr,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: const Color(0xFF179CFF),
                fontSize: 17.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          )

        ],
      ),
    );
  }
}
