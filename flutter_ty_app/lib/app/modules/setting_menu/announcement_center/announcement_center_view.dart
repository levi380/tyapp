import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/announcement_center/announcement_center_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/announcement_center/widgets/announcement_center_itme_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/announcement_center/widgets/announcement_center_title_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/announcement_center/widgets/announcement_center_type_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/announcement_center/widgets/announcement_pin_button_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/announcement_center/widgets/announcement_search_widget.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import '../../../../generated/locales.g.dart';
import 'package:flutter_ty_app/app/utils/image_util.dart';
import '../../../widgets/fireworks/fireworks_animation.dart';
import '../../../widgets/fireworks/fireworks_controller.dart';
import '../../../widgets/empty/no_data.dart';
import '../../main_tab/main_tab_controller.dart';
import 'announcement_center_controller.dart';
import 'widgets/notce_picker.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a3a627ae-2de5-4ce2-862f-eeb8573aa24d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 公告中心】】】
    【【【 AUTO_PARAGRAPH_TITLE 公告中心 视图页面 AnnouncementCenterPage  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 公告中心 视图页面 AnnouncementCenterPage
    - AnnouncementCenterPage
    ```
    ///头部
    _title(),

    ///球种类型
    if (controller.nl.isNotEmpty) _type(),

    ///搜索框
    if (controller.nb.isNotEmpty) _search()

    ```
    】】】
 *
 */
class AnnouncementCenterPage extends StatefulWidget {
  const AnnouncementCenterPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementCenterPage> createState() => _QuickBetAmountPageState();
}

class _QuickBetAmountPageState extends State<AnnouncementCenterPage> {
  final controller = Get.find<AnnouncementCenterController>();
  final logic = Get.find<AnnouncementCenterController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnnouncementCenterController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            color: context.isDarkMode ? Color(0xFF1E2029) : Color(0xFFF2F2F6),
            child: Stack(
              children: [
                SafeArea(
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.maxFinite,
                                color: context.isDarkMode ? null : Colors.white,
                                child: Column(
                                  children: [
                                    ///头部
                                    _title(),

                                    ///球种类型
                                    if (controller.nl.isNotEmpty) _type(),

                                    ///搜索框
                                    if (controller.nb.isNotEmpty) _search()
                                  ],
                                ),
                              ),

                              ///公告列表
                              Expanded(
                                child: _item(),
                              )
                            ],
                          ),
                          Visibility(
                            visible: logic.openDate,
                            child: Column(
                              children: [
                                ///头部
                                _title(),

                                ///公告时间 筛选器
                                _date(),
                              ],
                            ),
                          ),
                        ],
                      ),

                      ///加载页
                      if (logic.updateList) _loading(),
                    ],
                  ),
                ),
                Obx(() => MainTabController.to.isFireworksPaly.value &&
                        FireworksController.to.isFireworksActivityValid(
                            MainTabController.to.activityEntity,
                            FireworksController.to.serverNow)
                    ? FireworksAnimation(
                        id: MainTabController.to.fireworksId.value,
                        beginTime: MainTabController.to.beginTime.value,
                        endTime: MainTabController.to.endTime.value,
                        type: MainTabController.to.fireworksType.value,
                        number: MainTabController.to.fireworksNumber,
                        championName: MainTabController.to.championName.value,
                        championIcon: MainTabController.to.championIcon.value,
                      )
                    : Container()),
              ],
            ),
          ),
        );
      },
    );
  }

  ///头部
  Widget _title() {
    return AnnouncementCenterTitleWidget(
      ///主题
      isDark: context.isDarkMode,

      ///标题 文字国际化 公告中心
      title: LocaleKeys.app_notice_center.tr,

      ///日期选择开关
      openDate: !logic.openDate,

      ///日期选择点击事件
      onOpenDate: () => controller.onOpenDate(),

      ///开始时间
      beginTime: logic.beginTime,

      ///结束时间
      endTime: logic.endTime,
    );
  }

  ///加载页
  Widget _loading() {
    return Container(
      width: double.maxFinite,
      color: context.isDarkMode ? Color(0xFF272932) : Colors.white,
      child: Column(
        children: [
          _title(),
          Expanded(
            child: Center(
              child: Container(
                alignment: Alignment.center,
                child: ImageView(
                  oddsInfoLoadingGif,
                  width: 70.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///球种类型
  Widget _type() {
    return AnnouncementCenterTypeWidget(
      ///主题
      isDark: context.isDarkMode,

      ///菜单控制器
      tabController: controller.tabController,

      ///菜单数据
      nl: controller.nl,

      ///点击索引
      onTap: (index) => controller.onTypeIndex(index),
      typeIndex: logic.typeIndex,
      sIndex: logic.sIndex,
      yIndex: logic.yIndex,

    );
  }

  ///搜索框
  Widget _search() {
    return AnnouncementSearchWidget(
      ///主题
      isDark: context.isDarkMode,

      ///搜索布局开关
      searchBox: logic.searchBox,

      ///悬浮日期字段
      sendTimeOther: logic.sendTimeOther,

      ///搜索输入框内容
      debounceSearch: (value) => controller.debounceSearch(value),

      ///清楚输入框
      onClearSearchText: () => controller.onClearSearchText(),

      ///搜索控制器
      searchController: controller.searchController,

      ///搜索焦点控制器
      focusNode: controller.focusNode,

      ///取消隐藏搜索
      onCancel: () => controller.onCancel(),
    );
  }

  ///公告时间 筛选器
  Widget _date() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            color: Colors.black.withValues(alpha: 0.5),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 14.w,
              right: 14.w,
            ),
            child: NoticePickerWidget(
              onItemClick: (DateTime? rangeStart, DateTime? rangeEnd) {
                ///根据公告日期 筛选
                controller.selectDate(rangeStart, rangeEnd);
              },

              ///绑定控制器的时间区间
              rangeStart: logic.rangeStart,
              rangeEnd: logic.rangeEnd,
            ),
          )
        ],
      ),
    );
  }

  ///公告列表
  Widget _item() {
    final nbList = controller.nbList;
    if (nbList.isNotEmpty) {
      String dateKeyOf(String timestamp) {
        final ms = int.tryParse(timestamp) ?? 0;
        final date = DateTime.fromMillisecondsSinceEpoch(ms);
        return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      }

      for (final item in nbList) {
        item.displayDate = false;
      }

      final Map<String, int> firstIndexMap = {};
      for (final entry in nbList.mapIndexed(
        (i, item) => MapEntry(dateKeyOf(item.sendTimeOther), i),
      )) {
        firstIndexMap.putIfAbsent(entry.key, () => entry.value);
      }

      for (final i in firstIndexMap.values) {
        if (i >= 0 && i < nbList.length) {
          nbList[i].displayDate = true;
        }
      }
    }

    return Stack(
      children: [
        nbList.isNotEmpty
            ? ListViewObserver(
                controller: controller.listObserverController,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: nbList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    controller: controller.scrollController,
                    itemBuilder: (context, index) {
                      return AnnouncementCenterItemWidget(
                        index: index,
                        isDark: context.isDarkMode,
                        getNoticeFrontListNewDataNb: nbList[index],
                        debounceSearch: (value) => controller.debounceSearch(value),
                        onClearSearchText: () => controller.onClearSearchText(),
                        searchController: controller.searchController,
                        focusNode: controller.focusNode,
                        onCancel: () => controller.onCancel(),
                        searchBox: logic.searchBox,
                        nbListLength: nbList.length,
                        typeIndex: logic.typeIndex,
                      );
                    }),
                onObserve: (resultModel) =>
                    controller.onObserves(resultModel.firstChild?.index),
              )
            : NoData(
                content: LocaleKeys.common_no_data.tr,
              ),
        if (logic.returnToFirst == true)
          AnnouncementPinButtonWidget(
            isDark: context.isDarkMode,
            scrollToFirstItem: () => controller.scrollToFirstItem(),
            scrollToTheLastPage: () =>
                controller.scrollToTheLastPage(controller.nbList.length),
          )
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<AnnouncementCenterController>();
    super.dispose();
  }
}
