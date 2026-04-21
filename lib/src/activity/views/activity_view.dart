import 'dart:convert';

import 'package:filbet/common/language.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/activity/controllers/activity_controller.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/themes/app_newcolor.dart';

import 'package:filbet/themes/app_decoration.dart';
import 'package:filbet/widgets/indicator/rectangular_indicator.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/widgets/empty_view.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/utils/time_util.dart';

class ActivityView extends GetView<ActivityController> {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityPage();
  }
}

class ActivityPage extends StatefulWidget {
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ActivityController controller = Get.find<ActivityController>();

  @override
  void initState() {
    super.initState();
    final tabLength = controller.typeList.length;
    _tabController = TabController(length: tabLength, vsync: this);
    _tabController.addListener(_initListener);
  }

  void _initListener() {
    if (!(_tabController.indexIsChanging)) {
      ActivityTypeModel typeModel = controller.typeList[_tabController.index];
      controller.typeId = typeModel.id;
      // if (typeModel.activityList.isEmpty) {
      controller.getPromoListData(type: controller.typeId);
      // }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg2,
      appBar: CustomAppbar(
        height: (kToolbarHeight + Get.mediaQuery.padding.top),
        left: _buildTypeTabbar(),
        showShadow: false,
        backgroundColor: appnewColors.bg1,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: Obx(() {
            return TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(controller.typeList.length, (i) {
                return _buildActivityListWidget(i);
              }),
            );
          }),
        ),
      ),
    );
  }

  ///类型导航栏
  Widget _buildTypeTabbar() {
    return Container(
      width: 1.sw - 20.w,
      height: 56.w,
      // padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: appnewColors.bg1,
      ),
      child: Container(
        height: 30.h,
        padding:
            EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
        child: Obx(() {
          return TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: List.generate(controller.typeList.length, (index) {
              ActivityTypeModel model = controller.typeList[index];
              String title = model.name ?? '';
              return Tab(
                child: Text(title),
              );
            }),
            labelStyle: TextStyle(
                color: appnewColors.bg,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(
                color: appnewColors.text5,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),

            labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
            // labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            dividerColor: Colors.transparent,
            dividerHeight: 0,
            indicatorColor: appnewColors.bg,
            // 修改指示器颜色
            indicatorSize: TabBarIndicatorSize.label, // 指示器宽度=文字宽度

            // indicator: RectangularIndicator(
            //     color: appnewColors.bg,
            //     bottomLeftRadius: 6.r,
            //     bottomRightRadius: 6.r,
            //     topLeftRadius: 6.r,
            //     topRightRadius: 6.r,
            //     horizontalPadding: 0),
          );
        }),
      ),
    );
  }

  _buildActivityListWidget(int tabIndex) {
    return Obx(() {
      ActivityTypeModel typeModel = controller.typeList[tabIndex];

      if (typeModel.activityList.isEmpty) {
        return SizedBox(height: 270.r, child: EmptyView());
      }
      return ListView.builder(
          itemCount: typeModel.activityList.length,
          itemBuilder: (context, index) {
            final model = typeModel.activityList[index];
            return _buildActivityItem(model: model, typeModel: typeModel);
          });
    });
  }

  ///活动item
  Widget _buildActivityItem(
      {required ActivityModel model, required ActivityTypeModel typeModel}) {
    String typename = "";
    ActivityTypeModel? found = controller.typeList
        .firstWhereOrNull((item) => item.id == model.tag_type);
    if (found != null) {
      typename = found.iconName ?? "";
    } else {
      typename = typeModel.name ?? "";
    }
    String iamges = model.images ?? "";
    String imageUlr = "";
    if (iamges.isNotEmpty) {
      final Map<String, dynamic> map = jsonDecode(iamges);
      imageUlr = map["h5_list"] ?? "";
    }
    return InkWell(
      onTap: () {
        if (model.ty == 9) {
          //每日
          Get.toNamed(Routes.DAILY_SIGNIN,
              arguments: {"name": model.name, "id": model.id});
        } else {
          controller.jumpToDetailPage(model);
        }
      },
      child: Container(
        decoration: AppDecoration.bgWhiteWithShadow(),
        width: 1.sw - 20.w,
        height: 140.w,
        margin: EdgeInsets.only(bottom: 10.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            children: [
              SKNetworkImage(
                width: 1.sw - 20.w,
                height: 140.w,
                borderRadius: 12.r,
                imageUrl: imageUlr ?? '',
                placeholderType: 1,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 24.r,
                      padding:
                          EdgeInsets.only(left: 6.r, right: 16.r, top: 8.r),
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        typename,
                        style: TextStyle(
                          color: Colors.transparent,
                          fontSize: 12.r,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-16.r, 0),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10.w, right: 12.w, top: 2.r, bottom: 2.r),
                        clipBehavior: Clip.none,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              const Color(0xFFE4EDF6),
                              const Color(0xFFE4EDF6),
                              const Color(0xFFE4EDF6),
                              const Color(0xFFE4EDF6).withOpacity(0),
                            ],
                          ),
                        ),
                        child: Text(
                          model.activityCycle == 2
                              ? "long_term_activity".tr
                              : "${endTime(model.startAt ?? 0)}-${endTime(model.endAt ?? 0)}",
                          style: TextStyle(
                              color: Color(0xFF6C6C89),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 24.r,
                  padding: EdgeInsets.only(left: 6.r, right: 16.r, top: 8.r),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        Assets.activityBgType1.replaceAll(
                            'bg_type_1', 'bg_type_${found?.color_num ?? 1}'),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    typename,
                    style: TextStyle(
                      color: appnewColors.text4,
                      fontSize: 12.r,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String endTime(int timestamp) {
    return timestamp.totsFormattedDateTimeString();
  }

  String settleTime(int timestamp) {
    return timestamp.totsFormattedDateTimeString();
  }
}
