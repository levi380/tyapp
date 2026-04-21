import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/result/vr_results/widgets/vr_date_widget.dart';
import 'package:flutter_ty_app/app/modules/result/vr_results/widgets/vr_itme_widget.dart';
import 'package:flutter_ty_app/app/modules/result/vr_results/widgets/vr_league_widget.dart';
import 'package:flutter_ty_app/app/modules/result/vr_results/widgets/vr_lq_item/vr_lq_itme_widget.dart';
import 'package:flutter_ty_app/app/modules/result/vr_results/widgets/vr_type_widget.dart';
import 'package:flutter_ty_app/app/modules/result/vr_results/widgets/vr_zq_item/vr_zq_itme_widget.dart';
import 'package:get/get.dart';
import '../../../utils/change_skin_tone_color_util.dart';
import '../../../widgets/image_view.dart';
import '../widgets/download_data_widget.dart';
import '../widgets/results_no_data_widget.dart';
import 'vr_results_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 视图 VrResultsPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 视图 VrResultsPage
    - VrResultsPage
    ```
    ///时间筛选
    _date(),

    ///球类筛选
    if (controller.vRMen) _vRType(),

    ///联赛筛选
    if (controller.vRLeagueMen) _vRLeague(),

    ///赛事列表
     _item()
    ```
    】】】
 *
 */
class VrResultsPage extends StatefulWidget {
  final int titleIndex;

  const VrResultsPage(this.titleIndex, {super.key});

  @override
  State<VrResultsPage> createState() => _VrResultsPageState();
}

class _VrResultsPageState extends State<VrResultsPage> {
  final controller = Get.find<VrResultsController>();
  final logic = Get.find<VrResultsController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VrResultsController>(
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                color: context.isDarkMode
                    ? ChangeSkinToneColorUtil.instance()
                        .getDarkBackgroundColor()
                    : Color(0xFFF2F2F6),
                child: Column(
                  children: [
                    Container(
                      color: context.isDarkMode ? null : Colors.white,
                      child: Column(
                        children: [
                          ///时间筛选
                          _date(),

                          ///球类筛选
                          if (logic.vRMen) _vRType(),

                          ///联赛筛选
                          if (logic.vRLeagueMen) _vRLeague(),
                        ],
                      ),
                    ),

                    ///列表数据
                    _body(),
                  ],
                ),
              ),

              ///返回第一条数据
              logic.returnToFirst == true
                  ? Positioned(
                      right: 14.w,
                      bottom: 50.h,
                      child: InkWell(
                        onTap: () => controller.scrollToFirstItem(),
                        child: ImageView(
                          context.isDarkMode
                              ? 'assets/images/icon/icon-top-dark.png'
                              : 'assets/images/icon/icon-top-light.png',
                          width: 30.w,
                          height: 30.w,
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        );
      },
    );
  }

  ///日期筛选
  Widget _date() {
    return Container(
      margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.h,bottom: 10.h),
      alignment: Alignment.centerLeft,
      child: TabBar(
        indicatorColor: Colors.transparent,
        indicator: const BoxDecoration(),
        isScrollable: true,
        dividerHeight: 0,
        labelPadding: EdgeInsets.zero,
        controller: controller.dateTabController,
        onTap: (index) => controller.onDateIndex(index),
        tabs: List<vRDateWidget>.generate(controller.dateList.length, (index) {
          return vRDateWidget(
            title: controller.dateList[index].date,
            isSelected: logic.dateIndex == index ? true : false,
            isDark: context.isDarkMode,
            titleIndex: widget.titleIndex,
          );
        }).toList(),
      ),
    );
  }

  ///球种类型
  Widget _vRType() {
    return Container(
      margin: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 5.h),
      alignment: Alignment.centerLeft,
      child: TabBar(
        indicatorColor: Colors.transparent,
        indicator: const BoxDecoration(),
        isScrollable: true,
        dividerHeight: 0,
        labelPadding: EdgeInsets.zero,
        controller: controller.vRTypeTabController,
        onTap: (index) => controller.onVrMenuIndex(index),
        tabs: List<VrTypeWidget>.generate(controller.vRMenuListData.length,
            (index) {
          final imgMap = logic.vrSportsMenuImg[controller.vRMenuListData[index].menuId];
          final imgUrl =
              'assets/images/vr/${logic.vRMenuIndex == index ? (imgMap?['imgNameSel'] ?? '') : (imgMap?[context.isDarkMode ? 'darkImgName' : 'imgName'] ?? '')}';
          return VrTypeWidget(
            title: controller.vRMenuListData[index].name,
            isSelected: logic.vRMenuIndex == index ? true : false,
            isDark: context.isDarkMode,
            titleIndex: widget.titleIndex,
            menuId: logic.vRMenuIndex,
            imgUrl: imgUrl,
          );
        }).toList(),
      ),
    );
  }

  ///联赛筛选
  Widget _vRLeague() {
    return Container(
      margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 5.h),
      alignment: Alignment.centerLeft,
      child: TabBar(
        indicatorColor: Colors.transparent,
        indicator: const BoxDecoration(),
        isScrollable: true,
        dividerHeight: 0,
        labelPadding: EdgeInsets.zero,
        controller: controller.vRLeagueTypeTabController,
        onTap: (index) => controller.onVrLeagueDateIndex(index),
        tabs:
            List<VrLeague>.generate(controller.vRLeagueSubList.length, (index) {
          return VrLeague(
            title: controller.vRLeagueSubList[index].name,
            isSelected: logic.vRLeagueIndex == index ? true : false,
            isDark: context.isDarkMode,
            titleIndex: widget.titleIndex,
          );
        }).toList(),
      ),
    );
  }

  ///列表
  Widget _body() {
    return Expanded(
        child: logic.downloadData == true
            ? const DownloadDataWidget()
            : logic.noData == false
                ? _item()
                : const ResultsNoDataWidget());
  }

  ///赛事列表
  Widget _item() {
    return logic.vRMenuMenuId == '1001'
        ? VrZqItemWidget(
      isDark: context.isDarkMode,
      recordsList: controller.recordsList,
      isExpand: logic.isExpand,
      onExpandItem: () => controller.onExpandItem(),
      vRMenuMenuId: logic.vRMenuMenuId,
      scrollController: controller.scrollController,
    )
        : logic.vRMenuMenuId == '1004'
        ? VrLqItemWidget(
      isDark: context.isDarkMode,
      recordsList: controller.recordsList,
      isExpand: logic.isExpand,
      onExpandItem: () => controller.onExpandItem(),
      vRMenuMenuId: logic.vRMenuMenuId,
      scrollController: controller.scrollController,
    )
        : VrItemWidget(
      isDark: context.isDarkMode,
      recordsList: controller.recordsList,
      isExpand: logic.isExpand,
      onExpandItem: () => controller.onExpandItem(),
      vRMenuMenuId: logic.vRMenuMenuId,
      scrollController: controller.scrollController,
    );
  }
}
