import 'package:common_utils/common_utils.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../utils/text_Utitl.dart';
import '../../../../widgets/date_picker/show_time_bottom.dart';
import '../../../login/login_head_import.dart';
import '../settled_zr_bets_logic.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-bd58c8a0-e850-406d-82ea-e9d19c8f5403-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人注单标题组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - `isDarkMode`: 是否为暗黑模式。
    - `type`: 状态类型，用于决定组件的显示样式。
    - `context`: 上下文，用于获取主题和其他信息。
    - `logic`: `SettledZrBetsLogic` 实例，负责业务逻辑处理。

    ## 描述
    用于展示注单的不同状态，支持点击事件以切换状态。

    ## 方法

    ### 1. `stateWidget`
    - 创建一个可点击的状态组件，根据类型和主题展示不同的样式。

    ### 2. `subItemTitle`
    - 用于展示注单的名称和号码，支持不同的样式和对齐方式。

    ## 其他说明
    - 在点击状态组件时，根据不同的类型处理逻辑。
    - 根据当前主题（暗黑/亮色模式）自动调整文本和背景颜色。

    】】】
 *
 */

Widget stateWidget(
    bool isDarkMode, int type, BuildContext context, SettledZrBetsLogic logic) {
  return Expanded(
    flex: 1,
    child: InkWell(
      onTap: () {
        showTimeBottom.resetinitTime();
        if (type == 5) {
          ///如果是自定义时间特殊处理
          logic.showTime(context, type);
        } else {
          logic.setType(type);
        }
      },
      child: Container(
        color: logic.BetsType == type
            ? context.isDarkMode
                ? null
                : const Color(0xFFE4E6ED)
            : null,
        child: Container(
          decoration: logic.BetsType == type
              ? BoxDecoration(
                  color: context.isDarkMode ? null : const Color(0xFFF2F2F6),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                )
              : ShapeDecoration(
                  color: context.isDarkMode
                      ? const Color(0xFF1E2029)
                      : const Color(0xFFE4E6ED),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(logic.leftRadius(type)),
                      bottomRight: Radius.circular(logic.rightRadius(type)),
                    ),
                  )),
          alignment: Alignment.center,
          child:

              ///赛选类型标题
              TextUtitls.normalText(
            type == 1
                ? LocaleKeys.app_bet_date_list_0.tr
                : type == 2
                    ? LocaleKeys.app_bet_date_list_1.tr
                    : type == 3
                        ? LocaleKeys.app_bet_date_list_2.tr
                        : ObjectUtil.isNotEmpty(logic.startTime2) ||
                                ObjectUtil.isNotEmpty(logic.endTime2)
                            ? "${logic.startTime2}\ ${logic.endTime2}"
                            : LocaleKeys.app_custom.tr,
            textAlign: TextAlign.center,

            ///中文标配
            fontSize:
                type != 5
                    ? Get.locale?.languageCode == 'zh'
                        ? 13.sp
                        : 12.sp
                    : logic.startTime2.isNotEmpty
                        ? 10.sp
                        : 13.sp,
            fontWeight:
                logic.BetsType == type ? FontWeight.w600 : FontWeight.w400,
            color: logic.BetsType == type
                ? context.isDarkMode
                    ? Colors.white.withValues(alpha:0.8999999761581421)
                    : const Color(0xFF303442)
                : context.isDarkMode
                    ? Colors.white.withValues(alpha:0.4000000059604645)
                    : const Color(0xff949AB6),
          ),
        ),
      ),
    ),
  );
}

Widget subItemTitle(bool isDarkMode, String name, String number, int type) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isDarkMode
                ? Colors.white.withValues(alpha:0.5)
                : const Color(0xFF7981A3),
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            fontFamily: 'PingFang SC',
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          number,
          style: TextStyle(
            color: type == 1
                ? const Color(0xffF53F3F)
                : isDarkMode
                    ? Colors.white.withValues(alpha:0.8999999761581421)
                    : const Color(0xFF303442),
            fontSize:14.sp,
            fontFamily: 'Akrobat',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
