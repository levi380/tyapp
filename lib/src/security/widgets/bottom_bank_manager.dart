import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/withdraw/wallet_account_model.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomBankManager extends StatelessWidget {
  ValueChanged<bool>? addBankCardChange;
  ValueChanged<WalletAccountModel>? deleteBankCardChange;
  RxList<WalletAccountModel> bankAccountList = RxList.empty();

  BottomBankManager({super.key, required this.bankAccountList, this.addBankCardChange, this.deleteBankCardChange});

  @override
  Widget build(BuildContext context) {
    final maxHeight = Get.height - (MediaQuery.of(context).padding.top + 180.r);
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return itemView(bankAccountList[index]);
            },
            itemCount: bankAccountList.length,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 16.r,
              right: 16.r,
              top: 55.r,
              bottom: 30.r,
            ),
            child: CommonActionButton(
              content: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.securityIconAdd,
                    height: 24.r,
                    width: 24.r,
                  ),
                  SizedBox(width: 5.r),
                  Text(
                    'bank_add'.tr,
                    style: TextStyle(
                      color: appColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              isActive: true,
              onPressed: () {
                Get.back();
                addBankCardChange?.call(false);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemView(WalletAccountModel item) {
    var addressInfo = item.addressInfo;
    return Container(
      height: 72.r,
      margin: EdgeInsets.only(left: 20.r, right: 20.r, top: 12.r),
      padding: EdgeInsets.symmetric(horizontal: 8.r),
      decoration: BoxDecoration(
        color: appnewColors.bg4,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          SKNetworkImage(
            fit: BoxFit.cover,
            imageUrl: addressInfo?.img ?? "",
            placeholderType: 2,
            borderRadius: 18.r,
            height: 36.r,
            width: 36.r,
          ),
          SizedBox(width: 8.r),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                addressInfo?.bankName ?? "",
                style: TextStyle(
                  color: appnewColors.text1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.r),
              Text(
                bankCard(addressInfo?.accountNo ?? ""),
                style: TextStyle(
                  color: appnewColors.text1,
                  fontSize: 12.sp,
                ),
              )
            ],
          ),
          Spacer(),
          InkWell(
            onTap: () {
              deleteBankCardChange?.call(item);
            },
            child: Image.asset(
              Assets.securityIconDelete,
              height: 24.r,
              width: 24.r,
            ),
          ),
        ],
      ),
    );
  }

  /// 输入 纯数字 或 已带空格格式均可
  static String bankCard(String card) {
    String number = card.replaceAll(" ", "");
    if (number.length <= 8) return card;
    String first = number.substring(0, 4);
    String last = number.substring(number.length - 4);
    return "$first **** $last";
  }

  void clickConfirm() {}
}
