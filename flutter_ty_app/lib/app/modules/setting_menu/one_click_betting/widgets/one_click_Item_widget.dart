import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';




/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-f8e965b2-b88c-4808-9861-fc1a918660f9-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 一键投注】】】
    【【【 AUTO_PARAGRAPH_TITLE 一键投注 列表开关组件 OneClickItemWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 一键投注 列表开关组件 OneClickItemWidget
    - OneClickItemWidget
    ```
    ///一键投注 列表开关组件
    OneClickItemWidget(
      isDark: context.isDarkMode,
      onTap: () => controller.onOneClickBetting(),
      title: LocaleKeys.bet_one_click_bet.tr,
      switchOn: switchOn,
    )
    ```
    】】】
 *
 */

class OneClickItemWidget extends StatelessWidget {
  const OneClickItemWidget({
    super.key,
    required this.isDark,
    required this.onTap,
    required this.title,
    required this.switchOn,
  });

  final bool isDark;
  final VoidCallback? onTap;
  final String title;
  final bool switchOn;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.w,
      ),
      height: 48.h,
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xFF272931) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withValues(alpha:0.5),
            width: 0.5,
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
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
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              switchOn == true
                  ? Expanded(
                      child: ImageView(
                        "assets/images/icon/one_click_pass1.png",
                        width: 36.w,
                        height: 18.h,
                      ),
                    )
                  : Expanded(
                      child: ImageView(
                        "assets/images/icon/one_click_pass.png",
                        width: 40.w,
                        height: 20.h,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
