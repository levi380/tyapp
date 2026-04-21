import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/discount_odd/discount_odd_page_ext.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/switch_button.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/change_skin_tone_color_util.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'dart:math';
import '../../config/analytic/analytics_utils.dart';
import '../../widgets/loading.dart';
import '../../widgets/empty/no_data.dart';
import 'controllers/discount_odd_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 增值赔率】】】
    【【【 AUTO_PARAGRAPH_TITLE 增值赔率】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 增值赔率Page
    】】】
 *
 */

///优惠赔率单独页
class DiscountOddPage extends StatelessWidget {
  const DiscountOddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscountOddController>(
      builder: (controller) {
        List<MatchEntity> matchDiscount = controller.state.matchtDiscount;
        String title = getName(matchDiscount);
        Set<String> foldSet = DiscountOddController.to.state.foldList;

        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
                  : const Color(0xfff2f2f6),
            ),
            child: Column(
              children: [
                _buildHeader(context, controller),
                Expanded(
                  child: _buildBody(context, controller, title, foldSet),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 顶部导航  包含返回按钮、标题、切换开关、刷新按钮
  Widget _buildHeader(BuildContext context, DiscountOddController controller) {
    return Container(
      color: context.isDarkMode ? Colors.transparent : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// 返回按钮
          GestureDetector(
            onTap: Get.back,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
              padding: EdgeInsets.all(12.w),
              child: ImageView(
                "assets/images/detail/icon_arrowleft_nor_night.svg",
                boxFit: BoxFit.fill,
                width: 8.w,
                svgColor: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),

          /// 页面标题
          Expanded(
            child: Text(
              LocaleKeys.discount_odd_odds_value_increase.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                fontFamily: 'PingFang SC',
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.9)
                    : const Color(0xff303442),
              ),
            ),
          ),

          /// 热门/时间切换开关
          Obx(
                () => SwitchButton(
              hasIcon: true,
              value: controller.state.isHot.value,
              onChild: Text(
                LocaleKeys.footer_menu_hot.tr,
                style: const TextStyle(fontWeight: FontWeight.w500, height: 1.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              offChild: Text(
                LocaleKeys.footer_menu_time.tr,
                style: const TextStyle(fontWeight: FontWeight.w500, height: 1.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onChanged: (value) {
                controller.state.isHot.value = value;
                BoolKV.sort.save(value);
                controller.getData(isFrist: true);
              },
            ),
          ),

          /// 刷新按钮
          GestureDetector(
            onTap: controller.iconRefresh,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
              padding: EdgeInsets.all(12.w),
              child: RotationTransition(
                turns: Tween(begin: 0.2, end: 1.2).animate(controller.state.animationController),
                child: ImageView(
                  'assets/images/icon/refresh.png',
                  boxFit: BoxFit.fill,
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.5)
                      : Colors.black.withValues(alpha: 0.3),
                  width: 20.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
      BuildContext context,
      DiscountOddController controller,
      String title,
      Set<String> foldSet,
      ) {
    /// 页面状态判断：
    /// 加载中 / 空数据 / 正常显示
    if (controller.state.needReload) {
      return const Loading(backHeader: false);
    } else if (controller.state.isEmptyTimer > 2) {
      return NoData(
        content: LocaleKeys.analysis_football_matches_no_data.tr,
        backHeader: false,
      );
    } else {
      return Column(
        children: [
          Container(height: 1, width: double.maxFinite, color: const Color(0xffFEAE2C)),
          _buildFilterBar(context, controller, title, foldSet), // 联赛折叠与展开
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              controller: controller.state.scrollController,
              itemCount: controller.state.matchtDiscountMerge.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return _buildLeagueItem(
                  context,
                  controller,
                  controller.state.matchtDiscountMerge[index],
                  foldSet,
                  index == 0 ? title : null,
                );
              },
            ),
          ),
        ],
      );
    }
  }

  /// 联赛折叠/展开条
  Widget _buildFilterBar(
      BuildContext context,
      DiscountOddController controller,
      String title,
      Set<String> foldSet,
      ) {
    return Container(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.w),
      color: context.isDarkMode ? Colors.white.withValues(alpha: 0.04) : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageView('assets/images/icon/icon_date.png', width: 18.w, height: 18.w),
              SizedBox(width: 5.w),
              Text(
                LocaleKeys.filter_all_leagues.tr,
                style: TextStyle(
                  color: context.isDarkMode ? Colors.white : const Color(0xFF303442),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Obx(() {
            if (!ConfigController.to.accessConfig.value.tourSwitch) return SizedBox(width: 24.w);

            return GestureDetector(
              onTap: () {
                controller.state.isExpand.value = !controller.state.isExpand.value;
                if (controller.state.isExpand.value) {
                  foldSet.clear();
                } else {
                  controller.state.matchtDiscount.forEach((match) => foldSet.add(match.tid));
                }
                DiscountOddController.to.update();
                ///埋点
                Analytics.handleHpidTracking("tab_odds_boost");
              },
              child: Container(
                height: 20.w,
                margin: EdgeInsets.only(right: 20.w),
                decoration: ShapeDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.04)
                      : const Color(0xFFF8F9FA),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.state.isExpand.value
                          ? LocaleKeys.tips_close.tr
                          : LocaleKeys.tips_expand.tr,
                      style: TextStyle(
                        color: context.isDarkMode ? Colors.white.withValues(alpha: 0.4) : const Color(0xFF949AB6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Transform.rotate(
                      angle: controller.state.isExpand.value ? 0 : -pi / 2,
                      child: ImageView(
                        context.isDarkMode
                            ? 'assets/images/league/tips_expand_dark.png'
                            : 'assets/images/league/tips_expand_light.png',
                        width: 10.w,
                        height: 10.w,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 单个联赛条目
  Widget _buildLeagueItem(
      BuildContext context,
      DiscountOddController controller,
      List<MatchEntity> matchEntityList,
      Set<String> foldSet,
      String? title,
      ) {
    MatchEntity matchEntity = matchEntityList.first;

    /// 玩法总数
    String totalHpsCount = controller.state.matchtDiscountMerge
        .map((list) => list.length)
        .fold(0, (sum, len) => sum + len)
        .toString();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.w, horizontal: 8.w),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.white.withValues(alpha: 0.04) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          width: 1.w,
          color: context.isDarkMode ? Colors.white.withValues(alpha: 0.04) : Colors.white,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 显示标题（只第一个会显示）
          if (title != null)
            Container(
              color: context.isDarkMode ? null : const Color(0xfff2f2f6),
              height: 20.w,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                '$title($totalHpsCount)',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: context.isDarkMode ? Colors.white.withValues(alpha: 0.5) : const Color(0xff7981A4),
                ),
              ),
            ),

          /// 联赛头部
          InkWell(
            onTap: () {
              if (foldSet.contains(matchEntity.tid)) {
                foldSet.remove(matchEntity.tid);
              } else {
                foldSet.add(matchEntity.tid);
              }
              DiscountOddController.to.update();
            },
            child: _buildLeagueHeader(context, matchEntity, foldSet),
          ),

          /// 赛事列表
          ...matchEntityList.map((match) => buildMatch(match, context)).toList(),
        ],
      ),
    );
  }

  /// 联赛条目 (展开/收起）
  Widget _buildLeagueHeader(BuildContext context, MatchEntity matchEntity, Set<String> foldSet) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.w),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(width: 2.w, height: 12.w, decoration: const BoxDecoration(color: Color(0xff179CFF))),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              matchEntity.tn,
              style: TextStyle(
                fontSize: 12.sp,
                color: context.isDarkMode ? Colors.white.withValues(alpha: 0.9) : const Color(0xff303442),
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 4),
          Visibility(
            visible: foldSet.contains(matchEntity.tid),
            child: Text(
              matchEntity.tid,
              style: TextStyle(
                fontSize: 12.sp,
                color: context.isDarkMode ? Colors.white.withValues(alpha: 0.9) : const Color(0xff303442),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          ImageView(
            foldSet.contains(matchEntity.tid)
                ? 'assets/images/league/ico_arrowright_nor.png'
                : 'assets/images/league/item_expand.png',
            width: 12.w,
          ),
        ],
      ),
    );
  }
}

