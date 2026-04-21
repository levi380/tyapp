
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 大小球模拟训练 视图页面 头部组件 SimulationTitleWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 大小球模拟训练 视图页面 头部组件 SimulationTitleWidget
    - SimulationTitleWidget
    ```
    ///头部
    SimulationTitleWidget(
      isDark: context.isDarkMode,
      title: LocaleKeys.app_h5_handicap_tutorial_answer_question.tr,
    )
    ```
    】】】
 *
 */

class SimulationTitleWidget extends StatelessWidget {
  const SimulationTitleWidget({
    super.key,
    required this.isDark,
    required this.title,
  });

  final bool isDark;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withValues(alpha:0.5),
              width: 0.5,
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 14.w, right: 14.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 0,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20.w,
                      color: context.isDarkMode
                          ? Colors.white
                          : const Color(0xFF303442),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white
                          : const Color(0xFF303442),
                      fontSize: 16.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: SizedBox(
                  width: 25.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
