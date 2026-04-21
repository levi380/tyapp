import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../utils/change_skin_tone_color_util.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-528b398c-8958-44e0-9713-fb7030115573-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE vr详情】】】
    【【【 AUTO_PARAGRAPH_TITLE vr详情-悬停tab头部】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 足球-历史战绩，投注，排行榜
    - 篮球-投注
    - 赛狗摩托-历史战绩，投注
    】】】
 *
 */
class vrSportDetailTabPageWidget extends GetView<VrSportDetailLogic> {
  @override
  Widget build(BuildContext context) {
    return controller.state.matchDetailList.isEmpty
        ? const SizedBox()
        : Container(
            decoration: context.isDarkMode
                ? BoxDecoration(
                   color: ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(),
                    // image: DecorationImage(
                    //   image: NetworkImage(
                    //     OssUtil.getServerPath(
                    //       'assets/images/home/color_background_skin.png',
                    //     ),
                    //   ),
                    //   fit: BoxFit.cover,
                    // ),
                  )
                : const BoxDecoration(
                    color: Colors.white,
                  ),
            height: 40.w,
            child: TabBar(
              controller: controller.state.matchTabController,
              indicatorSize: TabBarIndicatorSize.label,
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              dividerHeight: 0,
              labelPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              indicator: const CustomTabIndicator(
                width: 45,
                borderSide: BorderSide(
                  width: 3.0,
                  color: Color(0xFF179CFF),
                ),
              ),

              tabs: _tabList(context),
            ),
          );
  }

  ///tabbar历史战绩，投注，排行榜
  List<Tab> _tabList(BuildContext context) {
    return controller.state.matchDetailList.asMap().keys.map((index) {
      return Tab(
        child: GetBuilder(
          init: VrSportDetailLogic(),
          builder: (controller) {
            String name = controller.state.matchDetailList[index];
            bool isSelect = controller.state.matchTabController?.index == index;
            double width = MediaQuery.of(context).size.width /
                controller.state.matchDetailList.length;
            return Visibility(
              visible: true,
              child: Container(
                padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 10.w),
                alignment: Alignment.center,
                width: width,
                height: 40.w,
                child: FittedBox(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: isSelect
                          ? context.isDarkMode
                              ? Colors.white.withValues(alpha:0.8)
                              : Colors.black
                          :context.isDarkMode ?
                      Colors.white.withValues(alpha:0.3):
                      const Color(0xFF7981A4),
                     // color:  context.isDarkMode
                     //      ? Colors.white.withValues(alpha:0.5)
                     //      // : const Color(0xFF7981A4),
                     //     :  Colors.black,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            );
          },
        ),

      );
    }).toList();
  }
}
