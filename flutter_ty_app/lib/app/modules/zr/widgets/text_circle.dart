import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

///显示庄闲和数量布局，真人-荷官，路纸使用到
class TextCircle extends StatelessWidget {
  final Color color;
  final String tag;
  final int? count;

  TextCircle(
      {super.key, required this.color, required this.tag, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14.w,
          height: 14.w,
          margin: EdgeInsets.only(right: 2.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(100)),
          child: Text(
            tag,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
              height: 1,
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.9)
                  : Colors.white,
            ),
          ),
        ),
        Text(
          "${count ?? 0}",
          style: TextStyle(
              fontSize: 10.sp,
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.9)
                  : Colors.black),
        ),
      ],
    );
  }
}
