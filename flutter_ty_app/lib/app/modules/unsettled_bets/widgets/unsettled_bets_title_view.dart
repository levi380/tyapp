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
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(未结算)注单单关头部视图Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示未结算投注的不同状态，允许用户通过点击切换不同的投注类型。
    - `UnsettledBetsTitleView`：接收两个参数 `selectType` 和 `onChanged`，用于初始化当前选中的投注类型和回调函数。
    - `build` 方法返回一个 `Container`，包含一个 `Row` 组件，展示三个不同的投注状态。
    - 根据当前语言环境 (`Get.locale?.languageCode`) 判断是否为中文，以调整布局间距和字体大小。
    - 使用 `Row` 组件将三个状态并排展示，每个状态使用 `Expanded` 组件以平分可用空间。
    - 每个状态的下方有一个指示器，表示当前选中的状态。
    - 点击每个状态会调用 `onChanged` 回调，传递当前状态类型。
    - 根据当前主题（暗黑模式或亮色模式）和选中状态，动态调整文本颜色和样式。
    - 支持最大行数限制和溢出处理，确保文本在不同设备上的可读性。
    - 选中状态下的指示器使用不同的颜色，以便用户清晰地看到当前选择。
    】】】
 *
 */
class UnsettledBetsTitleView extends StatelessWidget {
  UnsettledBetsTitleView({
    Key? key,
    required this.selectType,
    required this.onChanged,
  }) : super(key: key);
  final int selectType;
  final ValueChanged<int> onChanged;

  bool get isCh => ['zh'].contains(Get.locale?.languageCode);

  bool get _isIndia => ['hi'].contains(Get.locale?.languageCode);
  @override
  Widget build(BuildContext context) {

    return Container(
      // 自适应高度
      height: 35.h,
      decoration: BoxDecoration(
        color: Color(context.isDarkMode ? 0x0AFFFFFF : 0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _state(0, context),
          SizedBox(
            width: isCh ? 8.w : 5.w,
          ),
          _state(1, context),
          SizedBox(
            width: isCh ? 8.w : 5.w,
          ),
          _state(2, context),
        ],
      ),
    );
  }

  /**
   * 适配中英文
   */
  int fitWidth(int singleType) {
    if (_isIndia && singleType == 0) {
      return 1;
    }
    return 2;
  }

  //头部切换Widget
  Widget _state(int type, BuildContext context) {
    return Expanded(
      flex: fitWidth(type),
      child: InkWell(
        onTap: () => {
          onChanged(type),
        },
        child: Column(
          children: [
            SizedBox(
              height: 3.w,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  type == 0
                      ? LocaleKeys.bet_record_no_account.tr
                      : type == 1
                          ? LocaleKeys.pre_record_booking.tr
                          : LocaleKeys.pre_record_expired.tr,
                  style: TextStyle(
                    fontSize: isCh ? 14.sp : 12.sp,
                    height: 1.h,
                    fontWeight: FontWeight.w500,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha:selectType == type ? 0.9 : 0.5)
                        : Color(selectType == type ? 0xFF303442 : 0xFF7981A4),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              width: 28.w,
              height: 3.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(1.5.r),
                    topRight: Radius.circular(1.5.r),
                  ),
                  color: type == selectType
                      ? Color(context.isDarkMode ? 0xFF127DCC : 0xFF179cff)
                      : Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }
}
