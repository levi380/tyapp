import 'package:get/get.dart';

/// 赔率信息加载中的gif
const String oddsInfoLoadingGif = 'assets/images/detail/odds-info-loading.gif';

/// 活动/任务
const String activityGif = 'assets/images/icon/activity.gif';

/// 右侧菜单
const String mainTabMenu0 = 'assets/images/icon/main_tab_menu0.png';
const String mainTabMenu1 = 'assets/images/icon/main_tab_menu1.png';
const String mainTabMenu2 = 'assets/images/icon/main_tab_menu2.png';
const String mainTabMenu3 = 'assets/images/icon/main_tab_menu3.png';
const String mainTabMenu4 = 'assets/images/icon/main_tab_menu4.png';
const String mainTabMenu5 = 'assets/images/icon/main_tab_menu5.png';

/// 足球篮球模板
const String footballBasketballTemplate5 =
    'assets/images/icon/footballBasketballTemplate_5.png';
const String footballBasketballTemplate4 =
    'assets/images/icon/footballBasketballTemplate_4.png';
const String footballBasketballTemplate2 =
    'assets/images/icon/footballBasketballTemplate_2.png';

/// 欧洲杯
const String europeanCup2 = 'assets/images/icon/europeanCup2.png';
const String europeanCup3 = 'assets/images/icon/europeanCup3.png';
const String europeanCup1 = 'assets/images/icon/europeanCup1.png';

/// 底部导航栏
const String mainTab1Night = 'assets/images/icon/main_tab1_night.svg';
const String mainTab1 = 'assets/images/icon/main_tab1.png';
const String mainTab2Night = 'assets/images/icon/main_tab2_night.svg';
const String mainTab2 = 'assets/images/icon/main_tab2.png';
const String mainTab3Night = 'assets/images/icon/main_tab3_night.svg';
const String mainTab3 = 'assets/images/icon/main_tab3.png';
const String mainTab4Night = 'assets/images/icon/main_tab4_night.png';
const String mainTab4 = 'assets/images/icon/main_tab4.png';
const String footballBasketballTemplate1 =
    'assets/images/icon/footballBasketballTemplate_1.png';
const String tab2025 = 'assets/images/icon/tab_2025.png';
const String mainTab5Light = 'assets/images/icon/main_tab5_light.png';
const String mainTab5Night = 'assets/images/icon/main_tab5_night.png';

/// 年报
const String annualReportLogo1 = 'assets/images/nb/annual_report_logo1.png';
const String annualReportClose = 'assets/images/nb/annual_report_close.png';
const String annualReportLogos = 'assets/images/nb/annual_report_logos.gif';
const String nbBg0 = 'assets/images/nb/nb_bg_0.jpg';

/// 球类图标
String getImage(String index, bool isSelected) {
  if (isSelected) {
    return 'assets/images/sport/sportstab_ico_${index.padLeft(2, '0')}_sel.png';
  } else {
    if (Get.isDarkMode) {
      return 'assets/images/sport/sportstab_ico_${index.padLeft(2, '0')}_nor_night.png';
    } else {
      return 'assets/images/sport/sportstab_ico_${index.padLeft(2, '0')}_nor.png';
    }
  }
}
