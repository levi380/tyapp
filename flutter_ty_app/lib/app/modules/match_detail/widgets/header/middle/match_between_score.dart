import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/utils/csid_util.dart';
import 'package:flutter_ty_app/app/widgets/sport_icon.dart';

import '../../../../../services/models/res/match_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 比分+队伍+赛事阶段】】】
    【【【 AUTO_PARAGRAPH_TITLE 发球方标识以及当前小节比分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 小节比分获取逻辑
    ```
    String score = "";
    // 网球取S103
    if (csid == 5 && currentScore("S103") != "") {
    score = formatScore(currentScore("S103"));
    }
    // 斯诺克, 乒乓球, 羽毛球, 排球, 沙滩排球 取赛事阶段范围内的最大为当前比分
    else if ([7, 8, 9, 10, 13].contains(csid)) {
    score = formatScore(currentScore(currentScoreCommon()));
    }
    // 冰球三节-局比分
    else if (csid == 4 && mmpArr1.contains(widgets.match.mmp)) {
    score = formatScore(currentScore(currentScoreCommon()));
    }
    // 冰球+橄榄球+曲棍球 加时赛比分
    else if (['4', '14', '15'].contains(csid) &&
    ['40', '440', '41', '33', '42'].contains(widgets.match.mmp) &&
    currentScore('S7') != "") {
    score = formatScore(currentScore("S7"));
    }
    // 冰球+橄榄球+曲棍球+水球 点球大战比分
    else if (['4', '14', '15', '16'].contains(csid) &&
    (widgets.match.mmp == "34" || widgets.match.mmp == "50") &&
    currentScore('S170') != "") {
    score = formatScore(currentScore("S170"));
    }
    ```
    - 发球放判断逻辑
    ```
    widgets.match.mat == "home" // 主队发球方
    widgets.match.mat == "away" // 客队发球方
    ```
    】】】
 *
 */
class MatchBetweenScore extends StatefulWidget {
  const MatchBetweenScore({super.key, required this.match});

  final MatchEntity match;

  @override
  State<MatchBetweenScore> createState() => _MatchBetweenScoreState();
}

class _MatchBetweenScoreState extends State<MatchBetweenScore> {
  // 斯诺克, 乒乓球, 羽毛球休息状态数组
  static const _restMmpArray = [
    "301",
    "302",
    "303",
    "304",
    "305",
    "306",
    "445"
  ];

  // 冰球三节显示局间比分的阶段
  static const _hockeyPeriodMmpArray = ["1", "2", "3", "301", "302"];

  // 加时赛阶段
  static const _overtimeMmpArray = ["40", "440", "41", "33", "42"];

  // 点球大战阶段
  static const _penaltyShootoutMmpArray = ["34", "50"];

  // 需要取最大比分的运动
  static const _maxScoreSports = ["7", "8", "9", "10", "13"];

  // 加时赛运动
  static const _overtimeSports = ['4', '14', '15'];

  // 点球大战运动
  static const _penaltySports = ['4', '14', '15', '16'];

  @override
  void initState() {
    _handleRestState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final csid = widget.match.csid;
    final score = _calculateCurrentScore();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: _buildScoreRow(csid, score),
    );
  }

  /// 构建比分行
  Widget _buildScoreRow(String csid, String score) {
    final position = SpriteImagesPosition.data[csid.toNum()] ?? 0;
    final isHomeServing = widget.match.mat == "home";
    final isAwayServing = widget.match.mat == "away";

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 主队发球图标
        if (isHomeServing)
          sportIcon(
              index: position, width: 14.w, height: 14.w, isSelected: true)
        else
          SizedBox(width: 14.w),

        SizedBox(width: 4.w),

        // 比分显示
        Text(
          score.isNotEmpty ? "($score)" : "   ",
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontFamily: 'Akrobat',
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(width: 4.w),

        // 客队发球图标
        if (isAwayServing)
          sportIcon(
              index: position, width: 14.w, height: 14.w, isSelected: true)
        else
          SizedBox(width: 14.w),
      ],
    );
  }

  /// 计算当前比分
  String _calculateCurrentScore() {
    final csid = widget.match.csid;
    final mmp = widget.match.mmp;

    // 网球取S103
    if (csid == "5") {
      return _getTennisScore();
    }
    // 斯诺克, 乒乓球, 羽毛球, 排球, 沙滩排球 取赛事阶段范围内的最大为当前比分
    else if (_maxScoreSports.contains(csid)) {
      return _getMaxPeriodScore();
    }
    // 板球 取当下局数出局数
    else if (csid == "37" && ['8', '9'].contains(mmp)) {
      return _getCricketOutScore();
    }
    // 冰球三节-局比分
    else if (csid == "4" && _hockeyPeriodMmpArray.contains(mmp)) {
      return _getMaxPeriodScore();
    }
    // 冰球+橄榄球+曲棍球 加时赛比分
    else if (_overtimeSports.contains(csid) &&
        _overtimeMmpArray.contains(mmp)) {
      return _getOvertimeScore();
    }
    // 冰球+橄榄球+曲棍球+水球 点球大战比分
    else if (_penaltySports.contains(csid) &&
        _penaltyShootoutMmpArray.contains(mmp)) {
      return _getPenaltyScore();
    }

    return "";
  }

  /// 获取网球比分
  String _getTennisScore() {
    final score = _getScoreByType("S103");
    return score.isNotEmpty ? _formatScore(score) : "";
  }

  /// 获取最大阶段比分
  String _getMaxPeriodScore() {
    final scoreType = _findMaxScoreType();
    return scoreType.isNotEmpty ? _formatScore(_getScoreByType(scoreType)) : "";
  }

  /// 获取板球出局数比分
  String _getCricketOutScore() {
    final scoreType = _findCricketOutScoreType();
    return scoreType.isNotEmpty
        ? _formatScore(_getScoreByType(scoreType),
            csid: "37", mmp: widget.match.mmp)
        : "";
  }

  /// 获取加时赛比分
  String _getOvertimeScore() {
    final score = _getScoreByType("S7");
    return score.isNotEmpty ? _formatScore(score) : "";
  }

  /// 获取点球大战比分
  String _getPenaltyScore() {
    final score = _getScoreByType("S170");
    return score.isNotEmpty ? _formatScore(score) : "";
  }

  /// 根据类型获取比分
  String _getScoreByType(String scoreType) {
    for (final v in widget.match.msc) {
      final splitV = v.split("|");
      if (splitV.length == 2 && splitV[0] == scoreType) {
        return splitV[1];
      }
    }
    return "";
  }

  /// 比分格式设置
  String _formatScore(String res, {String? csid, String? mmp}) {
    String scoreStr = "";

    if (res.contains("|")) {
      final arr = res.split("|");
      scoreStr = arr[1];
    } else if (res.contains(":")) {
      scoreStr = res;
    }

    final scoreParts = scoreStr.split(":");
    if (scoreParts.length != 2) return '';

    // 板球出局数特殊处理
    if (csid == "37" && mmp == "9") {
      return _formatCricketOutScore(scoreParts[0], scoreParts[1]);
    }

    return '${scoreParts[0].toInt()} - ${scoreParts[1].toInt()}';
  }

  /// 格式化板球出局数比分
  String _formatCricketOutScore(String homeOut, String awayOut) {
    final outHome = homeOut.toInt();
    final outAway = awayOut.toInt();
    final allOutText = LocaleKeys.common_all_out.tr;

    if (outHome == 10 && outAway != 10) {
      return '$allOutText - $outAway';
    } else if (outHome != 10 && outAway == 10) {
      return '$outHome - $allOutText';
    } else if (outHome == 10 && outAway == 10) {
      return '$allOutText - $allOutText';
    } else {
      return '$outHome - $outAway';
    }
  }

  /// 处理休息状态
  void _handleRestState() {
    // 将休息状态的发球方置空显示，不显示绿色小点
    if (_restMmpArray.contains(widget.match.mmp)) {
      widget.match.mat = "";
    }
  }

  /// 查找最大比分类型
  String _findMaxScoreType() {
    int maxNum = 0;

    for (final v in widget.match.msc) {
      final parts = v.split("|");
      if (parts.length == 2) {
        final type = parts[0];
        if (type.startsWith("S")) {
          final current = int.tryParse(type.substring(1)) ?? 0;
          // 120-159范围内的比分类型
          if (current > maxNum && current >= 120 && current <= 159) {
            maxNum = current;
          }
        }
      }
    }

    return maxNum > 0 ? "S$maxNum" : "";
  }

  /// 查找板球出局数比分类型
  String _findCricketOutScoreType() {
    int maxNum = 0;

    for (final v in widget.match.msc) {
      final parts = v.split("|");
      if (parts.length == 2) {
        final type = parts[0];
        if (type.startsWith("S")) {
          final current = int.tryParse(type.substring(1)) ?? 0;
          // S373-S374范围内的出局数类型
          if (current > maxNum && current >= 373 && current <= 374) {
            maxNum = current;
          }
        }
      }
    }

    return maxNum > 0 ? "S$maxNum" : "";
  }
}
