import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/core/MatchListClass.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../../../utils/global_timer.dart';
import '../../../../../utils/sport.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-4d94410b-d7ac-420f-9869-c75776960bc3-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 列表定时器 】】】
    【【【 AUTO_PARAGRAPH_TITLE 定时器Countingdown 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    ## 组件概述
    `Countingdown` 是一个 Flutter 状态组件，用于显示和管理比赛的倒计时。

    ## 主要属性
    - **match**: 当前比赛的信息（类型为 `MatchEntity`）。
    - **title**: 比赛阶段的标题。
    - **countingTime**: 当前计时字符串，格式为 `MM:SS`。
    - **lastShowTime**: 上次显示时间的时间戳（毫秒）。
    - **lastChangeTime**: 上次更改时间的时间戳（毫秒）。
    - **goon**: 标记计时器是否继续。
    - **isAdd**: 标记是否为累加计时器。
    - **step**: 计时器步长（单位：秒）。
    - **reduceSecond**: 计时器的倒计时时间（单位：秒）。
    - **tempInt**: 用于记录上次流数据的临时整数。

    ## 生命周期
    - **initState()**: 初始化计时器设置，调用 `init()` 方法。
    - **didUpdateWidget()**: 当组件更新时，根据新的比赛数据重新计算计时器。

    ## 初始化
    - **init()**:
    - 设置 `isAdd` 和 `step`。
    - 解析并设置 `reduceSecond`。
    - 调用 `computeCounter()` 计算初始倒计时。

    ## UI 构建
    - **build()**:
    - 使用 `StreamBuilder` 监听流数据，更新计时。
    - 显示比赛阶段标题和计时信息。
    - 根据条件显示额外信息（如伤停补时）。

    ## 计时逻辑
    - **computeCounter()**: 计算当前计时状态，根据比赛状态调整 `reduceSecond`。
    - **getCountingTime()**: 计算并格式化当前倒计时。
    - **showTimeCounting()**: 判断是否显示倒计时。

    ## 其他功能
    - **showMststi()**: 判断是否显示伤停补时信息。

    ## 注意事项
    - 确保所有依赖的类（如 `MatchEntity`, `MatchListClass`, `GlobalStreamTimer`, `FormatDate` 等）已正确定义并可用。
    - 处理可能的空值和异常情况，确保应用的稳定性。
    】】】
 *
 * */
// 对应vue: user-pc-vite/src/base-h5/components/common/counting-down.vue
class Countingdown extends StatefulWidget {
  const Countingdown(this.match, {super.key});

  final MatchEntity match;

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<Countingdown> {
  String countingTime = '00:00';
  // 增加：用于保留上一次有效显示的倒计时和标题，防止闪烁
  String? _lastValidCountingTime;
  String? _lastValidTitle;
  bool goon = false;
  late bool isAdd;
  int lastChangeTime = DateTime.now().millisecondsSinceEpoch;
  // 修改：将 lastShowTime 初始化为 0，确保首次调用 getCountingTime 不会被防抖拦截
  int lastShowTime = 0;
  /// 计时器开始计时时间
  double reduceSecond = 0.0;
  /// 计时器步长
  double step = 1.0;
  /// 定时器
  int tempInt = 0;
  late String title;

  @override
  void didUpdateWidget(covariant Countingdown oldWidget) {
    // 获取最新的 mst (服务端时间)
    double newMst = double.tryParse(widget.match.mst) ?? 0;
    // 1. 判断计时器状态是否发生变化 赛事阶段、暂停状态等
    bool statusChanged = widget.match.mmp != oldWidget.match.mmp ||
        widget.match.mess != oldWidget.match.mess ||
        widget.match.ms != oldWidget.match.ms;
    // - 无论正计时还是倒计时，只有当服务端时间 (newMst) 与本地计时偏差超过 15s 时，才进行校准
    bool shouldSync = statusChanged;

    if (!shouldSync && newMst > 0) {
      if ((newMst - reduceSecond).abs() > 15) {
        shouldSync = true;
      }
    }
    if (shouldSync) {
      reduceSecond = newMst;
      lastShowTime = 0; // 重置防抖
      init();
      if (mounted) setState(() {});
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    try {
      init();
    } catch (e) {}
  }

  init() {
    isAdd = [1, 4, 11, 14, 100, 101, 102, 103]
        .contains(int.tryParse(widget.match.csid) ?? 0);
    // 初始化修正设置步长
    step = MatchListClass.matchVrStep(widget.match, step);
    // 计时器计时时间
    try {
      reduceSecond = double.tryParse(widget.match.mst) ?? 0;
    } catch (e) {
      AppLogger.error(e);
    }
    computeCounter();
    // getSyncMatchTime();
  }

  bool showMststi() {
    var match = widget.match;
    if (int.parse(match.csid) != SportData.sportCsid_1) {
      return false;
    }
    if ([6, 7].contains(match.mmp.toInt())) {
      return match.mststi != '' && match.mststi != '0';
    }
    return false;
  }

  void getCountingTime() {
    if (reduceSecond <= 0 || widget.match.mmp == "0") {
      countingTime = '00:00';
      return;
    }
    // 移除防抖限制，确保每次调用都能立即更新时间，防止快速刷新时显示旧数据
    int secondCount = reduceSecond.toInt();
    String minutes, second;

    minutes = (secondCount ~/ 60).toString().padLeft(2, '0');
    int minutesToSecond = (int.tryParse(minutes) ?? 0) * 60;
    second = (secondCount - minutesToSecond).toString().padLeft(2, '0');

    // 水球
    if (int.parse(widget.match.csid) == SportData.sportCsid_16) {
      String waterPCountingDown =
          LocaleKeys.list_water_polo_countdown.tr; // 这里替换为对应的国际化字符串
      int fMinutes = (secondCount ~/ 60).ceil();
      fMinutes = fMinutes > 0 ? fMinutes : 1;
      countingTime = waterPCountingDown.replaceFirst('S%', fMinutes.toString());
    } else {
      countingTime = '$minutes:$second';
    }

    // 防止时间出现负数
    if (countingTime.startsWith('-')) {
      countingTime = countingTime.substring(1);
      countingTime = (countingTime[1] == ':' ? '0' : '') + countingTime;
    }

    // 更新最后一次有效时间
    if (countingTime != '00:00') {
      _lastValidCountingTime = countingTime;
    }
  }

  // 获取当前计时时间
  computeCounter() {
    // 赛事使用mstrc字段数据
    // 获取当前计时时间
    getCountingTime();
    int csid = int.parse(widget.match.csid);
    int mess = widget.match.mess;
    String mmp = widget.match.mmp;
    int ms = widget.match.ms;
    if (
        // 暂停 mess = 0
        mess == 0 ||
            // 足球 csid : 1 同时赛事为等待加时
            (csid == SportData.sportCsid_1 && mmp == "32") ||
            // 0：赛事为未开赛则暂停 或局间休息暂停
            ["0", "301", "302", "303", "304", "305", "306"].contains(mmp) ||
            // 全局暂停|中断
            [2, 10].contains(ms)) {
      goon = false;
    } else if (mess == 1) {
      goon = true;
    }
    // 不满足暂停条件则执行
    if (goon) {
      // 是否为累加计时器
      if ([
        SportData.sportCsid_1,

        ///冰球 csid = 4 冰球改为递减倒计时  ---- 涉及到业务发板 0728 未上
        // SportData.sportCsid_4,
        SportData.sportCsid_11,
        SportData.sportCsid_14,
        SportData.sportCsid_100,
        SportData.sportCsid_101,
        SportData.sportCsid_102,
        SportData.sportCsid_103
      ].contains(csid)) {
        int nowChangeTime = DateTime.now().millisecondsSinceEpoch;
        if (nowChangeTime - lastChangeTime >= 800) {
          reduceSecond += step;
          lastChangeTime = nowChangeTime;
        }
      } else {
        reduceSecond--;
      }
    }
  }

  ///篮球半场休息
  bool isRest() {
    int csid = int.tryParse(widget.match.csid) ?? 0;
    int mmp = int.tryParse(widget.match.mmp) ?? 0;

    /// 篮球 第二场修改半场休息，并且不显示时间
    if (mmp == 302 && csid == 2) {
      return true;
    } else {
      return false;
    }
  }

  bool showTimeCounting() {
    try {
      int csid = int.tryParse(widget.match.csid) ?? 0;
      int mmp = int.tryParse(widget.match.mmp) ?? 0;

      // 增加：如果当前数据看似无效（mmp=0），但我们有上次有效的显示状态，则继续显示
      // 避免刷新瞬间数据为空导致的置空
      bool hasLastValid =
          (_lastValidCountingTime != null && _lastValidCountingTime != '00:00');

      /// 篮球 第二场修改半场休息，并且不显示时间
      if (mmp == 302 && csid == 2) {
        return false;
      }

      if ([
        SportData.sportCsid_5,
        SportData.sportCsid_10,
        SportData.sportCsid_8,
        SportData.sportCsid_7,
        SportData.sportCsid_3,
        SportData.sportCsid_9,
        SportData.sportCsid_13,
        SportData.sportCsid_37
      ].contains(csid)) {
        return false;
      } else if (csid == SportData.sportCsid_1) {
        bool shouldShow = ![
          0, 30, 31, 32, 33, 34, 50, 61, 80, 90, 100, 110, 120, 301, 302, 303, 445
        ].contains(mmp);
        return shouldShow || (mmp == 0 && hasLastValid);
      } else if (csid == SportData.sportCsid_4) {
        if (widget.match.mlet != '') {
          List<int> mmps = [1, 2, 3, 40, 50];
          return mmps.contains(mmp);
        }
        return false || (mmp == 0 && hasLastValid);
      } else if (csid == SportData.sportCsid_6) {
        if (widget.match.mlet != '') {
          if (mmp == 40 && countingTime == '00:00') {
            return false;
          }
          List<int> mmps = [13, 14, 15, 16, 40];
          return mmps.contains(mmp);
        }
        return false || (mmp == 0 && hasLastValid);
      } else if ([
        SportData.sportCsid_100,
        SportData.sportCsid_101,
        SportData.sportCsid_102,
        SportData.sportCsid_103
      ].contains(csid)) {
        if (mmp > -1) {
          return true;
        }
      } else {
        bool shouldShow = ![
          0, 30, 31, 32, 33, 34, 50, 61, 80, 90, 100, 110, 120, 301, 302, 303, 445
        ].contains(mmp);
        return shouldShow || (mmp == 0 && hasLastValid);
      }
    } catch (e) {}
    return false;
  }

  @override
  Widget build(BuildContext context) {
    String currentTitle = MatchListClass.matchPeriodMap(widget.match);
    if (currentTitle.isNotEmpty) {
      title = currentTitle;
      _lastValidTitle = title;
    } else {
      // 如果当前获取的标题为空（可能是数据刷新瞬间），使用上一次有效的标题
      title = _lastValidTitle ?? '';
    }

    return StreamBuilder(
      ///绑定stream
      stream: GlobalStreamTimer.getInstance().streamController.stream,

      ///默认的数据
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        /// 记录倒计时时间，时间不同时再进行计算，避免出现多次渲染导致时间连跳
        // 如果是返回首页后的第一次渲染（countingTime 为 00:00 且 reduceSecond 有值），强制计算一次
        // 修正：增加对 countingTime == '00:00' 的判断，避免在已经有时间显示时重复计算
        // 并且确保在 snapshot 数据到达前也能显示（如果已有缓存）
        bool forceCompute = (countingTime == '00:00' &&
            reduceSecond > 0 &&
            widget.match.mmp != '0');

        // 双重保险：如果当前 reduceSecond 与 widget.match.mst 差异过大，强制同步
        // 这解决了部分情况下 didUpdateWidget 未能及时触发或状态不同步的问题
        double currentMst = double.tryParse(widget.match.mst) ?? 0;
        if (currentMst > 0 && (reduceSecond - currentMst).abs() > 15) {
          reduceSecond = currentMst;
          forceCompute = true;
        }

        if ((snapshot.hasData && tempInt != snapshot.data) || forceCompute) {
          tempInt = snapshot.data ?? 0;
          computeCounter();
        }

        return RepaintBoundary(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title != '')
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp.scale,
                    fontFamily: 'PingFang SC',
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                  strutStyle:
                      const StrutStyle(height: 1.1, forceStrutHeight: true),
                ),

              ///81465板球添加第几轮参数
              if ([SportData.sportCsid_37].contains(widget.match.csid.toInt()))
                Text(
                  widget.match.mbcn,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp.scale,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                ).marginOnly(left: 4.w),
              if (showTimeCounting())
                Text(
                  FormatDate.countingTimeCtrShowFormat(
                      widget.match,
                      (countingTime == '00:00' &&
                              _lastValidCountingTime != null)
                          ? _lastValidCountingTime!
                          : countingTime),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp.scale,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                  strutStyle:
                      const StrutStyle(height: 1.1, forceStrutHeight: true),
                ).marginOnly(left: 4.w),

              // 对应vue  MatchInjoureingTime  组件
              if (showMststi())
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4),
                  child: Text(
                    "+${widget.match.mststi.trimLeft()}'",
                    style: TextStyle(
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp.scale,
                      letterSpacing: 2.w,
                      color: context.isDarkMode
                          ? const Color(0xFF127DCC)
                          : const Color(0xFF179CFF),
                    ),
                    strutStyle:
                        const StrutStyle(height: 1.1, forceStrutHeight: true),
                  ),
                ),

              if ([
                    SportData.sportCsid_2,
                    SportData.sportCsid_4,
                    SportData.sportCsid_6,
                    SportData.sportCsid_15,
                    SportData.sportCsid_16
                  ].contains(widget.match.csid.toInt()) &&
                  [301, 302, 303].contains(widget.match.mmp.toInt()) &&
                  !isRest())
                Text(
                  widget.match.mlet,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp.scale,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                  strutStyle:
                      const StrutStyle(height: 1.1, forceStrutHeight: true),
                ),
            ],
          ),
        );
      },
    );
  }
}
