import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/home/appconfig_model.dart';
import 'package:filbet/src/home/homegame_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/dialog/tips_confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessageDetailController extends GetxController {
  int type = 0; //0通知详情  1活动详情 2公告 3充提
  NoticeModel detailModel = NoticeModel();

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> map = Get.arguments;
    if (map.containsKey('type')) {
      type = map['type'];
    }
    if (map.containsKey('model')) {
      detailModel = map['model'];
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void showDeleteBottom(
    BuildContext context, {
    required VoidCallback onDelete,
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
                    _buildActionItem("删除", onTap: () {
                      Get.back();
                      onDelete();
                    }),
                    Divider(height: 1, color: appnewColors.colorLine),
                  ],
                ),
              ),
              // 取消按钮
              Container(
                child: _buildActionItem("cancel".tr,
                    textColor: appnewColors.textMain, onTap: () {
                  Get.back();
                }),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionItem(
    String text, {
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50.h,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            color: textColor ?? appnewColors.text25,
          ),
        ),
      ),
    );
  }

  void showDeleteConfirmDialog(BuildContext context) {
    Get.dialog(
      TipsConfirmDialog(
        content: '删除后将无法恢复，确认要删除吗？',
        confirmCallback: () {
          deleteMessages([detailModel.id ?? '']);
        },
      ),
    );
  }

  void deleteMessages(List<String>? readIds) async {
    var resp = type != 2
        ? await ApiRequest.deleteMessages(readIds, null)
        : await ApiRequest.deleteNotices(readIds, null);
    if (resp == true) {
      Get.back(result: true);
    }
  }

  void clickDetail(NoticeModel model) {
    //跳转类型：0=不跳转，1=指定链接，2=平台活动，3=指定界面，4=指定场馆，5=跳转赛事
    // jump_type 1 // 指定链接：{"link_type":0,"url":{"pc":"/path/to/page","h5":"/path/to/page","app":"/path/to/page"}}
    // jump_type 1 // 指定链接：{"link_type":1,"url":"/path/to/page"}
    // jump_type 2 // 平台活动：{"activity_id":"123456","ty":"1"}
    // jump_type 3 // 指定界面：{"route":"personal_center"} // 个人中心
    // jump_type 3 // 指定界面：{"route":"promotion_list"} // 优惠列表
    // jump_type 4 // 指定场馆：{"id":"123456","venue_id":"123456","game_id":"123456","game_type":"4","name":"场馆名称"}
    // jump_type 5 // 跳转赛事：{"venue_id":"123456","game_id":"789012"}
    var jumpType = model.jumpType;
    if (jumpType == 0) {
      return;
    }
    if (jumpType == 1) {
      if (model.jumpConfigModel?.linkType == '0') {
        String route = model.jumpConfigModel?.appUrl ?? '';
        try {
          if (hasRoute(route)) {
            Get.toNamed(route);
          }
        } catch (e) {}
      } else if (model.jumpConfigModel?.linkType == '1') {
        String detailLink = model.jumpConfigModel?.url ?? '';
        AppUtils.launchH5(detailLink);
      }
    } else if (jumpType == 2) {
      var activityId = model.jumpConfigModel?.activityId ?? '';
      var activityType = model.jumpConfigModel?.ty ?? 0;
      if (activityId.isEmpty) {
        return;
      }
      ActivityModel activityModel =
          ActivityModel(id: activityId, ty: activityType);
      if (activityType == 4) {
        Get.toNamed(Routes.ACTIVITY_DETAIL_TURNTABLE,
            arguments: {'model': activityModel});
      } else if (activityType == 1) {
        Get.toNamed(Routes.FIRST_DEPOSIT_ACTIVITY,
            arguments: {'model': activityModel});
      } else if (activityType == 3) {
        Get.toNamed(Routes.BETTING_FIRST_DEPOSIT,
            arguments: {'model': activityModel});
      } else if (activityType == 5) {
        Get.toNamed(Routes.MATCH_BETTING_ACT,
            arguments: {'model': activityModel});
      } else {
        Get.toNamed(Routes.ACTIVITY_DETAIL,
            arguments: {'model': activityModel});
      }
    } else if (jumpType == 3) {
      String route = model.jumpConfigModel?.route ?? '';
      if (route == 'personal_center') {
//        Get.toNamed(Routes.USER_INFO);
        AppNavigator.startMainByIndex(tabIndex: 3);
      } else if (route == 'promotion_list') {
        // ActivityView 在 MainTabbarView 的第2个（index=1）
        AppNavigator.startMainByIndex(tabIndex: 1);
      }
    } else if (jumpType == 4) {
      final VenueModel? game = GlobalService.to.state.allGameConfig
          .firstWhereOrNull((item) => item.id == model.jumpConfigModel?.id);
      if (game == null) {
        AppUtils.showToast('coming_soon'.tr);
        return;
      }
      if (game.maintained == 2) {
        AppUtils.showToast('场馆维护中');
        return;
      }
      if (game.id == '-1') {
        AppUtils.showToast('coming_soon'.tr);
        return;
      }
      AppNavigator.gotoGameList(
          game,
          CategoryType.fromId(
                  int.tryParse(model.jumpConfigModel?.gameType ?? '') ?? 0) ??
              CategoryType.video);
    } else if (jumpType == 5) {}
  }

  bool hasRoute(String name) {
    return Get.routeTree.routes.any((r) => r.name == name);
  }
}
