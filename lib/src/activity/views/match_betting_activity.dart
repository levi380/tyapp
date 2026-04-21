import 'dart:convert';

import 'package:filbet/src/activity/controllers/match_betting_controller.dart';
import 'package:filbet/src/activity/model/config_model.dart';
import 'package:filbet/src/activity/views/match_betting_content_list.dart';
import 'package:filbet/src/activity/views/match_contest_config.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/base_util.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///赛事竞猜活动
class MatchBettingActivity extends GetView<MatchBettingController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScffold(
        showBgTexture: false,
        backgroundColor: appnewColors.bg4,
        appBar: CustomAppbar.normalTitle(
          bgColor: appnewColors.bg4,
          title: controller.detail.value?.name ?? "",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopImg(),
              if (controller.promoDetail.length > 1) _buildPageTag(),
              _buildListContent(),
              // _buildRule(),
              // if (controller.pageTagSelItem.value is PageContestConfig) _bottomApply()
            ],
          ),
        ),
      );
    });
  }

  ///头部Banner
  Widget _buildTopImg() {
    String images = controller.detail.value?.images ?? "";
    String topIamges = "";
    if (images.isNotEmpty) {
      final Map<String, dynamic> map = jsonDecode(images);
      topIamges = map["h5_main"] ?? "";
    }
    return topIamges.isNotEmpty
        ? SizedBox(
            width: double.infinity,
            child: Image.network(
              staticImageResolver(topIamges),
              fit: BoxFit.fitWidth,
            ),
          )
        : Text("");
  }

  ///页签
  Widget _buildPageTag() {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      child: GridView.builder(
          padding: EdgeInsets.all(15.w),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 每行3列
            mainAxisSpacing: 10.w, // 主轴方向间距（上下）
            crossAxisSpacing: 10.w, // 交叉轴方向间距（左右）
            childAspectRatio: 110 / 40, // 宽高比 (宽 / 高)
          ),
          itemCount: controller.promoDetail.length,
          itemBuilder: (context, index) {
            var item = controller.promoDetail[index];
            var title = "";
            if (item is PageRiddleConfigBean) {
              title = item.title ?? "";
            } else if (item is PageContestConfig) {
              title = item.title ?? "";
            }
            return GestureDetector(
              child: Obx(() {
                bool isSel = controller.pageTagSelIndex.value == index;
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: isSel ? Color(0xff4C96FF) : Colors.white, borderRadius: BorderRadius.circular(10.w)),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: isSel ? Colors.white : Color(0xff4C96FF), fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                );
              }),
              onTap: () {
                controller.pageTagSelIndex.value = index;
                controller.pageTagSelItem.value = item;
                controller.tabIndex.value = 0;
              },
            );
          }),
    );
  }

  ///列表内容
  Widget _buildListContent() {
    if (controller.pageTagSelItem.value == null) {
      return Text("");
    }
    if (controller.pageTagSelItem.value is PageRiddleConfigBean) {
      //竞猜页
      return MatchBettingContentList(
        pageRiddleConfigBean: controller.pageTagSelItem.value as PageRiddleConfigBean,
        id: controller.id.value,
        ty: controller.ty.value,
      );
    } else if (controller.pageTagSelItem.value is PageContestConfig) {
      //赛事页配置
      return MatchContestConfigList(
        pageContestConfig: controller.pageTagSelItem.value as PageContestConfig,
        id: controller.id.value,
        ty: controller.ty.value,
      );
    } else {
      return Text("没有该类型");
    }
  }
}
