
import 'package:flutter_ty_app/app/modules/home/states/home_state.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';


/// 首页返回顶部按钮
class HomeBackTopButton extends StatelessWidget {
  final VoidCallback onTap;
  final double? bottom;

  const HomeBackTopButton({
    super.key,
    required this.onTap,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: HomeState.outrightRightPadding.w,
      bottom: bottom,
      child: ImageView(
        context.isDarkMode
            ? HomeState.backTopImageDark
            : HomeState.backTopImageLight,
        width: context.isDarkMode
            ? HomeState.ipadImageWidth.w
            : HomeState.mobileImageWidth.w,
        height: context.isDarkMode
            ? HomeState.ipadImageHeight.w
            : HomeState.mobileImageHeight.w,
        onTap: onTap,
      ),
    );
  }
}
