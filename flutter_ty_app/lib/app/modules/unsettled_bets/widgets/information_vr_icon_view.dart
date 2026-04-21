
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单VR图标Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    】】】
 *
 */
class InformationVrIconView extends StatelessWidget {
  const InformationVrIconView({
    Key? key,
    required this.vrIcons,
  }) : super(key: key);

  final List<String> vrIcons;

  @override
  Widget build(BuildContext context) {
    ///vr图标Widget
    List<Widget> listChildrenView = [];
    for (int i = 0; i < vrIcons.length; i++) {
      if (vrIcons[i].isNotEmpty) {
        listChildrenView.add(
          ImageView(
            vrIcons[i],
            width: 18.w,
            height: 18.h,
          ).marginOnly(top: 3.h),
        );
      }
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: listChildrenView,
    );
  }
}
