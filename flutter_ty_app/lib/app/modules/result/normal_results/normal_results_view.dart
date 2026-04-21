import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/change_skin_tone_color_util.dart';
import '../../../widgets/image_view.dart';
import '../gaming_results/gaming_results_controller.dart';
import '../widgets/all_events_widget.dart';
import '../widgets/date_widget.dart';
import '../widgets/download_data_widget.dart';
import '../widgets/results_index_widget.dart';
import '../widgets/results_itme_widget.dart';
import '../widgets/results_no_data_widget.dart';
import '../widgets/type_filter_widget.dart';
import 'normal_results_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-aac9743b-8526-4a48-b939-39e894116a65-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 普通赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  普通赛果 视图页面 NormalResultsPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  普通赛果 视图页面  NormalResultsPage
    - NormalResultsPage
    ```
    ///日期筛选
    Widget _date()
    ///类型筛选
    Widget _typeFilter()
    ///列表
    Widget _body()
    ///全部赛事
    Widget _allEvents()

    ```
    】】】
 *
 */
class NormalResultsPage extends StatefulWidget {
  final int titleIndex;

  const NormalResultsPage(this.titleIndex, {super.key});

  @override
  State<NormalResultsPage> createState() => _NormalResultsPageState();
}

class _NormalResultsPageState extends State<NormalResultsPage> {
  final controller = Get.find<NormalResultsController>();
  final logic = Get.find<NormalResultsController>().logic;


  @override
  Widget build(BuildContext context) {
    return GetBuilder<NormalResultsController>(
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                color: context.isDarkMode ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor() : Color(0xFFF2F2F6),
                child: Column(
                  children: [
                    Container(
                      color:  context.isDarkMode ? null : Colors.white,
                      child: Column(
                        children: [
                          _date(),
                          _typeFilter(),
                        ],
                      ),
                    ),
                    GetBuilder<NormalResultsController>(
                      id: "data",
                      builder: (controller) {
                        return logic.downloadData == true
                            ? Container()
                            : logic.noData == false
                            ? _allEvents()
                            : Container();
                      },
                    ),
                    _body(),
                  ],
                ),
              ),
              GetBuilder<NormalResultsController>(
                id: "back",
                builder: (controller) {
                  return logic.returnToFirst == true
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
                      : Container();
                },
              ),
              if(logic.isIcon)
                GestureDetector(
                  onTap: ()=> controller.onCloseIsIcon(),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.0),
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  ///日期筛选
  Widget _date() {
    return GetBuilder<NormalResultsController>(
      id: "date",
      builder: (controller) {
        return Container(
          margin: EdgeInsets.only(left: 14.w, right: 14.w,top: 10.h),
          alignment: Alignment.centerLeft,
          child: TabBar(
            indicatorColor: Colors.transparent,
            indicator: const BoxDecoration(),
            isScrollable: true,
            dividerHeight: 0,
            labelPadding: EdgeInsets.zero,
            controller: controller.dateTabController,
            onTap: (index) => controller.onDateIndex(index),
            tabs:
                List<DateWidget>.generate(controller.dateList.length, (index) {
              return DateWidget(
                title: controller.dateList[index].date,
                isSelected: logic.dateIndex == index ? true : false,
                isDark: context.isDarkMode,
                titleIndex: widget.titleIndex,
              );
            }).toList(),
          ),
        );
      },
    );
  }

  ///类型筛选
  Widget _typeFilter() {
    return GetBuilder<NormalResultsController>(
      id: "type",
      builder: (controller) {
        return Container(
          height: 60.h,
          width: double.maxFinite,
          margin: EdgeInsets.only(
            left: 14.w,
            right: 14.w,
          ),
          child: Row(
            children: [
              Visibility(
                visible: logic.leftShow,
                child: Expanded(
                  flex: 0,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: TypeFilterWidget(
                      onTap: () => controller.onTypeFilterIndex(logic.typeFilterIndex,controller.typeFilterList[logic.typeFilterIndex].sportId),
                      title: controller.typeFilterList[logic.typeFilterIndex].name,
                      miid:controller.typeFilterList[logic.typeFilterIndex].miid,
                      isSelected: logic.typeFilterIndex == logic.typeFilterIndex ? true : false,
                      isDark: context.isDarkMode,
                      index: logic.typeFilterIndex,
                      titleIndex: widget.titleIndex,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child:ResultsIndexWidget(
                  callBack: (int firstIndex, int lastIndex) => controller.onCallBack(firstIndex, lastIndex),
                      child: ListView.builder(
                        itemCount: controller.typeFilterList.length,
                        scrollDirection: Axis.horizontal,
                        controller:controller.typeScrollController,
                        itemBuilder: (context, index) {
                          return TypeFilterWidget(
                            key: controller.typeFilterList[index].sportId.toString().contains(logic.sportid) ?
                                 controller.normalResultsKey
                                : ValueKey(controller.typeFilterList[index].sportId),
                            onTap: () => controller.onTypeFilterIndex(index,controller.typeFilterList[index].sportId),
                            miid: controller.typeFilterList[index].miid,
                            title: controller.typeFilterList[index].name,
                            isSelected: logic.typeFilterIndex == index ? true : false,
                            isDark: context.isDarkMode,
                            index: index,
                            titleIndex: widget.titleIndex,
                          );
                        },
                      ),
                    ),
              ),
              Visibility(
                visible: logic.rightShow,
                child: Expanded(
                  flex: 0,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: TypeFilterWidget(
                      onTap: () => controller.onTypeFilterIndex(logic.typeFilterIndex,controller.typeFilterList[logic.typeFilterIndex].sportId),
                      miid: controller.typeFilterList[logic.typeFilterIndex].miid,
                      title: controller.typeFilterList[logic.typeFilterIndex].name,
                      isSelected: logic.typeFilterIndex == logic.typeFilterIndex ? true : false,
                      isDark: context.isDarkMode,
                      index: logic.typeFilterIndex,
                      titleIndex: widget.titleIndex,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///列表
  Widget _body() {
    return GetBuilder<NormalResultsController>(
      id: "data",
      builder: (controller) {
        return Expanded(
            child: logic.downloadData == true
                ? const DownloadDataWidget()
                : logic.noData == false
                    ? _item()
                    : const ResultsNoDataWidget());
      },
    );
  }

  ///全部赛事
  Widget _allEvents() {
    return AllEventsWidget(
      isDark: context.isDarkMode,
      onExpandAll: () => controller.onExpandAll(),
      isExpandAll: logic.isExpandAll,
    );
  }

  ///全部赛事
  Widget _item() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.matcheResultData.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        controller: controller.scrollController,
        itemBuilder: (context, index) {
          TidDataList dataItem = controller.matcheResultData[index];
          return ResultsItemWidget(
            isDark: context.isDarkMode,
            dataItem: dataItem,
            onExpandItem: () => controller.onExpandItem(dataItem),
            onGoToDetails: (item) => controller.onGoToDetails(item, widget.titleIndex),
            onIsIcon: (mid,noticeIndex)=> controller.onIsIcon(mid),
            isIcon: logic.isIcon,
            mid:logic.mid,
            noticeListByIdData: controller.noticeListByIdData,
            index: index,
            sportId: logic.sportid,

          );
        });
  }
}
