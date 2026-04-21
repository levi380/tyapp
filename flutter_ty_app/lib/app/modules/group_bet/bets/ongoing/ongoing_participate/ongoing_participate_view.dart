import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'ongoing_participate_logic.dart';

class OngoingParticipatePage extends StatelessWidget {
  OngoingParticipatePage({Key? key}) : super(key: key);

  final logic = Get.find<OngoingParticipateLogic>();

  @override
  Widget build(BuildContext context) {
    return Container();
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
