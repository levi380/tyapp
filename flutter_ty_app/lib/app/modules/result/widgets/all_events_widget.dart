import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../utils/change_skin_tone_color_util.dart';

import '../../../widgets/image_view.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果 列表全部赛事 组件 AllEventsWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果 列表全部赛事 组件 AllEventsWidget
    - AllEventsWidget
    ```
    AllEventsWidget(
      isDark: context.isDarkMode,
      onExpandAll: () => controller.onExpandAll(),
      isExpandAll: controller.isExpandAll,
    )
    ```
    】】】
 *
 */

class AllEventsWidget extends StatelessWidget {
  const AllEventsWidget({
    super.key,
    required this.isDark,
    this.onExpandAll,
    required this.isExpandAll,
  });

  final bool isDark;
  final VoidCallback? onExpandAll;
  final bool isExpandAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: context.isDarkMode ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(colorStyle_1: Color(0xFF26282D) ,colorStyle_2: Color(0xFF23292D),colorStyle_3: Color(0xFF26242A)) : Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFFEAE2B).withValues(alpha:.8),
            width: 2.0.h,
          ),
        ),
      ),
      child: InkWell(
        onTap: onExpandAll,
        child: Container(
          margin: EdgeInsets.only(left: 14.w, right: 14.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageView(
                    'assets/images/icon/icon_date.png',
                    width: 18.w,
                    height: 18.w,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    LocaleKeys.filter_all_leagues.tr,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white
                          : const Color(0xFF303442),
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 30.w,
                height: 20.w,
                child: Transform.rotate(
                  angle: isExpandAll ? 0 : -pi / 2,
                  child: ImageView(
                    context.isDarkMode
                        ? 'assets/images/icon/allEvents_dark.png'
                        : 'assets/images/icon/allEvents_light.png',
                    width: 30.w,
                    height: 20.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
