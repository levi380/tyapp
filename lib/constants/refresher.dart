import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Center(
        child: SizedBox(
          height: 22.w,
          width: 22.w,
          child: CircularProgressIndicator(
            strokeWidth: 2.w,
            // valueColor: AlwaysStoppedAnimation<Color>(PageStyle.bg),
          ),
        ),
      ),
    );
  }
}
