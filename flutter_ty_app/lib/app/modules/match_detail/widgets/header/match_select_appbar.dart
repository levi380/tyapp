import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/match_stage.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../main.dart';
import '../../../../global/data_store_controller.dart';
import '../../../../utils/format_score_util.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/marquee.dart';
import '../../constants/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import '../../controllers/match_tools_methods.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-94bbec27-e1cd-4919-9dab-28cfe5505d7a 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 下拉联赛选择】】】
    【【【 AUTO_PARAGRAPH_TITLE 下拉联赛头部】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 下拉联赛头部
    】】】
 *
 */
class MatchSelectAppbar extends StatefulWidget {
  const MatchSelectAppbar({super.key, this.tag});

  final String? tag;

  @override
  State<MatchSelectAppbar> createState() => _MatchSelectAppbarState();
}

class _MatchSelectAppbarState extends State<MatchSelectAppbar>
    with SingleTickerProviderStateMixin {
  final _refreshSubject = BehaviorSubject<Function>();
  late AnimationController _animationController;

  @override
  void initState() {
    _refreshSubject
        .debounceTime(const Duration(milliseconds: 1100))
        .listen((callback) {
      // 防抖
      callback();
    });
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    _refreshSubject.close();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
        tag: widget.tag,
        builder: (controller) {
          if (controller.detailState.match == null) return Container();
          MatchEntity match = controller.detailState.match!;
          return GetBuilder<DataStoreController>(
              id: DataStoreController.to.getMatchId(match.mid),
              builder: (dataStoreController) {
                MatchEntity matchEntity =
                    dataStoreController.getMatchById(match.mid) ?? match;
                return Container(
                  height: obtyAppbarHeight,
                  width: 1.sw,
                  padding: EdgeInsets.only(
                      left: 6.w, top: 4.h, bottom: 4.h, right: 14.w),

                  /// 根据是否置顶渲染不动的widget
                  child: Obx(() => controller.detailState.appbarPinned.value
                      ? _pinnedAppbar(matchEntity, controller)
                      : _normalAppbar(matchEntity, controller)),
                );
              });
        });
  }

  /// 未置顶
  _normalAppbar(MatchEntity match, MatchDetailController controller) {
    /// 未置顶时正常标题时宽度
    double normalTitleWidth = 1.sw - 100.w;
    // maxMarqueeWidth = 正常标题时宽度 - 右侧三角形图标宽度以及边距
    double maxMarqueeWidth = normalTitleWidth - 12.w - 4.w;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        /// 返回 增大触摸区域
        Positioned(
          left: 0,
          child: InkWell(
            onTap: () => controller.back(),
            child: Container(
              width: 24.w,
              height: obtyAppbarHeight,
              alignment: Alignment.center,
              child: ImageView(
                !Get.isDarkMode
                    ? "assets/images/detail/icon_arrowleft_nor.svg"
                    : "assets/images/detail/icon_arrowleft_nor_night.svg",
                boxFit: BoxFit.fill,
                width: isIPad ? 14.w : 8.w,
              ),
            ),
          ),
        ),

        /// 中间
        GestureDetector(
          onTap: () {
            controller.detailState.isMatchSelectExpand.value = false;
            Get.back();
          },
          child: Container(
            width: normalTitleWidth,
            alignment: Alignment.center,
            child:

                /// 标题滚动
                needMarquee(
                        text: match.tn,
                        fontSize: isIPad ? 20.sp : 18.sp,
                        maxWidth: maxMarqueeWidth)
                    ? _buildMarqueeTitle(maxMarqueeWidth, match, controller)
                    : _buildNormalTitle(match, controller),
          ),
        ),
      ],
    );
  }

  /// 置顶
  _pinnedAppbar(MatchEntity match, MatchDetailController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            /// 返回 增大触摸区域
            InkWell(
              onTap: () => controller.back(),
              child: Container(
                width: 24.w,
                height: obtyAppbarHeight,
                alignment: Alignment.center,
                child: ImageView(
                  "assets/images/detail/icon_arrowleft_nor_night.svg",
                  boxFit: BoxFit.fill,
                  width: isIPad ? 14.w : 8.w,
                ),
              ),
            ),

            /// 队伍1
            SizedBox(
              width: isIPad ? 120.w : 75.w,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      match.mhn,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isIPad ? 16.sp : 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  if (isTopShowScore(match) &&
                      !eSportsScoring(match))
                    AutoSizeText(
                      FormatScore.formatTotalScore(match, 0).toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: isIPad ? 20.sp : 18.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DIN'),
                    ).marginOnly(left: 8.w),
                ],
              ),
            ),
          ],
        ),

        /// 赛事阶段状态
        InkWell(
          onTap: () {
            controller.detailState.scrollController.animateTo(
              0.0,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
          },
          child: MatchStage(
            match: match,
            isPinnedAppbar: true,
          ),
        ),

        /// 队伍2
        SizedBox(
          width: isIPad ? 130.w : 85.w,
          child: Row(
            children: [
              if (isTopShowScore(match) &&
                  !eSportsScoring(match))
                Text(
                  FormatScore.formatTotalScore(match, 1).toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: isIPad ? 20.sp : 18.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DIN'),
                ).marginOnly(right: 8.w),
              Expanded(
                child: Text(
                  match.man,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isIPad ? 16.sp : 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ).marginOnly(right: 8.w),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 滚动标题
  _buildMarqueeTitle(
      double maxWidth, MatchEntity match, MatchDetailController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: maxWidth,
          child: Marquee(
            text: match.tn,
            style: TextStyle(
              fontSize: isIPad ? 20.sp : 18.sp,
              fontWeight: FontWeight.w400,
              color: !Get.isDarkMode
                  ? Get.theme.matchSelectTitleColor
                  : Colors.white.withValues(alpha: 0.9),
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
          boxFit: BoxFit.fill,
          width: 12.w,
          height: 12.w,
        )
      ],
    );
  }

  /// 正常标题
  _buildNormalTitle(MatchEntity match, MatchDetailController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 联赛名
        Text(
          match.tn,
          style: TextStyle(
            fontSize: isIPad ? 20.sp : 18.sp,
            fontWeight: FontWeight.w400,
            color: !Get.isDarkMode
                ? Get.theme.matchSelectTitleColor
                : Colors.white.withValues(alpha: 0.9),
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
          boxFit: BoxFit.fill,
          width: 12.w,
          height: 12.w,
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
