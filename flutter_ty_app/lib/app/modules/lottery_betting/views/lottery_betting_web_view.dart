import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/tab_widget.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../controllers/lottery_betting_controller.dart';

class LotteryBettingWebView extends GetView<LotteryBettingController> {
  const LotteryBettingWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LotteryBettingController>(
      init: LotteryBettingController(),
      builder: (_) => Scaffold(
        bottomNavigationBar: _buildBottonNavBar(context),
        body: Container(
          decoration: context.isDarkMode
              ? BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      OssUtil.getServerPath(
                        'assets/images/home/color_background_skin.png',
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                )
              : BoxDecoration(color: '#F2F2F2'.hexColor),
          child: _WebView(),
        ),
      ),
    );
  }

  Widget _buildBottonNavBar(BuildContext context) {
    return Container(
      height: 75.h,
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? const Color(0xE5181A21)
            : const Color(0xffFFFAFA),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode ? Colors.black : Colors.grey,
            blurRadius: 4.r,
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 赛果
          TabWidget(
            onTap: () => controller.logicToTargetPage(0),
            title: LocaleKeys.menu_itme_name_results.tr,
            imageUrl: context.isDarkMode
                ? 'assets/images/icon/main_tab1_night.svg'
                : 'assets/images/icon/main_tab1.png',
            dailyActivities: false,
          ),
          // 设置菜单
          TabWidget(
            onTap: () {
              controller.logicToTargetPage(1);
            },
            title: LocaleKeys.footer_menu_set_menu.tr,
            imageUrl: context.isDarkMode
                ? 'assets/images/icon/main_tab2_night.svg'
                : 'assets/images/icon/main_tab2.png',
            dailyActivities: false,
          ),
          // 未结注单
          TabWidget(
            onTap: () => controller.logicToTargetPage(2),
            title: LocaleKeys.app_h5_cathectic_open_bets.tr,
            imageUrl: context.isDarkMode
                ? 'assets/images/icon/main_tab3_night.svg'
                : 'assets/images/icon/main_tab3.png',
            dailyActivities: false,
          ),
          // 已结注单
          TabWidget(
            onTap: () => controller.logicToTargetPage(3),
            title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
            imageUrl: context.isDarkMode
                ? 'assets/images/icon/main_tab4_night.png'
                : 'assets/images/icon/main_tab4.png',
            dailyActivities: false,
          ),
          // 刷新
          TabWidget(
            onTap: () => controller.logicToTargetPage(4),
            title: LocaleKeys.footer_menu_refresh.tr,
            imageUrl: 'assets/images/icon/main_tab4.png',
            animation: true,
            dailyActivities: controller.dailyActivities,
            animate: controller.animationController,
          ),
        ],
      ),
    );
  }

  Widget _WebView() {
    return Container();
  }
}
