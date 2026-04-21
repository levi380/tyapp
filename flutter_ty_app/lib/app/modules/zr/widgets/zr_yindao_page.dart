import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

///真人和彩票引导页，点击真人下一步弹出彩票引导页，进入彩票引导页后点完成消失
class ZrYindaoPage extends StatelessWidget {
  final String type;
  ZrYindaoPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if (type == 'zr') {
          ///判断是否真人，下一步弹出彩票引导页，
          Get.dialog(
            useSafeArea: false,
            ZrYindaoPage(
              type: 'cp',
            ),
            barrierColor: Colors.black.withValues(alpha: 0.76),
          );
        }
      },

      ///由于 Get.dialog设置安全区不灵活，需求只要上安全区，不要下安全区，所以自己用SafeArea实现
      child: SafeArea(
        bottom: false,
        child: Container(
          width: Get.size.width,
          height: Get.size.height,
          child: ImageView(
            ///由于新手版和专业版布局不同，所以显示不同的引导图
            TyHomeController.to.homeState.isProfess
                ? type == 'zr'
                    ? "assets/images/zr/yindao_zr_pro.png"
                    : "assets/images/zr/yindao_cp_pro.png"
                : type == 'zr'
                    ? "assets/images/zr/yindao_zr_new.png"
                    : "assets/images/zr/yindao_cp_new.png",
            boxFit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
