import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/home/appconfig_model.dart';
import 'package:filbet/src/message/message_private_list/message_private_list_controller.dart';
import 'package:filbet/src/message/widgets/message_item_view.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/common_tab_bar.dart';
import 'package:filbet/widgets/skEasyRefresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessagePrivateListView extends GetView<MessagePrivateListController> {
  const MessagePrivateListView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MessagePrivateListController());
    return Column(
      children: [
        tabView(),
        Expanded(child: dataView()),
        bottomView(context),
      ],
    );
  }

  Widget tabView() {
    return Obx(() {
      return CommonTabBar(
          tabController: controller.tabController,
          menus: controller.menu.value,
          selectIndex: controller.tabIndex.value);
    });
  }

  Widget dataView() {
    return TabBarView(
      controller: controller.tabController,
      children: [
        _buildMessagePage(0, controller.noticeModels), // 通知
        _buildMessagePage(1, controller.activityModels), // 活动
        _buildMessagePage(2, controller.depositWithdrawModels), // 充提
      ],
    );
  }

  Widget _buildMessagePage(int tabIndex, RxList<NoticeModel> models) {
    return EasyRefreshConfig.build(
      controller: controller.easyRefreshController,
      onRefresh: () async {
        await controller.refreshDataByTab(tabIndex);
      },
      onLoad: () async {
        await controller.loadMoreDataByTab(tabIndex);
      },
      childBuilder: (context, physics) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final viewportHeight = constraints.maxHeight;
            return Obx(() {
              if (models.isNotEmpty) {
                return CustomScrollView(
                  physics: physics,
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(top: 10.r),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final model = models[index];
                            return Obx(() {
                              return MessageItemView(
                                model: model,
                                isEdit: controller.isEdit.value,
                                type: tabIndex,
                                callback: () => controller.queryData(),
                                clickCallback: () {
                                  controller.readMessage(model);
                                  if (model.readState == 0) {
                                    controller.decreaseUnreadCount(tabIndex);
                                  }
                                  model.readState = 1;
                                  models.refresh();
                                },
                              );
                            });
                          },
                          childCount: models.length,
                        ),
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: SizedBox.shrink(),
                    ),
                  ],
                );
              } else {
                return SizedBox(
                  height: viewportHeight,
                  child: Container(
                    margin: EdgeInsets.only(top: 160.r),
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          Assets.mineNodataMsg,
                          width: 160.r,
                          height: 160.r,
                        ),
                        Text(
                          '暂时没有消息',
                          style: TextStyle(
                            color: appnewColors.textSecond,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            });
          },
        );
      },
    );
  }

  Widget bottomView(BuildContext context) {
    return Obx(() {
      if (controller.isEdit.value) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Container(
            height: 56.r,
            color: Color(0xFFEEEEEE),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.readSelectedMessage();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '标记已读',
                        style: TextStyle(
                          color: appnewColors.textBlue,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.deleteSelectedMessage();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '删除',
                        style: TextStyle(
                          color: appnewColors.text25,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return SizedBox();
      }
    });
  }

}
