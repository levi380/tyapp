import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OverLayWidget extends StatefulWidget {
  OverLayWidget(this.offsetTop, this.offsetLeft, this.content, this.bgIcon,
      {super.key, this.width, this.height});

  double offsetTop;
  double offsetLeft;
  String content;
  String bgIcon;
  double? width;
  double? height;

  @override
  State<OverLayWidget> createState() => _DeleteOverLayWidgetState();
}

class _DeleteOverLayWidgetState extends State<OverLayWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Stack(
        children: [
          Positioned(
            top: widget.offsetTop,
            left: widget.offsetLeft,
            child: Container(
              width: widget.width ?? 180.r,
              height: widget.height ?? 78.r,
              padding: EdgeInsets.only(
                top: 15.r,
                left: 8.r,
                right: 3.r,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.bgIcon),
                  fit: BoxFit.fill,
                ),
              ),
              child: Text(
                widget.content,
                style: TextStyle(
                  color: appnewColors.text4,
                  fontSize: 12.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
