import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../modules/home/states/home_state.dart';
import '../modules/home/views/common_match_list_view.dart';

typedef ViewPortCallBack = void Function(int firstIndex, int lastIndex);
typedef ScrollEndCallBack = void Function(bool endScroll);
typedef StickyCallBack = void Function(int firstIndex, int lastIndex);

bool isScrolling = false;
int endCallFirsttIndex = 0;
int endCallLastIndex = 0;

class ScrollIndexWidget extends StatelessWidget {
  final Widget child;
  final bool isStopCallback;
  final ViewPortCallBack callBack;
  final ScrollEndCallBack? endCallBack;
  final StickyCallBack? stickyCallBack;
  final Axis scrollDirection;

  const ScrollIndexWidget({
    super.key,
    required this.child,
    required this.callBack,
    this.stickyCallBack,
    this.isStopCallback = true,
    this.endCallBack,
    required this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onNotification,
      child: child,
    );
  }

  bool _onNotification(ScrollNotification notification) {
    // AppLogger.debug("notification.metrics.axisDirection = " +
    //     notification.metrics.axis.toString());
    if (notification.metrics.axis != scrollDirection) return false;
/*
    final SliverMultiBoxAdaptorElement? element =
        findSliverMultiBoxAdaptorElement(notification.context! as Element);
    if (element == null) return false;

    final viewPortDimension = notification.metrics.viewportDimension;
    int firstIndex = 0;
    int lastIndex = 0;

    void onVisitChildren(Element element) {
      final SliverMultiBoxAdaptorParentData oldParentData =
          element.renderObject?.parentData as SliverMultiBoxAdaptorParentData;

      double layoutOffset = oldParentData.layoutOffset!;
      double pixels = notification.metrics.pixels + 30.h;
      double all = pixels + viewPortDimension;

      if (layoutOffset >= pixels) {
        firstIndex = min(firstIndex, oldParentData.index!);
        if (layoutOffset <= all) {
          lastIndex = max(lastIndex, oldParentData.index!);
        }
        firstIndex = max(firstIndex, 0);
      } else {
        lastIndex = firstIndex = oldParentData.index!;
      }
    }

    element.visitChildren(onVisitChildren);
 */
/*
    final Element? element = notification.context as Element?;
    if (element == null) return false;

    final sliverElement = findSliverMultiBoxAdaptorElement(element);
    if (sliverElement == null) return false;

    final renderObject = sliverElement.renderObject;
    if (renderObject is! RenderSliverMultiBoxAdaptor) return false;

    final firstChild = renderObject.firstChild;
    final lastChild = renderObject.lastChild;

    if (firstChild == null || lastChild == null) return false;

    final firstParentData =
    firstChild.parentData as SliverMultiBoxAdaptorParentData;

    final lastParentData =
    lastChild.parentData as SliverMultiBoxAdaptorParentData;

    final firstIndex = firstParentData.index!;
    final lastIndex = lastParentData.index!;
*/
    final viewportTop = notification.metrics.pixels + 30.h;
    final viewportBottom = viewportTop + notification.metrics.viewportDimension;

    int firstIndex = 1 << 30;
    int lastIndex = -1;

    final Element? element = notification.context as Element?;
    if (element == null) return false;

    final sliverElement = findSliverMultiBoxAdaptorElement(element);
    if (sliverElement == null) return false;

    final renderObject = sliverElement.renderObject;
    if (renderObject is! RenderSliverMultiBoxAdaptor) return false;

    RenderBox? child = renderObject.firstChild;

    while (child != null) {
      final parentData =
      child.parentData as SliverMultiBoxAdaptorParentData;

      final top = parentData.layoutOffset!;
      final bottom = top + child.size.height;

      if (bottom >= viewportTop && top <= viewportBottom) {
        final index = parentData.index!;

        firstIndex = min(firstIndex, index);
        lastIndex = max(lastIndex, index);
      }

      child = renderObject.childAfter(child);
    }
    if(lastIndex == -1){
      firstIndex = lastIndex = 0;
    }
    //print("visible range: $firstIndex -> $lastIndex");

    stickyCallBack?.call(firstIndex, lastIndex);

    /// 停止滚动才回调
    if (isStopCallback) {
      if (notification is ScrollEndNotification) {
        Future.delayed(Duration(milliseconds: 200), () {
          if (!isScrolling) {
            callBack(firstIndex, lastIndex);
          }
        });
      }
    } else {
      //callBack(firstIndex, lastIndex);
      if (notification is ScrollEndNotification &&  (kLastIndex - lastIndex) < HomeState.pageCount/2 ) {
        //考虑收起的情况，一页超过20条
        int range = max(HomeState.pageCount,lastIndex - firstIndex);
        callBack(kLastIndex, kLastIndex+range);
        //print("first $firstIndex last $lastIndex kLastIndex $kLastIndex");
      }
    }
    switch (notification.runtimeType) {
      case ScrollStartNotification:
        // AppLogger.debug('开始滚动');
        isScrolling = true;
        endCallBack?.call(false);
        break;
      case ScrollUpdateNotification:
        // AppLogger.debug('正在滚动');
        isScrolling = true;
        endCallBack?.call(false);
        break;
      case ScrollEndNotification:
        isScrolling = false;
        // AppLogger.debug('停止滚动');
        // 因为windows鼠标滚动和触摸滚动不同，做了一些判断限制
        if(firstIndex!=endCallFirsttIndex || lastIndex!=endCallLastIndex) {
          //print("firstIndex $firstIndex last $lastIndex endCallFirsttIndex $endCallFirsttIndex endCallLastIndex $endCallLastIndex");
          endCallFirsttIndex = firstIndex;
          endCallLastIndex = lastIndex;
          Future.delayed(const Duration(milliseconds: 500), () {
            if(endCallFirsttIndex == firstIndex && endCallLastIndex==lastIndex){
              if (!isScrolling) {
                endCallBack?.call(true);
              }
            }
          });
        }
        break;
      case OverscrollNotification:
        isScrolling = true;
        // AppLogger.debug('滚动到边界');
        endCallBack?.call(false);
        break;
      default:
        break;
    }
    return false;
  }

  SliverMultiBoxAdaptorElement? findSliverMultiBoxAdaptorElement(
      Element? element) {
    if (element is SliverMultiBoxAdaptorElement) {
      return element;
    }
    if (element == null) {
      return null;
    }
    SliverMultiBoxAdaptorElement? target;
    element.visitChildElements((element) {
      target ??= findSliverMultiBoxAdaptorElement(element);
    });
    return target;
  }
}
