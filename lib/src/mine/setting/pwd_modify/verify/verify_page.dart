import 'package:filbet/src/mine/setting/pwd_modify/verify/verify_controller.dart';
import 'package:filbet/src/mine/setting/pwd_modify/verify_email/verify_email.dart';
import 'package:filbet/src/mine/setting/pwd_modify/verify_phone/verify_phone.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerifyPage extends GetView<VerifyController> {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        bgColor: appnewColors.bg1,
        title: 'verify_identity'.tr,
      ),
      body: Column(
        children: [
          if (controller.tabs.length > 1) _tabView(),
          if (controller.tabs.isNotEmpty)
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: _buildTabBarViewChildren(),
              ),
            )
        ],
      ),
    );
  }

  Widget _tabView() {
    return Container(
      alignment: Alignment.topCenter,
      child: TabBar(
        controller: controller.tabController,
        onTap: (index) {
          controller.selectTabIndex.value = index;
        },
        padding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.center,

        // 调整 indicator 与文字间距的关键
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.w, color: Color(0xff6EA8FF)),
          insets: EdgeInsets.symmetric(horizontal: 5.w), // indicator 距左右间距
        ),

        indicatorSize: TabBarIndicatorSize.label,
        // 让指示器更贴近文字宽度
        labelColor: Color(0xff131416),
        unselectedLabelColor: Color(0xff69728C),
        isScrollable: false,

        tabs: [
          for (int i = 0; i < controller.tabs.length; i++)
            Obx(() {
              return Tab(
                child: Text(
                  controller.tabs[i].title,
                  style: TextStyle(
                    color: controller.selectTabIndex.value == i
                        ? Color(0xff1D1D1F)
                        : Color(0xffB0B1B6),
                    fontSize: 16.sp,
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  List<Widget> _buildTabBarViewChildren() {
    List<Widget> children = [];

    // 如果需要手机验证，添加手机验证页面
    if (controller.phone?.isNotEmpty == true) {
      children.add(
        VerifyPhone(
          verityType: controller.verifyType ?? ValidationType.changeLoginPwd,
          deleteId: controller.deleteId,
        ),
      );
    }

    // 如果需要邮箱验证，添加邮箱验证页面
    if (controller.email?.isNotEmpty == true) {
      children.add(
        VerifyEmail(
          verityType: controller.verifyType ?? ValidationType.changeLoginPwd,
          deleteId: controller.deleteId,
        ),
      );
    }

    return children;
  }
}
