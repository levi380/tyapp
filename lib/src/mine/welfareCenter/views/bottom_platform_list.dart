import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/home/homegame_model.dart';
import 'package:filbet/src/mine/welfareCenter/models/platform_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

typedef PlatformSelect = void Function(VenueModel model);

class BottomPlatformList extends StatelessWidget {
  const BottomPlatformList(
      {super.key, required this.models, required this.platformSelect});

  final List<VenueModel> models;
  final PlatformSelect platformSelect;

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
          Flexible(
            child: SingleChildScrollView(
              child: contentView(),
            ),
          ),
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
            '选择场馆',
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

  Widget contentView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var model = models[index];
        String? providerName;
        var list = GlobalService.to.state.allPlatformNameConfig
            .where((item) => item.id == model.id);
        if (list.isNotEmpty) {
          providerName = list.first.name;
        }
        return InkWell(
          onTap: () {
            if (model.maintained == 2) {
              return;
            }
            Get.back();
            platformSelect(model);
          },
          child: Container(
            height: 44.r,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 14.r),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: appnewColors.colorLine3, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Text(
                  providerName ?? model.name ?? '',
                  style: TextStyle(
                    color: model.maintained == 2
                        ? appnewColors.textThird
                        : appnewColors.textMain,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  model.maintained == 2 ? '(维护中)' : '',
                  style: TextStyle(
                    color: appnewColors.textThird,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: models.length,
    );
  }
}
