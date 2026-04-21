import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/champion/bet_button.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';

import '../../../../../../main.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../match_detail/models/odds_button_enum.dart';
import '../../../../shop_cart/shop_cart_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-547f4052-1479-46be-a032-ebaae676b0c8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 冠军 】】】
    【【【 AUTO_PARAGRAPH_TITLE 冠军页面 item 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 冠军页面 头部组件
    - 冠军页面 投注组件
    】】】
 *
 */
/**
 * 冠军页面 item
 * */
class ChampionItemBodyWidget extends StatelessWidget {
  const ChampionItemBodyWidget({
    super.key,
    required this.matchHps,
    required this.matchEntity,
  });

  final MatchEntity matchEntity;
  final MatchHps matchHps;

  ///样式抽离
  Color _titleColor(BuildContext context) =>
      context.isDarkMode ? Colors.white.withValues(alpha: 0.9) : const Color(0xFF303442);

  Color _subTitleColor(BuildContext context) =>
      context.isDarkMode ? Colors.white.withValues(alpha: 0.3) : const Color(0xFFAFB3C8);

  Color _lineColor(BuildContext context) =>
      context.isDarkMode ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFE4E6F0);

  double _titleFontSize() => isIPad ? 14.sp.scale : 12.sp.scale;

  double _subTitleFontSize() => isIPad ? 12.sp.scale : 10.sp.scale;



  @override
  Widget build(BuildContext context) {
    final width = (Get.width - 26.w - 8.w) / 2;
    final height = TyTextScaler.instance().isScale ? 40.w : 32.w;

    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),

            /// 冠军列表
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: matchHps.ol.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.w,
                crossAxisSpacing: 8.w,
                childAspectRatio: width / height,
              ),
              itemBuilder: (_, index) => _buildGridItem(index, width, height),
            ),

            SizedBox(height: 10.w),
          ],
        ),
      ),
    );
  }


  /// 冠军头部
  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6.h),
      padding: EdgeInsets.only(bottom: 4.w, top: 2.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: _lineColor(context), width: 1),
        ),
      ),
      child: Row(
        children: [
          _buildHeaderText(context),
          const SizedBox(width: 10),
          _buildTimeText(context),
        ],
      ),
    );
  }

  /// 冠军头部玩法
  Widget _buildHeaderText(BuildContext context) {
    return Expanded(
      child: Text(
        matchHps.hps,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: _titleColor(context),
          fontSize: _titleFontSize(),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
  ///冠军开赛时间
  Widget _buildTimeText(BuildContext context) {
    final timestamp = TimeZoneUtils.convertTimeToTimestamp(
      matchHps.hmed,
      isMilliseconds: true,
      returnMilliseconds: true,
    );

    final timeStr = DateUtil.formatDateMs(
      timestamp,
      format: LocaleKeys.time7.tr,
      isUtc: true,
    ) +
        " (${TimeZoneUtils.getTimeZoneString()})" +
        LocaleKeys.match_main_cut_off.tr;

    return Text(
      timeStr,
      textAlign: TextAlign.right,
      style: TextStyle(
        color: _subTitleColor(context),
        fontSize: _subTitleFontSize(),
        fontWeight: FontWeight.w400,
      ),
    );
  }
  
  /// 冠军列表盘口
  Widget _buildGridItem(int index, double width, double height) {
    final ol = matchHps.ol[index];

    return InkWell(
      onTap: () => ShopCartController.to.addBet(
        matchEntity,
        matchHps,
        null,
        ol,
        betType: OddsBetType.guanjun,
      ),
      child: BetButton(
        width: width,
        direction: BetButtonLayoutDirection.horizontal,
        matchHpsHlOl: ol,
      ),
    );
  }
}

