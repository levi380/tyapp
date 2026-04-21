import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/locales.g.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单加载更多提示语句Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示加载状态的提示信息，适用于列表或滚动视图的底部。
    - `FooterView`：无参数构造函数。
    - 根据当前主题模式（暗黑模式或亮色模式）设置文本颜色。
    - 返回一个 `CustomFooter` 组件，使用 `builder` 函数根据 `LoadStatus` 的不同状态构建不同的内容。
    - `LoadStatus.idle`：显示“下拉加载”提示。
    - `LoadStatus.loading`：显示一个 `CupertinoActivityIndicator` 作为加载指示器。
    - `LoadStatus.failed`：显示加载失败的提示。
    - `LoadStatus.canLoading`：显示“释放加载更多”提示。
    - `LoadStatus.noMore`：显示“没有更多数据”提示。
    - 默认情况下返回一个空的文本组件。
    】】】
 *
 */
class FooterView extends StatelessWidget {
  const FooterView({super.key});
  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xFF949AB6);

    if (context.isDarkMode) {
      color = Colors.white.withValues(alpha:0.7999999761581421);
    }
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text(
            LocaleKeys.app_pull_up_loading.tr,
            style: TextStyle(
              fontSize: 13.sp,
              color: color,
            ),
          );
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator(
            color: color,
          );
        } else if (mode == LoadStatus.failed) {
          body = Text(
            LocaleKeys.app_failed_to_load.tr,
            style: TextStyle(
              fontSize: 13.sp,
              color: color,
            ),
          );
        } else if (mode == LoadStatus.canLoading) {
          body = Text(
            LocaleKeys.app_release_to_load_more.tr,
            style: TextStyle(
              fontSize: 13.sp,
              color: color,
            ),
          );
        } else if (mode == LoadStatus.noMore) {
          body = Text(
            LocaleKeys.app_no_more_data.tr,
            style: TextStyle(
              fontSize: 13.sp,
              color: color,
            ),
          );
        } else {
          // body = Text("没有更多数据");
          body = const Text("");
        }
        return Center(
          child: body,
        );
      },
    );
  }
}
