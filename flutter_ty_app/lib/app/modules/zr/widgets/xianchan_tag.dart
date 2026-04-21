import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

///显示庄闲和数量布局，真人-现场使用到
class XianChangTag extends StatelessWidget {
  final String img;
  final int? text;

  XianChangTag({super.key, required this.img, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 23.w,
          height: 14.w,
          margin: EdgeInsets.only(right: 2.w),
          child: ImageView(img),
        ),
        Text(
          "${text ?? 0}",
          style: TextStyle(
            fontSize: 12.sp,
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.9)
                : Colors.black,
          ),
        ),
      ],
    );
  }
}
