import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/platform_check_out_model.dart';
import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/src/mine/vip/models/resp_vip_rate_detail.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecycleResultDialog extends StatelessWidget {
  RecycleResultDialog({super.key, required this.models});

  final List<PlatformWalletModel> models;

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
        '温馨提示',
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
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.r),
            constraints: BoxConstraints(
              maxHeight: 36.r * 10,
            ),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: appnewColors.colorLine2,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    contentItemView('对应场馆', '欠缺流水', isTitle: true),
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var model = models[index];
                        return contentItemView('${model.walletName}',
                            '¥${model.remainTurnover ?? ''}');
                      },
                      itemCount: models.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 1,
                          color: appnewColors.colorLine2,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.r, bottom: 20.r),
            child: Text(
              '以上场馆未满足流水要求,无法回收到中心钱包。',
              style: TextStyle(
                color: appnewColors.textMain,
                fontSize: 12.sp,
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
                Get.back();
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
