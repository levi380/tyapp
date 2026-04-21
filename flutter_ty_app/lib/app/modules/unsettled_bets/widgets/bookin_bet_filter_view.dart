import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-未结算冠军选择Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 构建组件的 UI，包括一个行，展示多个过滤选项。
    - `singleType`: 当前选项的类型（整数）。
    - `title`: 显示的标题。
    - **功能**: 返回一个可点击的选项，调用 `onChanged` 回调。
    - `singleType`: 当前选项的类型（整数）。
    - `title`: 显示的标题。
    - **功能**: 根据选项类型和状态返回不同的 UI：
    - 如果是自定义时间且未打开自定义选择，则显示开始和结束时间。
    - 否则，仅显示标题。
    - 通过 `Get.isDarkMode` 判断当前主题，动态设置颜色。
    - 文本样式包括字体、大小和粗细等属性，适配中文和英文显示。
    - 使用 `Flexible` 适配不同语言的布局。
    - 选项的点击事件通过 `InkWell` 处理，提供反馈效果。
    】】】
 *
 */
class BookinBetFilterView extends StatelessWidget {
  BookinBetFilterView({
    required this.type,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final int type;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.w,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.w,
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.1)
                : const Color(0xFFE4E6ED),
          ),
        ),
      ),
      child: Row(
        children: [
          _single(
            0,
            LocaleKeys.app_all_events.tr,
          ),
          _div(),
          _single(
            1,
            LocaleKeys.app_championships.tr,
          )
        ],
      ),
    );
  }

  Widget _single(int singleType, String title) {
    return Flexible(
      ///适配英文
      flex: 1,
      child: InkWell(
        onTap: () => {
          onChanged(singleType),
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _showStatus(singleType, title),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showStatus(int singleType, String title) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: Get.isDarkMode
              ? singleType == type
                  ? const Color(0xFF127DCC)
                  : Colors.white.withValues(alpha: 0.5)
              : Color(
                  singleType == type ? 0xff179CFF : 0xFF949AB6,
                ),
          fontSize: 14.sp,
          fontFamily: 'PingFang SC',
          fontWeight: singleType == type ? FontWeight.w600 : FontWeight.w400,
          height: 1.34.h,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _div() {
    return Container(
      width: 1.w,
      height: 27.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Colors.white.withValues(
                alpha: 0.08,
              )
            : const Color(
                0xFFE4E6ED,
              ),
      ),
    );
  }
}
