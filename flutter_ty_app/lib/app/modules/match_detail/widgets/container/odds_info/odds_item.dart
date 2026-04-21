import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_item_util.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp0.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp10.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp11.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp12.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp13.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp14.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp15.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp2.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp3.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp4.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp5.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp51.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp6.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp9.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../global/data_store_controller.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../login/login_head_import.dart';
import '../../../constants/detail_constant.dart';
import '../../../controllers/match_detail_controller.dart';
import 'templates/default_temp.dart';
import 'templates/temp1.dart';
import 'templates/temp18.dart';
import 'templates/temp18_new.dart';
import 'templates/temp7.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-f08af561-1ebf-4a71-9dae-bd0bf80a7e9c 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注列表+赛果列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 详情玩法组件集合】】】
    【【【 AUTOMATIC_GENERATE_DOCUMENT_PARAGRAPH_CONTENT
    详情玩法组件集合
    】】】
 *
 */
class OddsItem extends StatefulWidget {
  const OddsItem({
    super.key,
    required this.item,
    this.tag,
    required this.index,
  });

  final MatchHps item;
  final int index;
  final String? tag;

  @override
  State<OddsItem> createState() => _OddsItemState();
}

class _OddsItemState extends State<OddsItem>
    with SingleTickerProviderStateMixin {
  // 动画控制器
  late final AnimationController _controller;
  late final Animation<double> _animation;
  // 定义动画开始与结束值
  late final Tween<double> _sizeTween;

  // 模板映射：将 hpt 值映射到对应的模板构建函数
  static final Map<int, Widget Function(Map<String, dynamic> params)> _templateMap = {
    0: (params) => Temp0(matchHps: params['matchHps']!, fullscreen: params['fullscreen']!),
    1: (params) => Temp1(
      matchHps: params['matchHps']!,
      isESport: params['isESport']!,
      fullscreen: params['fullscreen']!,
    ),
    2: (params) => Temp2(matchHps: params['matchHps']!, fullscreen: params['fullscreen']!),
    3: (params) => Temp3(
      matchHps: params['matchHps']!,
      isESport: params['isESport']!,
      fullscreen: params['fullscreen']!,
    ),
    4: (params) => Temp4(matchHps: params['matchHps']!, fullscreen: params['fullscreen']!),
    5: (params) => Temp5(matchHps: params['matchHps']!, fullscreen: params['fullscreen']!),
    6: (params) => Temp6(matchHps: params['matchHps']!, fullscreen: params['fullscreen']!),
    7: (params) => Temp7(matchHps: params['matchHps']!, fullscreen: params['fullscreen']!),
    9: (params) => Temp9(matchHps: params['matchHps']!),
    10: (params) => Temp10(matchHps: params['matchHps']!),
    11: (params) => Temp11(matchHps: params['matchHps']!),
    12: (params) => Temp12(matchHps: params['matchHps']!, fullscreen: params['fullscreen']!),
    13: (params) => Temp13(
      matchHps: params['matchHps']!,
      fullscreen: params['fullscreen']!,
      tag: params['tag'],
    ),
    14: (params) => Temp14(matchHps: params['matchHps']!, fullscreen: params['fullscreen']!),
    15: (params) => Temp15(matchHps: params['matchHps']!, fullscreen: params['fullscreen']!),
    18: (params) => Temp18(matchHps: params['matchHps']!, fullscreen: params['fullscreen']!),
    51: (params) => Temp51(
      matchHps: params['matchHps']!,
      isESport: params['isESport']!,
      fullscreen: params['fullscreen']!,
    ),
  };

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _sizeTween = Tween(begin: 0, end: 1);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
      tag: widget.tag,
      id: "hpid_${widget.item.hpid}_${widget.item.topKey}_${widget.item.hid}",
      builder: (controller) {
        final MatchHps item = widget.item;
        final MatchEntity? match = DataStoreController.to.getMatchById(widget.item.mid);

        // 根据默认状态判断是否展开
        _toggleAnimated(item, controller);

        // 赛果详情页不需要检查移除/隐藏逻辑
        final String route = Get.currentRoute;
        final bool shouldShow = route != Routes.matchResultsDetails ||
            (!isRemove(item) && !isHide(item));

        if (!shouldShow) {
          return Container();
        }

        final bool fullscreen = controller.detailState.fullscreen.value;

        return Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.only(
            left: fullscreen ? 5 : 5.w,
            right: fullscreen ? 5 : 5.w,
            bottom: fullscreen ? 8 : 8.w,
          ),
          decoration: _buildContainerDecoration(controller),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 头部：标题区域，可点击展开/收起
              _buildHeader(item, controller, match),
              // 分隔线：只在展开时显示
              if (item.hshow == SHOW_YES) _buildDivider(controller),
              // 内容区域：使用动画展开/收起
              if (item.hshow == SHOW_YES)
                SizeTransition(
                  sizeFactor: _sizeTween.animate(_animation),
                  child: _buildOddWidget(item, controller),
                ),
            ],
          ),
        );
      },
    );
  }

  /// 构建容器装饰
  BoxDecoration _buildContainerDecoration(MatchDetailController controller) {
    final bool fullscreen = controller.detailState.fullscreen.value;

    return BoxDecoration(
      color: fullscreen
          ? Colors.white.withValues(alpha: 0.08)
          : Get.theme.betPanelBackGroundColor,
      borderRadius: BorderRadius.circular(fullscreen ? 8 : 8.r),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 12,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ],
    );
  }

  /// 构建头部组件（标题+图标）
  Widget _buildHeader(MatchHps item, MatchDetailController controller, MatchEntity? match) {
    final bool fullscreen = controller.detailState.fullscreen.value;
    final double titleHeight = fullscreen ? 36 : (isIPad ? 50.h : 36.h);

    return InkWell(
      onTap: () => controller.setHShow(item),
      child: Stack(
        children: [
          // 标题容器
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: fullscreen ? 12 : 12.w,
            ),
            height: titleHeight,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: fullscreen ? 50 : 50.w),
              child: _buildTitleContent(item, match, controller),
            ),
          ),
          // 图标区域（置顶+箭头）
          _buildHeaderIcons(item, controller, titleHeight),
        ],
      ),
    );
  }

  /// 构建标题内容
  Widget _buildTitleContent(MatchHps item, MatchEntity? match, MatchDetailController controller) {
    final bool fullscreen = controller.detailState.fullscreen.value;
    final double fontSize = fullscreen ? 13 : (isIPad ? 18.sp : 13.sp);

    // 角球相关玩法
    if (cornerBall.contains(item.hpid)) {
      return Text(
        item.hpn +
            ((match?.ms ?? 0) != 0 && getMatchHpsScore(item, match).isNotEmpty
                ? "(${getMatchHpsScore(item, match)})"
                : ""),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: fullscreen
              ? Colors.white.withValues(alpha: 0.9)
              : Get.theme.betPanelFontColor,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ),
      );
    }

    // 普通赛事基准分
    return Text(
      (item.hpn == "(null)" ? "" : item.hpn) +
          ((match?.ms ?? 0) != 0 && getMatchHpsScore(item, match).isNotEmpty
              ? "(${getMatchHpsScore(item, match)})"
              : ""),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: fullscreen
            ? Colors.white.withValues(alpha: 0.9)
            : Get.theme.betPanelFontColor,
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
      ),
    );
  }

  /// 构建头部图标区域
  Widget _buildHeaderIcons(MatchHps item, MatchDetailController controller, double height) {
    final bool fullscreen = controller.detailState.fullscreen.value;
    final double iconContainerSize = fullscreen ? 36 : (isIPad ? 50.h : 36.h);
    final double iconSize = fullscreen ? 16 : (isIPad ? 20.w : 16.w);
    final double arrowIconSize = fullscreen ? 12 : (isIPad ? 16.w : 12.w);

    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 置顶图标
          InkWell(
            onTap: () => controller.setHton(item, widget.index),
            child: Container(
              width: iconContainerSize,
              height: iconContainerSize,
              alignment: Alignment.center,
              child: ImageView(
                item.hton != "0"
                    ? Get.isDarkMode
                    ? 'assets/images/detail/list_pintop_sel_night.svg'
                    : 'assets/images/detail/list_pintop_sel.svg'
                    : fullscreen
                    ? 'assets/images/detail/list_pintop_nor_night.svg'
                    : Get.isDarkMode
                    ? 'assets/images/detail/list_pintop_nor_night.svg'
                    : 'assets/images/detail/list_pintop_nor.svg',
                width: iconSize,
                boxFit: BoxFit.cover,
              ),
            ),
          ),
          // 展开/收起箭头图标
          AnimatedRotation(
            duration: const Duration(milliseconds: 200),
            turns: item.hshow == SHOW_YES ? 0 : -0.25,
            child: ImageView(
              fullscreen
                  ? 'assets/images/detail/ico_arrowdown_nor_night.svg'
                  : Get.isDarkMode
                  ? 'assets/images/detail/ico_arrowdown_nor_night.svg'
                  : 'assets/images/detail/ico_arrowdown_nor.svg',
              width: arrowIconSize,
              height: arrowIconSize,
            ),
          ).marginOnly(
            right: fullscreen ? 10 : 10.w,
            left: fullscreen ? 8 : 8.w,
          ),
        ],
      ),
    );
  }

  /// 构建分隔线
  Widget _buildDivider(MatchDetailController controller) {
    final bool fullscreen = controller.detailState.fullscreen.value;

    return Container(
      height: 0.5,
      margin: EdgeInsets.symmetric(
        horizontal: fullscreen ? 8 : 8.w,
      ),
      color: fullscreen
          ? Colors.white.withValues(alpha: 0.08)
          : Get.theme.betPanelUnderlineColor,
    );
  }

  /// 控制动画展开/收起
  void _toggleAnimated(MatchHps item, MatchDetailController controller) {
    // 如果有动画标志，使用动画
    if (controller.detailState.toggleAnimate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleAnimate(item, controller);
      });
    } else {
      // 否则直接设置动画状态
      _setImmediateAnimationState(item);
    }
  }

  /// 处理动画（带异常捕获）
  void _handleAnimate(MatchHps item, MatchDetailController controller) {
    try {
      if (item.hshow == SHOW_YES) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      controller.detailState.toggleAnimate = false;
    } catch (e) {
      AppLogger.debug("oddsItem _toggleAnimated: $e");
    }
  }

  /// 立即设置动画状态（无动画）
  void _setImmediateAnimationState(MatchHps item) {
    _controller.value = item.hshow == SHOW_YES ? 1.0 : 0.0;
  }

  /// 玩法模版 - 根据 hpt 对应模板
  Widget _buildOddWidget(MatchHps item, MatchDetailController controller) {
    final int hpt = item.hpt;
    final bool fullscreen = controller.detailState.fullscreen.value;
    final bool isEsport = controller.detailState.isDJDetail;
    final bool isVrSport = Get.currentRoute == Routes.vrSportDetail;

    // 定义使用默认模板的 hpt 集合
    const defaultTemplates = {0, 1, 2, 3, 4, 5, 6, 7, 13, 14, 15, 16};

    // 判断是否应该使用默认模板
    final shouldUseDefault = defaultTemplates.contains(hpt) ||
        (hpt == 9 && !isVrSport);

    // 特殊处理：hpt=18 使用新模板
    if (hpt == 18) {
      return Temp18New(
        isESport: isEsport,
        matchHps: item,
        fullscreen: fullscreen,
        isDov: controller.detailState.curCategoryTabId == ADDED_ODDS_CATEGORY_ID,
      );
    }

    // 使用默认模板
    if (shouldUseDefault) {
      return DefaultTemp(
        isESport: isEsport,
        matchHps: item,
        fullscreen: fullscreen,
        isDov: controller.detailState.curCategoryTabId == ADDED_ODDS_CATEGORY_ID,
      );
    }

    // 从映射中获取模板构建器
    final templateBuilder = _templateMap[hpt];
    if (templateBuilder != null) {
      return templateBuilder({
        'matchHps': item,
        'fullscreen': fullscreen,
        'isESport': isEsport,
        'tag': widget.tag,
      });
    }

    // 未匹配到任何模板，返回空容器（保持原有逻辑）
    return Container();
  }
}