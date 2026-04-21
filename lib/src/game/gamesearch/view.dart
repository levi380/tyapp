import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'game_search_controller.dart';
import 'package:easy_refresh/easy_refresh.dart';

import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/image_button.dart';
import 'package:filbet/widgets/titlebar.dart';

import 'package:filbet/widgets/custom_searchbar.dart';
import 'package:filbet/themes/app_color.dart';
import '../gamelist/gamedataCell.dart';
import '../gamelist/game_item.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/widgets/skEasyRefresh.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/services/global/global_service.dart';

class GamesearchPage extends GetView<GameSearchController> {
  GamesearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg2,
      appBar: CustomAppbar.searchmargin(
        actions: _actions(),
        center: searchbar(),
        backgroundColor: appnewColors.bg1,
        // actions: _buildActions(),
      ),
      body: EasyRefreshConfig.build(
        controller: controller.easyRefreshController,
        // header: commonHeader,
        childBuilder: (context, physics) {
          return _body(physics);
        },

        onLoad: () async {
          await controller.loadMoreData();
        },
      ),
    );
  }

  Widget _body(ScrollPhysics? physics) {
    return Column(
      children: [
        Obx(() {
          return controller.ckeyword.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(
                      top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                  height: 30.r,
                  // width: 145.r,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 8.r, right: 8.r),

                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'search_results_found'.tr,
                          style: TextStyle(
                            color: Color(0xff98A2C1),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: controller.records.length.toString(),
                          style: TextStyle(
                            color: Color(0xff00A6D6),
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                        TextSpan(
                          text: 'search_results_about'.tr,
                          style: TextStyle(
                              color: Color(0xff98A2C1), fontSize: 12.sp),
                        ),
                        TextSpan(
                          text: controller.ckeyword.value,
                          style: TextStyle(
                              color: Color(0xff00A6D6), fontSize: 12.sp),
                        ),
                        TextSpan(
                          text: 'search_results_of'.tr,
                          style: TextStyle(
                              color: Color(0xff98A2C1), fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox();
        }),
        Expanded(child: _getgameitemCell(physics))
      ],
    );
  }

  _getgameitemCell(physics) {
    return Obx(() {
      return GridView.builder(
        padding:
            EdgeInsets.only(left: 9.0.w, right: 9.0.w, top: 12.w, bottom: 0),
        scrollDirection: Axis.vertical,
        physics: physics,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 170 / 137,
        ),
        itemCount: controller.records.length,
        // item数量
        itemBuilder: (context, index) {
          String text = "";
          String image = "";
          bool isfav = false;
          GameInfoModel model = GameInfoModel();

          text = controller.records[index].name ?? "";
          image = controller.records[index].img ?? "";
          isfav = controller.records[index].fav;
          model = controller.records[index];

          return GameDataCell(
              text: text,
              image: image,
              isfav: isfav,
              startcallBack: () {
                AppNavigator.gotoGame(
                    model.platformId ?? "",
                    model.gameId ?? "",
                    model.name ?? "",
                    controller.categoryType ?? CategoryType.video);
              },
              callBack: () {
                if (isfav == true) {
                  controller.favdelete(model);
                } else {
                  controller.inserftav(model);
                }
              });
        },
      );
    });
  }

  List<Widget> _actions() {
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
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.only(left: 15.w),
        alignment: Alignment.center,
        child: Text('cancel'.tr,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: appnewColors.text2,
            )),
      ),
    );
  }

  searchbar() {
    return Container(
      margin: EdgeInsets.only(top: 5.r, right: 15.w, bottom: 5.r),
      child: Row(
        children: [
          Expanded(
            child: SearchTextFieldBar(
              isShowBackButton: true,
              text: "",
              height: 46.h,
              hint: "input_game_name".tr,
              fontSize: 14.sp,
              defaultBorderRadius: 8.r,
              heroTag: "searchStatidBar",
              onChanged: (String value) {
                //  controller.searchWithKeyWord(value);
                if (value.isEmpty) {
                  controller.ckeyword.value = value;
                }
              },
              onSubmitted: (text) {
                controller.searchWithKeyWord(text);
              },
              clearCallback: () {
                controller.searchWithKeyWord("");
              },
            ),
          ),
        ],
      ),
    );
  }
}
