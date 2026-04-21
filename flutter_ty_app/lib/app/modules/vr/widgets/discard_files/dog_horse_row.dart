import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';

import '../../../../utils/vr_rank_icon_utils.dart';
import '../vr_common_box_shadow.dart';

class DogHorseRow extends StatelessWidget {
  const DogHorseRow({
    super.key,
    required this.rank,
    this.isSelected = false,
    this.iconSrc,
    this.title,
    this.subtitle,
    this.onTap,
    required this.teamNum,
  });

  final int rank;
  final String teamNum;
  final String? iconSrc;
  final String? title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback? onTap;

  Widget buildContentView(){
    return  Row(
      children: [
        ImageView(
          getIconByRankIndex('1002',int.tryParse(teamNum) ?? 2),
          width: 20.w,
          height: 20.w,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            title ?? 'Annette Black',
            style: TextStyle(
              fontSize: 12.sp.scale,
              color: (isSelected ? '#127DCC' : '#303442').hexColor,
            ),
          ),
        ),
        Text(
          subtitle ?? '${rank + 1}',
          style: TextStyle(
            fontSize: 16.sp.scale,
            color: (isSelected ? '#127DCC' : '#303442').hexColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return VrCommonBoxShadow(
      onTap: onTap,
      padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
      color: isSelected ? (Get.isDarkMode?AppColor.colorDarkMode:'#D1EBFF'.hexColor) : AppColor.colorWhite,
      child: Row(
        children: [
          ImageView(
            getIconByRankIndex('1002',int.tryParse(teamNum) ?? 2),
            width: 20.w,
            height: 20.w,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              title ?? 'Annette Black',
              style: TextStyle(
                fontSize: 12.sp.scale,
                color: (isSelected ? '#127DCC' : '#303442').hexColor,
              ),
            ),
          ),
          Text(
            subtitle ?? '${rank + 1}',
            style: TextStyle(
              fontSize: 16.sp.scale,
              color: (isSelected ? '#127DCC' : '#303442').hexColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
  ///公共获取vr赛狗 vr赛马 vr摩托车 vr泥地摩托车 图标 公共方法
  String getIconByRankIndex(String? csid, int index){
    String icon =   VrRankIconUtils.getRankIcon(int.tryParse(csid ?? '1002') ?? 1002,index.toString());
    if(icon.isEmpty){
      icon = 'assets/images/vr/vr_dog_horse_rank$index.png';
    }
    return icon;
  }
}
