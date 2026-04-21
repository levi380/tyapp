
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_view_common_decoration.dart';

/// VR赛马视图输入组件
/// 包含投注金额输入框和预约按钮
class VrHorseInput extends StatelessWidget {
  const VrHorseInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        VrHorseViewCommonDecoration(
          borderRadius: 12.w,
          height: 44.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: '限额 0.00-100,000',
                  hintStyle: TextStyle(
                    fontSize: 14.sp.scale,
                    color: '#C9CDDB'.hexColor,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ).expanded(),
              Text(
                'RMB',
                style: TextStyle(
                  fontSize: 14.sp.scale,
                  color: '#C9CDDB'.hexColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ).expanded(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          height: 44.w,
          decoration: BoxDecoration(
            color: '#179CFF'.hexColor,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Row(
            children: [
              ImageView(
                'assets/images/shopcart/add.png',
                width: 20.w,
                height: 20.w,
              ),
              Text(
                '预约',
                style: TextStyle(
                  fontSize: 16.sp.scale,
                  color: AppColor.colorWhite,
                ),
              ).marginOnly(left: 4.w),
            ],
          ),
        ).marginOnly(left: 8.w),
      ],
    );
  }
}

