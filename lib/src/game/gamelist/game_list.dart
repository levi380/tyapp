import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/common/language.dart';
import 'gamelist_controller.dart';
import 'package:easy_refresh/easy_refresh.dart';

import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/image_button.dart';
import 'package:filbet/widgets/titlebar.dart';

import 'package:filbet/widgets/custom_searchbar.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/widgets/indicator/rectangular_indicator.dart';
import 'gamedataCell.dart';
import 'package:filbet/widgets/empty_view.dart';
import 'game_item.dart';
import 'package:filbet/widgets/skEasyRefresh.dart';
import 'package:filbet/services/global/global_service.dart';

class GameListitemView extends StatefulWidget {
  final int type; // 新增参数

  GameListitemView({Key? key, required this.type}) : super(key: key);

  @override
  State<GameListitemView> createState() => _GameListitemViewState();
}

class _GameListitemViewState extends State<GameListitemView> {
  // 保持页面状态‌:ml-citation{ref="6" data="citationList"}

  int _currentPage = 1;

  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final venueId = args?["platform_id"]?.toString();
    print('[GameListitemView] args=' +
        (args?.toString() ?? 'null') +
        ' venueId=' +
        (venueId ?? 'null') +
        ' isRegistered=' +
        Get.isRegistered<GameListController>(tag: venueId).toString());
    return GetBuilder<GameListController>(
        tag: venueId, // ✅ 一定要加上这个 tag！

        builder: (logic) {
          print('[GameListitemView] builder tag=' +
              (venueId ?? 'null') +
              ' controller.platform_id=' +
              (logic.platform_id?.toString() ?? 'null'));
          return widget.type == 2
              ? _body(
                  const NeverScrollableScrollPhysics(),
                )
              : EasyRefreshConfig.build(
                  controller: easyRefreshController,
                  // header: commonHeader,
                  childBuilder: (context, physics) {
                    return _body(physics);
                  },
                  onRefresh: () async {
                    // 下拉刷新逻辑
                    await fetchData(pageNum: _currentPage, isRefresh: true);
                  },
                  onLoad: () async {
                    _currentPage = _currentPage + 1;
                    // 上拉加载逻辑（非必须，按需启用）
                    await fetchData(pageNum: _currentPage);
                  },
                );
        });
  }

  fetchData({int? pageNum, bool isRefresh = false}) {
    GameListController.to.fetchData(
      pageNum,
      onSuccess: (hasMore) {
        //  _controller.finishLoad(hasMore ? IndicatorResult.success : IndicatorResult.noMore);

        if (isRefresh) {
          easyRefreshController.finishRefresh();
          easyRefreshController.resetFooter();
        } else {
          easyRefreshController.finishLoad(
              hasMore ? IndicatorResult.success : IndicatorResult.noMore);
        }
      },
    );
  }

  Widget _body(ScrollPhysics? physics) {
    if (widget.type == 0 && GameListController.to.records.length == 0) {
      return EmptyView();
    }
    if (widget.type == 1 && GameListController.to.hotrecords.length == 0) {
      return EmptyView();
    }
    if (widget.type == 2 && GameListController.to.favgames.length == 0) {
      return EmptyView();
    }

    return _getgameitemCell(physics);
  }

  _getgameitemCell(ScrollPhysics? physics) {
    return GridView.builder(
      padding: EdgeInsets.only(left: 9.0, right: 9.0, top: 0, bottom: 0),
      physics: physics,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 168 / 135,
      ),
      itemCount: widget.type == 0
          ? GameListController.to.records.length
          : widget.type == 1
              ? GameListController.to.hotrecords.length
              : GameListController.to.favgames.length,
      // item数量
      itemBuilder: (context, index) {
        String text = "";
        String image = "";
        bool isfav = false;
        GameInfoModel model = GameInfoModel();
        if (widget.type == 0) {
          text = GameListController.to.records[index].name ?? "";
          image = GameListController.to.records[index].img ?? "";
          isfav = GameListController.to.records[index].fav;
          model = GameListController.to.records[index];
        }
        if (widget.type == 1) {
          text = GameListController.to.hotrecords[index].name ?? "";
          image = GameListController.to.hotrecords[index].img ?? "";
          isfav = GameListController.to.hotrecords[index].fav;
          model = GameListController.to.hotrecords[index];
        }

        if (widget.type == 2) {
          text = GameListController.to.favgames[index].name ?? "";
          image = GameListController.to.favgames[index].img ?? "";
          isfav = true;
          model = GameListController.to.favgames[index];
        }

        return GameDataCell(
            text: text,
            image: image,
            isfav: isfav,
            startcallBack: () {
              AppNavigator.gotoGame(
                  model.platformId ?? "",
                  model.gameId ?? "",
                  model.name ?? "",
                  GameListController.to.categoryType ?? CategoryType.video);
            },
            callBack: () {
              if (isfav == true) {
                GameListController.to.favdelete(model);
              } else {
                GameListController.to.inserftav(model);
              }
            });
      },
    );
  }
}
