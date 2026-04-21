import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/deposit/channel_model.dart';
import 'package:filbet/src/deposit/deposit_tutorial_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:filbet/widgets/wallet_component_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//存款教程
class DepositTutorialView extends GetView<DepositTutorialController> {
  const DepositTutorialView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.textWhite,
      appBar: CustomAppbar.normalTitle(
        bgColor: appnewColors.textWhite,
        title: '存款教程'.tr,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildChannelSelector(),
                    Container(
                      height: 16.h,
                      color: appnewColors.bg3,
                    ),
                    // 支付宝类型显示 tab 栏
                    Obx(() => controller.isAlipayType
                        ? _buildAlipayTabBar()
                        : SizedBox()),
                    _buildTutorialImages(),
                    SizedBox(height: 60.h), // 底部留出空间，避免内容被箭头遮挡
                  ],
                ),
              ),
            ),
            // 固定在底部的箭头（带动画）
            Positioned(
              bottom: 20.h,
              left: 0,
              right: 0,
              child: Center(
                child: _buildAnimatedArrow(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 渠道选择器
  Widget _buildChannelSelector() {
    return Obx(() {
      final selected = controller.selectedChannel.value;
      print("object123456 selected=${selected?.img}");
      if (selected == null) {
        return SizedBox();
      }

      return GestureDetector(
        onTap: () => _showChannelBottomSheet(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: appnewColors.bg1,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              // 渠道图标
//              _getChannelIcon(selected),
              Image.asset(
                selected.img,
                width: 32.r,
                height: 32.r,
              ),
              SizedBox(width: 12.w),
              // 渠道名称
              Expanded(
                child: Text(
                  selected.name,
                  style: TextStyle(
                    color: appnewColors.text1,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // 右箭头
              Image.asset(
                Assets.mineIconArrowR,
                width: 16.r,
                height: 16.r,
              ),
            ],
          ),
        ),
      );
    });
  }

  // 显示渠道选择底部弹窗
  void _showChannelBottomSheet() {
    if (controller.channelList.isEmpty) {
      return;
    }
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: appnewColors.bg1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 标题栏
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: appnewColors.colorLine,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '选择存款教程'.tr,
                    style: TextStyle(
                      color: appnewColors.text1,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // 渠道列表
            Flexible(
              child: Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemCount: controller.channelList.length,
                  itemBuilder: (context, index) {
                    final channel = controller.channelList[index];
                    final isSelected =
                        controller.selectedChannel.value?.paymentType ==
                            channel.paymentType;

                    return GestureDetector(
                      onTap: () {
                        controller.selectChannel(channel);
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: appnewColors.colorLine,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            // 渠道图标
                            //  _getChannelIcon(channel),
                            Image.asset(
                              channel.img,
                              width: 32.r,
                              height: 32.r,
                            ),
                            SizedBox(width: 12.w),
                            // 渠道名称
                            Expanded(
                              child: Text(
                                channel.name,
                                style: TextStyle(
                                  color: appnewColors.text22,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            // 选中标记或箭头
                            if (isSelected)
                              Image.asset(
                                Assets.imagesIconChecked1,
                                width: 10.w,
                                height: 7.h,
                              )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // 获取渠道图标
  Widget _getChannelIcon(ChannelModel channel) {
    // 使用 ChannelModelForWallet extension 获取图标
    return channel.icon;
  }

  // 构建支付宝 tab 栏
  Widget _buildAlipayTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      color: appnewColors.bg1,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            controller.alipayTabs.length,
            (index) {
              return Obx(() {
                final isSelected =
                    controller.selectedAlipayTabIndex.value == index;
                return GestureDetector(
                  onTap: () => controller.selectAlipayTab(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.alipayTabs[index],
                          style: TextStyle(
                            color: isSelected
                                ? appnewColors.text1
                                : appnewColors.text2,
                            fontSize: 14.sp,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // 下划线指示器
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: isSelected ? 40.w : 0,
                          height: isSelected ? 2.h : 0,
                          decoration: BoxDecoration(
                            color: appnewColors.colorLine3,
                            borderRadius: BorderRadius.circular(1.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }

  // 构建教程图片列表
  Widget _buildTutorialImages() {
    return Obx(() {
      final images = controller.currentTutorialImages;

      if (images.isEmpty) {
        return Container(
          padding: EdgeInsets.all(40.h),
          alignment: Alignment.center,
          child: Text(
            '暂无教程'.tr,
            style: TextStyle(
              color: appnewColors.text2,
              fontSize: 14.sp,
            ),
          ),
        );
      }

      return Column(
        children: List.generate(images.length, (index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Text(
                  '步骤${index + 1}/${images.length}',
                  style: TextStyle(
                    color: appnewColors.text2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12.h),
                Image.asset(
                  images[index],
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        }),
      );
    });
  }

  // 构建带动画的箭头
  Widget _buildAnimatedArrow() {
    return _AnimatedArrow();
  }
}

// 带动画的箭头组件
class _AnimatedArrow extends StatefulWidget {
  @override
  _AnimatedArrowState createState() => _AnimatedArrowState();
}

class _AnimatedArrowState extends State<_AnimatedArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    // 使用 Tween 创建来回移动的动画
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // 循环播放动画
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // 计算移动距离，范围在 0 到 8.h 之间
        final translateY = _animation.value * 8.h;

        return Transform.translate(
          offset: Offset(0, -translateY),
          child: Image.asset(
            'assets/images/tutorial/icon_arrow.webp',
            width: 24.r,
            height: 24.r,
          ),
        );
      },
    );
  }
}
