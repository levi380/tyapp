import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../../utils/format_score_util.dart';
import '../../../../../../widgets/image_view.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 视频+动画按钮+详细比分】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部比分条】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 斯诺克比分模板
    】】】
 *
 */
///斯诺克比分模板
class ScoreChild7 extends StatefulWidget {
  const ScoreChild7({super.key, required this.match});

  final MatchEntity match;

  @override
  State<ScoreChild7> createState() => _ScoreChild7State();
}

class _ScoreChild7State extends State<ScoreChild7> {
  late ScrollController _scrollController;
  late List<String> scoreList;
  /// 是否显示左箭头
  bool _showLeftArrow = true;
  /// 是否显示右箭头
  bool _showRightArrow = false;
  bool firstUpdate = true;
  ///左右滑动按钮图片
  final String leftArrowUrl = 'assets/images/icon/detail_left_arrow.png';
  final String rightArrowUrl = 'assets/images/icon/detail_right_arrow.png';
  ///左右滑动显示 最大比分数量
  int maxNum = 9;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateArrowVisibility);
    scoreList = basketballScoreArray(widget.match);
    scoreList = basketballScoreArray(widget.match);
    /// 斯诺克 模拟测试数据
    // scoreList = [
    //   "131:0", "98:01", "11:02", "31:07", "31:90", "11:0",
    //   "131:0", "11:110", "11:30", "11:40", "51:0",  "131:0", "11:110", "11:30", "11:40", "51:0"
    // ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToRight();
    });
  }

  /// 更新箭头显示状态
  void _updateArrowVisibility() {
    if (!_scrollController.hasClients) return;
    if(firstUpdate)return;
    final offset = _scrollController.offset;
    final maxOffset = _scrollController.position.maxScrollExtent;

    setState(() {
      /// 不是最左
      _showLeftArrow = offset > 0;
      /// 不是最右
      _showRightArrow = offset < maxOffset;
    });
  }

  ///默认展示当前比分
  void _scrollToRight() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  ///比分左滚动
  void _scrollLeft() {
    final target = _scrollController.offset - 100;
    _scrollController.animateTo(
      target.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
  ///比分右滚动
  void _scrollRight() {
    final target = _scrollController.offset + 100;
    _scrollController.animateTo(
      target.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateArrowVisibility);
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    /// mmp 32 等待加时  40 加时赛  110加时赛结束
    /// msc S7表示公共加时赛比分
    if (scoreList.length <= maxNum) {
      /// 少于等于 maxNum 个时，居中   隐藏左右按钮
      return Container(
        margin: EdgeInsets.only(left: 10.w),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: scoreList.asMap().entries.map((entry) {
            int index = entry.key + 1;
            String e = entry.value;
            return Text(
              e,
              style: TextStyle(
                color: index == scoreList.length && widget.match.mo != 1
                    ? Get.theme.scoreDetailColor
                    : Colors.white,
                fontSize: Get.theme.fontSize_12,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w600,
              ),
            ).paddingOnly(right: 10);
          }).toList(),
        ),
      );
    }
    ///正常 是居中显示
    return  Row(
      children: [
        /// 左箭头显示
        if (_showLeftArrow)
        Container(
          padding: EdgeInsets.only(right: 10.w),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (){
              firstUpdate = false;
              _scrollLeft();
            },
            child: ImageView(
              leftArrowUrl,
              width: 10.w,
              height: 17.h,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// mmp
                ...scoreList.asMap().entries.map((entry) {
                  int index = entry.key + 1;
                  String e = entry.value;
                  return Text(
                    FormatScore.scoreFormat(e),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: index == scoreList.length && widget.match.mo != 1
                          ? Get.theme.scoreDetailColor
                          : Colors.white,
                      fontSize: Get.theme.fontSize_12,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w600,
                    ),
                  ).marginOnly(right: 10.w);
                }).toList(),
              ],
            ),
          ),
        ),
        /// 右箭头显示
        if (_showRightArrow)
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){

            _scrollRight();
          },
          child: ImageView(
            rightArrowUrl,
            width: 10.w,
            height: 17.h,
          ),
        ),
      ],
    );
  }


  ///@description 斯诺克比分集合
  ///@return {Array} 斯诺克比分
  List<String> basketballScoreArray(MatchEntity match) {
    List<String> scoreArr = [];
    List<String> msc = match.msc;
    // sortBy方法  比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      int aStage = int.parse(a.split("|")[0].substring(1));
      int bStage = int.parse(b.split("|")[0].substring(1));
      return aStage.compareTo(bStage);
    });

    List<String> mscArray = [];
    for (var i = 120; i <= 159; i++) {
      mscArray.add('S$i');
    }

    /// 循环只取出接口返回的比分里面符合斯诺克球阶段的比分
    for (String item in msc) {
      String numIndex = item.split("|")[0];
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    }

    return scoreArr;
  }

  ///@description 公共加时赛比分
  ///@return {String} 加时赛比分
  String getExtraTime(MatchEntity match) {
    String extra = "";
    List<String> msc = match.msc;

    for (String item in msc) {
      List<String> splitItem = item.split("|");
      if (splitItem.length >= 2 && splitItem[0] == "S7") {
        extra = splitItem[1];
        break;
      }
    }

    return extra;
  }
}
