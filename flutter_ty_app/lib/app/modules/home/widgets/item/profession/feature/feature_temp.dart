import 'dart:math';

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/secondary_expand_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../routes/route_manager.dart';
import '../../../../../../utils/widget_utils.dart';
import '../../../../controllers/home_controller.dart';
import 'feature_temp_body_item.dart';
import 'feature_temp_indicator.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-06de67a4-485b-4b00-91a1-b8c4546e388e-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 子玩法 】】】
    【【【 AUTO_PARAGRAPH_TITLE 特色组合UI组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - btnHeight 计算投注按钮高度
    - boxHeight 计算特色组合模块箱体高度
    - _currentPage 监听赔率页面滑动半场还是全场
    - 绘制特色组合队伍标题
    - 特色组合列表数据拆分
    ```
    List<MatchHps> groupList = match.hpsCompose
    .getRange(
    index * 2,
    min((index + 1) * 2,
    match.hpsCompose.length))
    .toList();
    ```
    - 绘制特色组合各分段赔率按钮

    # FeatureTemp 组件总结

    ## 类定义

    ### `FeatureTemp`
    - **描述**: 一个状态管理的 Widget，用于展示比赛相关信息。
    - **构造函数**:
    - `matchEntity`: 比赛实体数据。
    - `hps`: 比赛的赔率列表。

    ## 状态变量

    - `pageController`: 控制页面滑动的控制器。
    - `btnHeight`: 投注按钮的高度。
    - `boxHeight`: 整体高度。
    - `_currentPage`: 当前选中的页面索引）。

    ## 生命周期方法

    ### `initState()`
    - 初始化 `pageController`，并设置初始页面。
    - 动态计算整体高度。
    - 监听页面滑动事件并更新当前页面索引。

    ### `didUpdateWidget()`
    - 处理 Widget 更新时的逻辑。

    ### `dispose()`
    - 清理 `pageController` 资源。

    ### 标题列表
    - `titles`: 全场独赢和两队都进球的标题。
    - `titles2`: 全场独赢和进球大小的标题。

    ### `build()`
    - 构建界面，使用 `GetBuilder` 监控数据变化。
    - 使用 `PageView` 实现页面滑动功能。
    - 根据赔率数据动态生成页面内容。
    - 显示指示器以指示当前页面。

    ## 事件处理

    - **页面滑动**: 监听页面变化，更新当前索引并发送事件。
    - **动态高度计算**: 根据按钮高度动态计算整体高度。

    】】】
 *
 */

///特色组合
class FeatureTemp extends StatefulWidget {
  const FeatureTemp({
    super.key,
    required this.matchEntity,
    required this.hps,
    this.playId = '',
    this.pids = '',
  });

  final List<MatchHps> hps;

  final MatchEntity matchEntity;
  final String playId;
  final String pids;

  @override
  State<FeatureTemp> createState() => _FeatureTempState();
}

class _FeatureTempState extends State<FeatureTemp> {
  late PageController pageController;

  ///投注按钮高度
  RxDouble btnHeight = 35.0.obs;

  ///整体高度
  RxDouble boxHeight = 140.0.obs;

  ///选中都滑动页面
  RxInt _currentPage = 0.obs;

  @override
  void initState() {
    pageController = PageController(
        initialPage:
            (widget.hps.length / 3).ceil() >= 2 ? SecondaryController.index : 0,
        keepPage: true,
        viewportFraction: 1);
    /**
     *
     *
        【【【 AUTO_DOCUMENT_UUID tyApp-06de67a4-485b-4b00-91a1-b8c4546e388e-sz 】】】
        【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
        【【【 AUTO_DOCUMENT_TITLE 子玩法 】】】
        【【【 AUTO_PARAGRAPH_TITLE 初始化计算投注按钮高度 】】】
        【【【 AUTO_PARAGRAPH_CONTENT
        - 动态计算整体高度
        ```
        boxHeight = RxDouble((btnHeight * 3 + 4 + 20).toDouble());
        ```
        】】】
     *
     */
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        _currentPage.value = SecondaryController.index;

        pageController.jumpToPage(SecondaryController.index);
        //动态计算整体高度
        boxHeight = RxDouble((btnHeight * 3 + 4 + 20).toDouble());
      }
    });
    super.initState();
    /**
     *
     *
        【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
        【【【 AUTO_DOCUMENT_TITLE 子玩法 】】】
        【【【 AUTO_PARAGRAPH_TITLE 监听赔率页面滑动 】】】
        ```
        //滑动页面监听发送
        if (SecondaryController.index != index) {
        setState(() {
        SecondaryController.setIndex(index);
        WidgetUtils.instance()
        .streamController
        ?.sink
        .add(index);
        _currentPage.value = index;

        });
        ```
        【【【 AUTO_PARAGRAPH_CONTENT
        - 滑动页面
        ```
        pageController.animateToPage(event,duration: const Duration(milliseconds: 300), curve: Curves.ease);
        ```
        】】】
     *
     */
    WidgetUtils.instance().stream.listen((event) {
      if (mounted) {
        _currentPage.value = event;

        ///监听赔率页面滑动
        pageController.animateToPage(event,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
    });
  }

  @override
  void didUpdateWidget(covariant FeatureTemp oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  ///标题 全场独赢 & 两队都进球 // 半场独赢 & 两队都进球
  List<String> titles = [
    (LocaleKeys.football_playing_way_all_both.tr),
    (LocaleKeys.football_playing_way_half_both.tr),
  ];

  ///标题 全场独赢 & 进球大小 // 半场独赢 & 进球大小
  List<String> titles2 = [
    (LocaleKeys.football_playing_way_all_total_goal.tr),
    (LocaleKeys.football_playing_way_half_total_goal.tr),
  ];

  @override
  Widget build(BuildContext context) {
    // 特色组合
    return GetBuilder<DataStoreController>(
      init: DataStoreController(),
      autoRemove: false,
      id: DataStoreController.to.getMatchId(widget.matchEntity.mid),
      builder: (logic) {
        MatchEntity match = widget.matchEntity;
        // hps 两个分一组 返回两个数字中的较大者
        int length = max((match.hpsCompose.length / 2).ceil(), 2);
        return Obx(
          () {
            return InkWell(
              onTap: widget.playId.isNotEmpty
                  ? () {
                      if (widget.playId.isNotEmpty) {
                        // 次要玩法跳转指定玩法集tab
                        RouteManager.goMatchDetail(
                          mid: match.mid,
                          playId: widget.playId,
                          pids: widget.pids,
                          csid: match.csid,
                        );
                      }
                    }
                  : null,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            minHeight:
                                isIPad ? boxHeight.value.w : boxHeight.value,
                            maxHeight: ((isIPad
                                    ? boxHeight.value.w + 10.w
                                    : boxHeight.value + 10) +
                                (TyTextScaler.instance().isScale ? 18 : 0)),
                          ),
                          child: PageView(
                            controller: pageController,
                            padEnds: true,
                            onPageChanged: (index) {
                              //滑动页面监听发送
                              if (SecondaryController.index != index) {
                                setState(() {
                                  SecondaryController.setIndex(index);
                                  WidgetUtils.instance()
                                      .streamController
                                      .sink
                                      .add(index);
                                  _currentPage.value = index;
                                });
                              }
                            },
                            children: List.generate(length, (index) {
                              if (match.hpsCompose.isEmpty) {
                                //空数据填充
                                return Row(children: [
                                  //全场进球标题
                                  featureTempbodyItem(match, MatchHps(),
                                      titles[index], 0, btnHeight, context),
                                  const Spacer(),
                                  //半场进球标题
                                  featureTempbodyItem(match, MatchHps(),
                                      titles2[index], 1, btnHeight, context),
                                ]);
                              }
                              List<MatchHps> groupList = match.hpsCompose
                                  .getRange(
                                      index * 2,
                                      min((index + 1) * 2,
                                          match.hpsCompose.length))
                                  .toList();
                              return Row(children: [
                                ///左列表
                                featureTempbodyItem(
                                    match,
                                    groupList.safeLast ?? MatchHps(),
                                    titles[index],
                                    0,
                                    btnHeight,
                                    context),
                                const Spacer(),

                                ///右列表
                                featureTempbodyItem(
                                    match,
                                    groupList.safeFirst ?? MatchHps(),
                                    titles2[index],
                                    1,
                                    btnHeight,
                                    context),
                              ]);
                            }),
                          ),
                        ),
                        if (length > 1)
                          Container(
                            height: 10.w,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //指示器
                                featureTempIndicator(
                                    context, _currentPage.value == 0),
                                SizedBox(width: 2.w),
                                featureTempIndicator(
                                    context, _currentPage.value == 1),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (TyHomeController.to.visiable)
                    Positioned(
                      right: 0,
                      child: ImageView(
                        SecondaryController.index == 0
                            ? 'assets/images/detail/ico_arrow_left.gif'
                            : 'assets/images/detail/ico_arrow_right.gif',
                        width: 16.w,
                        height: 16.w,
                      ),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
