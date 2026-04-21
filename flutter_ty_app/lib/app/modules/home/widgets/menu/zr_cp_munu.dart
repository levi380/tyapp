
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/match_list_type.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/config/analytic/analytics_utils.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../utils/oss_util.dart';
import '../../../cp/controllers/cp_controller.dart';
import '../../../cp/widget/lottery_betting_switch_container_widget.dart';
import '../../../main_tab/main_tab_controller.dart';
import '../../../zr/widgets/zr_switch_widget.dart';

/// 总控开发关闭，简中才显示： TYUserController.to.userInfo.value?.zr != 1 || !isZHCN()
/// 总控开发关闭，简中才显示： TYUserController.to.userInfo.value?.cp != 1 || !isZHCN()

class ZRCpMenu extends StatelessWidget {
  const ZRCpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TyHomeController>(
      tag: MainTabController.to.uuid,
      builder: (logic) {
        return Column(
          children: [
            Builder(builder: (context) {
              return Obx(() {
                ///真人开关
                bool zrSwitch =
                    (ConfigController.to.accessConfig.value.zrSwitchConfig.zr &&
                        ConfigController
                            .to.accessConfig.value.zrSwitchConfig.zrSdk &&
                        ConfigController
                            .to.accessConfig.value.zrSwitchConfig.zrSwitch);

                ///cp开关
                bool cpSwitch =
                    (ConfigController.to.accessConfig.value.zrSwitchConfig.cp &&
                        ConfigController
                            .to.accessConfig.value.zrSwitchConfig.cpSdk &&
                        ConfigController
                            .to.accessConfig.value.zrSwitchConfig.cpSwitch);

                bool isChampion = TyHomeController.to.homeState.listType ==
                    MatchListType.champion;
                return Visibility(
                  visible: (zrSwitch || cpSwitch) && !isChampion,
                  child: Container(
                    height: 48.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildItem(
                          isIPad
                              ? 'assets/images/cp_zr_menu/zr_ips_bet_ligth.png'
                              : 'assets/images/cp_zr_menu/zr_ii_bet_ligth.png',
                          isIPad
                              ? 'assets/images/cp_zr_menu/zr_ips_bet_night.png'
                              : 'assets/images/cp_zr_menu/zr_ii_bet_night.png',
                          logic.homeState.listType == MatchListType.zr,
                          LocaleKeys.menu_itme_name_zr_menu.tr,
                          'CASINO',
                          () {
                            if (!zrSwitch) return;

                            ///判断是否登录
                            if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) {
                              return;
                            }
                            // 真人埋点
                            // AppLogger.debug("==========>热门真人排序埋点   ");
                            Analytics.track(AnalyticsEvent.menu_live_casino, pagePath: '', clickTarget: (AnalyticsEvent.menu_live_casino).toString());
                            ///真人切换
                            logic.homeState.listType = MatchListType.zr;
                            logic.update();
                            MainTabController.to.update();

                            /// 关掉画中画
                            // TyHomeController.to.closePipVideo();
                          },
                          context,
                          'assets/images/cp_zr_menu/default.png',
                          'assets/images/cp_zr_menu/zr_wh_light.png',
                          'assets/images/cp_zr_menu/zr_wh_night.png',
                          LocaleKeys
                              .zr_cp_Lottery_Bet_Slips_live_maintenance.tr,

                          /// 真人 商户控制 总控开关
                          zrSwitch,

                          ///真人维护开关  ----暂未上线
                          // zrWH
                        ),

                        ///合买大厅开发暂停   全局锚点
                        // 8.horizontalSpace,
                        // _buildItem(
                        //   isIPad ?  'assets/images/cp_zr_menu/cp_ips_bet_light.png':  'assets/images/cp_zr_menu/cp_i_bet_light.png',
                        //   isIPad ?  'assets/images/cp_zr_menu/cp_ips_bet_night.png':   'assets/images/cp_zr_menu/cp_i_bet_night.png',
                        //   false,
                        //   '合买大厅',
                        //   'Group Bet',
                        //   () {
                        //     Get.toNamed(Routes.GROUP_BET);
                        //   },
                        //   context,
                        //   'assets/images/cp_zr_menu/default.png',
                        //   'assets/images/cp_zr_menu/cp_wh_light.png',
                        //   'assets/images/cp_zr_menu/cp_wh_night.png',
                        //   LocaleKeys
                        //       .zr_cp_Lottery_Bet_Slips_lottery_maintenance.tr,
                        //   /// 彩票 商户控制 总控开关
                        //   ///cp维护开关  ----暂未上线
                        //   // cpWH
                        // ),
                        8.horizontalSpace,
                        _buildItem(
                          isIPad
                              ? 'assets/images/cp_zr_menu/cp_ips_bet_light.png'
                              : 'assets/images/cp_zr_menu/cp_i_bet_light.png',
                          isIPad
                              ? 'assets/images/cp_zr_menu/cp_ips_bet_night.png'
                              : 'assets/images/cp_zr_menu/cp_i_bet_night.png',
                          logic.homeState.listType == MatchListType.cp,
                          LocaleKeys.menu_itme_name_cp_menu.tr,
                          'LOTTERY',
                          () {
                            if (!cpSwitch) return;

                            ///判断是否登录
                            if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) {
                              return;
                            }
                            // AppLogger.debug("==========>彩票排序埋点   ");
                            Analytics.track(AnalyticsEvent.menu_lottery, pagePath: '', clickTarget: (AnalyticsEvent.menu_lottery).toString());
                            ///彩票切换
                            logic.homeState.listType = MatchListType.cp;
                            logic.update();
                            final mainTabController =
                                Get.find<MainTabController>();
                            mainTabController.update();
                            /// 关掉画中画
                            // TyHomeController.to.closePipVideo();
                          },
                          context,
                          'assets/images/cp_zr_menu/default.png',
                          'assets/images/cp_zr_menu/cp_wh_light.png',
                          'assets/images/cp_zr_menu/cp_wh_night.png',
                          LocaleKeys
                              .zr_cp_Lottery_Bet_Slips_lottery_maintenance.tr,

                          /// 彩票 商户控制 总控开关
                          cpSwitch,

                          ///cp维护开关  ----暂未上线
                          // cpWH
                        ),
                      ],
                    ),
                  ),
                );
              });
            }),
            Builder(builder: (context) {
              if (logic.homeState.listType == MatchListType.zr) {
                return const ZrSwitchWidget().marginOnly(bottom: 5.h);
              }
              if (logic.homeState.listType == MatchListType.cp) {
                return GetBuilder<CpController>(
                  init: CpController(),
                  builder: (controller) {
                    final tabTitles = [
                      LocaleKeys.zr_cp_settings_Menu_cp_collect.tr,
                      LocaleKeys.zr_cp_top_navigation_bar_all.tr,
                      LocaleKeys.zr_cp_settings_Menu_cp_classic.tr,
                      LocaleKeys.zr_cp_settings_Menu_cp_feature.tr,
                    ];

                    ///彩票切换
                    return LotteryBettingSwitchContainerWidget(
                      childrenTitles: tabTitles,
                      selIndex: controller.selTabIndex,
                      onNewChange: controller.onSelTabChangedNewChange,
                    ).marginOnly(bottom: 5.h);
                  },
                );
              }
              return const SizedBox();
            }),
          ],
        );
      },
    );
  }

  Widget _buildItem(
    String lightIcon,
    String nightIcon,
    bool isSelected,
    String title,
    String dec,
    VoidCallback onTap,
    BuildContext context,

    ///没开启图片
    String noOpenIcon,
    String whLightIcon,
    String whNightIcon,
    String whTitle,

    ///默认开启 默认不在维护状态
    [
    bool isOpen = true,
    bool isWH = false,
  ]) {
    return Expanded(
      child: isIPad
          ?

          ///isIPad
          Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Container(
                    height: 40.w,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          OssUtil.getServerPath(() {
                            if (isWH)
                              return context.isDarkMode
                                  ? whNightIcon
                                  : whLightIcon;
                            if (isOpen) {
                              return context.isDarkMode ? nightIcon : lightIcon;
                            } else {
                              return noOpenIcon;
                            }
                          }()),
                        ),
                        fit: BoxFit.fill,
                      ),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xff179CFF)
                            : Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: isOpen
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 45.w,
                              ),
                              Text(
                                title,
                                style: TextStyle(
                                  color: context.isDarkMode
                                      ? Colors.white
                                          .withValues(alpha: 0.699999988079071)
                                      : const Color(0xFF616783),
                                  fontSize: 18.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                width: 16.w,
                              ),
                              Text(
                                dec,
                                style: TextStyle(
                                  color: context.isDarkMode
                                      ? Colors.white
                                          .withValues(alpha: 0.699999988079071)
                                      : const Color(0xFF616783),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.96,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            isWH ? whTitle : '',
                            style: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                      .withValues(alpha: 0.699999988079071)
                                  : const Color(0xFF616783),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                isSelected
                    ? ImageView(
                        'assets/images/cp_zr_menu/ligth_arrow_down.svg',
                        cdn: true,
                        width: 8.w,
                        height: 4.w,
                      )
                    : 4.verticalSpaceFromWidth,
              ],
            )
          :

          ///iphone
          Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Container(
                    height: 40.w,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          OssUtil.getServerPath(() {
                            if (isWH)
                              return context.isDarkMode
                                  ? whNightIcon
                                  : whLightIcon;
                            if (isOpen) {
                              return context.isDarkMode ? nightIcon : lightIcon;
                            } else {
                              return noOpenIcon;
                            }
                          }()),
                        ),
                        fit: BoxFit.fill,
                      ),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xff179CFF)
                            : Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: isOpen && !isWH
                        ? Row(
                            children: [
                              if ([
                                'zh',
                                'th',
                                'ko',
                                'mn',
                                'en',
                                'ms',
                                'id',
                                'hi'
                              ].contains(Get.locale?.languageCode))
                                Container(
                                  width: 27.w,
                                ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white.withValues(
                                              alpha: 0.699999988079071)
                                          : const Color(0xFF616783),
                                      fontSize: 12.sp,
                                      height: 1.0,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  2.verticalSpaceFromWidth,
                                  Text(
                                    dec,
                                    style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white.withValues(
                                              alpha: 0.699999988079071)
                                          : const Color(0xFF616783),
                                      fontSize: 7.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.56,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : Text(
                            ///判断是否是维护还是没显示
                            isWH ? whTitle : '',
                            style: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                      .withValues(alpha: 0.699999988079071)
                                  : const Color(0xFF616783),
                              fontSize: 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                isSelected
                    ? ImageView(
                        'assets/images/cp_zr_menu/ligth_arrow_down.svg',
                        cdn: true,
                        width: 8.w,
                        height: 4.w,
                      )
                    : 4.verticalSpaceFromWidth,
              ],
            ),
    );
  }
}
