import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

typedef WalletSelect = void Function(PlatformWalletModel model);

class BottomAutoWalletList extends StatelessWidget {
  const BottomAutoWalletList(
      {super.key,
      required this.models,
      required this.walletSelect,
      required this.checkedModel});

  final List<PlatformWalletModel> models;
  final WalletSelect walletSelect;
  final PlatformWalletModel? checkedModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height - 100),
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleView(),
          Expanded(child: contentView()),
        ],
      ),
    );
  }

  Widget titleView() {
    return Container(
      margin: EdgeInsets.only(top: 10.r, bottom: 20.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 46.r,
          ),
          Text(
            '选择钱包',
            style: TextStyle(
              color: appnewColors.textMain,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.all(15.r),
              child: Image.asset(
                Assets.mineIconCloes,
                width: 16.r,
                height: 16.r,
                color: appnewColors.textMain,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// locked == 1 或 maintained == 2 的排在下面
  List<PlatformWalletModel> get _sortedModels {
    return List<PlatformWalletModel>.from(models)
      ..sort((a, b) {
        final aBottom = a.locked == 1 || a.maintained == 2;
        final bBottom = b.locked == 1 || b.maintained == 2;
        if (aBottom == bBottom) return 0;
        return aBottom ? 1 : -1;
      });
  }

  Widget contentView() {
    final list = _sortedModels;
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var model = list[index];
          return InkWell(
            onTap: () {
              if (model.locked == 1 || model.maintained == 2) {
                return;
              }
              Get.back();
              walletSelect(model);
            },
            child: Container(
              height: 44.r,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 14.r, right: 14.r),
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(color: appnewColors.colorLine3, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    model.walletName ?? '',
                    style: TextStyle(
                      color: model.maintained == 2 || model.locked == 1
                          ? appnewColors.textThird
                          : appnewColors.textMain,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    model.maintained == 2
                        ? '(维护中)'
                        : model.locked == 1
                            ? '（锁定中）'
                            : '',
                    style: TextStyle(
                      color: appnewColors.textThird,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  if (checkedModel?.walletId == model.walletId)
                    Image.asset(
                      Assets.imagesChecked,
                      width: 16.r,
                      height: 15.r,
                    ),
                ],
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
