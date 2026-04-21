import 'package:carousel_slider/carousel_slider.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/home/appconfig_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:filbet/widgets/network_image.dart';

class HomeBanner extends StatefulWidget {
  final bool needIndicator;
  final double aspectRatio;
  final double? radius;

  const HomeBanner({
    super.key,
    this.needIndicator = true,
    this.aspectRatio = 2.4,
    this.radius,
  });

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 28.r,
      height: (Get.width - 28.r) / widget.aspectRatio,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x17383C44),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Obx(() {
        if (GlobalService.to.state.homeBanners.isEmpty) {
          return _bannerEmpty();
        } else if (GlobalService.to.state.homeBanners.length == 1) {
          return _singleBanner();
        } else {
          return _style();
        }
      }),
    );
  }

  Widget _bannerEmpty() {
    return Image.asset(
      Assets.homeLogoPlaceholder,
      width: 40.r,
      height: 40.r,
      fit: BoxFit.contain,
    );
  }

  Widget _singleBanner() {
    var banner = GlobalService.to.state.homeBanners[0];
    return GestureDetector(
      onTap: () {
        onTapBanner(banner);
      },
      child: SKNetworkImage(
        borderRadius: widget.radius ?? 12.r,
        imageUrl: banner.img ?? '',
        placeholderType: 2,
      ),
    );
  }

  Widget _style() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            viewportFraction: 1,
            height: (Get.width - 28.r) / widget.aspectRatio,

            autoPlay: true,

            enlargeCenterPage: false,
            // 取消中间放大
            padEnds: false,
            // 防止两端 item 缩进

            ///loop
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              currentIndex.value = index;
            },
          ),
          itemCount: GlobalService.to.state.homeBanners.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            var model = GlobalService.to.state.homeBanners[index];
            return Container(
              // padding: EdgeInsets.only(left: 2.w, right: 2.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                // color: Color(0xffE6F1FE),
                border: Border.all(
                  color: Colors.white,
                  width: 1.r,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  onTapBanner(model);
                },
                child: SKNetworkImage(
                  borderRadius: widget.radius ?? 12.r,
                  imageUrl: model.img ?? '',
                  placeholderType: 2,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        if (widget.needIndicator &&
            GlobalService.to.state.homeBanners.length > 1)
          Positioned(
            bottom: 10.r,
            child: _dotWidget(),
          )
      ],
    );
  }

  Widget _dotWidget() {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (BuildContext context, int value, Widget? child) {
        return AnimatedSmoothIndicator(
          activeIndex: value,
          count: GlobalService.to.state.homeBanners.length,
          effect: ExpandingDotsEffect(
              dotHeight: 4.r,
              dotWidth: 6.r,
              dotColor: appnewColors.bg1,
              activeDotColor: appnewColors.bg),
        );
      },
    );
  }

  void onTapBanner(BannerItem banner) {
    // - **jump_type = 1, link_type = 1**：无链接，点击后不跳转，仅静态展示
    // - **jump_type = 1, link_type = 2**：站内链接，在当前客户端内跳转到 `detail_link` 指定的页面
    // - **jump_type = 1, link_type = 3**：站外链接，PC端新标签页打开，APP/A75端调用系统默认浏览器打开 `detail_link` 指定的URL
    // - **jump_type = 2, activity_id = ""**：平台活动-不选活动，点击后不跳转，仅静态展示
    // - **jump_type = 2, activity_id != ""**：平台活动-选择活动，点击后跳转到对应活动详情页

    var jumpType = banner.jumpType;
    var linkType = banner.linkType;
    if (jumpType == 1) {
      String detailLink = banner.detailLink ?? '';
      if (linkType == 1) {
        return;
      } else if (linkType == 2) {
        String name = '';
        for (var page in AppPages.getPages) {
          if (page.name == detailLink) {
            name = page.name;
          }
        }
        if (name.isNotEmpty) {
          Get.toNamed(name);
        }
      } else if (linkType == 3) {
        AppUtils.launchH5(detailLink);
      }
    } else if (jumpType == 2) {
      var activityId = banner.activityId ?? '';
      var activityType = banner.activityType?.toInt();
//      var activityType = banner.ty;
      if (activityId.isEmpty) {
        return;
      }
      ActivityModel model =
          ActivityModel(id: banner.activityId, ty: activityType);
      if (activityType == 4) {
        Get.toNamed(Routes.ACTIVITY_DETAIL_TURNTABLE,
            arguments: {'model': model});
      } else if (activityType == 1) {
        Get.toNamed(Routes.FIRST_DEPOSIT_ACTIVITY, arguments: {'model': model});
      } else if (activityType == 3) {
        Get.toNamed(Routes.BETTING_FIRST_DEPOSIT, arguments: {'model': model});
      } else if (activityType == 5) {
        Get.toNamed(Routes.MATCH_BETTING_ACT, arguments: {'model': model});
      } else {
        Get.toNamed(Routes.ACTIVITY_DETAIL, arguments: {'model': model});
      }
    }
  }
}
