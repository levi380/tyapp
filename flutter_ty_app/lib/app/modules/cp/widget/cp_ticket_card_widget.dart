import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/modules/cp/extensions/cp_ticket_entity_extensions.dart';
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';
import 'package:flutter_ty_app/app/services/models/res/cp_ticket_cate_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class CpTicketCardWidget extends StatelessWidget {
  const CpTicketCardWidget({
    super.key,
    required this.onTicketTap,
    required this.ticket,
    required this.onTicketCollectTap,
  });

  final ValueChanged<CpTicketCateList> onTicketTap;
  final CpTicketCateList ticket;
  final ValueChanged<CpTicketCateList> onTicketCollectTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTicketTap(ticket),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CpState.ticketCardShadowColor,
              blurRadius: CpState.ticketCardBlurRadius,
              offset: CpState.ticketCardShadowOffset,
            ),
          ],
          borderRadius: BorderRadius.circular(8.r),
          color: Get.isDarkMode
              ? CpState.ticketCardBgColorDark
              : AppColor.colorWhite,
        ),
        child: Stack(
          children: [
            ImageView(
              ticket.cpTicketBgPath(Get.isDarkMode),
              boxFit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),


           Container(
             padding: EdgeInsets.only(left:CpState.ticketCardPadding,top:CpState.ticketCardPadding,right: CpState.ticketCardPadding),

             child:  Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   ticket.ticketName,
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                     height: 1,
                     wordSpacing: 0.1,
                     fontSize: CpState.ticketNameSize,
                     fontWeight: FontWeight.w500,
                     fontFamily: 'PingFang SC',
                     color: Get.isDarkMode
                         ? CpState.ticketNameColorDark
                         : CpState.ticketNameColorLight,
                   ),
                 ),
                 SizedBox(height: 2.w),
                 SizedBox(
                   width: isIPad ? CpState.ticketDescWidthIPad : CpState.ticketDescWidthMobile,
                   child: Text(
                     ticket.desc.tr,
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                     style: TextStyle(
                       fontSize: CpState.ticketDescSize,
                       height: CpState.ticketDescHeight,
                       fontWeight: FontWeight.w400,
                       fontFamily: 'PingFang SC',
                       color: Get.isDarkMode
                           ?  CpState.ticketDescColorDark
                           : CpState.ticketDescColorLight,
                     ),
                   ),
                 ),
               ],
             ),
           ),

            Positioned(
              left: 0,
              bottom:isIPad ? CpState.ticketCollectBottomIPad : CpState.ticketCollectBottomMobile,
              child: InkWell(
                onTap: () => onTicketCollectTap(ticket),
                child: Padding(
                  padding: EdgeInsets.all(CpState.ticketCollectPadding).copyWith(bottom: CpState.ticketCollectPaddingBottom),
                  child: ImageView(
                    Get.isDarkMode
                        ? ticket.isCollect
                        ? CpState.ticketFavSelNight
                        : CpState.ticketFavNorNight
                        : ticket.isCollect
                        ? CpState.ticketFavSelDay
                        : CpState.ticketFavNorDay,
                    width: CpState.favIconSize,
                    height: CpState.favIconSize,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
