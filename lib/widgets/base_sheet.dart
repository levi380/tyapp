import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filbet/generated/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final double? height;

  const BaseBottomSheet({
    Key? key,
    required this.title,
    required this.child,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Center(
                    child: Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                const SizedBox(height: 12),
                Expanded(child: child),
              ],
            ),
            Positioned(
                right: 15,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    Assets.homeDialogCircularCloseIcon,
                    fit: BoxFit.fill,
                    width: 30.r,
                    height: 30.r,
                  ),
                ))
          ],
        ));
  }
}
