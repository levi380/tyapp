
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../utils/oss_util.dart';
import '../../../utils/skin_status.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5a7d82aa-a062-4061-ad30-cc1cd2482bdc-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 主题风格皮肤选择组件 MenuReplaceSkinWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主题风格皮肤选择组件 MenuReplaceSkinWidget
    ```
    MenuReplaceSkinWidget(
      modeStatus: ChangeSkinToneColorUtil.instance().getModeStatus(),
      switchAOnTap: () {
      controller.setModeStatus(Status.BLACK_STYLE_1);
      },
      switchBOnTap: () {
      controller.setModeStatus(Status.BLACK_STYLE_2);
      },
      switchCOnTap: () {
      controller.setModeStatus(Status.BLACK_STYLE_3);
      },
    )
    ```

    】】】
 *
 */
class MenuReplaceSkinWidget extends StatelessWidget {
  const MenuReplaceSkinWidget({
    super.key,
    required this.switchAOnTap,
    required this.switchBOnTap,
    required this.switchCOnTap,
    required this.modeStatus,
  });

  final VoidCallback? switchAOnTap, switchBOnTap, switchCOnTap;
  final Status modeStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      color: Colors.white.withValues(alpha:0.03999999910593033),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha:0.07999999821186066),
              width: 0.50.h,
            ),
          ),
        ),
        margin: EdgeInsets.only(
          left: 14.w,
          right: 14.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 1.w,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              decoration: ShapeDecoration(
                color: const Color(0x33030303),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _handoff(Status.BLACK_STYLE_1).marginOnly(right: 4.h),
                  _handoff(Status.BLACK_STYLE_2).marginOnly(right: 4.h),
                  _handoff(Status.BLACK_STYLE_3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _handoff(Status mode) {
    return InkWell(
      onTap: mode == Status.BLACK_STYLE_1
          ? switchAOnTap
          : mode == Status.BLACK_STYLE_2
              ? switchBOnTap
              : switchCOnTap,
      child: Container(
        width: 50.w,
        height: 27.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              OssUtil.getServerPath(
                mode == Status.BLACK_STYLE_1
                      ?  'assets/images/home/black_style_1.png'
                      : mode == Status.BLACK_STYLE_2
                          ? 'assets/images/home/black_style_2.png'
                          : 'assets/images/home/black_style_3.png',
              ),
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: mode == modeStatus
            ? ImageView(
              'assets/images/home/state.png',
                width: 16.w,
                height: 16.h,
              )
            : Container(),
      ),
    );
  }
}
