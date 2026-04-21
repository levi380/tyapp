import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'game_container_widget.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/widgets/network_image.dart';

import 'package:filbet/widgets/image_button.dart';

class GameDataCell extends StatelessWidget {
  ///回调
  ///

  final String image;
  final String text;
  final Function()? callBack;
  final Function()? startcallBack;
  final bool isfav;
  const GameDataCell(
      {super.key,
      required this.callBack,
      required this.startcallBack,
      required this.image,
      required this.text,
      this.isfav = false});

  @override
  Widget build(BuildContext context) {
    return GameContainerWidget(
      margin: EdgeInsets.only(bottom: 2.w),
      // borderColor: PageStyle.c_000000.withOpacity(0.12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                // color: Colors.red,
                // margin: EdgeInsets.only(left: 10.r, right: 10.r, top: 10.r),
                height: 105.r,
                child: SKNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: image,
                  borderRadius: 5.r,
                  placeholderType: 2,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
              // alignment: Alignment.center,

              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffFFFFFF),
                    Color(0xffE5EDFF),
                    Color(0xffFFFFFF)
                  ],
                  begin: Alignment.topCenter, // 起点（上方）
                  end: Alignment.bottomCenter, // 终点（下方）
                ),
              ),
              child: Row(
                //  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    text,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14.w,
                      color: appnewColors.text1,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                  Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        ImageButton(
                          onTap: () {
                            callBack!();
                          },
                          imgStrRes: isfav
                              ? Assets.homeIconCollect
                              : Assets.homeIconCollectN,
                          alignment: Alignment.centerLeft,
                          imgWidth: 20.r,
                          imgHeight: 20.r,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      // height: 400,  //设置高度没有反应
    ).toBtn(
      onTap: () {
        startcallBack!();
      },
    );
  }

  void replaceNullWithDefault(List<dynamic> myList, dynamic defaultValue) {
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] == null) {
        myList[i] = defaultValue;
      }
    }
  }
}
