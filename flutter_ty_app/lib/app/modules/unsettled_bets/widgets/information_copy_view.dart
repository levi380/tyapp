import 'package:flutter/services.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../../main.dart';
import '../utils/betsUtils.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单复制主单号功能Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示信息和结果，并提供复制功能，用户可以方便地复制结果文本。
    - `InformationCopyView`：接收两个参数：
    - `information`：字符串类型，表示需要展示的信息。
    - `outcome`：字符串类型，表示需要复制的结果。
    - 根据当前主题模式（暗黑模式或亮色模式）设置文本颜色。
    - 返回一个包含信息和复制功能的 `Container`：
    - **信息文本**：展示 `information`，支持单行显示和省略号处理。
    - **复制区域**：包含 `outcome` 文本和复制图标，点击后将 `outcome` 复制到剪贴板并显示成功提示。
    - 使用 `Clipboard.setData` 将 `outcome` 复制到剪贴板。
    - 调用 `ToastUtils.showGrayBackground` 显示复制成功的提示信息。
    】】】
 *
 */
class InformationCopyView extends StatelessWidget {
  const InformationCopyView({
    Key? key,
    required this.information,
    required this.outcome,
  }) : super(key: key);
  final String information, outcome;

  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xFF303442);

    if (context.isDarkMode) {
      color = Colors.white.withValues(alpha:0.8999999761581421);
    }

    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              information,
              style: TextStyle(
                color: color,
                fontSize: isIPad ? 14.sp : 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          InkWell(
            onTap: () => {
              ///弹框
              BetsUtils.toastDialog("${LocaleKeys.bet_record_copy_suc.tr}！"),
              //复制逻辑
              Clipboard.setData(
                ClipboardData(
                  text: outcome,
                ),
              ),
            },
            child: Row(
              children: [
                Text(
                  outcome,
                  style: TextStyle(
                    color: color,
                    fontSize: isIPad ? 14.sp : 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ).paddingOnly(
                  right: 4.w,
                ),
                ImageView(
                  context.isDarkMode
                      ? 'assets/images/bets/icon_copy_night.png'
                      : 'assets/images/bets/icon_copy_daytime.png',
                  width: isIPad ? 15.w : 11.w,
                  height: isIPad ? 15.h : 11.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
