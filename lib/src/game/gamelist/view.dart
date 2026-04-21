import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/generated/assets.dart';
import 'gamelist_controller.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/image_button.dart';
import 'package:filbet/widgets/titlebar.dart';

import 'package:filbet/widgets/custom_searchbar.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/indicator/rectangular_indicator.dart';
import 'gamedataCell.dart';
import 'game_list.dart';
import 'package:filbet/widgets/want_keep_alive_widget.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/widgets/common_button.dart';
import 'package:filbet/src/game/gameinit/guideOverlay.dart';
import 'package:filbet/src/game/gamelist/GameVenueOverlay2.dart';

abstract class TaggedGetView<T extends GetxController> extends StatelessWidget {
  const TaggedGetView({super.key});
  String? get tag;
  T get controller => Get.find<T>(tag: tag);
}

class GameListView extends TaggedGetView<GameListController> {
  GameListView({Key? key}) : super(key: key);
  @override
  String? get tag => (Get.arguments as Map?)?["platform_id"]?.toString();

  @override
  Widget build(BuildContext context) {
    final tagId = tag;
    print('[GameListView] tag=' +
        (tagId ?? 'null') +
        ' args=' +
        Get.arguments.toString() +
        ' isRegistered=' +
        Get.isRegistered<GameListController>(tag: tagId).toString());
    return Stack(children: [
      CustomScffold(
          showBgTexture: false,
          backgroundColor: appnewColors.bg2,
          appBar: CustomAppbar.backcenterView(
            backgroundColor: appnewColors.bg1,
            center: Column(children: [
              Container(
                color: Colors.transparent,
                child: Image.asset(
                  Assets.homeGameTop,
                  width: 79,
                  height: 20,
                ),
              ).toBtn(
                onTap: () {
                controller.showGameVenue.value = true;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.title ?? "",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: appnewColors.text1,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            ]),
            actions: _actions() ?? [],

            // style: const TextStyle(
            //   fontSize: 20,
            //   color: PageStyle.c_FFFFFF,
            // ),

            // actions: _buildActions(),
          ),
          body: Column(
            children: [
              _buildTypeTabbar(),
              // Expanded(
              //   child: EasyRefresh.builder(
              //     controller: controller.easyRefreshController,
              //     // header: commonHeader,
              //     childBuilder: (context, physics) {
              //       return _body(physics);
              //     },
              //     onRefresh: () async {
              //       await controller.refreshData();
              //     },
              //     onLoad: () async {
              //       await controller.loadMoreData();
              //     },
              //   ),
              // )

              Expanded(
                  child: TabBarView(
                controller: controller.tabController,
                physics: NeverScrollableScrollPhysics(), // 禁止滑动

                /// AccounChangePage交易消息  MessageSystemPage()系统消息
                children: <Widget>[
                  WantKeepAliveWidget(
                      child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: GameListitemView(
                      type: 0,
                    ),
                  )),
                  WantKeepAliveWidget(
                    child: Container(
                        padding: EdgeInsets.only(top: 10),
                        child: GameListitemView(
                          type: 1,
                        )),
                  ),
                  WantKeepAliveWidget(
                      child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: GameListitemView(
                      type: 2,
                    ),
                  )),
                ],
              ))
            ],
          )),

      // 引导层
      Obx(() {
        return (controller.showGuide.value)
            ? Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                
                 
                    child: Container(
                        color: Colors.black.withOpacity(0.6),
                      child: GuideOverlay(
                        onClose: () {
                          controller.showGuide.value = false;

                          UserService.to.state.userInfo.guide = false;
                          // Get.back();
                          // onComplete?.call();
                        },
                      ),
                    ),
                  ),
                
              )
            : SizedBox.shrink();
      }),

       Obx(() {
          final show = controller.showGameVenue.value;

          return Positioned.fill(
            child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: show
                ? 
                
                GameVenueOverlay(
                    key: const ValueKey("panel"),
                  )
                : const SizedBox.shrink(),
          ));
        }),
    ]);
  }

  ///类型导航栏
  Widget _buildTypeTabbar() {
    return Container(
      // width: 1.sw - 20.w,
      height: 40.h,
      // padding: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(6.r),
        color: appnewColors.bg1,
      ),
      child: Obx(() {
        return Container(
          height: 30.h,
          // padding:
          //     EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
          child: Row(children: [
            Expanded(
                child: TabBar(
              controller: controller.tabController,
              // tabAlignment: TabAlignment.start,
              isScrollable: false, // 均分宽度，适合 tab 少的情况
              tabs: List.generate(controller.typeList.length, (index) {
                String title = controller.typeList[index];
                return Container(
                    child: Tab(
                  child: Text(title),
                ));
              }),
              unselectedLabelStyle: TextStyle(
                  color: appnewColors.text2,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                  color: appnewColors.text1,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),

              // labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
              labelPadding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              // dividerColor: Colors.transparent,
              dividerHeight: 0,

              indicatorColor: appnewColors.bg, // 修改指示器颜色
              indicatorSize: TabBarIndicatorSize.label, // 指示器宽度=文字宽度
              // indicator: RectangularIndicator(
              //     // color: appColors.mainColor,
              //     bottomLeftRadius: 6.r,
              //     bottomRightRadius: 6.r,
              //     topLeftRadius: 6.r,
              //     topRightRadius: 6.r,
              //     horizontalPadding: 0),
            ))
          ]),
        );
      }),
    );
  }

  List<Widget>? _actions() {
    return [
      buildCancel(),
      SizedBox(
        width: 10.w,
      )
    ];
  }

  Widget buildCancel() {
    return GestureDetector(
      onTap: () {
        AppNavigator.gotoSearch(
            controller.platform_id ?? "",
            controller.venue_id ?? "",
            controller.categoryType ?? CategoryType.video);
      },
      child: Container(
        margin: EdgeInsets.only(left: 15.w, right: 0.w, top: 14),
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(left: 15.w),
          alignment: Alignment.centerLeft,
          child: Image.asset(
            Assets.homeSearch,
            width: 20.r,
            height: 20.r,
          ),
        ),
      ),
    );
  }
}
