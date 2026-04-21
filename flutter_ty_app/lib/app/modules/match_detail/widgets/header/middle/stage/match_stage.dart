import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child1.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child10.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child11.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child13.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child14.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child15.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child16.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child2.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child3.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child4.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child5.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child6.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child7.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child8.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/templates/stage_child9.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/time_zone/timeZoneUtils.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../../core/constant/common/module/csid.dart';
import '../../../../../../utils/format_date_util.dart';
import '../../../../controllers/match_tools_methods.dart';
import 'show_start_time.dart';
import 'templates/stage_child101.dart';
import 'templates/stage_child37.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-b193a488-950c-4758-a598-07d84641c373 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 比分+队伍+赛事阶段】】】
    【【【 AUTO_PARAGRAPH_TITLE 全部球种赛事阶段展示】】】
    【【【 AUTOMATIC_GENERATE_DOCUMENT_PARAGRAPH_CONTENT
    - 赛事未开赛时，距离开赛时间大于一个小时，显示月和日。否则展示开赛倒计时组件
    - 赛事已开赛显示不同球种赛事阶段模板
    ```
    // 赛事未开赛
    if (widgets.match.ms == 0) {
    // 即将开赛的赛事不显示日期
    if (!isOneHour) {
    // 距离开赛时间大于一个小时 显示月和日
    return DateFormat(LocaleKeys.time2.tr).format(
    DateTime.fromMillisecondsSinceEpoch(int.tryParse(
    TimeZoneUtils.convertTimeToTimestamp(widgets.match.mgt,
    isMilliseconds: true, returnMilliseconds: true)
    .toString()) ??
    0));
    }
    if (isPinnedAppbar && isOneHour) {
    return "isOneHour";
    }
    return null;
    }
    // 赛事结束
    else if (widgets.match.ms == 3 || widgets.match.mo == 1) {
    if (["1", "2"].contains(widgets.match.csid)) {
    return LocaleKeys.match_info_match_over.tr;
    } else {
    return LocaleKeys.match_info_match_end.tr;
    }
    } else if (widgets.match.ms == 110) {
    return "ms_${widgets.match.ms}".tr;
    }
    ```
    - 显示不同赛事阶段模板
    - 中立场展示
    ```
    /// 是否中立场 即将开赛不显示中立场
    if (isMidField() && widgets.match.ms != 110)
    ```
    】】】
 *
 */
class MatchStage extends StatefulWidget {
  const MatchStage({
    super.key,
    required this.match,
    this.isPinnedAppbar = false,
    this.isMatchSelect = false,
    this.isMatchSelectCell = false,
    this.timeLineWrapDisplay = false,
  });

  /// 赛事详情实体
  final MatchEntity match;

  /// 是否为吸顶状态 (AppBar 上的展示)
  final bool isPinnedAppbar;

  /// 是否在联赛筛选下拉中显示
  final bool isMatchSelect;

  /// 是否在联赛筛选下拉的子 Item 中显示
  final bool isMatchSelectCell;

  /// 时间线是否换行显示
  final bool timeLineWrapDisplay;

  @override
  State<MatchStage> createState() => _MatchStageState();
}

class _MatchStageState extends State<MatchStage> {
  /// 是否显示倒计时（距离开赛时间小于 1 小时）
  bool isOneHour = false;

  @override
  void initState() {
    super.initState();
    _checkTimeStatus();
    // 监听赛事未开赛事件，用于刷新时间状态
    Bus.getInstance().on(EventType.matchNoStart, (_) {
      _checkTimeStatus();
    });
  }

  @override
  void dispose() {
    Bus.getInstance().off(EventType.matchNoStart);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MatchStage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当赛事时间发生变化时，重新检查状态
    if (oldWidget.match.mgt != widget.match.mgt) {
      _checkTimeStatus();
    }
  }

  /// 检查当前时间与赛事开赛时间的差值，判断是否需要显示倒计时
  void _checkTimeStatus() {
    // 当前时间戳
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;
    // 赛事开赛时间戳
    int mgt = int.tryParse(widget.match.mgt) ?? 0;

    // 如果距离开赛时间在 1 小时(3600*1000ms)以内，且尚未开赛 (>0)，则标记为 isOneHour
    bool newIsOneHour = (mgt - nowTimeStamp) < 3600 * 1000 && (mgt - nowTimeStamp) > 0;
    
    if (isOneHour != newIsOneHour) {
      if (mounted) {
        setState(() {
          isOneHour = newIsOneHour;
        });
      }
    }
  }

  /// 获取顶部显示的赛事文本内容
  ///
  /// 返回显示的文本，如果返回空字符串，则表示需要显示具体的赛事阶段组件。
  String? _getTextOfStageOnTop() {
    // 在联赛下拉筛选的 Cell 中不显示时区
    bool showTimeZone = !(widget.isMatchSelect && widget.isMatchSelectCell);
    return _matchStageContentTop(widget.isPinnedAppbar, showTimeZone: showTimeZone);
  }

  @override
  Widget build(BuildContext context) {
    String? stageOnTop = _getTextOfStageOnTop();

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            // 如果是下拉列表的 Cell，左对齐；否则居中对齐
            mainAxisAlignment: widget.isMatchSelectCell ? MainAxisAlignment.start : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 比赛中断显示图标 (仅限足球 csid=1 且 mmp=80)
              if (["1"].contains(widget.match.csid) && widget.match.mmp == "80")
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: ImageView(
                    'assets/images/detail/match_interrupted_icon.svg',
                    width: 18.w,
                  ),
                ),

              // 显示文本内容 (非倒计时情况)
              if (ObjectUtil.isNotEmpty(stageOnTop) && stageOnTop != "isOneHour")
                Flexible(
                  child: Text(
                    stageOnTop ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: widget.isMatchSelect
                          ? Get.theme.subSelectTitleColor
                          : Colors.white,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      // 吸顶状态下加粗
                      fontWeight: widget.isPinnedAppbar
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                ),

              // 显示即将开赛倒计时组件
              if (stageOnTop == "isOneHour")
                ShowStartTime(
                  match: widget.match,
                  isPinnedAppbar: widget.isPinnedAppbar,
                  isMatchSelect: widget.isMatchSelect,
                ),

              // 显示具体赛事阶段和时间组件 (当文本为空时)
              if (stageOnTop == "")
                  _getMatchStageTemplate(),

              // 是否中立场 (即将开赛不显示中立场)
              if (isMidField(widget.match) && widget.match.ms != 110)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  margin: EdgeInsets.only(left: 4.w),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(23, 156, 255, 1),
                      borderRadius: BorderRadius.circular(4.r)),
                  child: AutoSizeText(
                    "N",
                    style: TextStyle(
                        color: Colors.white, fontSize: isIPad ? 16.sp : 12.sp),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// 根据球种 ID (csid) 获取对应的赛事阶段/比分模板
  Widget _getMatchStageTemplate() {
    String csid = widget.match.csid;
    int? csidInt = int.tryParse(csid);

    // 电竞赛事
    if (Csid.esports_csid.contains(csidInt)) {
      return StageChild101(
          isPinnedAppbar: widget.isPinnedAppbar,
          match: widget.match,
          isMatchSelect: widget.isMatchSelect
      );
    }

    switch (csid) {
      case "1": // 足球
        return StageChild1(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect,
            timeLineWrapDisplay: widget.timeLineWrapDisplay,
        );
      case "2": // 篮球
        return StageChild2(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect,
            timeLineWrapDisplay: widget.timeLineWrapDisplay,
        );
      case "3": // 棒球
        return StageChild3(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect
        );
      case "4": // 冰球
        return StageChild4(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect,
            timeLineWrapDisplay: widget.timeLineWrapDisplay,
        );
      case "5": // 网球
        return StageChild5(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect
        );
      case "6": // 美式足球
        return StageChild6(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect
        );
      case "7": // 斯诺克
        return StageChild7(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect
        );
      case "8": // 乒乓球
        return StageChild8(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect
        );
      case "9": // 排球
        return StageChild9(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect
        );
      case "10": // 羽毛球
        return StageChild10(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect
        );
      case "11": // 手球
        return StageChild11(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect
        );
      case "13": // 沙滩排球
        return StageChild13(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect
        );
      case "14": // 橄榄球
        return StageChild14(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect
        );
      case "15": // 曲棍球
        return StageChild15(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect
        );
      case "16": // 水球
        return StageChild16(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect,
            timeLineWrapDisplay: widget.timeLineWrapDisplay,
        );
      case "37": // 其它/壁球
        return StageChild37(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect
        );
      default:
        return const SizedBox.shrink();
    }
  }

  /// 计算并返回顶部显示的文本内容
  /// 
  /// - 返回值 "isOneHour": 特殊标记，通知 UI 层显示倒计时组件。
  /// - 返回值 "": 空字符串，通知 UI 层显示 `StageChild` 模板。
  /// - 其他: 显示具体的文本（如日期、结束状态等）。
  String? _matchStageContentTop(bool isPinnedAppbar, {bool showTimeZone = true}) {
    // 1. 赛事未开赛 (ms == 0)
    if (widget.match.ms == 0) {
      // 距离开赛时间 > 1小时：显示开赛日期
      if (!isOneHour) {
        // 安全获取时间戳
        int mgtMillis = 0;
        var convertedC = TimeZoneUtils.convertTimeToTimestamp(
            widget.match.mgt,
            isMilliseconds: true,
            returnMilliseconds: true);
        
        if (convertedC is int) {
            mgtMillis = convertedC;
        } else {
            mgtMillis = int.tryParse(convertedC.toString()) ?? 0;
        }

        // 使用 UTC 时间还是本地时间取决于 convertTimeToTimestamp 的返回值和 DateFormat 的期望
        // 原逻辑: DateTime.fromMillisecondsSinceEpoch(..., isUtc: true)
        DateTime matchDate = DateTime.fromMillisecondsSinceEpoch(mgtMillis, isUtc: true);
        
        // 格式化日期 MM/dd
        String timeStr = DateFormat(LocaleKeys.time2.tr).format(matchDate);
        
        if (showTimeZone) {
          timeStr += " (${TimeZoneUtils.getTimeZoneString()})";
        }

        // 如果是吸顶状态，额外显示 HH:mm
        if (isPinnedAppbar) {
          String hm = FormatDate.formatHHMM(mgtMillis).toString();
          timeStr += " $hm";
        }
        return timeStr;
      }
      
      // 距离开赛时间 < 1小时 且 吸顶：返回特殊标记，显示倒计时
      if (isPinnedAppbar && isOneHour) {
        return "isOneHour";
      }

      // 距离开赛时间 < 1小时 且 不吸顶：返回 null
      return null;
    }

    // 2. 赛事结束 (ms == 3) 或 其他结束状态 (mo == 1)
    else if (widget.match.ms == 3 || widget.match.mo == 1) {
      if (["1", "2"].contains(widget.match.csid)) {
        return LocaleKeys.match_info_match_over.tr; // 全场结束
      } else {
        return LocaleKeys.match_info_match_end.tr; // 结束
      }
    } 
    
    // 3. 特殊状态 (ms == 110, 可能对应即将开赛或其他状态)
    else if (widget.match.ms == 110) {
      return "ms_${widget.match.ms}".tr;
    }

    // 4. 进行中或其他状态，返回空字符串，交由 StageChild 模板处理
    return "";
  }
}
