import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../main.dart';
import '../../../../services/models/res/get_filter_match_list_new_d_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选  全选按钮 SelectAllBoxWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选  全选按钮 SelectAllBoxWidget
    - SelectAllBoxWidget
    ```
    ///全选按钮
    SelectAllBoxWidget(
      isDark: context.isDarkMode,
      onSelectAll: () => controller.onSelectAll(),
      searchController: controller.searchController,
      getFilterMatchListNewsData: controller.getFilterMatchListNewsData,
      selectAll: controller.selectAll,
      isSelectCount:  controller.isSelectCount,
      onTap: () => controller.onFinish(),
    )
    ```
    】】】
 *
 */

class SelectAllBoxWidget extends StatelessWidget {
  const SelectAllBoxWidget({
    super.key,
    required this.isDark,
    required this.onSelectAll,
    required this.searchController,
    required this.getFilterMatchListNewsData,
    required this.selectAll,
    required this.isSelectCount,
    required this.onTap,
  });

  final bool isDark;
  final VoidCallback? onSelectAll;
  final dynamic searchController;
  final List<GetFilterMatchListNewDData> getFilterMatchListNewsData;
  final bool selectAll;
  final int isSelectCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Container(
        height: 60.h,
        margin: EdgeInsets.only(bottom: bottomHideSwitch ? 26.h: 0.h),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? const Color(0xFF1E2029)
              : const Color(0xFFF2F2F6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(0, 4), // 阴影的位置
            ),
          ],
        ),
        child: Container(
          margin:
              EdgeInsets.only(left: 14.w, right: 25.w, top: 15.h, bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getFilterMatchListNewsData.isNotEmpty
                  ? InkWell(
                      onTap: onSelectAll,
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.common_all_select.tr,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFFAFB3C8),
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            width: 5.w,
                          ),
                          ImageView(
                            selectAll == false
                                ? "assets/images/icon/search_unselected.png"
                                : "assets/images/icon/search_selected.png",
                            height: 20.w,
                            width: 20.w,
                          )
                        ],
                      ),
                    )
                  : Container(),
              if (isSelectCount > 0)
                InkWell(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          offset: Offset(0, 4), // 阴影的位置
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
                      child: Text(
                        LocaleKeys.footer_menu_filter.tr +
                            '  ' +
                            isSelectCount.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
