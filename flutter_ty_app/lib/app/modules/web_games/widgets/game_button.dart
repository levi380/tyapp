

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../utils/oss_util.dart';
import '../web_games_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-0715b484-12fe-4fa9-97ad-7f985fe2cf06-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  真人彩票详情】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人彩票详情web 页 悬浮按钮  NSuspension 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人彩票详情web 页 悬浮按钮  NSuspension
    - NSuspension
    ```
    /// 底部组件
    final Widget bgChild;

    /// 悬浮组件
    final Widget child;

    /// 悬浮组件宽高
    final Size childSize;

    /// 距离四周边界
    final EdgeInsets padding;

    NSuspension(
      childSize: const Size(35, 35),
        bgChild: Container(
        color: Colors.black.withValues(alpha:0.0),
        child: ImageView(
        'assets/images/icon/games_out.png',
        width: 35.w,
        height: 35.w,
        ),
    )
    ```
    】】】
 *
 */
class NSuspension extends StatefulWidget {
  const NSuspension({
    Key? key,
    required this.child,
    required this.bgChild,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.fit = StackFit.loose,
    this.clipBehavior = Clip.hardEdge,
    this.padding = EdgeInsets.zero,
    this.childSize = const Size(100, 100),
  }) : super(key: key);

  final AlignmentGeometry alignment;

  final TextDirection? textDirection;

  final StackFit fit;

  final Clip clipBehavior;

  /// 底部组件
  final Widget bgChild;

  /// 悬浮组件
  final Widget child;

  /// 悬浮组件宽高
  final Size childSize;

  /// 距离四周边界
  final EdgeInsets padding;

  @override
  _NSuspensionState createState() => _NSuspensionState();
}

class _NSuspensionState extends State<NSuspension> {
  final _topVN = ValueNotifier(30.0);
  final _leftVN = ValueNotifier(double.parse((Get.width - 30).toString()));
  bool dragState = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        alignment: widget.alignment,
        textDirection: widget.textDirection,
        fit: widget.fit,
        clipBehavior: widget.clipBehavior,
        children: [
          buildSuspension(
            child: widget.child,
            maxWidth: constraints.maxWidth,
            maxHeight: constraints.maxHeight,
          ),
        ],
      );
    });
  }

  buildSuspension(
      {required Widget child,
      required double maxWidth,
      required double maxHeight}) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _topVN,
          _leftVN,
        ]),
        child: Row(
          children: [
            if (dragState == true)
              Container(
                width: 100.w,
                height: 30.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      OssUtil.getServerPath(
                        'assets/images/icon/games_ts.png',
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '退出全屏',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            Container(
              width: 5.w,
            ),
            child,
          ],
        ),
        builder: (context, child) {
          return Positioned(
              top: _topVN.value,
              left: _leftVN.value,
              child: GestureDetector(
                onTap: () {
                  final wbGamesController = Get.find<WebGamesController>();
                  wbGamesController.fullScreen = false;
                  wbGamesController.update();
                },
                onPanEnd: (details) {
                  setState(() {
                    dragState = false;
                  });
                },
                onPanUpdate: (DragUpdateDetails e) {
                  setState(() {
                    dragState = true;
                  });

                  //用户手指滑动时，更新偏移，重新构建
                  //顶部
                  if (_topVN.value < widget.padding.top && e.delta.dy < 0) {
                    return;
                  }
                  // 左边
                  if (_leftVN.value < widget.padding.left && e.delta.dx < 0) {
                    return;
                  }
                  // 右边
                  if (_topVN.value >
                          (maxHeight -
                              widget.childSize.height -
                              widget.padding.bottom) &&
                      e.delta.dy > 0) {
                    return;
                  }
                  // 下边
                  if (_leftVN.value >
                          (maxWidth -
                              widget.childSize.width -
                              widget.padding.right) &&
                      e.delta.dx > 0) {
                    return;
                  }
                  _topVN.value += e.delta.dy;
                  _leftVN.value += e.delta.dx;
                  // AppLogger.debug("xy:${_leftVN.value},${_topVN.value}");
                },
                child: child,
              ));
        });
  }
}
