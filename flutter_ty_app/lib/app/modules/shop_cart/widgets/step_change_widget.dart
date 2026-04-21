import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/image_view.dart';

class StepChangeWidget extends StatelessWidget {
  const StepChangeWidget(this.currentValue,this.step,{this.accuracy=0,this.minValue = 0,this.maxValue = double.infinity,this.unit="",this.unitStyle,this.space=0, Key? key}) : super(key: key);

  final num step;
  final Rx<num> currentValue;
  final int accuracy;
  final double minValue;
  final double maxValue;
  final String unit;
  final double space;
  final TextStyle? unitStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 2.h),
      decoration: ShapeDecoration(
        color: Color(0xFFF3FAFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageView('assets/images/shopcart/icon_addreduce1.png', width: 16.sp,
            onTap: (){
              if(currentValue.value.toDouble()>this.minValue) {
                currentValue.value -= step;
              }
            },
          ),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(()=>Text(
                    currentValue.value.toStringAsFixed(accuracy),
                    style: TextStyle(
                      color: Color(0xFF303442),
                      fontSize: 20.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                      height: 1.2
                    ),
                  ),
                ),
                SizedBox(width: space,),
                Text(
                  unit,
                  style: unitStyle!=null?unitStyle:TextStyle(
                    color: Color(0xFF303442),
                    fontSize: 20.sp,
                    fontFamily: 'Akrobat',
                    fontWeight: FontWeight.w700,
                      height: 1.2
                  ),
                ),
              ],
            ),
          ),
          ImageView('assets/images/shopcart/icon_addreserve1.png', width: 16.sp,
            onTap: (){
              if(currentValue.value.toDouble()<this.maxValue) {
                currentValue.value += step;
              }
            },
          ),
        ],
      ),
    );
  }
}