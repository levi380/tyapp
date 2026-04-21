
import 'package:flutter_ty_app/app/extension/string_extension.dart';

import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/score_list.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/team_score_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';

import '../../../../../routes/route_manager.dart';
import '../../../../../utils/sport.dart';
import '../../../../../utils/widget_utils.dart';
import '../../../controllers/secondary_expand_controller.dart';
import 'bet_group_widget.dart';
import 'secodary/flag_widget.dart';

// 引入拆分后的文件
import 'corner_play_rules_util.dart';
import 'corner_play_anim_mixin.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5f158035-f477-4643-a213-01fc14035094-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 通用玩法模型 】】】
    【【【 AUTO_PARAGRAPH_TITLE 列表玩法/角球玩法/15分钟玩法 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - isMainPlay 是否是主列表
    - playId 子玩法playId
    - match 列表赛事数据
    - hSpecial 15分钟时段
    ```
    if (hasHps) {
    hSpecial = NumUtil.subtract(num.parse(widgets.hps[index].hSpecial), 1)
    .toInt()
    .obs
    .string;
    } else {
    hSpecial = "0";
    }
    if (num.parse(hSpecial).toInt() == 2) {
    hSpecial = "3";//不显示阶段2
    }
    if (num.parse(hSpecial).toInt() > 4) {
    hSpecial = "4"; //容错 下标不能大于4 最大特5
    }

    if (num.parse(hSpecial).toInt() < 0) {
    hSpecial = "0";
    }
    ```
    - minutesTitle 时段标题
    ```
    ///更新15分钟提示标题
    if (widgets.playId == playIdConfig.hps15Minutes) {
    if (mounted) {
    setState(() {
    List result = titleList
    .where((element) => element['value'] == num.parse(hSpecial))
    .toList();
    minutesTitle = result.first['title'];
    });
    }
    }
    ```
    - 显示进球动画 isShowGoal
    ```
    WidgetUtils.instance().ShowGoalStream.listen((event) {
    if (mounted) {
    // AppLogger.debug("收到C115通知_进球更新动画");
    ShowGoalAnimation(event, widgets.match.mid);
    }
    });
    ```
    - 是否显示红牌 isShowRed
    - 显示伤停补时 isShowMststi
    - 显示各种提示动画 hint
    ```
    for (var e in TyHomeController.to.EventInfoList) {
    if (match.cmec == e.nameCode) {
    if (mounted) {
    setState(() {
    hit = HintLanguage.gethint(language, e);
    });
    }
    break; // 只取第一个符合条件的比分
    }
    }
    ```
    ## CornerPlayTemp 组件概述

    `CornerPlayTemp` 是一个用于展示角球玩法的 Flutter 组件，支持比赛相关信息的动态更新和动画效果。

    ### 属性
    - **match**: 当前比赛数据 (`MatchEntity`)。
    - **hps**: 比赛相关的玩法数据 (`List<MatchHps>`)。
    - **isMainPlay**: 是否为主玩法，默认为 `true`。
    - **playId**: 当前玩法 ID，默认为空字符串。

    ### 状态变量
    - **hSpecial**: 计算的特殊比分参数，初始为 "0"。
    - **minutesTitle**: 15分钟玩法的标题。
    - **language**: 当前语言设置。
    - **threeBoxHeight**: 高度设置，初始为 110。

    ### 生命周期方法
    - **initState**: 初始化组件，设置监听器和更新提示。
    - **didUpdateWidget**: 处理组件更新，显示红牌和提示动画。
    - **build**: 构建 UI，展示比赛信息和动态效果。

    ### UI 逻辑
    - 使用 `Stack` 和 `Row` 布局展示主队和客队信息，包括进球和红牌动画。
    - 根据 `playId` 判断是否显示特定的玩法信息和动画。
    - 提供规则弹框显示玩法详细信息。

    ### 方法
    - **ruleText**: 根据 `playId` 返回对应的规则标题。
    - **rullGroud**: 返回规则说明的弹框内容。
    - **uptitle**: 更新 15分钟玩法的提示标题。
    - **_isThree**: 判断是否为特定玩法。
    - **_showScoreMatchLine**: 判断比分区域是否显示。
    - **s11Score**: 获取 S11 比分。
    - **resetEvent**: 重置动画状态。
    - **ShowGoalAnimation**: 显示进球动画。
    - **ShowRedAnimation**: 显示红牌动画。
    - **ShowHitAnimation**: 显示伤停补时动画。

    ### 动画控制
    - 控制主队和客队的进球、红牌和伤停补时动画的显示与隐藏，确保 UI 动态更新。

    ### 其他
    - 组件通过 `GetBuilder` 监听状态变化，实现动态更新。

    】】】
 *
 */

class CornerPlayTemp extends StatefulWidget {
  const CornerPlayTemp({
    super.key,
    required this.match,
    required this.hps,
    this.isMainPlay = true,
    this.playId = '',
    this.pids = "",
  });

  final MatchEntity match;
  final List<MatchHps> hps;
  final bool isMainPlay;
  final String playId;
  final String pids;

  @override
  State<CornerPlayTemp> createState() => _CornerPlayTempState();
}

class _CornerPlayTempState extends State<CornerPlayTemp>
    with SingleTickerProviderStateMixin, CornerPlayAnimMixin {
  // 状态变量
  String hSpecial = "0";
  String minutesTitle = '';
  String language = '';
  double threeBoxHeight = 110;
  StreamSubscription? _goalSubscription;
  StreamSubscription? _generalSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        _updateTitles();
        language = StringKV.language.get() ?? "CN";
      }
    });

    _goalSubscription = WidgetUtils.instance().ShowGoalStream.listen((event) {
      if (mounted) handleGoalAnimation(event, widget.match.mid);
    });

    _generalSubscription = WidgetUtils.instance().stream.listen((event) {
      if (mounted) _updateTitles();
    });

    super.initState();
  }

  @override
  void dispose() {
    _goalSubscription?.cancel();
    _generalSubscription?.cancel();
    super.dispose();
  }

  void _updateTitles() {
    if (!widget.isMainPlay) {
      if (widget.playId == playIdConfig.hps15Minutes) {
        _update15MinTitle(SecondaryController.index);
      } else if (widget.playId == playIdConfig.hps6Minutes) {
        _update6MinTitle(SecondaryController.index);
      }
    }
  }

  @override
  void didUpdateWidget(covariant CornerPlayTemp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.match.mid == oldWidget.match.mid &&
        [1].contains(widget.match.csid.toInt())) {
      if (!widget.isMainPlay && widget.playId == playIdConfig.hps15Minutes) {
        // 15分钟玩法时间差异检测逻辑
        int difference = (widget.match.mst.toInt() / 60).floor();
        int residue = (difference / 15).floor();
        int olddifference = (oldWidget.match.mst.toInt() / 60).floor();
        int oldresidue = (olddifference / 15).floor();
        if (residue != oldresidue) {
          _update15MinTitle(SecondaryController.index);
        }
      }

      // 使用 Mixin 处理动画
      handleRedAnimation(oldWidget.match, widget.match);
      handleHitAnimation(oldWidget.match, widget.match, language);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasRule = widget.playId == playIdConfig.hps15Minutes ||
        widget.playId == playIdConfig.hps6Minutes ||
        widget.playId == playIdConfig.hpsPunish ||
        widget.playId == playIdConfig.hpsPenalty;

    return InkWell(
      onTap: widget.playId.isNotEmpty
          ? () {
        if (widget.playId.isNotEmpty) {
          RouteManager.goMatchDetail(
            mid: widget.match.mid,
            playId: widget.playId,
            pids: widget.pids,
            csid: widget.match.csid,
          );
        }
      }
          : null,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: _calculateContainerHeight(hasRule),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 主队
                      TeamScoreWidget(
                          hint: hit,
                          isShowGoal: isShowHomeGoal,
                          isShowRed: isShowHomeRed,
                          isShowMststi: isShowMststi,
                          isMainPlay: widget.isMainPlay,
                          matchEntity: widget.match,
                          index: 0,
                          playId: widget.playId,
                          hSpecial: hSpecial),
                      2.verticalSpaceFromWidth,
                      // 客队
                      TeamScoreWidget(
                          hint: hit,
                          isShowGoal: isShowAwayGoal,
                          isShowRed: isShowAwayRed,
                          isShowMststi: isShowMststi,
                          isMainPlay: widget.isMainPlay,
                          matchEntity: widget.match,
                          index: 1,
                          playId: widget.playId,
                          hSpecial: hSpecial),
                      // 加时说明
                      Visibility(
                        visible: widget.playId == playIdConfig.hpsOvertime,
                        child: Text(
                          CornerPlayRulesUtil.getRuleTitle(
                              playId: widget.playId,
                              match: widget.match,
                              hps: widget.hps,
                              currentHSpecial: hSpecial),
                          style: TextStyle(
                              height: 1.4,
                              color: const Color(0xFF7981A4),
                              fontSize: 11.sp),
                        ),
                      ),
                      const Spacer(),
                      // 底部规则/标题栏
                      Visibility(
                        visible: hasRule,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ///悬浮弹框
                            WidgetUtils.instance().showToolTip(
                                context.isDarkMode
                                    ? const Color(0xff2E3846)
                                    : Colors.white,
                                CornerPlayRulesUtil.buildRulePopup(context, widget.playId, context.isDarkMode),
                                ImageView(
                                  widget.playId == playIdConfig.hps6Minutes
                                      ? 'assets/images/icon/rull2.png'
                                      : 'assets/images/icon/rull.svg',
                                  width: 18.w,
                                  height: 18.w,
                                ),
                                arrowColor: context.isDarkMode
                                    ? const Color(0xff2E3846)
                                    : Colors.white),
                            5.horizontalSpace,
                            Expanded(
                                child: Text(
                                  minutesTitle.isNotEmpty
                                      ? minutesTitle
                                      : CornerPlayRulesUtil.getRuleTitle(
                                      playId: widget.playId,
                                      match: widget.match,
                                      hps: widget.hps,
                                      currentHSpecial: hSpecial),
                                  style: TextStyle(
                                    color: widget.playId == playIdConfig.hps6Minutes
                                        ? const Color(0xFFFEAE2C)
                                        : const Color(0xFF7981A4),
                                    fontSize: 11.sp,
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Visibility(
                        visible: widget.isMainPlay,
                          child:GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => RouteManager.goMatchDetail(
                                mid: widget.match.mid, csid: widget.match.csid),
                            child: FlagWidget(
                                type: 0, matchEntity: widget.match),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
              // 右侧区域 (BetGroup)
              SizedBox(width: 8.w),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BetGroupWidget(
                      matchEntity: widget.match,
                      hps: widget.hps,
                      playId: widget.playId,
                      isMainPlay: widget.isMainPlay,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 底部/角标信息
          Positioned(
            right: 8.w,
            bottom: 5.w,
            child: Row(
              children: [
                if (widget.match.mfo != null &&
                    !SportData.getSportsMS([SportData.sportMs_1, SportData.sportMs_10])!.contains(widget.match.ms) &&
                    SportData.getSportsCsid([5, 7, 8, 9, 10])!.contains(int.parse(widget.match.csid)) &&
                    widget.match.ms == 110)
                  Text(
                    widget.match.mfo,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha: 0.3)
                          : const Color(0xffAFB3C8),
                    ),
                  ),
              ],
            ),
          ),
          // 主玩法比分区域
          if (widget.isMainPlay)
            Positioned(
              bottom: int.parse(widget.match.csid) == SportData.sportCsid_37 ? -2.h : 0,
              right: 8.w,
              child: ScoreList(match: widget.match),
            ),
        ],
      ),
    );
  }

  /// 辅助方法：计算容器高度
  double _calculateContainerHeight(bool hasRule) {
    double baseHeight;
    if (_isThree()) {
      baseHeight = widget.isMainPlay
          ? (_showScoreMatchLine(widget.match) ? 132.0 : threeBoxHeight + 10)
          : (!hasRule ? 92.0 : threeBoxHeight);
    } else {
      baseHeight = widget.isMainPlay ? 108.5 : (!hasRule ? 72.0 : 108.5);
    }
    return baseHeight + (TyTextScaler.instance().isScale ? 18 : 0);
  }

  /// 更新15分钟标题状态
  void _update15MinTitle(int eventIndex) {
    if (mounted) {
      setState(() {
        hSpecial = CornerPlayRulesUtil.calculate15MinHSpecial(
            widget.hps, eventIndex);
        minutesTitle = CornerPlayRulesUtil.getPeriodTitle(
            widget.playId, hSpecial);
      });
    }
  }

  /// 更新6分钟标题状态
  void _update6MinTitle(int eventIndex) {
    if (mounted) {
      setState(() {
        hSpecial = CornerPlayRulesUtil.calculate6MinHSpecial(
            widget.hps, eventIndex);
        minutesTitle = CornerPlayRulesUtil.getPeriodTitle(
            widget.playId, hSpecial);
      });
    }
  }

  /// 足球1 冰球4 手球11 水球16 是否显示三行
  bool _isThree() {
    return SportData.getSportsCsid([
      SportData.sportCsid_1,
      SportData.sportCsid_4,
      SportData.sportCsid_11,
      SportData.sportCsid_16,
      SportData.sportCsid_37
    ])!.contains(int.tryParse(widget.match.csid));
  }

  bool _showScoreMatchLine(MatchEntity match) {
    int csid = int.tryParse(match.csid) ?? 0;
    return SportData.getSportsMS([SportData.sportMs_1])!.contains(match.ms) &&
        SportData.getSportsCsid([2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])!
            .contains(csid);
  }
}