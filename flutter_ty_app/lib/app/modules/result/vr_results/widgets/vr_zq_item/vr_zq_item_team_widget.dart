import '../../../../../../main.dart';
import '../../../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 赛果足球列表小组件 VrZqItemWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 赛果足球列表小组件 VrZqItemWidget
    - VrZqItemWidget
    ```
    ///赛果足球列表小组件
    VrZqItemWidget(
    isDark: context.isDarkMode,
    recordsList: controller.recordsList,
    isExpand: controller.isExpand,
    onExpandItem: () => controller.onExpandItem(),
    vRMenuMenuId: controller.vRMenuMenuId,
    scrollController: controller.scrollController,
    )
    ```
    】】】
 *
 */
class VrZqItemTeamWidget extends StatelessWidget {
  const VrZqItemTeamWidget({
    super.key,
    required this.teamIcon,
    required this.teamName,
    required this.isDark,
  });


  final String teamIcon;
  final String teamName;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 20.w,
      ),
      height: 34.h,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          ImageView(
            teamIcon,
            cdn: true,
            width: 20.w,
            height: 20.w,
          ).marginOnly(right: 8.w),
          Text(
            teamName,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            maxLines: 1,
            style: TextStyle(
              color: isDark
                  ? Colors.white
                  : const Color(0xFF303442),
              fontSize: isIPad ? 14.sp : 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}