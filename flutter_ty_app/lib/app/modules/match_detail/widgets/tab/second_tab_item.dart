import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import 'package:get/get.dart';

import '../../../../../main.dart';
import '../../../../widgets/image_view.dart';

typedef WidgetCenterBack = Function(Point center);

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-3f1a6545-7dd8-4618-882a-3e4551577455 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 玩法集tab】】】
    【【【 AUTO_PARAGRAPH_TITLE 子tab标题单个item】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 传入状态
    |  名称  |  字段   | 类型  |
    |  :----: |  :----:  | :----:  |
    | 选中状态 | active  | bool |
    | 展示文本 | text  | String |
    | 全屏状态 | fullscreen  | bool |
    | 居中回调 | centerBack  | WidgetCenterBack |
    | 点击事件 | onTap  | VoidCallback |
    - typedef WidgetCenterBack = Function(Point center);
    - 点击居中回调逻辑
    ```
    void _scrollExcursion() {
    RenderObject? renderObject = context.findRenderObject();
    //获取元素尺寸
    Rect? rect = renderObject?.paintBounds;
    //获取元素位置
    var vector3 = renderObject?.getTransformTo(null).getTranslation();
    if (vector3 != null && rect != null && widgets.centerBack != null) {
    widgets.centerBack!(Point(
    vector3.x + rect.size.width / 2, vector3.y + rect.size.height / 2));
    }
    }
    ```
    】】】
 *
 */
class SecondTabItem extends StatefulWidget {
  const SecondTabItem(
    this.text, {
    super.key,
    this.active = false,
    required this.onTap,
    this.fullscreen = false,
    this.centerBack,
    this.hasChampionIcon = false,
  });

  /// 标签选中状态
  final bool active;
  final String text;
  final bool fullscreen;
  final WidgetCenterBack? centerBack;

  final VoidCallback onTap;
  final bool hasChampionIcon;

  @override
  State<SecondTabItem> createState() => _SecondTabItemViewState();
}

class _SecondTabItemViewState extends State<SecondTabItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
        _scrollExcursion();
      },
      child: Container(
        // height: widgets.fullscreen ? 30 : (isIPad ? 40.h : 30.h),
        padding: EdgeInsets.symmetric(
            horizontal: widget.fullscreen ? 12 : (isIPad ? 24.w : 12.w)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.active
              ? widget.fullscreen
                  ? const Color.fromRGBO(18, 125, 204, 1)
                  : Get.theme.secondTabPanelSelectedColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(
              widget.fullscreen ? 20 : (isIPad ? 40.r : 20.r)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.hasChampionIcon)
              ImageView(
                Get.locale?.languageCode == "zh"
                    ? 'assets/images/detail/outright_prefix.svg'
                    : 'assets/images/detail/outright_prefix_en.svg',
                width: widget.fullscreen ? 20 : 20.w,
              ).marginOnly(right: widget.fullscreen ? 4 : 4.w),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              strutStyle: Platform.isAndroid
                  ? const StrutStyle(
                      height: 1.1,
                      forceStrutHeight: true,
                    )
                  : null,
              textHeightBehavior: const TextHeightBehavior(
                  // 基线 发现不设置也能行
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false),
              style: TextStyle(
                color: widget.active
                    ? widget.fullscreen
                        ? Colors.white
                        : Get.theme.secondTabPanelSelectedFontColor
                    : widget.fullscreen
                        ? const Color.fromRGBO(97, 103, 131, 0.6)
                        : Get.theme.secondTabPanelUnSelectedFontColor,
                // fontSize: widget.fullscreen ? 12 : (isIPad ? 18.sp : 13.sp),
                fontSize: (widget.fullscreen ? 12 : (isIPad ? 18.sp : 13.sp)),
                fontFamily: 'PingFang SC',
                fontWeight: widget.active ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollExcursion() {
    RenderObject? renderObject = context.findRenderObject();
    //获取元素尺寸
    Rect? rect = renderObject?.paintBounds;
    //获取元素位置
    var vector3 = renderObject?.getTransformTo(null).getTranslation();
    if (vector3 != null && rect != null && widget.centerBack != null) {
      widget.centerBack!(Point(
          vector3.x + rect.size.width / 2, vector3.y + rect.size.height / 2));
    }
  }
}
