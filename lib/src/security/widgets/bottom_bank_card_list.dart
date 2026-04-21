import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/security/Bank_list_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomBankCardList extends StatefulWidget {
  ValueChanged<BankListModel> onSelect;
  RxList<BankListModel> bankList;

  BottomBankCardList({super.key, required this.bankList, required this.onSelect});

  @override
  State<BottomBankCardList> createState() => _BottomBankCardList();
}

class _BottomBankCardList extends State<BottomBankCardList> {
  List<BankListModel> filterList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filterList = List.from(widget.bankList);
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setState(() {
          filterList = List.from(widget.bankList);
        });
      } else {
        setState(() {
          filterList = widget.bankList.where((e) => e.name?.contains(searchController.text) ?? false).toList();
        });
      }
    });
  }

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
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "请输入银行名称".tr,
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
                  hintStyle: TextStyle(color:Color(0xFFA6A9B4), fontSize: 14.sp, fontWeight: FontWeight.w500),
                  filled: true,
                  fillColor: appnewColors.bgGray1,
                  contentPadding: EdgeInsets.only(left: 12.w, right: 12.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            if (filterList.isNotEmpty)
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 200.h,
                ),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return itemView(filterList[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: appnewColors.colorLine2,
                        height: 1.h,
                      );
                    },
                    itemCount: filterList.length),
              ),
          ],
        ),
      ),
    );
  }

  Widget itemView(BankListModel item) {
    return InkWell(
        child: Container(
          height: 44.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.name ?? "",
                style: TextStyle(color: appnewColors.text1, fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        onTap: () {
          widget.onSelect.call(item);
        });
  }
}
