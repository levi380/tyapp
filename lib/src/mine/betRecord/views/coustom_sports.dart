import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:filbet/themes/app_newcolor.dart';

class coustomSports extends StatefulWidget {
  final List<dynamic> detailList; // 外部传进来的头部
  const coustomSports({
    super.key,
    required this.detailList,
  });

  @override
  State<coustomSports> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<coustomSports> {
  late bool _expanded = false;
  late bool _showexpanded = false;
  List<dynamic> detailList = []; // 外部传进来的头部
  @override
  void initState() {
    super.initState();
    _showexpanded = widget.detailList.length > 3;

    if (_showexpanded) {
      detailList = widget.detailList.sublist(0, 3);
    } else {
      detailList = widget.detailList;
    }
  }

  void _toggle() {
    setState(() {
      if (_expanded) {
        detailList = widget.detailList.sublist(0, 3);
      } else {
        detailList = widget.detailList;
      }
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 3.w, bottom: 3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.05),
        //     blurRadius: 6,
        //     offset: const Offset(0, 3),
        //   )
        // ],
      ),
      child: Column(
        children: [
          // 头部（点击可展开/收起）

          // 展开区域
          Container(
            child: Column(
              children: detailList.map((item) {
                return Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF2F1F7),
                      borderRadius: BorderRadius.circular(12),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.05),
                      //     blurRadius: 6,
                      //     offset: const Offset(0, 3),
                      //   )
                      // ],
                    ),
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 3.w, bottom: 3.w),
                    margin: EdgeInsets.only(top: 3.w, bottom: 3.w),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            

  "${item?["fav_team"] ?? ""}@${item?["odds"]?.toString() ?? ""}",
                            style: TextStyle(
                                color: appnewColors.text1,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 3.w,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 3.w,
                              height: 20.w,
                              color: appnewColors.bg,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "${item["bet_type"]}",
                                style: TextStyle(
                                    color: appnewColors.text2,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 3.w,
                              height: 20.w,
                              color: appnewColors.bg,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "${item["competition_name"] ?? ""}",
                                style: TextStyle(
                                    color: appnewColors.text2,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
              }).toList(),
            ),
          ),

          _showexpanded
              ? InkWell(
                  onTap: _toggle,
                  child: Container(
                      height: 30.w,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffEBF1FF),
                          borderRadius: BorderRadius.circular(99),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.05),
                          //     blurRadius: 6,
                          //     offset: const Offset(0, 3),
                          //   )
                          // ],
                        ),
                        height: 19.w,
                        alignment: Alignment.center,
                        width: 44.w,
                        child: Text(
                          _expanded ? '收起' : '展开',
                          style: TextStyle(
                            color: appnewColors.text2,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                )
              : Container(),
        ],
      ),
    );
  }
}
