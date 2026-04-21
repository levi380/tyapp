import 'package:filbet/generated/assets.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/mine/controllers/user_info_controller.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';

import 'package:filbet/widgets/titlebar.dart';

class DialogChangeNickname extends StatefulWidget {
  const DialogChangeNickname({
    super.key,
    this.inputController,
    this.hintStyle,
    this.textStyle,
    this.hint = "请输入昵称",
  });

  final TextEditingController? inputController;
  final String hint;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;

  @override
  State<StatefulWidget> createState() => DialogChangeNicknameState();
}

class DialogChangeNicknameState extends State<DialogChangeNickname> {
  UserInfoController controller = Get.find();

  UserService get _userService => Get.find<UserService>();

  late TextEditingController _textController;

  int inputState = 0; //0:默认状态 1:输入状态 2:输入错误状态
  Color defaultBorder = Colors.transparent;
  Color inputBorder = appnewColors.bg1;
  Color errorBorder = Color(0xffFF9400);
  Color errorBg = Color(0xff953720).withAlpha(10);
  Color normalBg = Color(0xffE7F4FD);
  int maxLength = 12;
  int currentLength = 0;
  bool isModify = true;

  @override
  void initState() {
    super.initState();
    isModify = UserService.to.state.userInfo.modify ?? true;
    // 使用传入的控制器或创建一个新的
    _textController = widget.inputController ?? TextEditingController();
    currentLength = _textController.text.length;
    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    // 检查组件是否仍然挂载，防止在dispose后调用setState
    if (!mounted) return;

    String str = _textController.text;
    setState(() {
      currentLength = str.length;
      if (currentLength > 0) {
        inputState = 1;
      } else {
        inputState = 0;
      }
      // 改进输入验证逻辑：昵称长度不能超过maxLength
      if (currentLength > maxLength) {
        inputState = 2;
      }
    });
  }

  @override
  void dispose() {
    // 移除监听器以防止在dispose后调用setState
    _textController.removeListener(_onTextChanged);

    // 只有在我们创建了控制器的情况下才释放它
    if (widget.inputController == null) {
      _textController.dispose();
    }
    super.dispose();
  }

  Color getBorderColor() {
    if (inputState == 0) {
      return defaultBorder;
    } else if (inputState == 1) {
      return inputBorder;
    } else {
      return errorBorder;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appColors.white,
      appBar: CustomAppbar.normalTitle(title: "修改昵称".tr),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.w),
            // padding: EdgeInsets.only(left: 5.w),
            alignment: Alignment.centerLeft,
            child: Text(
              "nickname".tr,
              style: TextStyle(color: appnewColors.text1, fontSize: 14.sp),
            ),
          ),
          _buildInput(),
          Container(
            margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.h),
            // padding: EdgeInsets.only(left: 5.w),
            alignment: Alignment.centerLeft,
            child: Text(
              !isModify ? "修改次数已达到上限".tr : "最多不超过12个字符".tr,
              style: TextStyle(
                  color: !isModify ? appnewColors.tip1 : appnewColors.text8,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
          _buildBtn()
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      decoration: BoxDecoration(
        color: appnewColors.bg4,
        border: Border.all(color: getBorderColor(), width: 1.w),
        borderRadius: BorderRadius.circular(8.w),
      ),
      height: 40.h,
      margin: EdgeInsets.only(top: 10.w, left: 14.w, right: 14.w),
      child: Row(
        children: [
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _textController,
                    maxLength: maxLength,
                    enabled: isModify,
                    style: TextStyle(
                      color: inputState != 2 ? appnewColors.text1 : errorBorder,
                    ),
                    cursorColor: appnewColors.bg,
                    decoration: InputDecoration(
                      hintText: "input_nickname".tr,
                      counterText: "",
                      isDense: true,
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: appnewColors.text3, fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                  ))),
          Text(
            "$currentLength/$maxLength",
            style: TextStyle(color: inputState != 2 ? Color(0xff6C8FA2) : errorBorder, fontSize: 14.sp),
          )
        ],
      ),
    );
  }

  Widget _buildBtn() {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 9.w),
        height: 44.h,
        child: InkWell(
            onTap: () async {
              if (!isModify) return;
              // 只有在输入状态正常且有内容时才能提交
              if (inputState == 1 && currentLength > 0 && currentLength <= maxLength) {
                String nickname = _textController.text.trim();
                if (nickname.isNotEmpty) {
                  // 返回修改后的昵称给上一层

                  final newEntity = _userService.state.userInfo.copyWith(nickName: nickname);
                  final tuple = await _userService.updateUserInfos(userInfo: newEntity);
                  if (tuple.item1) {
                    UserService.to.getUserInfos();
                    AppUtils.showToast("setSuccess".tr);
                    Get.back(result: nickname);
                  } else {
                    AppUtils.showToast(tuple.item2 ?? 'unknownError'.tr);
                  }
                }
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                gradient: LinearGradient(
                  colors: isModify
                      ? inputState == 0 || inputState == 2
                          ? appnewColors.bg60
                          : appnewColors.btnbg1
                      : appnewColors.bg60,

                  // 渐变的颜色数组
                  begin: Alignment.topCenter,
                  // 从上到下
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.repeated, // 镜像平铺 平点
                ),
              ),
              child: Text(
                'confirm'.tr,
                style: TextStyle(
                  color: appnewColors.bg1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )));
  }
}
