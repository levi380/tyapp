import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/src/service/controllers/service_controller.dart';
import 'package:filbet/widgets/common_button.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:filbet/widgets/empty_view.dart';
class ServiceView extends GetView<ServiceController> {
  ServiceView({super.key});

  ServiceController controller = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      needAppbar: false,
      backgroundColor: Color(0xffE7F4FD),
      body: SafeArea(
          child: Column(
        children: [_buildUserInfo(), _buildService()],
      )),
    );
  }

  Widget _buildUserInfo() {
    return Container(
      margin: EdgeInsets.only(left: 20.w, top: 20.w),
      child: Row(
        children: [
          Image.asset(
            Assets.homeTestHead,
            width: 60.w,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Skbet User NickName",
                  style: TextStyle(
                      color: Color(0xff3B5078),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.w),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      left: 15.w, top: 2.w, bottom: 2.w, right: 15.w),
                  decoration: BoxDecoration(
                      color: Color(0xff00A6D6),
                      borderRadius: BorderRadius.circular(5.w),
                      border: Border.all(color: Colors.white, width: 2.w)),
                  child: Text(
                    "welcome_support_center".tr,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildService() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w, bottom: 5.w),
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12.w)),
      child: Obx(() {
        return controller.serviceList.isEmpty
          ? EmptyView():
         Column(
          children: List.generate(controller.serviceList.length, (index) {
            return _buildServiceItem(index);
          }),
        );
      }
      ),
    );
  }

  Widget _buildServiceItem(index) {
    var kfModel = controller.serviceList[index];
    return Container(
      padding: EdgeInsets.all(10.w),
      margin: EdgeInsets.only(bottom: 10.w),
      decoration: BoxDecoration(
          color: Color(0xffE7F4FD), borderRadius: BorderRadius.circular(12.w)),
      child: Row(
        children: [
          Image.asset(
            kfModel.image,
            width: 36.w,
          ),
          Container(
            margin: EdgeInsets.only(left: 15.w),
            child: Text(
              kfModel.name,
              style: TextStyle(color: Color(0xff3B5078), fontSize: 14.sp),
            ),
          ),
          Expanded(child: SizedBox()),
          Container(
            margin: EdgeInsets.only(right: 15.w),
            child: Text(
              kfModel.content,
              style: TextStyle(color: Color(0xff3B5078), fontSize: 14.sp),
            ),
          ),
          SvgPicture.asset(
            Assets.homeServiceArrowRight,
            width: 14.w,
          ),
        ],
      ),
    ).toBtn(
      onTap: () async {
        if (kfModel.type == "1") {
          if (!await launchUrl(
            Uri.parse(kfModel.url),
          )) {
            // SmartDialog.showToast("链接有问题");
          }
        } else {
          AppNavigator.gotoweb(kfModel.url, "客服");
        }
      },
    );
  }
}
