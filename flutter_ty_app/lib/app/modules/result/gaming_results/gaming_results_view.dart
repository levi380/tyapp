

import '../../../utils/change_skin_tone_color_util.dart';

import '../../login/login_head_import.dart';
import '../widgets/all_events_widget.dart';
import '../widgets/date_widget.dart';
import '../widgets/download_data_widget.dart';
import '../widgets/results_itme_dj_widget.dart';
import '../widgets/results_no_data_widget.dart';
import '../widgets/type_filter_widget.dart';
import 'gaming_results_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-986a10e2-8038-4187-b36c-717a79579d9c-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  电竞赛果 视图页面 GamingResultsPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  电竞赛果 视图页面  GamingResultsPage
    - GamingResultsPage
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
class GamingResultsPage extends StatefulWidget {
  final int titleIndex;

  const GamingResultsPage(this.titleIndex, {super.key});

  @override
  State<GamingResultsPage> createState() => _GamingResultsPageState();
}

class _GamingResultsPageState extends State<GamingResultsPage> {
  final controller = Get.find<GamingResultsController>();
  final logic = Get.find<GamingResultsController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GamingResultsController>(
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                color: context.isDarkMode
                    ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
                    : Color(0xFFF2F2F6),
                child: Column(
                  children: [
                    Container(
                      color: context.isDarkMode ? null : Colors.white,
                      child: Column(
                        children: [
                          _date(),
                          _typeFilter(),
                        ],
                      ),
                    ),
                    GetBuilder<GamingResultsController>(
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
              GetBuilder<GamingResultsController>(
                id: "back",
                builder: (controller) {
                  return logic.returnToFirst == true
                      ? Positioned(
                    right: 20.w,
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
    return GetBuilder<GamingResultsController>(
      id: "date",
      builder: (controller) {
        return Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.h),
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
    return GetBuilder<GamingResultsController>(
      id: "type",
      builder: (controller) {
        return Container(
          height: 60.h,
          margin: EdgeInsets.only(
            left: 14.w,
            right: 14.w,
          ),
          child: Row(
            children: List<TypeFilterWidget>.generate(
                controller.typeFilterList.length, (index) {
              return TypeFilterWidget(
                onTap: () => controller.onTypeFilterIndex(index),
                miid: controller.typeFilterList[index].miid,
                title: controller.typeFilterList[index].name,
                isSelected: logic.typeFilterIndex == index ? true : false,
                isDark: context.isDarkMode,
                index: index,
                titleIndex: widget.titleIndex,
              );
            }).toList(),
          ),
        );
      },
    );
  }

  ///列表
  Widget _body() {
    return GetBuilder<GamingResultsController>(
      id: "data",
      builder: (controller) {
        return Expanded(
          child: logic.downloadData == true
              ? const DownloadDataWidget()
              : logic.noData == false
                  ? _item()
                  : const ResultsNoDataWidget(),
        );
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
        itemBuilder: (context, index) {
          TidDataList dataItem = controller.matcheResultData[index];
          return ResultsItemDjWidget(
            isDark: context.isDarkMode,
            isIcon: logic.isIcon,
            dataItem: dataItem,
            noticeListByIdData: controller.noticeListByIdData,
            onExpandItem: ()=> controller.onExpandItem(dataItem),
            onIsIcon: (mid)=> controller.onIsIcon(mid),
            mid:logic.mid,
            miid: controller.typeFilterList[logic.typeFilterIndex].miid,
            onGoToDetails: (item) => controller.onGoToDetails(item, widget.titleIndex),
            index: index,
          );
        });
  }
}
