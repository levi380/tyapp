import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


typedef ViewPortCallBack = void Function(int firstIndex, int lastIndex);
typedef ScrollEndCallBack = void Function(bool endScroll);
typedef StickyCallBack = void Function(int firstIndex, int lastIndex);

bool isScrolling = false;


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果详情 球类滑动监听可见位置悬浮组件 组件  ResultsIndexWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果详情 球类滑动监听可见位置悬浮组件 组件  ResultsIndexWidget
    - ResultsIndexWidget
    ```
    ResultsIndexWidget(
      callBack: (int firstIndex, int lastIndex) => controller.onCallBack(firstIndex, lastIndex),
        child: ListView.builder(
        itemCount: controller.typeFilterList.length,
        scrollDirection: Axis.horizontal,
        controller:controller.typeScrollController,
        itemBuilder: (context, index) {
        return TypeFilterWidget(
        key: controller.typeFilterList[index].sportId.toString().contains(controller.sportid) ?
        controller.normalResultsKey: ValueKey(controller.typeFilterList[index].sportId),
        onTap: () => controller.onTypeFilterIndex(index,controller.typeFilterList[index].sportId),
        miid: controller.typeFilterList[index].miid,
        title: controller.typeFilterList[index].name,
        isSelected:
        controller.typeFilterIndex == index ? true : false,
        isDark: context.isDarkMode,
        index: index,
        titleIndex: widget.titleIndex,
      );
      },
      ),
    )
    ```
    】】】
 *
 */

class ResultsIndexWidget extends StatelessWidget {
  final Widget child;
  final bool isStopCallback;
  final ViewPortCallBack callBack;
  final ScrollEndCallBack? endCallBack;
  final StickyCallBack? stickyCallBack;

  const ResultsIndexWidget({
    super.key,
    required this.child,
    required this.callBack,
    this.stickyCallBack,
    this.isStopCallback = true,
    this.endCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,
      child: child,
    );
  }

  bool _onNotification(ScrollNotification notification) {
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
      double pixels = notification.metrics.pixels;
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
    stickyCallBack?.call(firstIndex, lastIndex);

    callBack(firstIndex, lastIndex);
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
        if (!isScrolling) {
          endCallBack?.call(true);
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
