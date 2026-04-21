import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';

import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/cp/extensions/cp_ticket_cate_entity_extensions.dart';
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';
import 'package:flutter_ty_app/app/modules/cp/widget/common_combined_rolling.dart';
import 'package:flutter_ty_app/app/modules/cp/widget/cp_ticket_card_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/cp_ticket_cate_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import '../../../../main.dart';


class CpOtherTicketView extends StatelessWidget {
  const CpOtherTicketView({
    super.key,
    required this.totalTicketCount,
    required this.cateList,
    required this.onTicketTap,
    required this.onToggleTicketCollect,
  });

  final num totalTicketCount;
  final List<CpTicketCateEntity> cateList;
  final ValueChanged<CpTicketCateList> onTicketTap;
  final ValueChanged<CpTicketCateList> onToggleTicketCollect;

  @override
  Widget build(BuildContext context) {
    return CommonCombinedRolling(
      tabs: cateList,
      space: CpState.otherTicketSpace,
      initialSelTabIndex: 0,
      leftFlex: isIPad ? CpState.otherTicketLeftFlexIPad : CpState.otherTicketLeftFlexMobile,
      leftDecoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.r),
        ),
        color: Get.isDarkMode
            ? CpState.otherTicketLeftBgColorDark
            : AppColor.colorWhite,
      ),
      leftTopWidgetBuilder: () {
        return Container(
          height: CpState.otherTicketLeftHeaderHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: CpState.otherTicketLeftHeaderBorderWidth,
                color: Get.isDarkMode
                    ? CpState.otherTicketLeftHeaderBorderColorDark
                    : CpState.otherTicketLeftHeaderBorderColorLight,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            '${LocaleKeys.zr_cp_top_navigation_bar_all.tr}(' + totalTicketCount.toString() + '${LocaleKeys.zr_cp_bet_Window_type.tr})',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Get.isDarkMode
                  ? CpState.otherTicketLeftHeaderTextColorDark
                  : CpState.otherTicketLeftHeaderTextColorLight,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
      leftTabBuilder: (tabIndex, isSelected) {
        final cate = cateList[tabIndex];
        final isSel = isSelected;
        return _buildLeftTabItem(isSel, cate);
      },
      rightGridViewVPadding: CpState.otherTicketRightVPadding,
      rightSectionHeaderBuilder: (tabIndex) {
        if (tabIndex <= 0) return const SizedBox();
        return Divider(
          color: context.isDarkMode
              ? CpState.otherTicketDividerColorDark
              : CpState.otherTicketDividerColorLight,
          height: CpState.otherTicketDividerHeight,
        );
      },
      rightGridCrossAxisSpacing: CpState.gameGridCrossAxisSpacing,
      rightGridMainAxisSpacing: CpState.gameGridMainAxisSpacing,
      rightItemBuilder: (tabIndex, itemIndex) {
        final showTicketList = cateList[tabIndex].list;
        if (itemIndex > showTicketList.length) {
          return const SizedBox();
        }
        final ticket = showTicketList[itemIndex];
        return CpTicketCardWidget(
          onTicketTap: onTicketTap,
          ticket: ticket,
          onTicketCollectTap: onToggleTicketCollect,
        );
      },
      rightDatasGetter: (tabIndex) {
        final showTicketList = cateList[tabIndex].list;
        return showTicketList;
      },
    );
  }
  // 左侧tab选择样式
  Widget _buildLeftTabItem(bool isSel, CpTicketCateEntity cate) {
    return Container(
      height: CpState.otherTicketLeftHeaderHeight,
      decoration: isSel
          ? BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: (Get.isDarkMode ? CpState.otherTicketLeftSelBorderColorDark : CpState.otherTicketLeftSelBorderColorLight),
                  width: CpState.otherTicketLeftSelBorderWidth,
                ),
              ),
            )
          : null,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          ImageView(
            cate.cpCateIconPath(isSel, Get.isDarkMode),
            width: CpState.otherTicketLeftIconSize,
            height: CpState.otherTicketLeftIconSize,
          ),
          SizedBox(width: 4.w),
          Text(
            cate.localeName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Get.isDarkMode
                  ? (isSel ? CpState.otherTicketLeftSelTextColorDark :  CpState.otherTicketLeftUnselTextColorDark ):
              (isSel ? CpState.otherTicketLeftSelTextColorLight : CpState.otherTicketLeftUnselTextColorLight),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: isSel ? FontWeight.w500 : FontWeight.w400,
            ),
          ).flexible(),
        ],
      ),
    );
  }
}
