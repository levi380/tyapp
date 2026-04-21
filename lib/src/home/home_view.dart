import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/home/home_banner.dart';
import 'package:filbet/src/home/home_view_controller.dart';
import 'package:filbet/src/home/middle_info.dart';
import 'package:filbet/src/home/text_announcement.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/event_bus.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/widgets/skEasyRefresh.dart';

import 'package:filbet/utils/base_util.dart';

import 'game_view.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: Color(0xFFE9EFF7),
      appBar: CustomAppbar.icontitle(
        backgroundColor: Color(0xFFE9EFF7),
        height: 44.r,
        leftw: _buildLeftImage(),
        actions: _actions() ?? [],
      ),
      body: EasyRefreshConfig.build(
        controller: controller.easyRefreshController,
        // header: commonHeader,
        childBuilder: (context, physics) {
          return _body(physics);
        },
        onRefresh: () async {
          await controller.homeRefresh();
        },
      ),
    );
  }

  Widget _body(ScrollPhysics? physics) {
    return _scrollingView(physics);
  }

  Widget _scrollingView(ScrollPhysics? physics) {
    ///改成wap粘性滚动
    return CustomScrollView(
      shrinkWrap: true,
      controller: controller.scrollController,
      physics: physics ?? const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _homeBanner(),
              SizedBox(
                height: 10.r,
              )
            ],
          ),
        ),
        SliverStickyGameList(),
      ],
    );
  }

  ///公告配置
  Widget _announcementLayout() {
    return Container(
      padding: EdgeInsets.only(left: 14.r, right: 14.r, top: 8.r),
      child: TextAnnouncement(height: 20.r),
    );
  }

  Widget _baseLayout() {
    return _announcementLayout();
  }

  Widget _homeBanner() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE9EFF7),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.r),
        ),
        border: Border(
          bottom: BorderSide(color: appnewColors.bg1, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFCFDCF1),
            offset: Offset(0, 2),
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          HomeBanner(),
          _baseLayout(),
          MiddleInfo(),
        ],
      ),
    );
  }

  Widget buildSupport() {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(Routes.MESSAGE_CENTER);
        if (UserService.to.state.isVisitor) {
          EventBus.emit(EventType.goToLogin);
        } else {
          AppNavigator.gotoMessage();
        }
      },
      child: Container(
        width: 26.r,
        height: 26.r,
        margin: EdgeInsets.only(right: 6.r),
        alignment: Alignment.center,
        child: Stack(children: [
          Image.asset(
            Assets.homeHomeMessage,
            width: 26.r,
            height: 26.r,
          ),
          Obx(() {
            int unRead = UserService.to.state.totalUnread.value;
            return (UserService.to.state.isRegularUser && unRead > 0)
                ? Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      height: 6.r,
                      width: 6.r,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFD3C31),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  )
                : SizedBox();
          }),
        ]),
      ),
    );
  }

  List<Widget>? _actions() {
    return [
      buildText(),
      buildSupport(),
    ];
  }

  Widget buildText() {
    return Container(
      height: 26.r,
      width: 136.r,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 4.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.homeNavBg), // 本地图片
          fit: BoxFit.cover, // 拉伸填充：cover、contain、fill、fitWidth、fitHeight
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.homeHomeWebIcon,
            width: 20.r,
            height: 20.r,
            fit: BoxFit.fill,
          ),
          Text(
            "permanent_website".tr,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff587189),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLeftImage() {
    return Container(
      margin: EdgeInsets.only(left: 7.r),
      child: Image.asset(
        Assets.homeHomeLogo,
        width: 71.r,
        height: 27.r,
      ),
    );
  }
}
