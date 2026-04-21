import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/area_code_model.dart';
import 'package:filbet/src/security/Address_provinces_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 区号选择弹窗。[width] 可选，不传时由父级约束（如居中时用 320.w）。输入框支持模糊搜索国家名称和区号。
class DialogAreaCode extends StatefulWidget {
  const DialogAreaCode({
    super.key,
    required this.onSelect,
    required this.areaCode,
    this.width,
  });

  final ValueChanged<AreaCodeModel> onSelect;
  final double? width;
  final String areaCode;

  @override
  State<DialogAreaCode> createState() => _DialogAreaCodeState();

  /// 统一入口：传入 [left]、[top]、[width] 时在指定位置显示；不传则居中、宽度 320.w
  static void show({
    required ValueChanged<AreaCodeModel> onSelect,
    required String areaCode,
    double? left,
    double? top,
    double? width,
  }) {
    final hasPosition = left != null && top != null && width != null;
    if (hasPosition) {
      Get.dialog(
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.back(),
            ),
            Positioned(
              left: left,
              top: top,
              width: width,
              child: Material(
                color: Colors.transparent,
                child: DialogAreaCode(
                  onSelect: (model) {
                    Get.back();
                    onSelect(model);
                  },
                  width: width,
                  areaCode: areaCode,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      Get.dialog(
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        Center(
          child: SizedBox(
            width: 320.w,
            child: DialogAreaCode(
              onSelect: (model) {
                Get.back();
                onSelect(model);
              },
              areaCode: areaCode,
            ),
          ),
        ),
      );
    }
  }

  static final List<AreaCodeModel> _fullList = [
    AreaCodeModel(name: '中国', code: '+86'),
    AreaCodeModel(name: '香港', code: '+852'),
  ];
}

class _DialogAreaCodeState extends State<DialogAreaCode> {
  final TextEditingController _searchController = TextEditingController();
  String _keyword = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// 模糊匹配：子串匹配（如「中」→中国/中国香港，「8」→+86/+852）；多字按顺序出现（如「中港」→中国香港）
  bool _fuzzyMatch(AreaCodeModel e, String k) {
    final name = (e.name ?? '').toLowerCase();
    final codeRaw = (e.code ?? '').toLowerCase();
    final codeNum = codeRaw.replaceAll('+', '');
    if (k.isEmpty) return true;
    if (name.contains(k) || codeRaw.contains(k) || codeNum.contains(k)) return true;
    bool orderedIn(String source) {
      int pos = 0;
      for (int i = 0; i < k.length; i++) {
        final idx = source.indexOf(k[i], pos);
        if (idx < 0) return false;
        pos = idx + 1;
      }
      return true;
    }
    return orderedIn(name) || orderedIn(codeNum);
  }

  List<AreaCodeModel> get _filteredList {
    final k = _keyword.trim().toLowerCase();
    if (k.isEmpty) return DialogAreaCode._fullList;
    return DialogAreaCode._fullList.where((e) => _fuzzyMatch(e, k)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _filteredList;
    return Container(
      width: widget.width ?? double.infinity,
      height: 232.r,
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Color(0xFFE0E7FE),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 40.h,
            margin: EdgeInsets.only(
                top: 15.r, left: 15.r, right: 15.r, bottom: 15.r),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _keyword = v),
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
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: list.length,
              separatorBuilder: (_, __) => SizedBox(height: 10.r),
              itemBuilder: (context, index) {
                return _itemView(list[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemView(AreaCodeModel model) {
    return InkWell(
      onTap: () => widget.onSelect.call(model),
      child: Container(
        height: 44.h,
        margin: EdgeInsets.symmetric(horizontal: 15.r),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: widget.areaCode == model.code
              ? appnewColors.bg3
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
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
