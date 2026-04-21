import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../utils/sport.dart';
import '../../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-4d94410b-d7ac-420f-9869-c75776960bc3-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 列表定时器 】】】
    【【【 AUTO_PARAGRAPH_TITLE 定时器 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - _startTimer 记时器开始
    - _stopTimer 记时器停止销毁
    】】】
 *
 */
class TimeWidget extends StatefulWidget {
  const TimeWidget({super.key, required this.matchEntity});

  final MatchEntity matchEntity;

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

// 时间: mst已经开赛时间（滚球）   mgt开赛时间 （早盘） ms:110 即将开赛（加上）
class _TimeWidgetState extends State<TimeWidget> {
  bool isAdd = false;

  bool _isTimerRunning = true;
  // 记时器
  /// 正向记录时间
  int _seconds = 0;

  // 增加：记录上一次有效的格式化时间字符串
  String? _lastValidFormat;

  late Stream<int> _secondsStream;
  late StreamController<int> _secondsStreamController;
  Timer? _timer;

  @override
  void dispose() {
    _stopTimer();
    _secondsStreamController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _secondsStreamController = StreamController<int>.broadcast();
    _secondsStream = _secondsStreamController.stream;

    isAdd = [
      SportData.sportCsid_1,
      SportData.sportCsid_4,
      SportData.sportCsid_11,
      SportData.sportCsid_14,
      SportData.sportCsid_100,
      SportData.sportCsid_101,
      SportData.sportCsid_102,
      SportData.sportCsid_103
    ].contains(
      int.tryParse(widget.matchEntity.csid),
    );

    // 检查是否是缓存数据
    // 我们约定：如果是缓存数据，isFromCache 为 true
    if (widget.matchEntity.isFromCache) {
      _seconds = -1; // 使用 -1 标记显示 --
    } else if (widget.matchEntity.mcg == 1) {
      _seconds = widget.matchEntity.mst.toInt();
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(TimeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当赛事数据更新时，重新同步时间
    // 获取最新的 mst (服务端时间)
    double newMst = double.tryParse(widget.matchEntity.mst) ?? 0;

    // 1. 判断计时器状态是否发生变化 赛事阶段、缓存状态等
    bool statusChanged = widget.matchEntity.mmp != oldWidget.matchEntity.mmp ||
        widget.matchEntity.mcg != oldWidget.matchEntity.mcg ||
        widget.matchEntity.isFromCache != oldWidget.matchEntity.isFromCache;


    // - 无论正计时还是倒计时，只有当服务端时间与本地计时偏差超过 15s 时，才进行校准
    bool shouldSync = statusChanged;
    if (!shouldSync && newMst > 0) {
      if ((newMst - _seconds).abs() > 15) {
        shouldSync = true;
      }
    }

    if (shouldSync) {
      _stopTimer();
      _secondsStreamController.close();
      _secondsStreamController = StreamController<int>.broadcast();
      _secondsStream = _secondsStreamController.stream;

      // 重新检查是否是缓存数据
      if (widget.matchEntity.isFromCache) {
        _seconds = -1;
      } else if (widget.matchEntity.mcg == 1) {
        _seconds = widget.matchEntity.mst.toInt();
        _isTimerRunning = true;
        _startTimer();
      }

      // 强制刷新一次 UI 以显示新时间（或 --）
      if (mounted) setState(() {});
    }
  }

  ///显示伤停补时
  bool showMststi() {
    var match = widget.matchEntity;
    if (int.parse(match.csid) != SportData.sportCsid_1) {
      return false;
    }
    if ([6, 7].contains(match.mmp.toInt())) {
      return match.mststi != '' && match.mststi != '0';
    }
    return false;
  }

  _startTimer() {
    _seconds = widget.matchEntity.mst.toInt();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isTimerRunning) {
        if (_seconds <= 0) {
          _stopTimer();
          return;
        }
        // 篮球-- 足球++
        _secondsStreamController.add(isAdd ? _seconds++ : _seconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _isTimerRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    bool displaysCountdown = true;
    if (int.parse(widget.matchEntity.csid) == SportData.sportCsid_1 &&
        ['31', '100', '110', '120', '999'].contains(widget.matchEntity.mmp)) {
      displaysCountdown = false;
    }
    if (widget.matchEntity.mcg == 1 && displaysCountdown) {
      return StreamBuilder<int>(
        stream: _secondsStream,
        initialData: _seconds,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          // 描述格式化
          String format = '';
          int currentSeconds = snapshot.data ?? 0;

          // 如果是缓存数据（标记为-1），显示 --
          if (currentSeconds < 0) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                "--",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp.scale,
                  height: 1.6,
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.30000001192092896)
                      : const Color(0xffAFB3C8),
                ),
              ),
            );
          }

          // 分秒
          int minutes = currentSeconds ~/ 60;

          // C01赛事只显示分钟不显示秒
          bool isC01 = widget.matchEntity.cds == 'C01' &&
              int.parse(widget.matchEntity.csid) == SportData.sportCsid_1;
          format = minutes.toString().padLeft(2, '0');
          if (!isC01) {
            int seconds = currentSeconds % 60;
            format += ':${seconds.toString().padLeft(2, '0')}';
          }

          // 更新最后一次有效显示的时间
          if (format.isNotEmpty && format != "00:00") {
            _lastValidFormat = format;
          }

          String displayTime = (format.isEmpty || format == "00:00")
              ? (_lastValidFormat ?? format)
              : format;

          return Row(
            children: [
              Text(
                displayTime,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp.scale,
                  height: 1.6,
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.30000001192092896)
                      : const Color(0xffAFB3C8),
                ),
              ),
              //显示伤时补停
              ///列表伤停补时
              if (showMststi())
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4),
                  child: Text(
                    "+${widget.matchEntity.mststi}'",
                    style: TextStyle(
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp.scale,
                      height: 1.6,
                      letterSpacing: 2,
                      color: context.isDarkMode
                          ? const Color(0x80FFFFFF)
                          : const Color(0xFFCCDDFF),
                      // ? Colors.white.withValues(alpha:0.30000001192092896)
                      // : const Color(0xffAFB3C8),
                    ),
                  ),
                ),
            ],
          );
        },
      );
    } else if (widget.matchEntity.ms == SportData.sportMs_110) {
      //  即将开赛 ms = 110
      return Text(
        LocaleKeys.ms_110.tr,
        style: TextStyle(
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
          fontSize: 11.sp.scale,
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.30000001192092896)
              : const Color(0xffAFB3C8),
        ),
      ).marginOnly(right: 4.w);
    } else {
      ///帆船
      if (int.parse(widget.matchEntity.csid) == SportData.sportCsid_1 &&
          ['31'].contains(widget.matchEntity.mmp)) {
        return const SizedBox(); //中场休息
      }
      String time = DateUtil.formatDateMs(widget.matchEntity.mgt.toInt(),
          format: LocaleKeys.time11.tr, isUtc: true);
      return Text(
        time,
        style: TextStyle(
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
          fontSize: 11.sp.scale,
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.30000001192092896)
              : const Color(0xffAFB3C8),
        ),
      );
    }
  }
}
