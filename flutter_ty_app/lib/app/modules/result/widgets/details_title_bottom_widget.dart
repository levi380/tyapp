

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../core/format/common/module/format-date.dart';
import '../../../core/format/common/module/format-score.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../match_detail/widgets/header/score/match_detail_score.dart';
import 'details_title_ended_widget.dart';
import 'details_title_new_score_widget.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果详情】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果详情  头部组件  热门赛事推荐  DetailsTitleNewWidget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果详情  头部组件  热门赛事推荐  DetailsTitleNewWidget
    - DetailsTitleNewWidget
    】】】
 *
 */
class DetailsTitleBottomWidget extends StatelessWidget {
  const DetailsTitleBottomWidget({
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
    List<MatchEntity> headMatchListNew = headMatchList.where((item) => item.mid != mid).toList();
    List<MatchEntity> headMatchListTitle = headMatchList.where((item) => item.mid == mid).toList();
    return  headMatchListTitle.isNotEmpty ? Visibility(
      visible: headMenu,
      maintainAnimation: true,
      maintainState: true,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: onHeadMenu,
              child: Container(
                color: Colors.black.withValues(alpha:0.0),
              ),
            ),
          ),
          Container(
            color: isDark ? const Color(0xFF1E2029)  : const Color(0xFFF2F2F6),
            child: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height-200.h,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: onHeadMenu,
                            child: ImageView(
                              'assets/images/icon/expands.png',
                              width: 24.w,
                              height: 24.h,
                              color: Colors.grey,
                            ),
                          ),
                          if (detailData != null)
                            MatchDetailScore(
                              match: headMatchListTitle[0],
                              isResult: true,
                              isResultTitle: true,
                            ).marginOnly(top: 5.h,bottom: 4.h),

                          Container(
                            margin: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 10.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          headMatchListTitle[0].mhn ,
                                          textAlign: TextAlign.right,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:isDark ? Colors.white.withValues(alpha: 0.90) : const Color(0xFF303442) /* text-color-text */,
                                            fontSize: 16.sp,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(width: 6.w,),
                                      titleIndex == 1 ?
                                      ImageView(
                                        StringKV.eSportsImgDomain.get()!.isNotEmpty ?  headMatchListTitle[0].mhlu[0] : 'assets/images/home/home_team_logo.svg' ,
                                        dj: true,
                                        width: 28.w,
                                        height: 28.w,
                                        errorWidget: ImageView(
                                         'assets/images/home/home_team_logo.svg' ,
                                          cdn: true,
                                          width: 28.w,
                                          height: 28.w,
                                        ),
                                      ):ImageView(
                                        headMatchListTitle[0].mhlu[0] ?? '',
                                        cdn: true,
                                        width: 28.w,
                                        height: 28.w,
                                        errorWidget: ImageView(
                                          'assets/images/home/home_team_logo.svg' ,
                                          cdn: true,
                                          width: 28.w,
                                          height: 28.w,
                                        ),
                                      ),
                                      Container(width: 20.w,),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  flex: 0,
                                  child: Column(
                                    children: [
                                      Text(
                                        TYFormatScore.formatTotalScore(detailData!).text,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color:isDark ? Colors.white.withValues(alpha: 0.90) : const Color(0xFF303442) /* text-color-text */,
                                          fontSize: 22.sp,
                                          fontFamily: 'Akrobat',
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Container(height: 10.h,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ///已完赛
                                          DetailsTitleEndedWidget(isDark: isDark,),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                    Container(width: 20.w,),
                                      titleIndex == 1 ?
                                      ImageView(
                                        headMatchListTitle[0].malu[0] ?? '',
                                        dj: true,
                                        width: 28.w,
                                        height: 28.w,
                                        errorWidget: ImageView(
                                          'assets/images/detail/default_team_away.svg' ,
                                          cdn: true,
                                          width: 28.w,
                                          height: 28.w,
                                        ),
                                      ):
                                      ImageView(
                                        headMatchListTitle[0].malu[0] ?? '',
                                        cdn: true,
                                        width: 28.w,
                                        height: 28.w,
                                        errorWidget: ImageView(
                                          'assets/images/detail/default_team_away.svg' ,
                                          cdn: true,
                                          width: 28.w,
                                          height: 28.w,
                                        ),
                                      ),
                                      Container(width: 6.w,),
                                      Expanded(
                                        child: Text(
                                          headMatchListTitle[0].man,
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:isDark ? Colors.white.withValues(alpha: 0.90)  :const Color(0xFF303442) /* text-color-text */,
                                            fontSize: 16.sp,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                    if(headMatchList.length>1)
                    Container(
                      height: 36.h,
                      alignment: Alignment.centerLeft,
                      color: isDark ? Color(0xFF272931): Colors.white,
                      margin: EdgeInsets.only(top: 8.h),
                      child: Container(
                        margin: EdgeInsets.only(left: 12.w,top: 8.h),
                        child: Text(
                            detailData!.tn+'(${headMatchList.length.toString()})',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color:isDark ? Colors.white.withValues(alpha: 0.90) : const Color(0xFF303442) ,
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: headMatchListNew.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => onHeadMatch(headMatchListNew[index]),
                              child: Container(
                                color: isDark ? Color(0xFF272931): Colors.white,
                                child: Container(
                                  margin: EdgeInsets.only(left: 12.w,right: 12.w,),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 80.h,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            textAlign: TextAlign.start,
                                                            TYFormatDate.formatTime(
                                                                TimeZoneUtils.convertTimeToTimestamp(headMatchListNew[index].mgt,
                                                                    isMilliseconds: true, returnMilliseconds: true)
                                                                    .toString(),
                                                                'mm/dd HH:MM') +
                                                                " (" +
                                                                TimeZoneUtils.getTimeZoneString() +
                                                                ")",
                                                            style: TextStyle(
                                                              color:isDark ? Colors.white.withValues(alpha: 0.50) : const Color(0xFF7881A3) /* text-color-text-subtle */,
                                                              fontSize: 12.sp,
                                                              fontFamily: 'PingFang SC',
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      ///比分组件
                                                      DetailsTitleNewScoreWidget(
                                                        isDark: isDark,
                                                        titleIndex: titleIndex,
                                                        image: headMatchListNew[index].mhlu[0] ?? '',
                                                        title: headMatchListNew[index].mhn,
                                                        score: TYFormatScore.formatTotalScore(headMatchListNew[index]).home,
                                                        isHomeTeam: true,
                                                      ),
                                                      Container(width: 15.w,),

                                                    ],
                                                  ),
                                                  Container(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            ///已完赛
                                                            DetailsTitleEndedWidget(isDark: isDark,),
                                                          ],
                                                        ),
                                                      ),

                                                      ///比分组件
                                                      DetailsTitleNewScoreWidget(
                                                        isDark: isDark,
                                                        titleIndex: titleIndex,
                                                        image: headMatchListNew[index].malu[0],
                                                        title: headMatchListNew[index].man,
                                                        score: TYFormatScore.formatTotalScore(headMatchListNew[index]).away,
                                                        isHomeTeam: false,
                                                      ),

                                                      Container(width: 15.w,),



                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 0,
                                              child: InkWell(
                                                onTap: onHeadMenu,
                                                child: ImageView(
                                                  'assets/images/icon/icon_expand_gray.png',
                                                  width: 14.w,
                                                  height: 14.w,
                                                ),
                                              ) ,
                                            )
                                            ,
                                          ],
                                        ),
                                      ),
                                      if(!(index == headMatchListNew.length-1))
                                      Divider(
                                        color: context.isDarkMode
                                            ? const Color(0xff383A41)
                                            : const Color(0xffE4E6ED),
                                        thickness: 0.50,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),


                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    ) :Container();
  }

}
