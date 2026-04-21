import '../../../../main.dart';
import '../../../extension/num_extension.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../utils/ty_text_scaler.dart';
import '../../../utils/utils.dart';
import '../../../utils/vr_rank_icon_utils.dart';
import '../../login/login_head_import.dart';
import '../../shop_cart/shop_cart_theme.dart';
import '../../shop_cart/shop_cart_util.dart';
import '../quick_bet_controller.dart';
import 'bet_detail_info.dart';
import 'bet_wait_animate.dart';

class QuickBetItem extends StatelessWidget {
  const QuickBetItem({super.key, required this.item, required this.controller});

  final BetResultOrderDetailRespList item;
  final QuickBetController controller;

  @override
  Widget build(BuildContext context) {
    bool hasMarketValue = false;
    // 使用投注前的数据 大小盘口item.handicap可能为空 故使用item.oldPlayOptionName
    String newPlayOptionName =
        item.handicap.isNotEmpty ? item.handicap : item.oldPlayOptionName;
    if (item.oldHandicapHv.isNotEmpty &&
        newPlayOptionName != item.oldHandicapHv) {
      hasMarketValue = true;
      newPlayOptionName = newPlayOptionName
          .replaceFirst(
              RegExp(r'\b' + RegExp.escape(item.oldHandicapHv) + r'$'), '')
          .trim();
    }

    String firstText = newPlayOptionName;
    double maxWidth = hasMarketValue
        ? controller.fullscreen.value
            ? (isIPad ? 110 : 55)
            : (isIPad
                ? 110.w
                : dbContainsChinese(firstText) // 英文更长，中文短
                    ? 55.w
                    : 35.w)
        : controller.fullscreen.value
            ? (isIPad ? 130 : 64)
            : (isIPad ? 130.w : 64.w);
    TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: firstText,
          style: TextStyle(
            fontSize: controller.fullscreen.value
                ? (isIPad ? 14 : 12)
                : (isIPad ? 14.sp.scale : 12.sp.scale),
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          )),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: maxWidth); // 设置最大宽度

    // 安卓部分手机中文省略号在中间，截取字符串添加...让他在下面
    if ((textPainter.didExceedMaxLines || textPainter.size.width >= maxWidth) &&
        dbContainsChinese(firstText)) {
      if (hasMarketValue) {
        firstText = firstText.substring(0, 2).trim() + "...";
      } else if (firstText.length > 4) {
        firstText = firstText.substring(0, 4).trim() + "...";
      } else {
        firstText += "...";
      }
    }
    return Column(
      children: [
        InkWell(
          onTap: () {
            controller.expandItem(item);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: controller.fullscreen.value ? 8 : 8.h,
                horizontal: controller.fullscreen.value ? 8 : 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if ([Routes.vrSportDetail, Routes.vrHomePage]
                            .contains(Get.currentRoute) &&
                        ShopCartUtilHandicap.isVrRankHandicap(
                            item.sportId, item.playId))
                      _buildVrHandicap(item.sportId, item)
                    else
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: maxWidth,
                        ),
                        child: Text(
                          firstText,
                          maxLines: 1,
                          overflow: dbContainsChinese(firstText)
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                          style: TextStyle(
                            color:
                                (controller.fullscreen.value || Get.isDarkMode)
                                    ? Colors.white.withValues(alpha: 0.8)
                                    : const Color(0xFFAFB3C8),
                            fontSize: controller.fullscreen.value
                                ? (isIPad ? 14 : 12)
                                : (isIPad ? 14.sp.scale : 12.sp.scale),
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                          // strutStyle: isIPad
                          //     ? null
                          //     : const StrutStyle(forceStrutHeight: true, height: 1.2),
                        ),
                      ),
                    if (hasMarketValue &&
                        !([Routes.vrSportDetail, Routes.vrHomePage]
                                .contains(Get.currentRoute) &&
                            ShopCartUtilHandicap.isVrRankHandicap(
                                item.sportId, item.playId)))
                      Text(
                        item.oldHandicapHv,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          // color: Colors.white.withValues(alpha:0.9),
                          color: (controller.fullscreen.value || Get.isDarkMode)
                              ? Colors.white.withValues(alpha: 0.3)
                              : const Color(0xFFAFB3C8),
                          fontSize: controller.fullscreen.value
                              ? (isIPad ? 16 : 14)
                              : (isIPad ? 16.sp.scale : 14.sp.scale),
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                        // strutStyle: isIPad
                        //     ? null
                        //     : const StrutStyle(forceStrutHeight: true, height: 1),
                      ).marginOnly(
                          left: controller.fullscreen.value
                              ? (isIPad ? 4 : 2)
                              : (isIPad ? 4.w : 2.w)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (item.orgOddFinally.isNotEmpty)
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '@',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: controller.fullscreen.value
                                    ? (isIPad ? 14 : 14)
                                    : (isIPad ? 14.sp.scale : 14.sp.scale),
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            WidgetSpan(
                              child: SizedBox(width: 2),
                            ),
                            TextSpan(
                              text: item.orgOddFinally,
                              style: TextStyle(
                                color: Get.theme.shopcartDiscountOddsColor,
                                fontSize: controller.fullscreen.value
                                    ? 16
                                    : 16.sp.scale,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.lineThrough, // 添加中划线
                              ),
                            ),
                            WidgetSpan(
                              child: SizedBox(width: 2),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: ImageView(
                                "assets/images/discount_odd/arrow_right.png",
                                width: 10,
                              ),
                            ),
                            TextSpan(
                              text: item.oddsValues,
                              style: TextStyle(
                                color: const Color(0xFF127DCC),
                                fontSize: controller.fullscreen.value
                                    ? 16
                                    : 16.sp.scale,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            WidgetSpan(
                              child: SizedBox(width: 2),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: ImageView(
                                "assets/images/icon/up.png",
                                width: 14.w,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '@',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: controller.fullscreen.value
                                  ? (isIPad ? 14 : 14)
                                  : (isIPad ? 14.sp.scale : 14.sp.scale),
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                            ),
                            strutStyle: isIPad ||
                                    TyTextScaler.instance().textScaleFactor != 1
                                ? null
                                : const StrutStyle(
                                    forceStrutHeight: true, height: 0.9),
                          ),
                          SizedBox(
                              width: controller.fullscreen.value ? 2 : 2.w),
                          Text(
                            item.oddsValues,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: controller.fullscreen.value
                                  ? 16
                                  : 16.sp.scale,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(width: controller.fullscreen.value ? 8 : 8.w),

                    /// 一键投注 弹框状态   订单状态 0:投注失败 1: 投注成功 2: 订单确认中
                    if (item.orderStatusCode == 2)
                      BetWaitAnimate(
                        child: ImageView(
                          'assets/images/quick_bet/quick-bet-wait.svg',
                          width: 16,
                        ),
                      ).marginOnly(bottom: 1.h)
                    else
                      ImageView(
                        item.orderStatusCode == 1
                            ? 'assets/images/quick_bet/quick-bet-success.svg'
                            : item.orderStatusCode == 2
                                ? 'assets/images/quick_bet/quick-bet-wait.svg'
                                : 'assets/images/quick_bet/quick-bet-fail.svg',
                        width: 16,
                      ).marginOnly(bottom: 1.h),
                  ],
                ),
              ],
            ),
          ),
        ),
        // 投注展开详情
        // AnimatedCrossFade(
        //   duration: const Duration(milliseconds: 300),
        //   crossFadeState: controller.expandOrderNo == item.orderNo
        //       ? CrossFadeState.showSecond
        //       : CrossFadeState.showFirst,
        //   firstChild: const SizedBox.shrink(), // 收起状态
        //   secondChild: BetDetailInfo(item: item), // 展开状态
        // )
        if (controller.expandOrderNo == item.orderNo) BetDetailInfo(item: item),
      ],
    );
  }

  Widget _buildVrHandicap(String csid, BetResultOrderDetailRespList item) {
    List<String> handicapHvArray = item.playOptionName.split('/');
    if (handicapHvArray.length == 1) {
      handicapHvArray = [item.oldHandicapHv];
    }
    final handicapArray = item.handicap.split(',');
    List<Widget> handicapList = [];
    for (int i = 0; i < handicapArray.length; i++) {
      final text = handicapArray[i];
      String hv = '';
      if (i < handicapHvArray.length) {
        hv = handicapHvArray[i];
      }

      ///公共获取vr赛狗 vr赛马 vr摩托车 vr泥地摩托车 图标 公共方法
      String icon = VrRankIconUtils.getRankIcon(
          int.tryParse(csid) ?? 1002, hv.toString());
      if (icon.isEmpty) {
        icon = 'assets/images/vr/vr_dog_horse_rank${hv}.png';
      }
      handicapList.add(Row(
        children: [
          if (hv.isNotEmpty)
            ImageView(
              icon,
              width: 16.w,
            ),
          SizedBox(width: 2.w),
          Container(
            constraints: BoxConstraints(
              maxWidth: controller.fullscreen.value
                  ? (isIPad ? 130 : 50)
                  : (isIPad ? 130.w : 50.w),
            ),
            child: Text(
              text,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: (controller.fullscreen.value || Get.isDarkMode)
                    ? Colors.white.withValues(alpha: 0.3)
                    : const Color(0xFFAFB3C8),
                fontSize: controller.fullscreen.value
                    ? (isIPad ? 14 : 12)
                    : (isIPad ? 14.sp.scale : 12.sp.scale),
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: handicapList,
    );
  }
}
