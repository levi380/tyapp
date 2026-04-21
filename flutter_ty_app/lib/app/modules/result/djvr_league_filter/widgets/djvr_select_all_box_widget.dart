
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../services/models/res/get_filter_match_list_new_d_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3a9df28f-c590-402c-a99e-edc66a224cb3-dj 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果电竞冠军联赛筛选】】】
    【【【 AUTO_PARAGRAPH_TITLE  电竞赛果冠军赛果 全选按钮组件 DjVrSelectAllBoxWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  电竞赛果冠军赛果 全选按钮组件 DjVrSelectAllBoxWidget
    - DjVrSelectAllBoxWidget
    ```
    ///全选按钮
    DjVrSelectAllBoxWidget(
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

class DjVrSelectAllBoxWidget extends StatelessWidget {
  const DjVrSelectAllBoxWidget({
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
    return Row(
      children: [
        Expanded(child: SizedBox()),
        Container(
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
            ],
          ),
        )
      ],
    );
  }
}
