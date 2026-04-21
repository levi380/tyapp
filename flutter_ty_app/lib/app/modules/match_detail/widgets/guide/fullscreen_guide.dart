import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_api_service.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/match_video/match_video_extension.dart';

import '../../../../utils/sport.dart';
import '../../../login/login_head_import.dart';
import '../../models/header_type_enum.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 详情头部】】】
    【【【 AUTO_PARAGRAPH_TITLE 动画操作组件】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 全屏引导
    】】】
 *
 */
class FullscreenGuide extends StatelessWidget {
  const FullscreenGuide({super.key, required this.controller});

  final MatchDetailController controller;

  @override
  Widget build(BuildContext context) {
    final detailState = controller.detailState;
    return Obx(() {
      // 所有用户（新/老用户） 功能上线后首次访问任一「综合球种」视频或动画时触发
      // 不包含足球 篮球 电子足篮  电竞
      bool isSpecialType = ![
            SportData.sportCsid_90,
            SportData.sportCsid_91,
            SportData.sportCsid_1,
            SportData.sportCsid_2
          ].contains(detailState.csid.toInt()) &&
          !detailState.isDJDetail;
      if ([HeaderType.live, HeaderType.animate]
              .contains(detailState.headerType.value) &&
          detailState.isShowBetGuide.value &&
          detailState.fullscreenKey.currentContext != null &&
          isSpecialType) {
        RenderBox box = detailState.fullscreenKey.currentContext!
            .findRenderObject() as RenderBox;
        Offset offset = box.localToGlobal(Offset.zero);
        Size size = box.size;
        return InkWell(
          onTap: () => controller.cancelFirstFullBetGuild(),
          child: Container(
            width: 1.sw,
            height: 1.sh,
            // color: Colors.black.withOpacity(.6),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 遮罩 + 高亮
                GestureDetector(
                  child: CustomPaint(
                    size: MediaQuery.of(context).size,
                    painter: _HighlightPainter(
                      holeRect: Rect.fromLTWH(
                        offset.dx,
                        offset.dy,
                        size.width,
                        size.height,
                      ),
                    ),
                  ),
                ),

                // 文本（放在按钮下方居中）
                Positioned(
                  top: offset.dy - 200.h,
                  // 按钮上方
                  child: Column(
                    children: [
                      ImageView(
                        "assets/images/detail/guide/full-guild-text-${Get.locale?.languageCode ?? "zh"}.png",
                        width: 249.w,
                      )
                    ],
                  ),
                ),
                // 箭头（相对按钮位置，比如在按钮上方居中）
                Positioned(
                  left: offset.dx - 100.w,
                  // 居中对齐按钮
                  top: offset.dy - 70.h,
                  // 按钮上方
                  child: ImageView(
                    'assets/images/detail/guide/guide-arrow.png',
                    width: 84.w,
                  ),
                ),
                // 点击小矩形（相对按钮，放在左上角）
                Positioned(
                  left: offset.dx - size.width / 4 - 2.w,
                  top: offset.dy - size.height / 4 - 2.h,
                  child: InkWell(
                    onTap: () {
                      controller.cancelFirstFullBetGuild();
                      controller.fullscreen(true);
                    },
                    child: ImageView(
                      'assets/images/detail/guide/guide-btn.svg',
                      width: 40.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}

/// 遮罩 + 挖空区域的画笔
class _HighlightPainter extends CustomPainter {
  final Rect holeRect;

  _HighlightPainter({required this.holeRect});

  @override
  void paint(Canvas canvas, Size size) {
    // 创建一个新的图层
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    // 画全屏遮罩
    Paint overlayPaint = Paint()..color = Colors.black54.withValues(alpha: 0.5);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), overlayPaint);

    // 挖空区域
    Paint clearPaint = Paint()
      ..blendMode = BlendMode.clear
      ..style = PaintingStyle.fill;

    RRect rRect = RRect.fromRectAndRadius(holeRect, const Radius.circular(8));
    canvas.drawRRect(rRect, clearPaint);

    // 恢复图层
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _HighlightPainter oldDelegate) {
    return holeRect != oldDelegate.holeRect;
  }
}
