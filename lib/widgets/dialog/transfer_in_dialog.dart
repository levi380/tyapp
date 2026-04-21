import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/dialog/dialog_kfview.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/vip/models/resp_vip_rate_detail.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TransferInDialog extends StatelessWidget {
  const TransferInDialog(this.existingTurnover, {super.key});

  final num existingTurnover;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.r),
        decoration: BoxDecoration(
          color: appnewColors.bg1,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleView(),
            contentView(),
            bottomView(),
          ],
        ),
      ),
    );
  }

  Widget titleView() {
    return Container(
      height: 48.r,
      margin: EdgeInsets.only(top: 10.r),
      alignment: Alignment.center,
      child: Text(
        '转入金额',
        style: TextStyle(
          color: appnewColors.textMain,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget contentView() {
    return Container(
      margin: EdgeInsets.only(top: 10.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.r),
            child: RichText(
              text: TextSpan(
                text: '您正在参与活动,场馆锁定中,转入金额后,您还需要完成',
                children: [
                  TextSpan(
                    text: ' ${existingTurnover.toString().toFixed2()}元 ',
                    style: TextStyle(
                      color: appnewColors.textBlue,
                      fontSize: 14.sp,
                    ),
                  ),
                  TextSpan(
                    text: '有效流水才能转出。您确定要转入吗?注意:当前场馆锁定中,转入的金额不享受返水奖励',
                  ),
                ],
                style: TextStyle(
                  color: appnewColors.textMain,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.r, bottom: 20.r, left: 20.r),
            child: RichText(
              text: TextSpan(
                text: '注:若需解锁场馆,请联系',
                children: [
                  TextSpan(
                      text: '在线客服',
                      style: TextStyle(
                        color: appnewColors.textBlue,
                        fontSize: 14.sp,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.dialog(
                            SkBaseDialog(
                              bgColor: Colors.transparent,
                              callback: () {
                                Get.back();
                              },
                              cancelCallback: () {},
                              showFooterBtn: false,
                              showDeleteBtn: true,
                              showDeleteBtnType: '2',
                              child: DialogKfView(),
                            ),
                          );
                        }),
                ],
                style: TextStyle(
                  color: appnewColors.textMain,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomView() {
    return Container(
      height: 48.r,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: appnewColors.colorLine,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '取消',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appnewColors.textMain,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: appnewColors.colorLine,
            width: 1,
            height: 48.r,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Get.back(result: true);
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '确定',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appnewColors.textBlue,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentItemView(String title, String content, {bool isTitle = false}) {
    return Container(
      height: 36.r,
      decoration: BoxDecoration(
        color: isTitle ? appnewColors.bgGray2 : null,
        borderRadius: BorderRadius.vertical(
          top: isTitle ? Radius.circular(8.r) : Radius.zero,
          bottom: isTitle ? Radius.zero : Radius.circular(8.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appnewColors.textMain,
                fontSize: 14.sp,
              ),
            ),
          ),
          Container(
            color: appnewColors.colorLine2,
            width: 1,
            height: 48.r,
          ),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appnewColors.textMain,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
