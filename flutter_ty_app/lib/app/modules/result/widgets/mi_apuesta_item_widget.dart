

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../utils/amount_util.dart';


import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import 'package:intl/intl.dart';

import '../../../utils/calcText_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果详情 我的注单 组件  MiApuestaItemWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果详情 我的注单 组件  MiApuestaItemWidget
    - MiApuestaItemWidget
    ```
    ```
    】】】
 *
 */

class MiApuestaItemWidget extends StatelessWidget {
  const MiApuestaItemWidget({
    super.key,
    required this.index,
    required this.isDark,
    required this.miApuestaData,
    required this.onBetIsExpand,
  });

  final int index;
  final bool isDark;
  final List<GetH5OrderListDataRecordxData> miApuestaData;
  final void Function(dynamic, dynamic) onBetIsExpand;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: miApuestaData[index].betIsExpand,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 10.h,
              left: 25.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.app_betting.tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF707070),
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      AmountUtil.toAmountSplit((double.tryParse(
                                  miApuestaData[index]
                                      .orderAmountTotal
                                      .toString()) ??
                              0)
                          .toStringAsFixed(2)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF707070),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.bet_record_go_back.tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF707070),
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      AmountUtil.toAmountSplit(double.parse(
                              miApuestaData[index].backAmount.toString())
                          .toStringAsFixed(2)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF707070),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      getFooterScore(miApuestaData[index]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF707070),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      getFooterText(miApuestaData[index]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF707070),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 10.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        LocaleKeys.bet_order_no.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color:
                              isDark ? Colors.white : const Color(0xFF414655),
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      AutoSizeText(
                        miApuestaData[index].orderNo,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color:
                              isDark ? Colors.white : const Color(0xFF414655),
                          fontSize: 10.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                              text: miApuestaData[index].orderNo));
                          ToastUtils.showGrayBackground(
                              LocaleKeys.bet_record_copy_suc.tr);
                        },
                        child: ImageView(
                          'assets/images/icon/copy.svg',
                          cdn: false,
                          width: 15.w,
                          height: 15.w,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        LocaleKeys.bet_record_bet_time.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color:
                              isDark ? Colors.white : const Color(0xFF414655),
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      AutoSizeText(
                        formatDateTime(int.parse(miApuestaData[index].betTime)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color:
                              isDark ? Colors.white : const Color(0xFF414655),
                          fontSize: 10.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('MM/dd HH:mm');
    return formatter.format(date);
  }
}
