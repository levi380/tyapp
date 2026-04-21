import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/src/home/Home_index_ads_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class HomeAdsDialog extends StatefulWidget {
  final List<HomeIndexAdsModel> dataList;

  const HomeAdsDialog({super.key, required this.dataList});

  @override
  State<StatefulWidget> createState() {
    return HomeAdsDialogState();
  }
}

class HomeAdsDialogState extends State<HomeAdsDialog> {
  int currentIndex = 0;
  RxBool check = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildBanner(),
        SizedBox(height: 18.h),
        _noMoreTodyPop(),
      ],
    );
  }

  Widget buildBanner() {
    double height = (Get.width - 30.r * 2) * 381 / 315;
    return SizedBox(
      height: height + 50.r,
      child: Swiper(
        itemCount: widget.dataList.length,
        autoplay: false,
        //autoplayDelay: 3000,
        loop: false,
        viewportFraction: 1,
        // 显示左右部分
        scale: 1,
        onIndexChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        // 缩放比例，让中间卡片突出
        itemBuilder: (BuildContext context, int index) {
          HomeIndexAdsModel model = widget.dataList[index];
          return Container(
            margin: EdgeInsets.only(left: 30.r, right: 30.r),
            child: GestureDetector(
              onTap: () async {
                Get.back();
                await _jumpToRoute(model);
              },
              child: Column(
                children: [
                  Container(
                    height: 50.r,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12.r)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft, // 渐变起点
                        end: Alignment.centerRight, // 渐变终点
                        colors: [
                          Color(0xff86B8FF),
                          Color(0xff4491FF),
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              model.title ?? "",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "FZZhengHeiS-EB-GB",
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            weight: 16.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(12.r)),
                    child: CachedNetworkImage(
                      imageUrl: AppUtils.getImgPath(model.img ?? ''),
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                      // 宽度铺满父容器,
                      placeholder: (context, url) => loadView(),
                      errorWidget: (context, url, error) => loadView(),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _noMoreTodyPop() {
    return Obx(() {
      return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16.w,
              height: 16.w,
              child: Checkbox(
                value: check.value,
                onChanged: (value) {
                  check.value = value ?? false;
                  _setCheckStats();
                  Get.back();
                },
                shape: const CircleBorder(),
                side: BorderSide(color: appnewColors.colorLine, width: 1.w),
                activeColor: appnewColors.bg,
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              'noPopupToday'.tr,
              style: TextStyle(
                color: appnewColors.bg, // 蓝色字体
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    });
  }

  void _setCheckStats() async {
    final today = DateTime.now();
    final todayString = '${today.year}-${today.month}-${today.day}';
    SpStorage.setHomeAdsDate(todayString);
  }

  //弹窗跳转页面
  _jumpToRoute(HomeIndexAdsModel model, {bool isOpenLinkH5 = false}) async {
    switch (model.urlType) {
      case "0":
        break;
      case "1":
        String url = model.url ?? "";
        String name = "";
        for (var page in AppPages.getPages) {
          if (page.name == url) {
            name = page.name;
          }
        }
        if (name.isNotEmpty) {
          Get.toNamed(name);
        }

        break;
      case "2":
        var result = await AppUtils.launchH5(model.url ?? "");
        break;
      default:
        print('route_not_found'.tr.replaceAll("{{url}}", model.url ?? ""));
    }
  }
}

Widget loadView() {
  return Container(
    height: 331.h,
    color: Color(0xffe5e5e5),
    // Lottie.asset(
    //   'assets/images/home/imageloading.json',
    //   repeat: false,
    //   reverse: false,
    //   animate: true,
    //   fit: BoxFit.cover,
    //   height: 323.w,
    // ),
  );
}
