import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../items/item.dart';
import '../../widgets/time_filtering_view.dart';
import '../../widgets/total_amount_bets _view.dart';
import 'ongoing_initiated_logic.dart';

class OngoingInitiatedPage extends StatelessWidget {
  OngoingInitiatedPage({Key? key}) : super(key: key);

  final logic = Get.find<OngoingInitiatedLogic>();

  @override
  Widget build(BuildContext context) {
    return _dataView();
  }

  _dataView() {
    return GetBuilder<OngoingInitiatedLogic>(
      builder: (logic) {
        return getDataView();
        // return Container(
        //   child: logic.loading
        //       ///加载页面
        //       ? const BetsLoadingView()
        //       : logic.listData.isEmpty

        //           ///无数据页面
        //           ? const NoDataHintsView(
        //               type: 0,
        //             )

        //           ///列表页面
        //           : getListView(),
        // );
      },
    );
  }

  Widget getDataView() {
    return Container(
      color: Color(0xFFF3FAFF),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => TimeFilteringView(
                  type: logic.timeType.value,
                  onChanged: (int value) {
                    logic.setType(value);
                  },
                ).marginSymmetric(vertical: 5.h, horizontal: 40.w)),
            Expanded(
              child: _body().marginSymmetric(horizontal: 10.w),
            ),
          ]),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TotalAmountBetsView().marginSymmetric(vertical: 10.h),
        Expanded(child: _getListView()),
      ],
    );
  }

  Widget _getListView() {
    return ListView.builder(
      itemCount: 15,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Item();
      },
    );
  }

/*
  Widget build3(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 374,
          height: 49,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.only(
                      left: BorderSide(color: Color(0xFFE4E6ED)),
                      top: BorderSide(color: Color(0xFFE4E6ED)),
                      right: BorderSide(width: 1, color: Color(0xFFE4E6ED)),
                      bottom_nav: BorderSide(color: Color(0xFFE4E6ED)),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '总投注单数',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF7981A3),
                          fontSize: 10,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '16',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF303442),
                          fontSize: 14,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 34),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.only(
                      left: BorderSide(color: Color(0xFFE4E6ED)),
                      top: BorderSide(color: Color(0xFFE4E6ED)),
                      right: BorderSide(width: 1, color: Color(0xFFE4E6ED)),
                      bottom_nav: BorderSide(color: Color(0xFFE4E6ED)),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '总子单数',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF7981A3),
                          fontSize: 10,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '8',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF303442),
                          fontSize: 14,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 34),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.only(
                      left: BorderSide(color: Color(0xFFE4E6ED)),
                      top: BorderSide(color: Color(0xFFE4E6ED)),
                      right: BorderSide(width: 1, color: Color(0xFFE4E6ED)),
                      bottom_nav: BorderSide(color: Color(0xFFE4E6ED)),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '总投注额',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF7981A3),
                          fontSize: 10,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '50.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF303442),
                          fontSize: 14,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 34),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '总可赢额',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF7981A3),
                          fontSize: 10,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '50.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF303442),
                          fontSize: 14,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
*/

  Widget build2(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          height: 39,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: ShapeDecoration(
                  color: Color(0xFFF2F2F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 72,
                      height: 26,
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '全部',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF179CFF),
                              fontSize: 12,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                              height: 1.67,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      width: 72,
                      height: 26,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '今日',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF949AB6),
                              fontSize: 12,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                              height: 1.67,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      width: 72,
                      height: 26,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '昨日',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF949AB6),
                              fontSize: 12,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                              height: 1.67,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      width: 72,
                      height: 26,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '近7日',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF949AB6),
                              fontSize: 12,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                              height: 1.67,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

/*
  Widget getListView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ///统计订单数量
        AwaitBetDialogHeadView(
          statistics: logic.statistics,
        ),
        ConstrainedBox(
          ///适配列表长度
          constraints:
              BoxConstraints(maxHeight: isIPad ? 620.h : 480.h, minHeight: 8.h),
          child: ListView.builder(
            itemCount: logic.listData.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return getItem(index);
            },
          ),
        ),
      ],
    );
  }

  Widget getItem(int index) {
    GetH5OrderListDataRecordxData data = logic.listData[index];
    if (data == null) {
      return Container();
    }
    String seriesType = data.seriesType;

    if (seriesType == "1") {
      int matchType = data.matchType ?? 0;
      if (matchType == 3) {
        ///冠军
        return OrderChampionItem(
          type: 0,
          index: index,
          data: data,
        );
      }

      ///单关
      return OrderIndividuallyItem(
        type: 0,
        index: index,
        data: data,
      );
    } else {
      ///各种串关
      return OrderMergeTogetherItem(
        type: 0,
        index: index,
        data: data,
        onTap: () => logic.onTextExpand(index),
      );
    }
  }

  Widget _body() {
    return GetBuilder<AwaitBetsLogic>(
      builder: (logic) {
        return logic.loading
            ? const BetsLoadingView()
            : logic.listData.isEmpty
                ? const NoDataHintsView(
                    type: 0,
                  )
                : Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                        child: SmartRefresher(
                          //不允许下拉刷新
                          enablePullDown: false,
                          //允许上拉加载
                          enablePullUp: logic.listData.isNotEmpty,
                          controller: logic.refreshController,
                          footer: const FooterView(),
                          child: ListView.builder(
                            itemCount: logic.listData.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getItem(index);
                            },
                          ), //列表组件
                        )),
                  );
      },
    );
  }

 */
}
