import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../../main.dart';
import '../../../utils/oss_util.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/marquee.dart';
import '../../match_detail/widgets/header/score/match_detail_score.dart';
import 'HeaderModel.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果 赛果详情头部  组件 DetailsHeadWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果 赛果详情头部  组件 DetailsHeadWidget
    - DetailsHeadWidget
    】】】
 *
 */
class DetailsHeadWidget extends StatelessWidget {
  const DetailsHeadWidget({
    super.key,
    required this.isDark,
    required this.typePicture,
    required this.onHeadMenu,
    required this.detailData,
    required this.onRefresh,
    required this.animationController,
    required this.headerMap,
  });

  final bool isDark;
  final String typePicture;
  final VoidCallback? onHeadMenu;
  final MatchEntity? detailData;
  final VoidCallback? onRefresh;
  final AnimationController animationController;
  final HeaderModel headerMap;

  @override

  Widget build(BuildContext context) {
    /// 正常标题时宽度
    double normalTitleWidth = 1.sw - 100.w;
    // maxMarqueeWidth = 正常标题时宽度 - 右侧三角形图标宽度以及边距
    double maxMarqueeWidth = normalTitleWidth - 12.w - 4.w;
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            OssUtil.getServerPath(typePicture),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 8.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => Get.back(),
                      child: ImageView(
                        'assets/images/icon/icon_arrowleft_nor.png',
                        width: 16.w,
                        height: 16.h,
                        color: Colors.white,
                      )),
                  if (detailData != null)
                    InkWell(
                      onTap: onHeadMenu,
                      child: SizedBox(
                        height: 44.h,
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
                    ),
                  InkWell(
                    onTap: onRefresh,
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 2.0)
                          .animate(animationController),
                      child: ImageView(
                        'assets/images/shopcart/refresh1.png',
                        color: Colors.white,
                        width: 18.w,
                        height: 18.w,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  '${detailData?.mhn ?? ''} v ${detailData?.man ?? ''}',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                constraints: BoxConstraints(
                                    maxWidth: isIPad ? 330.w : 210.w),
                              ),
                              Text(
                                " (" + LocaleKeys.mmp_3_999_app_h5.tr + ")",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Text(
                            headerMap.score,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(
                        top: 4.h,
                      ),
                      child: Row(
                        children: [
                          Text(
                            headerMap.time,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (![5, 10, 7, 8, 13].contains(
                                  int.tryParse(detailData?.csid ?? "")) &&
                              detailData?.mng != 0)
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 0.5),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 0),
                              child: Text(
                                "N",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ).marginOnly(left: 4.w),
                          // 上半场，全场，加时赛，点球大战
                          if (detailData != null)
                            MatchDetailScore(
                              match: detailData!,
                              isResult: true,
                            ).marginOnly(left: 4.w)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (detailData != null)
                    Expanded(child: MatchDetailScore(match: detailData!))
                ],
              ),
            ],
          ),
        ),
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
              fontWeight: FontWeight.w500,
              fontFamily: 'PingFang SC',
              color: Colors.white,
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
          "assets/images/detail/icon_arrowdown_nor_night.svg",
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
            fontWeight: FontWeight.w500,
            fontFamily: 'PingFang SC',
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        // 三角形图标
        ImageView(
          "assets/images/detail/icon_arrowdown_nor_night.svg",
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

  Size calculateTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
