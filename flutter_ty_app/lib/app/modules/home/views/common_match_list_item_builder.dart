import 'package:flutter_ty_app/app/extension/num_extension.dart';

import '../../../global/data_store_operate/ws_handle/ws_handle.dart';
import '../../../config/analytic/analytics_utils.dart';
import '../../login/login_head_import.dart';
import '../controllers/home_controller.dart';
import '../controllers/match_expand_controller.dart';
import '../models/combine_info.dart';
import '../widgets/discount_odd_widget.dart';
import '../widgets/item/header/seaction_header_widget.dart';
import '../widgets/item/header/sport_header_widget.dart';
import '../widgets/item/noob/noob_item_body_widget.dart';
import '../widgets/item/profession/bet_title_group_widget.dart';
import '../widgets/item/profession/item_body_widget.dart';
import '../widgets/item/profession/match_group_header_widget.dart';
import '../states/home_state.dart';

class CommonMatchListItemBuilder extends StatelessWidget {
  final TyHomeController controller;
  final int index;

  const CommonMatchListItemBuilder({
    super.key,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    int idx = index;

    if (controller.homeState.showMatchtDiscount &&
        controller.homeState.matchtDiscount.isNotEmpty) {
      if (idx == 0) {
        return DiscountOddWidget(controller: controller);
      }
      idx -= 1;
    }

    CombineInfo? combineInfo = controller.homeState.combineList.safe(idx);
    if (combineInfo == null) return 0.verticalSpaceFromWidth;

    if (controller.homeState.isProfess) {
      return _buildProfession(context, combineInfo, idx);
    } else {
      return _buildNoob(context, combineInfo, idx);
    }
  }

  Widget _buildProfession(
      BuildContext context, CombineInfo combineInfo, int index) {
    /// 如果是大的分组标题  进行中 未开始等
    if (combineInfo.type == CombineType.sectionHeader) {
      return SectionHeaderWidget(
        isExpand: !FoldMatchManager.isGroupFold(combineInfo.sectionGroupEnum!),
        onExpand: (value) {
          Analytics.track(
            AnalyticsEvent.btn_expand_collapse,
            pagePath: '',
            clickTarget: (AnalyticsEvent.btn_expand_collapse).toString(),
          );

          FoldMatchManager.setGroupFold(combineInfo.sectionGroupEnum!, !value);

          TyHomeController.to.homeState.combineList.forEach((element) {
            if (element.sectionGroupEnum == combineInfo.sectionGroupEnum) {
              FoldMatchManager.setFoldByTid(
                  element.tid, element.sectionGroupEnum!, !value);
            }
          });
          controller.update();
        },
        sectionGroupEnum: combineInfo.sectionGroupEnum!,
      );
    }

    /// 赛事数量统计
    if (combineInfo.type == CombineType.sportHeader) {
      return SportHeaderWidget(
        title: '${combineInfo.sportTitle}(${combineInfo.sportCount})',
      );
    }

    /// 联赛 + 比赛（带头）
    if (combineInfo.type == CombineType.matchWithHeader) {
      bool isFold = FoldMatchManager.isFoldByTid(
          combineInfo.tid, combineInfo.sectionGroupEnum!);

      bool isClose = MatchDataBaseWS.closeMatch(
        mhs: combineInfo.data!.mhs,
        mmp: combineInfo.data!.mmp,
        ms: combineInfo.data!.ms,
      );
      if (isClose) return const SizedBox();
      /// 置顶赛事过滤-------锚点 。 暂时去掉
      // if (combineInfo.sectionGroupEnum != SectionGroupEnum.Pin) {
      //   if (PinController.to?.isLeaguePin(combineInfo.tid.toInt()) == true) {
      //     return const SizedBox();
      //   } else {
      //     CombineInfo? nextInfo = combineInfo;
      //     int matchIndex = index;
      //     bool allMatchPin = true;
      //
      //     while (nextInfo?.tid == combineInfo.tid) {
      //       if (nextInfo!.data != null &&
      //           PinController.to?.isMatchPin(nextInfo.data!) != true) {
      //         allMatchPin = false;
      //         break;
      //       }
      //       matchIndex++;
      //       if (nextInfo.isLastMatch == false &&
      //           matchIndex < controller.homeState.combineList.length) {
      //         nextInfo = controller.homeState.combineList.safe(matchIndex);
      //       } else {
      //         break;
      //       }
      //     }
      //     if (allMatchPin) return const SizedBox();
      //   }
      // }

      return Container(
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: HomeState.listItemOpacity)
              : const Color(0xffF8F9FA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
            bottomLeft: combineInfo.isLastMatch || isFold
                ? Radius.circular(8.r)
                : Radius.zero,
            bottomRight: combineInfo.isLastMatch || isFold
                ? Radius.circular(8.r)
                : Radius.zero,
          ),
          border: context.isDarkMode
              ? null
              : Border(
                  top: const BorderSide(color: Color(0xffFFFFFF), width: 1),
                  left: const BorderSide(color: Color(0xffFFFFFF), width: 1),
                  right: const BorderSide(color: Color(0xffFFFFFF), width: 1),
                  bottom: combineInfo.isLastMatch || isFold
                      ? const BorderSide(color: Color(0xffFFFFFF), width: 1)
                      : BorderSide.none,
                ),
        ),
        margin: EdgeInsets.only(
          left: HomeState.listItemHorizontalPadding.w,
          right: HomeState.listItemHorizontalPadding.w,
          bottom: combineInfo.isLastMatch || isFold
              ? HomeState.listItemBottomPadding.w
              : 0,
        ),
        child: Column(
          children: [
            MatchGroupHeaderWidget(combineInfo: combineInfo),
            if (!isFold)
              Column(
                children: [
                  Divider(
                    height: HomeState.listItemDividerHeight.w,
                    color: context.isDarkMode
                        ? Colors.white.withAlpha(10)
                        : const Color(0xffE4E6ED),
                  ),
                  BetTitleGroupWidget(
                    hps: combineInfo.data!.hps,
                    matchEntity: combineInfo.data!,
                  ).paddingOnly(bottom: HomeState.listItemBottomMargin.h),
                  ItemBodyWidget(
                    key: combineInfo.data != null
                        ? ValueKey(
                            "ItemBody-${combineInfo.sectionGroupEnum}-${combineInfo.data!.mid}")
                        : null,
                    matchEntity: combineInfo.data!,
                  ),
                  if (combineInfo.isLastMatch)
                    HomeState.listItemVerticalSpacing.verticalSpaceFromWidth,
                ],
              ),
          ],
        ),
      );
    }

    /// 无头比赛
    if (combineInfo.type == CombineType.match) {
      bool isFold = FoldMatchManager.isFoldByTid(
          combineInfo.tid, combineInfo.sectionGroupEnum!);
      if (isFold) return 0.verticalSpaceFromWidth;

      return Container(
        margin: EdgeInsets.only(
          bottom: combineInfo.isLastMatch ? 8.w : 0,
          left: 5.w,
          right: 5.w,
        ),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.03999999910593033)
              : const Color(0xffF8F9FA),
          borderRadius: BorderRadius.only(
            bottomLeft:
                combineInfo.isLastMatch ? Radius.circular(4.r) : Radius.zero,
            bottomRight:
                combineInfo.isLastMatch ? Radius.circular(4.r) : Radius.zero,
          ),
          border: context.isDarkMode
              ? null
              : Border(
                  left: const BorderSide(color: Color(0xffFFFFFF), width: 1),
                  right: const BorderSide(color: Color(0xffFFFFFF), width: 1),
                  bottom: combineInfo.isLastMatch
                      ? const BorderSide(color: Color(0xffFFFFFF), width: 1)
                      : BorderSide.none,
                ),
        ),
        child: ItemBodyWidget(
          key: combineInfo.data?.mid != null
              ? ValueKey(
                  "ItemBody-${combineInfo.sectionGroupEnum}-${combineInfo.data!.mid}")
              : null,
          matchEntity: combineInfo.data!,
        ),
      );
    }

    return 0.verticalSpaceFromWidth;
  }

  Widget _buildNoob(BuildContext context, CombineInfo combineInfo, int index) {
    if (combineInfo.type == CombineType.sectionHeader) {
      return SectionHeaderWidget(
        isExpand: !FoldMatchManager.isGroupFold(combineInfo.sectionGroupEnum!),
        onExpand: (value) {
          FoldMatchManager.setGroupFold(combineInfo.sectionGroupEnum!, !value);

          TyHomeController.to.homeState.combineList.forEach((element) {
            if (element.sectionGroupEnum == combineInfo.sectionGroupEnum) {
              FoldMatchManager.setFoldByTid(
                  element.tid, element.sectionGroupEnum!, !value);
            }
          });
          controller.update();
        },
        sectionGroupEnum: combineInfo.sectionGroupEnum!,
      );
    }

    if (combineInfo.type == CombineType.sportHeader) {
      return SportHeaderWidget(
        title: '${combineInfo.sportTitle}(${combineInfo.sportCount})',
      );
    }

    if (combineInfo.type == CombineType.matchWithHeader) {
      bool isFold = FoldMatchManager.isFoldByTid(
          combineInfo.tid, combineInfo.sectionGroupEnum!);

      bool isClose = MatchDataBaseWS.closeMatch(
        mhs: combineInfo.data!.mhs,
        mmp: combineInfo.data!.mmp,
        ms: combineInfo.data!.ms,
      );
      if (isClose) return const SizedBox();

      return Container(
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.03999999910593033)
              : const Color(0xffF8F9FA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
            bottomLeft: combineInfo.isLastMatch || isFold
                ? Radius.circular(8.r)
                : Radius.zero,
            bottomRight: combineInfo.isLastMatch || isFold
                ? Radius.circular(8.r)
                : Radius.zero,
          ),
        ),
        margin: EdgeInsets.only(
          left: 5.w,
          right: 5.w,
          bottom: combineInfo.isLastMatch || isFold ? 8.w : 0,
        ),
        child: Column(
          children: [
            MatchGroupHeaderWidget(combineInfo: combineInfo),
            isFold
                ? const SizedBox()
                : NoobItemBodyWidget(
                    key: ValueKey(
                        "NoobItemBody-${combineInfo.sectionGroupEnum}-${combineInfo.data?.mid}"),
                    matchEntity: combineInfo.data!,
                    combineType: combineInfo.type,
                  ),
          ],
        ),
      );
    }

    if (combineInfo.type == CombineType.match) {
      bool isFold = FoldMatchManager.isFoldByTid(
          combineInfo.tid, combineInfo.sectionGroupEnum!);
      if (isFold) return 0.verticalSpaceFromWidth;

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        margin: EdgeInsets.only(
          bottom: combineInfo.isLastMatch ? 8.w : 0,
          left: 5.w,
          right: 5.w,
        ),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.03999999910593033)
              : const Color(0xffF8F9FA),
          borderRadius: BorderRadius.only(
            bottomLeft:
                combineInfo.isLastMatch ? Radius.circular(8.r) : Radius.zero,
            bottomRight:
                combineInfo.isLastMatch ? Radius.circular(8.r) : Radius.zero,
          ),
        ),
        child: NoobItemBodyWidget(
          key: ValueKey(
              "NoobItemBody-${combineInfo.sectionGroupEnum}-${combineInfo.data?.mid}"),
          matchEntity: combineInfo.data!,
          combineType: combineInfo.type,
        ),
      );
    }

    return 0.verticalSpaceFromWidth;
  }
}
