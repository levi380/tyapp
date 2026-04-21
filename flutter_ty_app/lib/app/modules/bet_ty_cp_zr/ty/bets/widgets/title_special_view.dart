import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(未结算)标题显示视图Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示特定的信息标题，支持暗黑模式和常规模式的颜色适配。
    - `TitleSpecialView`：接收一个参数 `information`，用于初始化组件的显示文本。
    - `build` 方法返回一个包含文本的容器，文本的样式根据当前主题（暗黑模式或亮色模式）动态调整。
    - 根据 `context.isDarkMode` 判断当前主题，设置文本颜色。暗黑模式下使用半透明的白色，亮色模式下使用深灰色。
    - 使用 `Container` 组件来设置文本的对齐方式和内边距，以确保文本在视觉上的舒适性。
    - 文本使用 `Text` 组件展示，支持最大行数限制和溢出处理。
    - 设置了字体、大小和粗细，确保文本在不同设备上的可读性。
    】】】
 *
 */
class TitleSpecialView extends StatelessWidget {
  const TitleSpecialView({
    Key? key,
    required this.information,
  }) : super(key: key);
  final String information;

  @override
  Widget build(BuildContext context) {
    Color color = context.isDarkMode
        ? Colors.white.withValues(alpha: 0.8999999761581421)
        : const Color(0xFF303442);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 30.w),
      child: Text(
        information,
        style: TextStyle(
          color: color,
          fontSize: 14.sp,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
