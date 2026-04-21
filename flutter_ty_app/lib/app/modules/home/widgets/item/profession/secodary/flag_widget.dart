
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';

import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/lodash.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';

import '../../../../../../global/ty_user_controller.dart';
import '../../../../../../utils/sport.dart';
import '../../../../controllers/home_controller_ext.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 常规赛事 】】】
    【【【 AUTO_PARAGRAPH_TITLE 图标UI部件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    ## 组件概述
    `FlagWidget` 是一个用于展示比赛相关标志的组件，包含足球图标、视频图标、中立场图标、角球图标和提前结算图标。

    ## 属性
    - **widget.matchEntity**: 比赛实体，包含比赛的详细信息。
    - **type**: 类型标识，0 表示常规版，1 表示新手版。

    ## 方法
    ### build
    - 构建组件的 UI。
    - 根据用户登录状态和比赛信息决定显示哪些图标。

    ### getCornerKick
    - 判断是否显示角球图标。
    - 从比赛实体中获取角球信息，检查是否包含特定标识。

    ### flagImage
    - 辅助方法，用于创建图标。
    - 接收图标路径和可选高度，返回一个包含图标的 `ImageView` 组件。

    ### createWidgets
    - 创建并返回一个包含多个图标的列表。
    - 根据比赛类型添加不同的图标。

    ### UI 逻辑
    - 使用 `Row` 布局展示多个图标。
    - 根据条件判断是否显示图标，例如用户是否登录、比赛状态等。
    - 使用 `ColorFiltered` 来呈现灰色图标，表示不可用状态。
    】】】
 *
 */

///子玩法图标
// ignore: must_be_immutable

class FlagWidget extends StatefulWidget {
  const FlagWidget({
    super.key,
    required this.matchEntity,
    required this.type,
  });

  final MatchEntity matchEntity; // 比赛实体
  final int type; // 0: 常规, 1: 新手版

  @override
  State<FlagWidget> createState() => _FlagWidgetState();
}

class _FlagWidgetState extends State<FlagWidget> {

  late bool isShowCornerKick = false;

  // 辅助方法，用于生成图标
  Widget flagImage(String path, {double? h}) {
    return ImageView(
      path,
      width: 18.w, // 图标宽度
      height: h ?? 18.w, // 图标高度
      boxFit: BoxFit.cover, // 图标适应方式
    ).marginOnly(right: 4.w); // 设置右边距
  }

  // 创建图标列表
  // List<Widget> createWidgets() {
  //   List<String> list = [];
  //   list.addAll([
  //     'assets/images/sport/ico_footerball.svg', // 足球图标
  //     'assets/images/sport/ico_video.svg', // 视频图标
  //   ]);
  //   // 如果不是电子竞技赛事，添加其他图标
  //   if (!CsidUtil.is_eports_csid(widget.matchEntity.csid)) {
  //     list.addAll([
  //       'assets/images/sport/ico_zhubo.svg', // 直播图标
  //       'assets/images/sport/ico_cornerkick.svg', // 角球图标
  //       'assets/images/sport/ico_time.svg', // 提前结算图标
  //     ]);
  //   }
  //   // 返回图标列表
  //   return list
  //       .map((e) => ImageView(
  //             e,
  //             width: 18.w,
  //             height: 18.w,
  //             boxFit: BoxFit.contain, // 图标适应方式
  //           ).marginOnly(right: 4.w)) // 设置右边距
  //       .toList();
  // }

  @override
  void initState(){
    super.initState();
    isShowCornerKick = _getCornerKick();
  }

  @override
  void didUpdateWidget(covariant FlagWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.matchEntity != widget.matchEntity ||
        oldWidget.type != widget.type) {
      isShowCornerKick = _getCornerKick();
    }
  }

  // 获取是否显示角球的状态
  bool _getCornerKick() {
    List<String> list =
    lodash.get(widget.matchEntity.toJson(), 'msc'); // 从比赛实体获取角球信息
    if (list.isEmpty) {
      return false; // 如果列表为空，返回 false
    }
    bool isShow = false;
    try {
      var str = list
          .firstWhere((element) => element.contains('S5|')); // 查找包含 'S5|' 的元素
      isShow = str.isNotEmpty; // 如果找到，设置为 true
      return isShow;
    } catch (e) {
      return false; // 如果没有找到，返回 false
    }
  }


  @override
  Widget build(BuildContext context) {
    // 获取是否显示角球的状态
    // bool getCornerKick() {
    //   List<String> list =
    //       lodash.get(widget.matchEntity.toJson(), 'msc'); // 从比赛实体获取角球信息
    //   if (list.isEmpty) {
    //     return false; // 如果列表为空，返回 false
    //   }
    //   bool isShow = false;
    //   try {
    //     var str = list
    //         .firstWhere((element) => element.contains('S5|')); // 查找包含 'S5|' 的元素
    //     isShow = str.isNotEmpty; // 如果找到，设置为 true
    //     return isShow;
    //   } catch (e) {
    //     return false; // 如果没有找到，返回 false
    //   }
    // }

    return Container(
      alignment: Alignment.center,
      height: 18.w, // 设置容器高度
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 判断用户是否登录以及 mvs 是否大于 -1，来决定是否显示动画
          if (TYUserController.to.userInfo.value == null ||
              TYUserController.to.userInfo.value?.ommv == 1)
            widget.matchEntity.mvs > -1
                ? GestureDetector(
                    onTap: () => TyHomeController.to.changePipVideo(
                        type: "animation", matchEntity: widget.matchEntity),
                    child: flagImage(
                        'assets/images/sport/ico_footerball.svg')) // 显示足球图标
                : ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                    child: flagImage(
                        'assets/images/sport/ico_footerball.svg'), // 显示灰色足球图标
                  ),

          /// 判断是否显示视频图标
          (RouteCheckUtil.checkIsLogin() &&
                  widget.matchEntity.mms > 1 &&
                  SportData.getSportsMS([
                    SportData.sportMs_1,
                    SportData.sportMs_2,
                    SportData.sportMs_7,
                    SportData.sportMs_10,
                    SportData.sportMs_110
                  ])!
                      .contains(widget.matchEntity.ms))
              ? GestureDetector(
                  onTap: () => TyHomeController.to
                      .changePipVideo(type: "video", matchEntity: widget.matchEntity),
                  child:
                      flagImage('assets/images/sport/ico_video.svg')) // 显示视频图标
              : ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  child: flagImage(
                      'assets/images/sport/ico_video.svg'), // 显示灰色视频图标
                ),

          // 判断是否为中立场
          if (!SportData.getSportsCsid([
                SportData.sportCsid_5,
                SportData.sportCsid_10,
                SportData.sportCsid_7,
                SportData.sportCsid_8,
                SportData.sportCsid_13
              ])!
                  .contains(int.tryParse(widget.matchEntity.csid)) &&
              widget.matchEntity.mng != 0)
            flagImage('assets/images/sport/midfield_icon_app.svg', h: 18.w),
          // 显示中立场图标

          // 判断是否显示角球图标
          if (SportData.getSportsCsid([SportData.sportCsid_1])!
                  .contains(int.tryParse(widget.matchEntity.csid)) &&
              isShowCornerKick == true &&
              !widget.matchEntity.isDZ)
            flagImage('assets/images/sport/ico_cornerkick.svg'),
          // 显示角球图标

          // 判断是否支持提前结算
          if (RouteCheckUtil.checkIsLogin() &&
              ((SportData.getSportsCsid([SportData.sportCsid_1])!
                          .contains(int.tryParse(widget.matchEntity.csid)) &&
                      TYUserController.to.isSettleSwitch() &&
                      widget.matchEntity.mearlys == 1) ||
                  (SportData.getSportsCsid([SportData.sportCsid_2])!
                          .contains(int.tryParse(widget.matchEntity.csid)) &&
                      TYUserController.to.isSettleSwitchBasket() &&
                      widget.matchEntity.mearlys == 1)))
            flagImage('assets/images/sport/ico_time.svg'),
          // 显示提前结算图标
        ],
      ),
    ).paddingZero.marginOnly(bottom: widget.type == 0 ? 5.w : 0.w); // 根据类型设置底部边距
  }
}
