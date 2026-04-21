

import '../../../../generated/locales.g.dart';

import '../../login/login_head_import.dart';
import '../results_details/results_settled_bets/results_settled_bets_logic.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-998323de-6c52-4771-a2e1-96f8fe57bb0f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果体育注单(已结算)提前兑折叠Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示可展开的内容，允许用户查看更详细的现金详情信息。
    - `ExtendView`：接收两个参数：
    - `index`：整数类型，表示当前视图的索引。
    - `preSettleExpand`：布尔值，指示内容是否展开。
    - 返回一个可点击的 `InkWell` 组件：
    - **文本**：展示“现金详情”。
    - **图标**：根据 `preSettleExpand` 的值显示不同的箭头图标（向上或向下）。
    - **点击事件**：当用户点击该视图时，调用 `SettledBetsLogic` 中的 `onPreSettleExpand` 方法，传入当前索引，以切换展开状态。
    】】】
 *
 */


class ResultsExtendView extends StatelessWidget {
  const ResultsExtendView({
    Key? key,
    required this.index,
    required this.preSettleExpand,
  }) : super(key: key);
  final int index;
  final bool preSettleExpand;

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ResultsSettledBetsLogic>();
    Color color = context.isDarkMode
        ? Colors.white.withValues(alpha: 0.8999999761581421)
        : const Color(0xFF303442);
    return InkWell(
      onTap: () => {
        logic.onPreSettleExpand(index),
      },
      child: Container(
        margin: EdgeInsets.only(top: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.app_h5_cathectic_cash_details.tr,
              style: TextStyle(
                color: color,
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ).marginOnly(right: 2.w),
            ImageView(
              preSettleExpand
                  ? 'assets/images/bets/icon_up.gif'
                  : 'assets/images/bets/icon_down.gif',
              width: 18.w,
              height: 18.h,
            ),
          ],
        ),
      ),
    );
  }
}
