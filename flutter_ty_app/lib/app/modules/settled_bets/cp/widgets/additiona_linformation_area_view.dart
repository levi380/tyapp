import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../../services/models/res/cp_order_list_entity.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 追号记录列表详情视图层Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能，是一个用于展示额外信息的无状态组件，主要用于显示有关投注的详细信息。该组件根据传入的 `settled` 状态和 `data` 对象动态更新显示内容。
    - 属性
    - data: 类型为 `CpOrderListList`，包含投注相关的信息。
    - settled: 类型为 `int`，表示结算状态（0 表示未结算）。
    -getInformation1()
    - 描述: 根据 `settled` 状态返回相应的信息。
    - 返回: 字符串，表示信息1。
    - getInformation2()
    - 描述: 根据 `settled` 状态返回相应的信息。
    - 返回: 字符串，表示信息2。
    - getInformation3()
    - 描述: 根据 `settled` 状态返回相应的信息。
    - 返回: 字符串，表示信息3。
    】】】
 *
 */
class AdditionalInformationAreaView extends StatelessWidget {
  const AdditionalInformationAreaView({
    Key? key,
    required this.data,
    required this.settled,
  }) : super(key: key);
  final CpOrderListList data;
  final int settled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      decoration: ShapeDecoration(
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.03999999910593033)
            : const Color(0xFFF2F2F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.r,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getInformation1(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442),
                  fontSize: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w600,
                ),
              ).marginOnly(
                left: 10.w,
              ),
              //  SizedBox(width: 10.w),
              Text(
                getInformation2(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442),
                  fontSize: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            getInformation3(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.8999999761581421)
                  : const Color(0xFF303442),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
            ),
          ).marginOnly(
            top: 8.h,
          ),
          if (settled == 0)
            Text(
              LocaleKeys.zr_cp_Lottery_Bet_Slips_total_winning.tr +
                  data.winAmountPlanNoCount.toString() +
                  LocaleKeys.zr_cp_Lottery_Bet_Slips_period.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.5)
                    : const Color(0xFF7981A3),
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ).marginOnly(
              top: 8.h,
            ),
        ],
      ),
    );
  }

  String getInformation1() {
    String information1 = "";
    if (settled == 0) {
      information1 = data.ticketName;
    } else {
      information1 = data.finishPlanNoCount.toString() +
          LocaleKeys.zr_cp_Lottery_Bet_Slips_period.tr;
    }
    return information1;
  }

  String getInformation2() {
    String getInformation2 = "";
    if (settled == 0) {
      getInformation2 = data.totalPlanNoCount.toString() +
          LocaleKeys.zr_cp_Lottery_Bet_Slips_period.tr;
    } else {
      getInformation2 = data.playLevel;
    }
    return getInformation2;
  }

  String getInformation3() {
    String getInformation2 = "";
    if (settled == 0) {
      getInformation2 = data.playLevel;
    } else {
      getInformation2 = data.ticketName;
    }
    return getInformation2;
  }
}
