import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/resp_service_model.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/utils/app_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/empty_view.dart';
import 'package:filbet/widgets/common_button.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:filbet/widgets/empty_view.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'dart:math' as math;
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/mixin/copy_mixin.dart';

class DialogKfviewNew extends StatefulWidget {
  DialogKfviewNew({
    super.key,
    required this.customServices,
  });

  List<ThirdPartys> customServices;

  @override
  State<StatefulWidget> createState() {
    return DialogChangeGenderState();
  }
}

class DialogChangeGenderState extends State<DialogKfviewNew> with CopyMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double itemHeight = 40.r;
    double minHeight = 320.r;

    double listHeight = 156.r +
        28.r +
        widget.customServices.length * (itemHeight + 12.r) -
        12.r;

    listHeight = listHeight < minHeight ? minHeight : listHeight;

    return Container(
        height: listHeight,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // 圆角半径
                  child: Image.asset(
                    Assets.homeBg1,
                    height: 244.r,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 64.r,
                left: 12,
                right: 12,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: AssetImage(
                        Assets.homeKfTextbg,
                      ), // 本地图片
                      fit: BoxFit.fill, // 填充方式
                    ),
                  ),
                  height: listHeight - 64.r,
                  // width: 251.w,
                  child: widget.customServices.isEmpty
                      ? EmptyView()
                      : ListView.separated(
                          padding: EdgeInsets.only(
                              left: 20.r, top: 28.r, right: 20.r),
                          itemCount: widget.customServices.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildServiceItem(index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 12.r);
                          },
                        ),
                )),
            Positioned(
                bottom: 54.r,
                left: 7.r,
                child: Image.asset(
                  Assets.homeKfBg2,
                  height: 113.r,
                  width: 251.r,
                  fit: BoxFit.fill,
                )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 118.r,
                child: Image.asset(
                  Assets.homeKfText1,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 185.w,
                child: Image.asset(
                  Assets.homeKfRw1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildServiceItem(index) {
    var kfModel = widget.customServices[index];
    return Container(
      height: 40.r,
      padding: EdgeInsets.symmetric(horizontal: 10.r),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: appnewColors.bg5List,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Image.asset(
            Assets.homeKfIcon2,
            width: 20.w,
            height: 20.w,
          ),
          Container(
            margin: EdgeInsets.only(left: 5.w),
            child: Text(
              kfModel.type ?? '',
              style: TextStyle(
                color: appnewColors.text1,
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          InkWell(
            onTap: () async {
              // if (kfModel.type == "1") {
              //   if (!await launchUrl(
              //     Uri.parse(kfModel.url ?? ''),
              //   )) {
              //     // SmartDialog.showToast("链接有问题");
              //   }
              // } else {
              if (kfModel.url?.isNotEmpty == true) {
                AppNavigator.gotoweb(kfModel.url ?? '', "customer_service".tr);
              } else {
                AppUtils.showToast("链接为空");
              }

              // }
            },
            child: Container(
              height: 20.r,
              padding: EdgeInsets.symmetric(horizontal: 10.r),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appnewColors.bgBlue,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                "点击咨询".tr,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: appnewColors.textWhite,
                  height: 1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
