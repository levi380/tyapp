import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/area_code_model.dart';
import 'package:filbet/src/security/Address_provinces_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomAreaCode extends StatelessWidget {
  BottomAreaCode({super.key, required this.onSelect});

  final ValueChanged<AreaCodeModel> onSelect;
  final List<AreaCodeModel> list = [
    AreaCodeModel(name: '中国', code: '+86'),
    AreaCodeModel(name: '香港', code: '+852'),
    AreaCodeModel(name: '马来西亚', code: '+60'),
    AreaCodeModel(name: '新加坡', code: '+65'),
    AreaCodeModel(name: '柬埔寨', code: '+855'),
    AreaCodeModel(name: '澳门', code: '+853'),
    AreaCodeModel(name: '菲律宾', code: '+63'),
    AreaCodeModel(name: '泰国', code: '+66'),
    AreaCodeModel(name: '阿联酋', code: '+971'),
    AreaCodeModel(name: '越南', code: '+84'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 16.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "请输入国家名称/地区区号".tr,
                  prefixIcon: Container(
                    margin: EdgeInsets.only(left: 12.w),
                    child: Image.asset(
                      Assets.homeSearch,
                      color: appnewColors.text21,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 30.w,
                    maxWidth: 30.w,
                  ),
                  prefix: Padding(
                    padding: EdgeInsets.only(left: 8.w),
                  ),
                  hintStyle: TextStyle(
                      color: appnewColors.text21,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: appnewColors.bg3,
                  contentPadding: EdgeInsets.only(left: 12.w, right: 12.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 200.h,
              ),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return itemView(list[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: appnewColors.colorLine2,
                      height: 1.h,
                    );
                  },
                  itemCount: list.length),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemView(AreaCodeModel model) {
    return InkWell(
      onTap: () => onSelect.call(model),
      child: Container(
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${model.name} ${model.code}',
              style: TextStyle(
                  color: appnewColors.text1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
