import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

///VR体育-状态与UI常量集中管理
///直接是通过 ---VRSportState 调用，避免在各组件中写死
class VRSportState {
  /// 背景-暗色图片
  static const String vrBgDark = 'assets/images/detail/bg-dark.png';

  /// 列表-内边距
  static const int listPaddingH = 5; // 水平
  static const int listPaddingBottom = 30; // 底部

  /// 无数据/网络失败 页面顶部间距
  static const int noDataTop = 70;

  /// 浮动按钮尺寸与颜色
  static const int floatBtnSize = 50;
  static const Color floatBtnDarkColor = Color(0xE5181A21);
  static const Color floatBtnLightColor = Color(0xFFFFFAFA);
  static const int floatBtnMarginTop = 5;
  static const int floatBtnMarginBottom = 5;
  static const String floatBtnInnerImg =
      'assets/images/icon/footballBasketballTemplate_2.png';
  static const int floatBtnInnerWidth = 33;
  static const int floatBtnInnerHeight = 26;

  /// 足球篮球专题入口-漂浮入口尺寸与左右按钮
  static const int specialEntrySize = 52;
  static const String specialPrevIcon =
      'assets/images/icon/footballBasketballTemplate_5.png';
  static const String specialNextIcon =
      'assets/images/icon/footballBasketballTemplate_4.png';

  /// 底部导航栏图标
  static const String bottomTab1Dark = 'assets/images/icon/main_tab1_night.svg';
  static const String bottomTab1Light = 'assets/images/icon/main_tab1.png';
  static const String bottomTab2Dark = 'assets/images/icon/main_tab2_night.svg';
  static const String bottomTab2Light = 'assets/images/icon/main_tab2.png';
  static const String bottomTab3Dark = 'assets/images/icon/main_tab3_night.svg';
  static const String bottomTab3Light = 'assets/images/icon/main_tab3.png';
  static const String bottomTab4Dark = 'assets/images/icon/main_tab4_night.png';
  static const String bottomTab4Light = 'assets/images/icon/main_tab4.png';
  static const String bottomTab5Dark = 'assets/images/icon/main_tab5_night.svg';
  static const String bottomTab5Light = 'assets/images/icon/main_tab5.png';
  static const String bottomCenterIcon =
      'assets/images/icon/footballBasketballTemplate_1.png';

  /// 通用展开/收起提示图
  static const String tipsExpandDark =
      'assets/images/league/tips_expand_dark.png';
  static const String tipsExpandLight =
      'assets/images/league/tips_expand_light.png';
  static const String iconAll = 'assets/images/league/icon_all.svg';

  /// 通用默认球队icon
  static const String defaultTeamLogo = 'assets/images/detail/team_s_l.png';

  /// 默认主队球队icon
  static const String defaultTeamHomeSvg =
      'assets/images/detail/default_team_home.svg';

  /// 默认客队队球队icon
  static const String defaultTeamAwaySvg =
      'assets/images/detail/default_team_away.svg';

  /// VR方向箭头
  static const String vrArrowRight = 'assets/images/vr/icon_arrowright_nor.png';

  /// 视频播放器图标
  static const String videoMute = 'assets/images/vr/video_mute.svg';
  static const String videoVolume = 'assets/images/vr/video_volume.svg';

  /// 余额图标
  static const String currencyUSDT =
      'assets/images/home/icon_trans_nor_USDT.svg';
  static const String currencyRMB = 'assets/images/home/icon_trans_nor_RMB.svg';

  /// 竞赛详情顶部背景
  static const String competitionDetailTopBg =
      'assets/images/vr/vr_competition_detail_top_bg.png';

  /// 排名（1/2/3）
  static String betRecordBadgeSvg(int rank) =>
      'assets/images/vr/bet_record_NO.$rank.svg';
  static String betRecordBadgePng(int rank) =>
      'assets/images/vr/bet_record_NO.$rank.png';

  /// 狗马排行图标
  static String dogHorseRankIcon(int index) =>
      'assets/images/vr/vr_dog_horse_rank$index.png';

  /// VS图标
  static const String vrVsIcon = 'assets/images/vr/vr_vs.svg';

  /// 锁盘
  static const String matchIconLock =
      'assets/images/detail/match-icon-lock.svg';

  /// 通用圆角
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;

  /// 通用文字大小
  static const int fontSmall = 12;
  static const int fontMedium = 14;
  static const int fontLarge = 18;

  /// 通用透明度（0~1）
  static const double alphaWeak = 0.04;
  static const double alphaNormal = 0.5;
  static const double alphaStrong = 0.9;

  /// 小组件封装：暗色背景层
  /// 统一VR页面暗色背景展示
  static Widget darkBackground() {
    return const ImageView(
      vrBgDark,
      width: double.infinity,
      height: double.infinity,
      boxFit: BoxFit.cover,
    );
  }

  /// 小组件封装：圆形浮动入口按钮（足球篮球专题）
  static Widget floatingSpecialButton({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: floatBtnSize.w,
        height: floatBtnSize.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Get.isDarkMode ? floatBtnDarkColor : floatBtnLightColor,
        ),
        child: Container(
          margin: EdgeInsets.only(
              top: floatBtnMarginTop.h, bottom: floatBtnMarginBottom.h),
          child: ImageView(
            floatBtnInnerImg,
            width: floatBtnInnerWidth.w,
            height: floatBtnInnerHeight.w,
          ),
        ),
      ),
    );
  }
}
