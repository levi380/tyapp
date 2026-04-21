import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'user_enum.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/controllers/mine_controller.dart';

class UserCenterMiddleInfoView extends StatelessWidget {
  const UserCenterMiddleInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return UserService.to.state.isVisitor == false
          ? Container(
              padding: EdgeInsets.only(
                  top: 12.w, bottom: 12.w, left: 20.w, right: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffCBDAE9), // 阴影颜色
                    spreadRadius: 2, // 阴影扩散范围
                    blurRadius: 8, // 模糊程度
                    offset: Offset(0, 4), // 阴影偏移量 (x, y)
                  ),
                ],
                color: appnewColors.bg3,
              ),
              child: gridview())
          : SizedBox();
    });
  }

  gridview() {
    double crossAxisCount = 4;
    double crossAxisSpacing = 12.w;
    double mainAxisSpacing = 12.w;
    double aspectRatio = 1; // 1:1 正方形

    return LayoutBuilder(
      builder: (context, constraints) {
        // 可用总宽度（父容器给到 Grid 的宽）
        final totalWidth = constraints.maxWidth.ceil();

        // 每个格子的“内容宽度”（要扣掉列间距）
        final cellWidth = 55.w;

        crossAxisSpacing = (totalWidth - (cellWidth * crossAxisCount)) / 3;
        // 1:1 ⇒ 高度 = 宽度；若不是 1:1，用 cellWidth / aspectRatio
        final cellHeight = 52.r;

        // 行数
        final rows = (contentList.length / crossAxisCount).ceil();

        // Grid 实际需要的总高度 = 行高*行数 + 行间距*(行数-1)
        final gridHeight = cellHeight * rows + mainAxisSpacing * (rows - 1);

        return SizedBox(
          height: gridHeight, // 关键：把 GridView 高度钉死为实际需要的高度
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: contentList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              childAspectRatio: cellWidth / cellHeight, // 仍然 1:1
            ),
            itemBuilder: (_, i) {
              final item = contentList[i];

              return GestureDetector(
                  onTap: () {
                    MineController.to.middleListClick(
                      item['type'],
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // 或 .end 贴底
                        children: [
                          Container(
                            child: Center(
                              child: Image.asset(
                                height: 36.r,
                                width: 36.r,
                                item['image'],
                              ),
                            ),
                          ),
                          Container(
                              width: 55.w,
                              // color: Colors.red,
                              child: Text(
                                item['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    height: 1,
                                    fontWeight: FontWeight.w400,
                                    // fontFamily: 'PingFang SC',
                                    color: appnewColors.text1),
                              )),
                        ],
                      ),
                      if (item['type'] ==
                          UserCenterItemType.userCenterMessageCenter)
                        Positioned(
                          top: 2,
                          right: 14.w,
                          child: Obx(() {
                            return _redDotNum(
                                UserService.to.state.totalUnread.value);
                          }),
                        ),
                    ],
                  ));
            },
          ),
        );
      },
    );
  }

  Widget _redDotNum(int number) {
    return number != 0
        ? Container(
            width: 4.w,
            height: 4.w,
            // padding: EdgeInsets.all(2.sp),
            // constraints: BoxConstraints(minHeight: 5.sp, minWidth: 5.sp),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: appnewColors.tip1,
              borderRadius: BorderRadius.circular(2.sp),
            ),
            child: Text(
              "",
              style: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontSize: 14.sp,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        : const SizedBox();
  }

  List get contentList {
    List contentList = [
      {
        'title': "my_assets".tr,
        'image': Assets.mineMyAssets,
        'type': UserCenterItemType.myAssets,
      },
      {
        'title': "bet_record".tr,
        'image': Assets.mineBetIcon,
        'type': UserCenterItemType.userCenterBetRecords,
      },
      {
        'title': "trade_record".tr,
        'image': Assets.mineTransactionIcon,
        'type': UserCenterItemType.userCenterTransactionRecord,
      },
      {
        'title': "账户管理".tr,
        'image': Assets.mineAccountManager,
        'type': UserCenterItemType.accountManager,
      },
      {
        'title': "feedback".tr,
        'image': Assets.mineFeedback,
        'type': UserCenterItemType.feedBack,
      },
      {
        'title': "help_center".tr,
        'image': Assets.mineHelpIcon,
        'type': UserCenterItemType.userCenterHelpCenter,
      },
      {
        'title': "join_us".tr,
        'image': Assets.mineAddIcon,
        'type': UserCenterItemType.userCenterJoinUs,
      },
    ];
    return contentList;
  }
}
