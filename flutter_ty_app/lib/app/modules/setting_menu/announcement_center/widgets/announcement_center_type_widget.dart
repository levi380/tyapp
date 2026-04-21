import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../services/models/res/get_notice_front_list_new_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a3a627ae-2de5-4ce2-862f-eeb8573aa24d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 公告中心】】】
    【【【 AUTO_PARAGRAPH_TITLE 公告中心 公告赛事类型组件 AnnouncementCenterTypeWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 公告中心 公告赛事类型组件 AnnouncementCenterTypeWidget
    - AnnouncementCenterTypeWidget
    ```
    AnnouncementCenterTypeWidget(
    ///主题
    isDark: context.isDarkMode,

    ///菜单控制器
    tabController: controller.tabController,

    ///菜单数据
    nl: controller.nl,

    ///点击索引
    onTap: (index) => controller.onTypeIndex(index),
    )
    ```
    】】】
 *
 */

class AnnouncementCenterTypeWidget extends StatelessWidget {
  const AnnouncementCenterTypeWidget({
    super.key,
    required this.isDark,
    required this.tabController,
    required this.onTap,
    required this.nl,
    required this.typeIndex,
    required this.sIndex,
    required this.yIndex,
  });

  final bool isDark;
  final TabController tabController;
  final Function(dynamic index) onTap;
  final List<GetNoticeFrontListNewDataNl> nl;
  final int typeIndex;
  final int sIndex;
  final int yIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      padding: EdgeInsets.only(bottom: 4.w, top: 4.h),
      child: TabBar(
        isScrollable: true,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: const Color(0xFF179CFF),
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(2.w),
        ),
        dividerHeight: 0,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        labelColor: const Color(0xFF179CFF),
        unselectedLabelColor: const Color(0xFFA0A4B0),
        labelPadding: EdgeInsets.symmetric(horizontal: 7.w),
        indicatorPadding: EdgeInsets.only(left: 10.w, right: 20.w),
        controller: tabController,
        onTap: onTap,
        tabs: List.generate(
          nl.length,
          (index) {
            return Stack(
              children: [
                Row(
                  children: [
                    Text(
                      nl[index].nen,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ).marginOnly(bottom: 4.w),
                    Container(
                      width: 5.w,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        nl[index].net == '9999'
                            ? yIndex.toString()
                            : nl[index].net == '8888'
                                ? sIndex.toString()
                                : nl[index].mtl.length.toString(),
                        style: TextStyle(
                          color: typeIndex == index
                              ? isDark
                                  ? Color(0xFFAFB3C8)
                                  : const Color(0xFF303442)
                              : const Color(0xFFAFB3C8),
                          fontSize: 10.sp,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
