import 'package:filbet/src/message/message_center_controller.dart';
import 'package:filbet/src/message/message_center_list/message_center_list_view.dart';
import 'package:filbet/src/message/message_private_list/message_private_list_view.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/generated/assets.dart';

class MessageCenterView extends GetView<MessageCenterController> {
  const MessageCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      backgroundColor: appnewColors.bg5,
      showBgTexture: false,
      appBar: CustomAppbar.backcenterView(
        center: appBarView(),
        left: Obx(() {
          if (controller.isEdit.value) {
            return InkWell(
              onTap: () {
                controller.editMessages(false);
              },
              child: Container(
                width: 44.r,
                height: 44.r,
                alignment: Alignment.center,
                child: Image.asset(
                  Assets.imagesClose,
                  width: 16.r,
                  height: 16.r,
                ),
              ),
            );
          } else {
            return InkWell(
              onTap: Get.back,
              child: Container(
                width: 44.r,
                height: 44.r,
                alignment: Alignment.center,
                child: Image.asset(
                  Assets.imagesBack,
                  width: 16.r,
                  height: 16.r,
                ),
              ),
            );
          }
        }),
        backgroundColor: appnewColors.bg1,
        actions: _actions() ?? [],
      ),
      body: Obx(() {
        if (controller.appBarIndex.value == 0) {
          return MessageCenterListView();
        } else {
          return MessagePrivateListView();
        }
      }),
    );
  }

  Widget appBarView() {
    return Container(
      height: 36.r,
      width: 200.r,
      padding: EdgeInsets.symmetric(horizontal: 4.r),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8FF),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Obx(() {
            return appBarItemView(
                "msg_center".tr, 0, controller.messageUnreadNum.value);
          }),
          SizedBox(width: 6.r), // 为数字徽章留出空间
          Obx(() {
            return appBarItemView(
                'private_message'.tr, 1, controller.privateUnreadNum.value);
          }),
        ],
      ),
    );
  }

  Widget appBarItemView(String title, int index, int number) {
    return Expanded(
      child: Obx(() {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: () {
                controller.appBarIndex.value = index;
              },
              child: Container(
                height: 28.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.appBarIndex.value == index
                      ? appnewColors.bg1
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: controller.appBarIndex.value == index
                        ? appnewColors.textMain
                        : appnewColors.textSecond,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            if (number > 0)
              Positioned(
                right: -6.r,
                child: Container(
                  height: 16.r,
                  padding: EdgeInsets.symmetric(horizontal: 5.r),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF7255),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    '$number',
                    style: TextStyle(
                      color: appnewColors.textWhite,
                      fontSize: 14.sp,
                      height: 1,
                    ),
                  ),
                ),
              )
          ],
        );
      }),
    );
  }

  List<Widget>? _actions() {
    return [
      Obx(() {
        if (controller.isEdit.value) {
          return buildEdit();
        } else {
          return buildCancel();
        }
      }),
    ];
  }

  Widget buildEdit() {
    return InkWell(
      onTap: () {
        controller.selectCurrentPage();
      },
      child: Container(
        margin: EdgeInsets.only(right: 15.r),
        child: Text(
          '选择本页',
          style: TextStyle(
            color: appnewColors.textMain,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildCancel() {
    return GestureDetector(
      onTap: () {
        showCustomActionSheet(
          Get.context!,
          onEdit: () {
            controller.editMessages(true);
          },
          onReadAll: () {
            controller.readAllMessages();
          },
          onDeleteAll: () {
            controller.deleteAllMessages();
          },
        );
        // controller.jumpToSettingPage();
      },
      child: Container(
        width: 28.w,
        height: 28.h,
        margin: EdgeInsets.only(right: 10.r),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Image.asset(
          Assets.mineMessageMore,
          width: 16.r,
          height: 16.r,
        ),
      ),
    );
  }
}

void showCustomActionSheet(BuildContext context, {
  required VoidCallback onEdit,
  required VoidCallback onReadAll,
  required VoidCallback onDeleteAll,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        // margin: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 操作按钮区域
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildActionItem('编辑消息', onTap: () {
                    Get.back();
                    onEdit();
                  }),
                  Divider(height: 1, color: appnewColors.colorLine),
                  _buildActionItem("mark_all_read".tr, onTap: () {
                    Get.back();
                    onReadAll();
                  }),
                  Divider(height: 1, color: appnewColors.colorLine),
                  _buildActionItem("全部删除", onTap: () {
                    Get.back();
                    onDeleteAll();
                  }),
                  Divider(height: 1, color: appnewColors.colorLine),
                ],
              ),
            ),
            SizedBox(height: 8.h),

            // 取消按钮
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: _buildActionItem("cancel".tr, onTap: () {
                Get.back();
              }),
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .padding
                .bottom + 8.h),
          ],
        ),
      );
    },
  );
}

Widget _buildActionItem(String text, {required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: 50.h,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: appnewColors.text1,
        ),
      ),
    ),
  );
}
