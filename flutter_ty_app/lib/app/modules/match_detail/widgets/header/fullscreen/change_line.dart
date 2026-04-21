import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/webview_extension.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';

import '../../../controllers/match_detail_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 背景+全屏】】】
    【【【 AUTO_PARAGRAPH_TITLE 视频动画全屏组件-清晰度切换】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 左滑清晰度切换组件
    】】】
 *
 */
class ChangeLine extends StatefulWidget {
  const ChangeLine({super.key, this.tag, required this.width});

  final String? tag;

  // 左滑出来的宽度
  final double width;

  @override
  State<ChangeLine> createState() => _ChangeLineState();
}

class _ChangeLineState extends State<ChangeLine> {
  late MatchDetailController controller;
  int curLine = 0;

  @override
  void initState() {
    controller = Get.find<MatchDetailController>(tag: widget.tag);
    curLine = controller.detailState.selectLine.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            top: 100,
            child: Container(
              height: 0.5.sh,
              width: 190,
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.detailState.playTypeList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    // 计算文本大小
                    TextPainter textPainter = TextPainter(
                      text: TextSpan(
                        text: controller.detailState.playTypeList[index],
                        style: TextStyle(
                          color: curLine == index
                              ? const Color(0xFF127DCC)
                              : Colors.white.withValues(alpha:0.5),
                          fontSize: 16,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      textDirection: TextDirection.ltr,
                      maxLines: 1,
                    );
                    textPainter.layout();
                    return LayoutBuilder(builder: (context, covariant) {
                      double width = textPainter.width;

                      if (textPainter.width > covariant.maxWidth) {
                        width = covariant.maxWidth;
                      }
                      return InkWell(
                        onTap: () {
                          if (controller.detailState.selectLine.value !=
                              index) {
                            controller.detailState.selectLine.value = index;
                            controller.switchVideoUrl(type: index);
                          }
                          setState(() {
                            curLine = index;
                          });
                        },
                        child: Container(
                          height: 36,
                          width: width,
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: curLine == index
                                    ? const Color(0xFF127DCC)
                                    : Colors.white.withValues(alpha:0.04),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            controller.detailState.playTypeList[index],
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: curLine == index
                                  ? const Color(0xFF127DCC)
                                  : Colors.white.withValues(alpha:0.5),
                              fontSize: 16,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    });
                  }),
            )),
        Positioned(
            bottom: 44,
            width: widget.width - 40,
            child: Text(
              LocaleKeys.app_Video_line_prompts.tr,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                color: Colors.white.withValues(alpha:0.6),
                fontSize: 12,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ))
      ],
    );
  }
}
