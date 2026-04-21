
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';


import '../../discount_odd/discount_odd_bean.dart';
import '../../../services/models/res/match_entity.dart';
import '../../discount_odd/widget/added_odds_widget.dart';

class DiscountOddCardList extends StatelessWidget {
  const DiscountOddCardList({
    super.key,
    required this.discountOddBeans,
    required this.controller,
    required this.cardWidth,
    required this.cardMargin,
    required this.maxCount,
    required this.leftArrowUrl,
    required this.rightArrowUrl,
    required this.onScrollLeft,
    required this.onScrollRight,
    required this.onMatchTap,
    required this.onAddBet,
  });

  final List<DiscountOddBean> discountOddBeans;
  final ScrollController controller;
  final double cardWidth;
  final double cardMargin;
  final int maxCount;
  final String leftArrowUrl;
  final String rightArrowUrl;

  final void Function() onScrollLeft;
  final void Function() onScrollRight;
  final void Function(MatchEntity match) onMatchTap;
  final void Function(
      DiscountOddBean discount,
      MatchHpsHlOl ol,
      MatchEntity match,
      ) onAddBet;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115.w,
      child: Stack(
        children: [
          ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            itemCount: discountOddBeans.length > maxCount
                ? maxCount
                : discountOddBeans.length,
            itemBuilder: (context, index) {
              final discount = discountOddBeans[index];
              return _DiscountOddCard(
                discount: discount,
                width: cardWidth,
                margin: cardMargin,
                onMatchTap: onMatchTap,
                onAddBet: onAddBet,
              );
            },
          ),
          if (discountOddBeans.length > 1)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: onScrollLeft,
                child: ImageView(leftArrowUrl, width: 16.w, height: 35.h),
              ),
            ),
          if (discountOddBeans.length > 1)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: onScrollRight,
                child: ImageView(rightArrowUrl, width: 16.w, height: 35.h),
              ),
            ),
        ],
      ),
    );
  }
}

class _DiscountOddCard extends StatelessWidget {
  const _DiscountOddCard({
    required this.discount,
    required this.width,
    required this.margin,
    required this.onMatchTap,
    required this.onAddBet,
  });

  final DiscountOddBean discount;
  final double width;
  final double margin;
  final void Function(MatchEntity match) onMatchTap;
  final void Function(
      DiscountOddBean discount,
      MatchHpsHlOl ol,
      MatchEntity match,
      ) onAddBet;

  @override
  Widget build(BuildContext context) {
    final match = discount.matchEntity;

    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: margin, vertical: 4.w),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: DiscountOddsWidget(
          ol: discount.ol,
          match: match,
          hps: discount.hps,
          hl: discount.hl!,
          fullscreen: false,
          selected: false,
          ishomeList: true,
          status2: 0,
        ),
      ),
    );
  }
}
