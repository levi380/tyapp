
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../db/csid_title.dart';
import '../../../../../utils/change_skin_tone_color_util.dart';

import '../../../../../utils/sport.dart';
import '../../../../../utils/widget_utils.dart';
import '../../../controllers/secondary_expand_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 常规赛事 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛标题部件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 展示联赛标题下的赔率类型
    - 添加联赛标题 全场或半场标题
    ```
    PageView(
    /// 禁止手动滑动
    physics: const NeverScrollableScrollPhysics(),
    controller: pageController,
    pageSnapping: false,
    /// 将titles 三个分为一组
    children: titles.length > 2
    ? List.generate((titles.length / 3).ceil(), (index) {
    return _buildTitle(titles.sublist(
    index * 3, min(titles.length, (index + 1) * 3)));
    })
    : [_buildTitle(titles)],
    ),
    ```
    - 联赛标题适配iPad和手机端宽度
    ```
    isIPad ? ((Get.width - 28.w - 18.w) * 0.5) : 184.w,
    ```
    】】】
 *
 */

///全场独赢 .......联赛标题下的赔率类型
class BetTitleGroupWidget extends StatefulWidget {
  const BetTitleGroupWidget({
    super.key,
    required this.hps,
    required this.matchEntity,
    this.isPinned = false,
    this.isDj = false,
  });

  final List<MatchHps> hps;
  /// 电竞列表
  final bool isDj;

  /// 置顶状态
  final bool isPinned;

  final MatchEntity matchEntity;

  @override
  State<BetTitleGroupWidget> createState() => _BetTitleGroupWidgetState();
}

class _BetTitleGroupWidgetState extends State<BetTitleGroupWidget> {
  late PageController pageController;

  RxInt _currentPage = 0.obs;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _currentPage.value = SecondaryController.index;
    pageController = PageController(
        initialPage: _currentPage.value, keepPage: true, viewportFraction: 1);
    super.initState();

    ///监听赛事赔率滑动全场或半场
    WidgetUtils.instance().stream.listen((event) {
      if (mounted) {
        _currentPage.value = event;
        pageController.animateToPage(_currentPage.value,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
    });
  }

  /// 投注盘口数
  int betCount() {
    /// 拳击格斗是2
    if (['12'].contains(widget.matchEntity.csid)) {
      return 2;
    } else {
      return 3;
    }
  }

  _buildTitle(List<String> titles) {
    return SizedBox(
      height: isIPad ? 30.h : 18.w.scale,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            //适配iPad宽度 三分之一宽度  // 37是板球需要做处理
            width: isIPad
                ? ((Get.width - 28.w - 18.w) * 0.5) / betCount()
                : (SportData.getSportsCsid([SportData.sportCsid_37])!
                            .contains(int.tryParse(widget.matchEntity.csid)) &&
                        index == 1 &&
                        _currentPage.value == 1)
                    ? 120.w
                    : betCount() == 2 ? 91.w : 60.w,
            alignment: Alignment.center,
            child: Text(
              titles[index],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isIPad ? 12.sp.scale : 10.sp.scale,
                color: context.isDarkMode
                    ? const Color(0xE5FFFFFF)
                    : const Color(0xff303442),
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 2.w,
          );
        },
        itemCount: titles.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> titles = [];

    ///联赛赔率全场或半场标题
    int csidTitleCount = csidTitleCountMap[widget.matchEntity.csid] ?? 0;
    if (csidTitleCount > 0) {
      for (int i = 0; i < csidTitleCount; i++) {
        String titleKey = 'list_title_${widget.matchEntity.csid}_title_$i'.tr;
        String title = titleKey;
        ///如果返回的是板球 动态添加队伍名称上去
        /*   if (widgets.matchEntity.csid == "37") {
          title = titleKey.replaceAllMapped(RegExp(r"{\$(competitor1|competitor2)}"), (match) {
            //return match[1] == 'competitor1' ? "${widgets.matchEntity.mhn}" : "${widgets.matchEntity.man}";
            return match[1] == 'competitor1' ? "" : "";
          });
        }
*/
        titles.add(title);
      }
    }

    return Container(
      margin: widget.isDj ? EdgeInsets.only(left: 5.w, right: 5.w) : null,
     color:  context.isDarkMode ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(colorStyle_1: Color(0xFF2B2D33) ,colorStyle_2: Color(0xFF23292D),colorStyle_3: Color(0xFF26242A)) : Color(0xFFF8F9FA),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(right: 8.w),
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: isIPad ? 30.h : 20.w,

              ///ipad 占半屏
              width: isIPad ? ((Get.width - 28.w - 18.w) * 0.5) : 184.w,
              child: NotificationListener(
                onNotification: (ScrollNotification value) {
                  // 返回true 避免被ScrollIndexWidget 监听
                  return true;
                },
                child: PageView(
                  /// 禁止手动滑动
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  pageSnapping: false,

                  /// 将titles 三个分为一组
                  children: titles.length >= betCount()
                      ? List.generate((titles.length / betCount()).ceil(),
                          (index) {
                          return _buildTitle(titles.sublist(index * betCount(),
                              min(titles.length, (index + 1) * betCount())));
                        })
                      : [_buildTitle(titles)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
