import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'package:flutter_ty_app/app/global/assets/preloadImg.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/manager/league_manager.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/widgets/menu_one_click_custom_Amount_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/widgets/menu_replace_skin_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/widgets/menu_switch_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/widgets/menu_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/widgets/one_click_menu_widget.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/utils/skin_status.dart';
import 'package:flutter_ty_app/app/utils/time_zone/timeZoneUtils.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../generated/locales.g.dart';
import '../../config/getx_navigation.dart';

import '../../utils/bus/bus.dart';
import '../../utils/bus/event_enum.dart';
import '../../utils/change_skin_tone_color_util.dart';
import '../home/widgets/menu/league/hotLeagueController.dart';
import '../zr/zr_setting_menu/widgets/close_widget.dart';
import 'setting_menu_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5a7d82aa-a062-4061-ad30-cc1cd2482bdc-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 设置菜单视图SettingMenuPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 设置菜单视图SettingMenuPage
    - SettingMenuPage
    - 包含联赛删选-投注模式-排序规则-盘口设置-主题风格-自定义快捷金额一键投注-切换语言-盘口教程-规则说明-公告中心
    ```
    ```
    】】】
 *
 */
class SettingMenuPage extends StatefulWidget {
  const SettingMenuPage({Key? key}) : super(key: key);

  @override
  State<SettingMenuPage> createState() => _SettingMenuPageState();
}

class _SettingMenuPageState extends State<SettingMenuPage> {
  final controller = Get.find<SettingMenuController>();
  final logic = Get.find<SettingMenuController>().logic;

  @override
  Widget build(BuildContext context) {
    PreloadImg.preloadOnSetting(context);
    return GetBuilder<SettingMenuController>(
      builder: (controller) {
        return Container(
          color: logic.isDarkMode ? const Color(0xFF1E2029) : const Color(0xFFF2F2F6),
          height: isSDK == false ? 680.h : 600.h,
          child: Get.currentRoute == Routes.europeanCup || Get.currentRoute == Routes.olympicGames
              ? Column(
                  children: [
                    ///盘口设置
                    // _handicapSettings(),
                    ///选择语言
                    _chooseLanguage(),
                    ///关闭
                    _close(),
                  ],
                )
              : Stack(
                  children: [
                    Column(
                      children: [
                        Obx(() {
                          bool show = ConfigController.to.accessConfig.value.filterSwitch && (((HotLeagueController.to?.showLeageuFilter.value ?? true))) && Get.currentRoute == Routes.mainTab;
                          return show
                              ? Column(
                                  children: [
                                    ///联赛删选
                                    _leagueDeletion(),
                                    Container(
                                      height: 10,
                                    )
                                  ],
                                )
                              : Container();
                        }),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ///投注模式
                                _bettingMode(),
                                ///排序规则
                                _sortingRules(),
                                ///每日活动
                                _dailyActivities(),
                                ///字号大小
                                _fontSize(),
                                ///投注手势
                                _betButtonStyle(),
                                ///主题风格
                                _themeStyle(),
                                ///更换皮肤颜色(只有暗黑模式才开启换肤)
                                if (logic.isDarkMode) _changeSkinColor(),
                                ///队名偏好 接口开关 ，0 关 ，1 开
                                if ((logic.languageSwitch.contains('1') && logic.languageSystemSwitch.contains('1')) && Get.locale?.countryCode == 'CN')
                                  _teamNamePreference(),
                                ///盘口设置  ///上面都是滑块  下面才是更多展示
                                if (!ShopCartController.to.isChampion())
                                  _handicapSettings(),
                                ///自定义快捷注金额
                                _customBetAmount(),
                                ///一键投注
                                _oneClickBetting(),
                                ///选择语言
                                _chooseLanguage(),
                                ///注单通知
                                _orderNotification(),
                                ///盘口教程
                                _handicapTutorial(),
                                ///选择时区
                                _selectTimeZone(),
                                ///规则说明
                                _ruleDescription(),
                                /// 公告中心
                                _noticeCenter(),
                                ///退出登录
                                if (isSDK == false) _signOut(),
                              ],
                            ),
                          ),
                        ),
                        ///关闭
                        _close(),
                      ],
                    ),
                    if (logic.updateLanguage)
                      AbsorbPointer(
                        absorbing: true,
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: ImageView(
                              oddsInfoLoadingGif,
                              width: 70.w,
                            ),
                          ),
                        ),
                      ),
                    _customAmountColumn(),
                  ],
                ),
        );
      },
    );
  }
  ///联赛删选
  Widget _leagueDeletion() {
    return MenuWidget(
      onTap: () => SettingMenuController.onLeagueFilter(),
      title: LocaleKeys.footer_menu_league_filter.tr,
      summary: LeagueManager.tid.isEmpty
          ? LocaleKeys.footer_menu_all.tr
          : '( ${LocaleKeys.footer_menu_selected.tr}${LeagueManager.tid.length})',
      subTitle: LocaleKeys.footer_menu_more.tr,
      imageUrl: "assets/images/icon/league_icon.png",
      isDark: logic.isDarkMode,
      dividing: false,
      bigFontSize: true,
    );
  }
  ///投注模式
  Widget _bettingMode() {
    return MenuSwitchWidget(
      title: LocaleKeys.footer_menu_bet_model.tr,
      isDark: logic.isDarkMode,
      switchA: LocaleKeys.footer_menu_new_v.tr,
      switchAParameter: logic.bettingMode,
      switchAOnTap: () => controller.onBettingMode(1),
      switchB: LocaleKeys.footer_menu_pro_v.tr,
      switchBParameter: logic.bettingMode,
      switchBOnTap: () => controller.onBettingMode(2),
      dividing: false,
      bigFontSize: true,
    );
  }
  ///投注手势
  Widget _betButtonStyle() {
    return MenuSwitchWidget(
      title: LocaleKeys.footer_menu_bet_button_style.tr,
      isDark: logic.isDarkMode,
      switchA: LocaleKeys.footer_menu_bet_button_style_slide.tr,
      switchAParameter: logic.betButtonStyle,
      switchAOnTap: () => controller.onBetButtonStyle(1),
      switchB: LocaleKeys.footer_menu_bet_button_style_tap.tr,
      switchBParameter: logic.betButtonStyle,
      switchBOnTap: () => controller.onBetButtonStyle(2),
      dividing: false,
      bigFontSize: true,
    );
  }
  ///排序规则
  Widget _sortingRules() {
    return MenuSwitchWidget(
      title: LocaleKeys.footer_menu_sort_title.tr,
      isDark: logic.isDarkMode,
      switchA: LocaleKeys.footer_menu_hot.tr,
      switchAParameter: logic.sortingRules,
      switchAOnTap: () => controller.onSortingRules(1),
      switchB: LocaleKeys.footer_menu_time.tr,
      switchBParameter: logic.sortingRules,
      switchBOnTap: () => controller.onSortingRules(2),
      dividing: true,
      bigFontSize: true,
    );
  }
  ///盘口设置
  Widget _handicapSettings() {
    bool isEuOnly = ShopCartController.to.isEuOnly();
    return MenuWidget(
      onTap: () => controller.toHandicapSettings(),
      title: LocaleKeys.footer_menu_odds_set.tr,
      isDark: logic.isDarkMode,
      imageUrl: '',
      subTitle: TYUserController.to.getCurHandicapName(),
      summary: '',
      dividing: true,
      enabled: !isEuOnly,
      bigFontSize: true,
    );
  }
  ///字号大小
  Widget _fontSize() {
    return MenuSwitchWidget(
      title: LocaleKeys.app_h5_filter_font_size.tr,
      isDark: logic.isDarkMode,
      switchA: LocaleKeys.app_h5_filter_default.tr,
      switchAParameter: logic.fontSize,
      switchAOnTap: () => controller.onFontSize(1),
      switchB: LocaleKeys.app_h5_filter_enlarge.tr,
      switchBParameter: logic.fontSize,
      switchBOnTap: () => controller.onFontSize(2),
      dividing: true,
      bigFontSize: true,
    );
  }
  ///队名偏好
  Widget _teamNamePreference() {
    return MenuSwitchWidget(
      title: LocaleKeys.app_teamPreference.tr,
      isDark: logic.isDarkMode,
      switchA: LocaleKeys.app_simplified.tr,
      switchAParameter: controller.teamNamePreference,
      switchAOnTap: () => controller.onTeamNamePreference(1),
      switchB: LocaleKeys.app_traditional.tr,
      switchBParameter: controller.teamNamePreference,
      switchBOnTap: () => controller.onTeamNamePreference(2),
      dividing: true,
      bigFontSize: true,
    );
  }
  ///主题风格
  Widget _themeStyle() {
    return MenuSwitchWidget(
      title: LocaleKeys.footer_menu_theme.tr,
      isDark: logic.isDarkMode,
      switchA: LocaleKeys.footer_menu_daytime.tr,
      switchAParameter: logic.themeStyle,
      switchAOnTap: () => controller.onThemeStyle(1),
      switchB: LocaleKeys.footer_menu_night.tr,
      switchBParameter: logic.themeStyle,
      switchBOnTap: () => controller.onThemeStyle(2),
      dividing: true,
      bigFontSize: true,
    );
  }
  ///每日活动
  Widget _dailyActivities() {
    return GetBuilder<SettingMenuController>(
      id: 'SettingMenuShowActivity',
      initState: (_) {},
      builder: (controller) {
        return logic.showActivity
            ? MenuSwitchWidget(
                title: LocaleKeys.app_h5_filter_daily_activities.tr,
                isDark: logic.isDarkMode,
                switchA: LocaleKeys.footer_menu_turn_on.tr,
                switchAParameter: logic.dailyActivities,
                switchAOnTap: () => controller.onDailyActivities(1),
                switchB: LocaleKeys.common_close.tr,
                switchBParameter: logic.dailyActivities,
                switchBOnTap: () => controller.onDailyActivities(2),
                dividing: true,
                bigFontSize: true,
              )
            : Container();
      },
    );
  }
  ///自定义投注金额
  Widget _customBetAmount() {
    return MenuWidget(
      onTap: () => controller.onCustomBetAmount(),
      title: LocaleKeys.app_h5_filter_customized_amount.tr,
      isDark: logic.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
      bigFontSize: true,
    );
  }
  ///一键投注
  Widget _oneClickBetting() {
    bool switchOn = logic.switchOn && !(ShopCartController.to.isParlayMode());
    return OneClickMenuWidget(
      onTap: () => controller.onOneClickBetting(),
      title: LocaleKeys.bet_one_click_bet.tr,
      isDark: logic.isDarkMode,
      fastBetAmount: logic.fastBetAmount,
      dividing: true,
      bigFontSize: true,
      switchA: LocaleKeys.app_open.tr,
      switchOn: switchOn,
      switchAOnTap: () => controller.onOneClickBettingNew(),
      switchB: LocaleKeys.app_close.tr,
      switchBOnTap: () => controller.onOneClickBettingNew(),
      setting: () => controller.onCloseVisibility(),
    );
  }
  ///一键投注金额设置
  Widget _customAmountColumn() {
    return MenuOneClickCustomAmountWidget(
      isDark: context.isDarkMode,
      betAmount: logic.betAmount,
      onCloseVisibility: () => controller.onCloseVisibility(),
      textEditingController: controller.textEditingController,
      focusNode: controller.focusNode,
      onBackspace: () => controller.onBackspace(),
      onMaxInputText: () => controller.onMaxInputText(),
      onOK: () => controller.onOK(),
      onInsertText: (myText) => controller.onInsertText(myText),
      replaceText: (myText) => controller.replaceText(myText),
      min: logic.min,
      singleList: logic.singleList,
    );
  }
  ///选择时区
  Widget _selectTimeZone() {
    return MenuWidget(
      onTap: () => controller.onSelectTimeZone(),
      title: LocaleKeys.app_time_zone.tr,
      isDark: logic.isDarkMode,
      imageUrl: '',
      subTitle: TimeZoneUtils.timeZone[TimeZoneUtils.zoneIndex],
      summary: '',
      dividing: true,
      bigFontSize: true,
    );
  }
  ///更换皮肤颜色
  Widget _changeSkinColor() {
    return MenuReplaceSkinWidget(
      modeStatus: ChangeSkinToneColorUtil.instance().getModeStatus(),
      switchAOnTap: () {
        controller.setModeStatus(Status.BLACK_STYLE_1);
      },
      switchBOnTap: () {
        controller.setModeStatus(Status.BLACK_STYLE_2);
      },
      switchCOnTap: () {
        controller.setModeStatus(Status.BLACK_STYLE_3);
      },
    );
  }
  ///盘口教程
  Widget _handicapTutorial() {
    return MenuWidget(
      onTap: () => controller.onTutorial(),
      title: LocaleKeys.app_h5_cathectic_handicap_tutorial.tr,
      isDark: logic.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
      bigFontSize: true,
    );
  }
  ///规则说明
  Widget _ruleDescription() {
    return MenuWidget(
      onTap: () => controller.toRuleDescription(),
      title: LocaleKeys.common_rule_description.tr,
      isDark: logic.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
      bigFontSize: true,
    );
  }

  /// 公告中心
  Widget _noticeCenter() {
    return MenuWidget(
      onTap: () => controller.toNoticeCenter(),
      title: LocaleKeys.app_notice_center.tr,
      isDark: logic.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
      bigFontSize: true,
    );
  }

  ///选择语言
  Widget _chooseLanguage() {
    return MenuWidget(
      onTap: () => controller.toLanguage(),
      title: LocaleKeys.setting_menu_chan_lan.tr,
      isDark: logic.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
      bigFontSize: true,
    );
  }
  ///注单通知
  Widget _orderNotification() {
    return MenuWidget(
      onTap: () => controller.toOrderNotification(),
      title: LocaleKeys.app_betOrderNotification.tr,
      isDark: logic.isDarkMode,
      imageUrl: '',
      subTitle: LocaleKeys.app_betNotificationReservationNotification.tr,
      summary: '',
      dividing: true,
      bigFontSize: true,
    );
  }
  ///退出登录
  Widget _signOut() {
    return MenuWidget(
      onTap: () => controller.toSignOut(),
      title: LocaleKeys.app_signOut.tr,
      isDark: logic.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
      bigFontSize: true,
    );
  }
  ///关闭
  Widget _close() {
    return CloseWidget(
      title: LocaleKeys.common_close.tr,
      isDark: logic.isDarkMode,
      onTap: () {
        Get_TY.back();
        Bus.getInstance().emit(EventType.tyCloseDialog);
      },
      bigFontSize: true,
    );
  }
  @override
  void dispose() {
    Get.delete<SettingMenuController>();
    super.dispose();
  }
}
