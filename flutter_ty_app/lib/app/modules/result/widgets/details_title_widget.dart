
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/result/widgets/details_title_score_widget.dart';
import 'package:flutter_ty_app/app/modules/result/widgets/details_title_team_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import '../../../widgets/marquee.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果详情 热门推荐 组件 DetailsTitleWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果详情 热门推荐  组件 DetailsTitleWidget
    - DetailsTitleWidget
    ```
    /// 赛果详情热门推荐  组件
    DetailsTitleWidget(
      isDark: context.isDarkMode,
      headMenu: controller.headMenu,
      onHeadMenu: () => controller.onHeadMenu(),
      detailData: controller.detailData,
      headMatchList: controller.headMatchList,
      onHeadMatch: (matchItem) =>
      controller.onHeadMatch(matchItem),
      mid: controller.mid,
      titleIndex: controller.titleIndex,
    ),
    ```
    】】】
 *
 */

class DetailsTitleWidget extends StatelessWidget {
  const DetailsTitleWidget({
    super.key,
    required this.isDark,
    required this.headMenu,
    required this.onHeadMenu,
    required this.detailData,
    required this.headMatchList,
    required this.onHeadMatch,
    required this.mid,
    required this.titleIndex,
  });

  final bool isDark;
  final bool headMenu;
  final VoidCallback? onHeadMenu;
  final MatchEntity? detailData;
  final List<MatchEntity> headMatchList;
  final void Function(dynamic) onHeadMatch;
  final String mid;
  final int titleIndex;

  @override
  Widget build(BuildContext context) {
    /// 正常标题时宽度
    double normalTitleWidth = 1.sw - 100.w;
    // maxMarqueeWidth = 正常标题时宽度 - 右侧三角形图标宽度以及边距
    double maxMarqueeWidth = normalTitleWidth - 12.w - 4.w;
    return Visibility(
      visible: headMenu,
      maintainAnimation: true,
      maintainState: true,
      child: Column(
        children: [
          Container(
            color: isDark ? const Color(0xFF1E2029) : Colors.white,
            child: SafeArea(
              child: SizedBox(
                height: headMatchList.length <= 1
                    ? 150.h
                    : headMatchList.length <= 2
                        ? 250.h
                        : headMatchList.length <= 3
                            ? 360.h
                            : 500.h,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 10.w,
                        right: 10.w,
                      ),
                      height: 44.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            child: ImageView(
                              'assets/images/icon/icon_arrowleft_nor.png',
                              width: 16.w,
                              height: 16.h,
                              color: Colors.grey,
                            ),
                          ),
                          InkWell(
                            onTap: onHeadMenu,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: normalTitleWidth,
                                  alignment: Alignment.center,
                                  child:

                                      /// 标题滚动
                                      needMarquee(
                                              text: detailData?.tn ?? "",
                                              fontSize: 16.sp,
                                              maxWidth: maxMarqueeWidth)
                                          ? _buildMarqueeTitle(
                                              maxMarqueeWidth, detailData)
                                          : _buildNormalTitle(detailData),
                                ),
                              ],
                            ),
                          ),
                          Container(

                            width: 20.w,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: headMatchList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            MatchEntity matchItem = headMatchList[index];
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () => onHeadMatch(matchItem),
                                  child: Container(
                                    margin: EdgeInsets.all(10.h),
                                    color: mid == matchItem.mid
                                        ? isDark
                                            ? const Color(0xFF272931)
                                            : const Color(0xFFe8f5ff)
                                        : null,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 10.h, bottom: 10.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          DetailsTitleTeamWidget(titleIndex: titleIndex, matchItem: matchItem, isDark: isDark, isHome: true),
                                          // Column(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.center,
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //   children: [
                                          //     titleIndex == 1
                                          //         ? ImageView(
                                          //             matchItem.mhlu[0] ?? '',
                                          //             width: 33.w,
                                          //             height: 33.h,
                                          //             dj: true,
                                          //           )
                                          //         : ImageView(
                                          //             ObjectUtil.isNotEmpty(
                                          //                     (matchItem.mhlu
                                          //                             as List)
                                          //                         .safe(0))
                                          //                 ? (matchItem.mhlu as List)
                                          //                     .safe(0)
                                          //                 : 'assets/images/home/home_team_logo.svg',
                                          //             cdn: true,
                                          //             width: 33.w,
                                          //             height: 33.h,
                                          //           ),
                                          //     Container(
                                          //       height: 10.w,
                                          //     ),
                                          //     Container(
                                          //       width: 115.w,
                                          //       height: 30.h,
                                          //       alignment: Alignment.topCenter,
                                          //       child: Text(
                                          //         matchItem.mhn,
                                          //         textAlign: TextAlign.center,
                                          //         style: TextStyle(
                                          //           color: isDark
                                          //               ? Colors.white
                                          //               : const Color(0xFF303442),
                                          //           fontSize: 12.sp,
                                          //           fontFamily: 'PingFang SC',
                                          //           fontWeight: FontWeight.w500,
                                          //         ),
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                          DetailsTitleScoreWidget(matchItem: matchItem, isDark: isDark),
                                          // Column(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.center,
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //   children: [
                                          //     Text(
                                          //       LocaleKeys.match_info_match_end.tr,
                                          //       style: TextStyle(
                                          //         color: isDark
                                          //             ? Colors.white
                                          //             : const Color(0xFF303442),
                                          //         fontSize: 12.sp,
                                          //         fontFamily: 'PingFang SC',
                                          //         fontWeight: FontWeight.w500,
                                          //       ),
                                          //     ),
                                          //     Container(
                                          //       height: 10.w,
                                          //     ),
                                          //     Text(
                                          //       TYFormatScore.formatTotalScore(
                                          //               matchItem)
                                          //           .text,
                                          //       style: TextStyle(
                                          //         color: isDark
                                          //             ? Colors.white
                                          //             : const Color(0xFF303442),
                                          //         fontSize: 22.sp,
                                          //         fontFamily: 'PingFang SC',
                                          //         fontWeight: FontWeight.w500,
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                          DetailsTitleTeamWidget(titleIndex: titleIndex, matchItem: matchItem, isDark: isDark, isHome: false),
                                          // Column(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.center,
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //   children: [
                                          //     titleIndex == 1
                                          //         ? ImageView(
                                          //             matchItem.malu[0] ?? '',
                                          //             width: 33.w,
                                          //             height: 33.h,
                                          //             dj: true,
                                          //           )
                                          //         : ImageView(
                                          //             ObjectUtil.isNotEmpty(
                                          //                     (matchItem.malu
                                          //                             as List)
                                          //                         .safe(0))
                                          //                 ? (matchItem.malu as List)
                                          //                     .safe(0)
                                          //                 : 'assets/images/home/home_team_logo.svg',
                                          //             cdn: true,
                                          //             width: 33.w,
                                          //             height: 33.h,
                                          //           ),
                                          //     Container(
                                          //       height: 10.w,
                                          //     ),
                                          //     Container(
                                          //       width: 115.w,
                                          //       height: 30.h,
                                          //       alignment: Alignment.topCenter,
                                          //       child: Text(
                                          //         matchItem.man,
                                          //         textAlign: TextAlign.center,
                                          //         style: TextStyle(
                                          //           color: isDark
                                          //               ? Colors.white
                                          //               : const Color(0xFF303442),
                                          //           fontSize: 12.sp,
                                          //           fontFamily: 'PingFang SC',
                                          //           fontWeight: FontWeight.w500,
                                          //         ),
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: context.isDarkMode
                                      ? Colors.white.withAlpha(10)
                                      : const Color(0xffE4E6ED),
                                  thickness: 1,
                                  height: 0,
                                )
                              ],
                            );
                          }),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: onHeadMenu,
              child: Container(
                color: Colors.black.withValues(alpha:0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 滚动标题
  _buildMarqueeTitle(double maxWidth, MatchEntity? match) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: maxWidth,
          child: Marquee(
            text: match?.tn ?? "",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: isDark ? Colors.white : Colors.black,
            ),
            velocity: 30.0,
            blankSpace: 10.w,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        // 三角形图标
        ImageView(
          Get.isDarkMode
              ? "assets/images/detail/icon_arrowup_nor_night.svg"
              : "assets/images/detail/icon_arrowup_nor.svg",
          width: 10.w,
          height: 10.h,
        )
      ],
    );
  }

  /// 正常标题
  _buildNormalTitle(MatchEntity? match) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 联赛名
        Text(
          match?.tn ?? "",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        // 三角形图标
        ImageView(
          Get.isDarkMode
              ? "assets/images/detail/icon_arrowup_nor_night.svg"
              : "assets/images/detail/icon_arrowup_nor.svg",
          width: 10.w,
          height: 10.h,
        )
      ],
    );
  }

  /// 计算标题是否滚动
  bool needMarquee(
      {required String text,
      required double fontSize,
      required double maxWidth}) {
    // 计算文本大小 超过规定边界则使用跑马灯
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout();

    if (textPainter.width > maxWidth) {
      return true;
    }
    return false;
  }
}
