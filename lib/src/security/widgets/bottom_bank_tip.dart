
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomBankTip extends StatelessWidget {
  ValueChanged<bool> onSelect;

  BottomBankTip({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 28.r, left: 24.r, right: 24.r),
          child: Text(
            'bank_risk'.tr,
            style: TextStyle(
              color: appnewColors.text1,
              fontSize: 14.sp,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 16.r,
            right: 16.r,
            top: 35.r,
            bottom: 30.r,
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                    onSelect.call(true);
                  },
                  child: Container(
                    height: 40.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r), border: Border.all(color: appnewColors.borderBlue)),
                    child: Text(
                      'back_to_modify'.tr,
                      style: TextStyle(
                        color: appnewColors.textBlue,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 7.r),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                    onSelect.call(false);
                  },
                  child: Container(
                    height: 40.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: appnewColors.bg,
                    ),
                    child: Text(
                      'go_on_binding'.tr,
                      style: TextStyle(
                        color: appnewColors.textWhite,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void clickConfirm() {}
}
