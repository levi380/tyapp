import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';




/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5177174d-b3ac-44f9-89be-505cb4a6b44a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 自定义快捷投注金额】】】
    【【【 AUTO_PARAGRAPH_TITLE 自定义快捷投注金额  单关串关ListItme 组件 SinglelevelComboItemWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 自定义快捷投注金额  单关串关ListItme 组件 SinglelevelComboItemWidget
    - SinglelevelComboItemWidget
    ```
     SinglelevelComboItemWidget(
      ///主题色
      isDark: context.isDarkMode,
      ///list数据
      list: controller.singleList,
      ///选择索引
      onSelectSingleLevelBetting: (list, index) =>controller.onSelectSingleLevelBetting(list, index),
      selectedMatchBetting: controller.selectedSingleLevelBetting,
      ///标题
      title: LocaleKeys.app_h5_filter_quick_bet.tr,
    )
    ```
    】】】
 *
 */

class SinglelevelComboItemWidget extends StatelessWidget {
  const SinglelevelComboItemWidget({
    super.key,
    required this.isDark,
    required this.onSelectSingleLevelBetting,
    required this.selectedMatchBetting,
    required this.title,
    required this.list,
  });

  final bool isDark;
  final void Function(dynamic, dynamic) onSelectSingleLevelBetting;
  final String selectedMatchBetting;
  final String title;
  final List<int> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? const Color(0xFF0E1014)
            : const Color(0xFFe4e6ed),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: GridView.builder(
          padding:
          EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.w,
            crossAxisCount: 3,
            childAspectRatio: 1.2,
          ),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () => onSelectSingleLevelBetting(list[index],index + 1),
              child: Container(
                margin:
                EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w),
                child: Column(
                  children: [
                    Text(
                      maxLines: 3,
                      '$title ${index + 1}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.isDarkMode
                            ? Colors.white
                            : const Color(0xFF303442),
                        fontSize: 12.sp,
                        height: 1,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      height: 25.h,
                      margin: EdgeInsets.only(top: 5.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? const Color(0xFF303442)
                            : Colors.white,
                        border:
                        selectedMatchBetting==
                            list[index]
                                .toString()
                            ? Border.all(
                          color: Colors.blue,
                          width: 1.0,
                        )
                            : null,
                      ),
                      child: Text(
                        '+ ${toAmountSplit(list[index].toString())}',
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              : const Color(0xFF303442),
                          fontSize: 12.sp,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  String toAmountSplit(String num) {
    String numStr = (num).toString();

    if (numStr.contains('.')) {
      List<String> parts = numStr.split('.');
      String integerPart = parts[0];
      String decimalPart = parts[1];

      String formattedInteger = integerPart.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
            (match) => '${match.group(1)},',
      );

      return '$formattedInteger.$decimalPart';
    } else {
      return numStr.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
            (match) => '${match.group(1)},',
      );
    }
  }
}
