import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleInfoView extends StatelessWidget {
  String title;
  Color? color = Color(0xff333333);

  TitleInfoView({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.w, right: 0.w, bottom: 10.w),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
            color: color ?? Color(0xff333333), fontWeight: FontWeight.bold),
      ),
    );
  }
}
