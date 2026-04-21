import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_cup_point_state.dart';
import 'package:flutter_ty_app/main.dart';

import 'package:get/get.dart';

typedef WidgetAnalyzeSelectCenterBack = Function(Point center);
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 杯赛积分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
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
    if (vector3 != null && rect != null && widget.centerBack != null) {
    widget.centerBack!(Point(
    vector3.x + rect.size.width / 2, vector3.y + rect.size.height / 2));
    }
    }
    ```
    】】】
 *
 */
class EliminateCombinedSelectWidget extends StatefulWidget {
  const EliminateCombinedSelectWidget(
    this.e, {
    this.isSelect = false,
    super.key,
    required this.onTap,
    this.centerBack,
  });

  /// 标签选中状态
  final String e;
  final bool isSelect;
  final WidgetAnalyzeSelectCenterBack? centerBack;
  final VoidCallback onTap;

  @override
  State<EliminateCombinedSelectWidget> createState() =>
      _AnalyzeSelectItemWidgetState();
}

class _AnalyzeSelectItemWidgetState
    extends State<EliminateCombinedSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
        _scrollExcursion();
      },
      child: Container(
        alignment: Alignment.center,
        height: 25.w,
        width: 66.w,
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        decoration: widget.isSelect
            ? BoxDecoration(
                border: Border.all(color: MatchCupPointState.selectedItemColor),
                color: MatchCupPointState.selectedItemColor,
                borderRadius: BorderRadius.all(Radius.circular(15.w)),
              )
            : BoxDecoration(),
        child: Text(
          widget.e,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: isIPad
                ? MatchCupPointState.eliminateSelectItemFontSizeIPad.sp
                : MatchCupPointState.eliminateSelectItemFontSize.sp,
            fontWeight: FontWeight.w400,
            color: widget.isSelect?Colors.white:Get.theme.orderDateTextColor,
          ),
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
