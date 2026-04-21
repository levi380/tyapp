import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../utils/change_skin_tone_color_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-528b398c-8958-44e0-9713-fb7030115573-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE vr详情】】】
    【【【 AUTO_PARAGRAPH_TITLE vr详情首页 入口】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - vr详情首页
    - 导航动画
    - 悬停头部tab
    - tabview内容组件

    - 导航

    `detailsAppBar()`

    - `悬停tab头部`
    `vrSportDetailTabPageWidget()`

    ```
    controller.state.matchDetailList.isEmpty
    ///没有头部则显示空
    ? const SizedBox()
    :

    ///悬停tab头部
    vrSportDetailTabPageWidget(),
    ```

    】】】
 *
 */
class VrSportDetailPage extends GetView<VrSportDetailLogic> {
  const VrSportDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      body: Column(
        children: [
          ///导航
          detailsAppBar(),
          controller.state.matchDetailList.isEmpty

              ///没有头部则显示空
              ? const SizedBox()
              :

              ///悬停tab头部
              vrSportDetailTabPageWidget(),
          Expanded(
            child: Container(
              decoration: context.isDarkMode
                  ? BoxDecoration(
                      color: ChangeSkinToneColorUtil.instance()
                          .getDarkBackgroundColor(),
                      // image: DecorationImage(
                      // image: NetworkImage(
                      //   OssUtil.getServerPath(
                      //     'assets/images/home/color_background_skin.png',
                      //   ),
                      // ),
                      //   fit: BoxFit.cover,
                      // ),
                    )
                  : const BoxDecoration(
                      color: Color(0xfff2f2f6),
                    ),
              child: VrSportDetailTabBarView(),
            ),
          ),
        ],
      ),
    );
  }
}
