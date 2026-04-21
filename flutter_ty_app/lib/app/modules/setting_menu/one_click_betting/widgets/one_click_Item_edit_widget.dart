import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';




/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-f8e965b2-b88c-4808-9861-fc1a918660f9-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 一键投注】】】
    【【【 AUTO_PARAGRAPH_TITLE 一键投注 编辑列表小部件 OneClickItemEditWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 一键投注 编辑列表小部件 OneClickItemEditWidget
    - OneClickItemEditWidget
    ```
    ///编辑列表小部件
    OneClickItemEditWidget(
      isDark: context.isDarkMode,
      onTap: () => controller.onCloseVisibility(),
      title: LocaleKeys.bet_record_bet_val.tr,
      amount: controller.toAmountSplit(
      controller.fastBetAmount.toStringAsFixed(2),
      ),
    )
    ```
    】】】
 *
 */

class OneClickItemEditWidget extends StatelessWidget {
  const OneClickItemEditWidget({
    super.key,
    required this.isDark,
    required this.onTap,
    required this.title,
    required this.amount,
  });

  final bool isDark;
  final VoidCallback? onTap;
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color:
                    context.isDarkMode ? Colors.white : const Color(0xFF303442),
                fontSize: 16.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    amount,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  ImageView(
                    "assets/images/icon/edit_icon.svg",
                    width: 22.w,
                    height: 22.w,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
