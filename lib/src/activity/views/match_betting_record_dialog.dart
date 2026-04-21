import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/activity_apply_model.dart';
import 'package:filbet/src/activity/model/promo_report_model.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MatchBettingRecordDialog extends StatelessWidget {
  const MatchBettingRecordDialog({
    super.key,
    required this.models,
  });

  final List<PromoReportModel> models;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.only(bottom: 20.r),
            decoration: BoxDecoration(
              color: appnewColors.bg1,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 48.r,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.r),
                      child: Text(
                        '申请记录',
                        style: TextStyle(
                          color: appnewColors.textMain,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 48.r,
                        height: 48.r,
                        alignment: Alignment.center,
                        child: Image.asset(
                          Assets.popupClose,
                          width: 16.r,
                          height: 16.r,
                          color: appnewColors.textMain,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: appnewColors.colorLine2, width: 1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Table(
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: appnewColors.bgGray2,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12.r),
                          ),
                        ),
                        children: [
                          Container(
                            height: 32.r,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: appnewColors.colorLine2,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Text(
                              '申请时间',
                              style: TextStyle(
                                color: appnewColors.textMain,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 32.r,
                            alignment: Alignment.center,
                            child: Text(
                              '申请状态',
                              style: TextStyle(
                                color: appnewColors.textMain,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...models.map((value) {
                        return TableRow(
                          children: [
                            Container(
                              height: 32.r,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: appnewColors.colorLine2,
                                    width: 1,
                                  ),
                                  right: BorderSide(
                                    color: appnewColors.colorLine2,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                formatDateTimeToString(
                                    DateTime.fromMillisecondsSinceEpoch((value.createdAt ?? 0).toInt())),
                                style: TextStyle(
                                  color: appnewColors.textMain,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            Container(
                              height: 32.r,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: appnewColors.colorLine2,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                _statusText(value.payoutStatus ?? 0),
                                style: TextStyle(
                                  color: appnewColors.textMain,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
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

  String _statusText(int status) {
    switch (status) {
      case 1:
        return '申请成功';
      case 2:
        return '中奖';
      case 3:
        return '未中奖';
      default:
        return '-';
    }
  }
}
