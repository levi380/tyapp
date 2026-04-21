import 'dart:math';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';
import 'package:flutter_ty_app/app/utils/widget_utils.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../../../utils/sport.dart';
import '../../../../match_detail/widgets/container/odds_info/odds_button.dart';
import '../../../controllers/secondary_expand_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 常规赛事 】】】
    【【【 AUTO_PARAGRAPH_TITLE 公共投注赔率按钮部件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 通过投注按钮基础高度 动态计算出投注box高度
    ```
    twoHeight = threeHeight * 1.5 + 1;
    threeBoxHeight = threeHeight * 3 + 10;
    twoBoxHeight = threeHeight * 2 + 10;
    ```
    - 监听 投注全场/半场 滑动页面
    ```
    pageController.animateToPage(event,
    duration: const Duration(milliseconds: 300), curve: Curves.ease);
    ```
    - 填充投注赔率数据
    ```
    widgets.add(_buildOdds(element, ols, height, i == 0),
    ```
    - 投注赔适配iPad和手机端宽度
    ```
    ///有数据实际高度设置
    height: isIPad ? height.w:height,
    width: isIPad ? ((Get.width - 28.w - 12.w) * 0.5) / 3 : mWidth.w,
    ```
    】】】
 *
 */

// 赛事列表 基本item
class BetGroupWidget extends StatefulWidget {
  const BetGroupWidget(
      {super.key,
      required this.matchEntity,
      required this.hps,
      required this.isMainPlay,
      this.playId = ''});

  final List<MatchHps> hps;
  final bool isMainPlay;
  final MatchEntity matchEntity;
  final String playId;
  /// 15分钟玩法 1007  罚牌 1003
  @override
  State<BetGroupWidget> createState() => _BetGroupWidgetState();
}

class _BetGroupWidgetState extends State<BetGroupWidget> {
  double mWidth = 60;
  ///15分钟 数据排序
  List<MatchHps> minutesListAll = [];
  late PageController pageController;
  double threeBoxHeight = 110;
  ///投注按钮高度 三行/两行
  double threeHeight = 35;
  double twoBoxHeight = 70;
  double twoHeight = 52.5;
  int _currentPage = 0;

  @override
  void didUpdateWidget(covariant BetGroupWidget oldWidget) {
    if (widget.hps != oldWidget.hps) {
      if (_currentPage != pageController.page?.round()) {
        pageSwitch();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    pageController = PageController(
        initialPage: (widget.hps.length / 3).ceil() >= 2
            ? SecondaryController.index
            : _currentPage,
        keepPage: true,
        viewportFraction: 1);
    pageSwitch();
    super.initState();
    ///首页 投注全场/半场 滑动监听
    WidgetUtils.instance().stream.listen((event) {
      if (mounted) {
        setState(() {
          _currentPage = event;
        });
        pageController.animateToPage(
          event,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    });
  }
  // 如果是板球并且是滑动到第二页
  bool shouldUseTwo(MatchHps? hps, bool isFirst) {
    return SportData.getSportsCsid([SportData.sportCsid_37])!
            .contains(int.tryParse(widget.matchEntity.csid)) &&
        _currentPage == 1;
  }
  ///UI加载完成后运行
  pageSwitch() {
    // 设置时间回调
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        ///板球单独定制 板球高投注高度
        if (SportData.getSportsCsid([SportData.sportCsid_37])!
            .contains(int.tryParse(widget.matchEntity.csid))) {
          threeHeight = 30;
          twoHeight = 45;
          threeBoxHeight = 90;
          twoBoxHeight = 60;
        }
        setState(() {
          //计算各去快对应高度
          _currentPage = SecondaryController.index;
          twoHeight = threeHeight * 1.5 + 1;
          threeBoxHeight = threeHeight * 3 + 10;
          twoBoxHeight = threeHeight.scale * 2 + 10;
        });
        // 增加页数判断 避免第一次列表项出现时滑动
        int length = (widget.hps.length / 3).ceil();
        if (length > 1) {
          pageController.jumpToPage(SecondaryController.index);
        }
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
  /// 是否有全场独赢的玩法  增加板球37
  bool _isThree() {
    return SportData.getSportsCsid([
      SportData.sportCsid_1,
      SportData.sportCsid_4,
      SportData.sportCsid_11,
      SportData.sportCsid_16,
      SportData.sportCsid_37
    ])!
        .contains(int.tryParse(widget.matchEntity.csid));
  }
  Widget _buildOddGroup(List<MatchHps> groupList) {
    List<Widget> widgets = [];
    for (int i = 0; i < max(groupList.length, betCount()); i++) {
      MatchHps? element = groupList.safe(i);
      List<MatchHpsHlOl> ols = element?.hl.safeFirst?.ol ?? [];
      List<MatchHpsHlOl> uniqueOlds = ols.removeDuplicates((ol) => ol.oid);
      ///投注按钮高度
      ///计算赔率btn高度
      double height = threeHeight;
      if (_isThree()) {
        if (ols.length > 2) {
          height = threeHeight + (TyTextScaler.instance().isScale ? 6 : 0);
        } else {
          height = twoHeight + (TyTextScaler.instance().isScale ? 9 : 0);
        }
      } else {
        height = threeHeight + (TyTextScaler.instance().isScale ? 6 : 0);
      }
      widgets.add(
        _buildOdds(element, uniqueOlds, height, i == 0),
      );
    }
    return SizedBox(
      width: isIPad ? (Get.width - 28.w - 12.w) * 0.5 : 184.w,

      ///三行和两行
      height: _isThree()
          ? (threeBoxHeight.h + (TyTextScaler.instance().isScale ? 6 * 3 : 0))
          : (twoHeight.h + (TyTextScaler.instance().isScale ? 28 : 0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widgets,
      ),
    );
  }
  ///列表玩法赔率
  Widget _buildOdds(
      MatchHps? hps, List<MatchHpsHlOl> list, double height, bool isFirst) {
    //_isThree的第一项为3行
    int length = list.isEmpty
        ? (['1', '17'].contains(hps?.chpid) || (_isThree() && isFirst && !(['135', '136'].contains(hps?.chpid)))
            ? (shouldUseTwo(hps, isFirst) ? 2 : 3)
            : 2)
        : list.length;
    return SizedBox(
      width: isIPad
          ? ((Get.width - 28.w - 16.w) * 0.5) / 3
          : betCount() == 2
              ? 91.w
              : mWidth.w,
      child: ListView.separated(
        // shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) {
          return 2.verticalSpaceFromWidth;
        },
        itemCount: length,
        itemBuilder: (BuildContext context, int index) {
          MatchHpsHlOl? ol = list.safe(index);
          double height = threeHeight;

          ///三行投注 🍺两行投注 高度设置
          if (_isThree()) {
            if (length > 2) {
              height = threeHeight + (TyTextScaler.instance().isScale ? 6 : 0);
            } else {
              height = twoHeight + (TyTextScaler.instance().isScale ? 9 : 0);
            }
          } else {
            height = threeHeight + (TyTextScaler.instance().isScale ? 6 : 0);
          }
          ///数据为空 用- 填充
          if (ol == null) {
            return Container(
              width: isIPad ? ((Get.width - 28.w - 8.w) * 0.5) / 3 : mWidth.w,
              height: isIPad ? height.w : height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Get.theme.oddsButtonBackgroundColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                "-",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 10.sp.scale,
                  color: Get.theme.oddsButtonNameFontColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }
          return Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 6,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ]),
            child: OddsButton(
              key: ValueKey(widget.matchEntity.mid +
                  widget.playId +
                  ol.oid +
                  (hps?.hpid ?? '')),
              isDetail: false,
              ///有数据实际高度设置
              height: isIPad ? height.w : height,
              width: isIPad ? ((Get.width - 28.w - 12.w) * 0.5) / 3 : mWidth.w,
              match: widget.matchEntity,
              playId: widget.playId,
              hps: hps,
              ol: ol,
              radius: 4.w,
              secondaryPaly: !widget.isMainPlay,
              betType: MatchUtil.isEsport(widget.matchEntity)
                  ? OddsBetType.esport
                  : OddsBetType.common,
              hl: hps?.hl.safeFirst,
            ),
          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    List<MatchHps> matchHpsList = widget.hps;
    //空数据填充
    if (matchHpsList.isEmpty) {
      matchHpsList.addAll([
        MatchHps(),
        MatchHps(),
        MatchHps(),
      ]);
    } else if (matchHpsList.length < 3 && !widget.isMainPlay) {
      for (var i = matchHpsList.length; i < 3; i++) {
        matchHpsList.addAll([
          MatchHps(),
        ]);
      }
    }
    // 三个一组
    int length = (matchHpsList.length / 3).ceil();
    // 15分钟滑动列表排序
    if (length >= 2 &&
        widget.playId == playIdConfig.hps15Minutes &&
        !widget.isMainPlay) {
      if (minutesListAll.isNotEmpty) {
        minutesListAll.clear();
      }
      minutesListAll = List.from(matchHpsList)
        ..sort((a, b) => a.hSpecial.compareTo(b.hSpecial));
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: isIPad ? (Get.width - 28.w - 8.w) * 0.5 : 184.w,
              height: _isThree()
                  ? (isIPad
                      ? threeBoxHeight.w
                      : (threeBoxHeight +
                          (TyTextScaler.instance().isScale ? 6 * 3 : 0)))
                  : (isIPad
                      ? twoBoxHeight.w
                      : twoBoxHeight +
                          (TyTextScaler.instance().isScale ? 6 * 2 : 0)),
              child: PageView(
                controller: pageController,
                onPageChanged: (pageIndex) async {
                  setState(() {
                    if (SecondaryController.index != pageIndex) {
                      if (length >= 2) {
                        SecondaryController.setIndex(pageIndex);
                        WidgetUtils.instance()
                            .streamController
                            .sink
                            .add(pageIndex);
                      }
                    }
                  });
                },
                ///大于2页面就拆开数据
                children: length >= 2
                    ? widget.playId == playIdConfig.hps15Minutes
                        ? List.generate(length, (index) {
                            List<MatchHps> groupList = minutesListAll
                                .getRange(index * 3,
                                    min((index + 1) * 3, minutesListAll.length))
                                .toList();
                            if (groupList.length < 3) {
                              for (int i = groupList.length; i < 3; i++) {
                                groupList.add(MatchHps());
                              }
                            }

                            return _buildOddGroup(groupList);
                          })
                        : List.generate(length, (index) {
                            List<MatchHps> groupList = matchHpsList
                                .getRange(index * 3,
                                    min((index + 1) * 3, matchHpsList.length))
                                .toList();
                            if (groupList.length < 3) {
                              for (int i = groupList.length; i < 3; i++) {
                                groupList.add(MatchHps());
                              }
                            }
                            return _buildOddGroup(groupList);
                          })

                    ///正常一页数据
                    : [_buildOddGroup(matchHpsList)],
              ),
            ),
            if (length > 1)
              Container(
                height: 10.w,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentPage = 0;
                          pageController.jumpToPage(_currentPage);
                        });
                      },
                      child: Container(
                        height: 2.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.h),
                          color: _currentPage == 0
                              ? context.isDarkMode
                                  ? const Color(0xFF127DCC)
                                  : const Color(0xff179CFF)
                              : context.isDarkMode
                                  ? const Color(0xFF127DCC).withValues(alpha:0.4)
                                  : const Color(0xff179CFF).withValues(alpha:0.4),
                        ),
                        width: _currentPage == 0 ? 6.w : 4.w,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentPage = 1;
                            pageController.jumpToPage(_currentPage);
                          });
                        },
                        child: Container(
                          height: 2.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.h),
                            color: _currentPage == 1
                                ? context.isDarkMode
                                    ? const Color(0xFF127DCC)
                                    : const Color(0xff179CFF)
                                : context.isDarkMode
                                    ? const Color(0xFF127DCC).withValues(alpha:0.4)
                                    : const Color(0xff179CFF).withValues(alpha:0.4),
                          ),
                          width: _currentPage == 1 ? 6.w : 4.w,
                        )),
                  ],
                ),
              ),
          ],
        ),
        ///列表git动画
        if (length > 1 && (TyHomeController.to.visiable || Get.currentRoute == Routes.matchResultsDetails))
          Positioned(
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: ImageView(
                _currentPage == 0
                    ? 'assets/images/detail/ico_arrow_left.gif'
                    : 'assets/images/detail/ico_arrow_right.gif',
                width: 16.w,
                height: 16.w,
              ),
            ),
          )
      ],
    ).marginOnly(bottom: !widget.isMainPlay ? 5.h : 0);
  }
}
extension ListExtension<T> on List<T> {
  List<T> removeDuplicates([String Function(T)? getKey]) {
    if (getKey == null) {
      return toSet().toList();
    }
    Map<String, T> uniqueMap = {};
    for (var item in this) {
      String key = getKey(item);
      if (!uniqueMap.containsKey(key)) {
        uniqueMap[key] = item;
      }
    }
    return uniqueMap.values.toList();
  }
}
