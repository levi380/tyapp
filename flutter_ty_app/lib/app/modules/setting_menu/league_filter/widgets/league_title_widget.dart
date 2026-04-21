import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../config/getx_navigation.dart';
import '../../../../utils/bus/bus.dart';
import '../../../../utils/bus/event_enum.dart';
import '../../../../utils/ty_text_scaler.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选  头部组件 LeagueTitleWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选  头部组件 LeagueTitleWidget
    - LeagueTitleWidget
    ```
    ///联赛头部
    LeagueTitleWidget(
      isDark: context.isDarkMode,
      focusNode:controller.focusNode,
      titles: [LocaleKeys.filter_match_select_title.tr],
      onTap: () => controller.onFinish(),
      onChanged: (value) {

      },
    )
    ```
    】】】
 *
 */

class LeagueTitleWidget extends StatefulWidget {
  const LeagueTitleWidget({
    super.key,
    required this.isDark,
    required this.titles,
    required this.onTap,
    required this.focusNode,
    required this.onChanged,
    this.index,
    this.onSearch,
  });

  final bool isDark;
  final List<String> titles;
  final VoidCallback? onTap;
  final ValueChanged<int> onChanged;
  final int? index;
  final VoidCallback? onSearch;
  final FocusNode focusNode;

  @override
  State<LeagueTitleWidget> createState() => _LeagueTitleWidgetState();
}

class _LeagueTitleWidgetState extends State<LeagueTitleWidget> {
  int _index = 0;
  List<String> titles = [];

  @override
  void initState() {
    super.initState();
    _index = widget.index ?? 0;
    titles = widget.titles;
  }

  @override
  void didUpdateWidget(covariant LeagueTitleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.titles != widget.titles || oldWidget.index != widget.index) {
      setState(() {
        titles = widget.titles;
        _index = widget.index ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 14.w,
        right: 14.w,
      ),
      height: 62.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              widget.focusNode.unfocus();
              Get_TY.back();
              Bus.getInstance().emit(EventType.tyCloseDialog);
            },
            child: Text(
              LocaleKeys.common_cancel.tr,
              style: TextStyle(
                color: const Color(0xFF179CFF),
                fontSize: 17.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Row(
            children: titles
                .asMap()
                .entries
                .map(
                  (e) => Text(
                    e.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _index == e.key
                          ? (context.isDarkMode
                              ? Colors.white
                              : const Color(0xFF303442))
                          : (context.isDarkMode
                              ? Colors.white.withValues(alpha:0.5)
                              : Color(0xFF949AB6)),
                      fontSize: TyTextScaler.instance().scale(18.sp),
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ).marginSymmetric(horizontal: 10.w).onTap(() {
                    setState(() {
                      _index = e.key;
                      widget.onChanged.call(e.key);
                    });
                  }),
                )
                .toList(),
          ),
          Visibility(
            visible: _index == titles.length - 1,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: InkWell(
              onTap: () => widget.onSearch?.call(),
              child: Text(
                LocaleKeys.search_search_title.tr,
                style: TextStyle(
                  color: const Color(0xFF179CFF),
                  fontSize: TyTextScaler.instance().scale(17.sp),
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
