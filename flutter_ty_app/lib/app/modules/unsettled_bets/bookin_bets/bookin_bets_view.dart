import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../../main.dart';
import '../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../../widgets/date_picker/show_time_bottom.dart';
import '../widgets/bet_time_filter_view.dart';
import '../widgets/bets_loading/bets_loading_view.dart';
import '../widgets/bookin_bet_dialog_head_view.dart';
import '../widgets/item/pre/pre_champion_item.dart';
import '../widgets/item/pre/pre_individually_item.dart';
import '../widgets/no_data_hints/no_data_hints_view.dart';
import 'bookin_bets_logic.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结注单(预约中)视图层】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能展示预约投注的用户界面，支持日期选择、数据加载和列表展示。
    - 主要是APP体育注单-未结注单-预约中列表展示
    - 主要是APP体育注单-未结注单-预约中数据加载框展示
    - 主要是APP体育注单-未结注单-预约中无数据展示
    - 主要是APP体育注单-未结注单-预约中，单关列表
    - 主要是APP体育注单-未结注单-预约中，修改赔率和金额
    - _dataView()根据加载状态展示不同的视图：
    - 加载中：显示加载视图。
    - 无数据：显示无数据提示。
    - 有数据：显示数据列表。
    - getListView()创建一个列表视图，用于展示预约投注的数据。
    - getItem()根据索引返回相应的列表项，如果数据项的 `seriesType` 为 "1"，则返回预约单个项的视图。
    】】】
 *
 */
class BookinBetsPage extends StatelessWidget {
  BookinBetsPage({Key? key}) : super(key: key);

  final logic = Get.find<BookinBetsLogic>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          ///日期选择空间（全部，今天，昨天，一周）
          () => Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: BetTimeFilteringView(
                  type: logic.selectType.value,
                  openSelectTypeTime: logic.openSelectTypeTime.value,
                  onChanged: (int value) {
                    showTimeBottom.resetinitTime();
                    if (value != 5) {
                      logic.setSelectType(value);
                    } else {
                      logic.showTime(context, value);
                    }
                  },
                  startTime: logic.startTime.value,
                  endTime: logic.endTime.value,
                ),
              ),
              if (logic.isOpenTips.value) _descriptionBox(context),
            ],
          ),
        ),
        Obx(
          () =>

              ///统计订单数量
              BookinBetDialogHeadView(
            statistics: [
              logic.statistics_1.value,
              logic.statistics_2.value,
              logic.statistics_3.value
            ],
            isOpenTips: logic.isOpenTips.value,
            onTap: () {
              logic.setIsOpenTips();
            },
          ),
        ),
        _dataView(),
      ],
    );
  }

  ///提示框
  _descriptionBox(BuildContext context) {
    return Positioned(
      right: 0.w,
      bottom: 0.h,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black
              .withValues(alpha: context.isDarkMode ? 0.95 : 0.9), // 图标颜色
          borderRadius: BorderRadius.all(
            Radius.circular(
              5.r,
            ),
          ),
        ),
        height: 24.h,
        alignment: Alignment.center,
        child: Text(
          LocaleKeys.app_subject_to_actual_odds.tr,
          style: TextStyle(
            color:
                Colors.white.withValues(alpha: context.isDarkMode ? 0.95 : 0.8),
            fontSize: 12.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          ),
          // maxLines: 1,
          //  overflow: TextOverflow.ellipsis,
        ).marginOnly(
          left: 5.w,
          right: 5.w,
        ),
      ),
    );
  }

  _dataView() {
    return GetBuilder<BookinBetsLogic>(
      builder: (logic) {
        return Container(
          child: logic.loading

              ///加载页面
              ? const BetsLoadingView()
              : logic.listData.isEmpty

                  ///无数据页面
                  ? const NoDataHintsView(
                      type: 1,
                    )

                  ///列表页面
                  : getListView(),
        );
      },
    );
  }

  Widget getListView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          ///适配列表长度
          constraints:
              BoxConstraints(maxHeight: isIPad ? 650.h : 520.h, minHeight: 8.h),

          ///注单历史列表
          child: ListView.builder(
            itemCount: logic.listData.length,
            controller: logic.scrollController,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return getItem(index);
            },
          ),
        ),
      ],
    );
  }

  ///添加item
  Widget getItem(int index) {
    Widget item = Container();
    GetH5PreBetOrderlistDataRecordxData data = logic.listData[index];
    String seriesType = data.seriesType;

    ///1是单关和冠军，100自选波胆
    if (seriesType == "1" || seriesType == "100") {
      int matchType = data.matchType ?? 0;

      ///冠军
      if (matchType == 3) {
        item = PreChampionItem(
          type: 0,
          index: index,
          data: data,
        );
      } else {
        ///单关
        item = PreIndividuallyItem(
          index: index,
          data: data,
          type: 0,
        );
      }
    }
    return item;
  }
}
