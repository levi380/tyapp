import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/ty_login_controller_ext.dart';

import 'ty_login_controller.dart';
import 'login_head_import.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1946adf1-50a0-44ce-9d72-c792c3516a9f-dl 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP登录界面 视图】】】
    【【【 AUTO_PARAGRAPH_TITLE APP登录界面 视图 TyLoginPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - APP登录界面 视图 TyLoginPage
    - TyLoginPage
    ```
    生产  开发 测试 隔离 试玩  mini
    ```
    】】】
 *
 */
class TyLoginPage extends StatefulWidget {
  const TyLoginPage({Key? key}) : super(key: key);

  @override
  State<TyLoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<TyLoginPage> {
  final controller = Get.find<TyLoginController>();
  final logic = Get.find<TyLoginController>().logic;

  ///登陆头部
  Widget _loginHeader() {
    return Container(
      margin: EdgeInsets.only(
        top: 10.h,
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            height: 20.h,
          ),
          Text(
            '模拟登录',
            style: TextStyle(color: Colors.white, fontSize: 16.sp.scale),
          ),
          Container(
            height: 30.h,
          ),
          Text(
            '环境———${controller.env}',
            style: TextStyle(color: Colors.white, fontSize: 16.sp.scale),
          ),
          Container(
            height: 15.h,
          ),
          Text(
            'V ${controller.version}',
            style: TextStyle(color: Colors.white, fontSize: 14.sp.scale),
          ),
        ],
      ),
    );
  }

  ///输入框
  Widget _loginInputBox() {
    return Container(
      margin: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
      child: Column(
        children: [
          Container(
            height: 40.h,
            decoration: const BoxDecoration(
              color: AppColor.card,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: controller.usernameController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.blue,
              style: TextStyle(
                color: AppColor.backgroundColor,
                fontSize: 14.sp.scale,
              ),
              inputFormatters: const [],
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10.h),
                hintText: '请输入用户名称',
                hintStyle: TextStyle(
                  color: AppColor.backgroundColor,
                  fontSize: 12.sp.scale,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withValues(alpha:0.0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withValues(alpha:0.0)),
                ),
                icon: Container(
                  margin: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  child: Text(
                    '用户名称',
                    style: TextStyle(
                      color: AppColor.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp.scale,
                    ),
                  ),
                ),
              ),
              autofocus: false,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.h),
            height: 40.h,
            decoration: const BoxDecoration(
              color: AppColor.card,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: controller.passwordController,
              obscureText: controller.obscurePassword,
              keyboardType: TextInputType.text,
              cursorColor: Colors.blue,
              style: TextStyle(
                color: AppColor.backgroundColor,
                fontSize: 14.sp.scale,
              ),
              inputFormatters: const [],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.h),
                hintText: '请输入用户密码',
                hintStyle: TextStyle(
                  color: AppColor.backgroundColor,
                  fontSize: 12.sp.scale,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withValues(alpha:0.0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withValues(alpha:0.0)),
                ),
                icon: Container(
                  margin: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  child: Text(
                    '用户密码',
                    style: TextStyle(
                      color: AppColor.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp.scale,
                    ),
                  ),
                ),
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: controller.onObscurePassword,
                  child: controller.obscurePassword == true
                      ? Icon(
                          Icons.visibility_off,
                          size: 25,
                          color: Colors.grey[500],
                        )
                      : Icon(
                          Icons.visibility,
                          size: 25,
                          color: Colors.grey[500],
                        ),
                ),
              ),
              autofocus: false,
            ),
          ),
          Container(
            height: 40.h,
            margin: EdgeInsets.only(top: 20.h),
            decoration: const BoxDecoration(
              color: AppColor.card,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: controller.codeController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.blue,
              style: TextStyle(
                color: AppColor.backgroundColor,
                fontSize: 14.sp.scale,
              ),
              inputFormatters: const [],
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10.h),
                hintText: '请输入商户code',
                hintStyle: TextStyle(
                  color: AppColor.backgroundColor,
                  fontSize: 12.sp.scale,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withValues(alpha:0.0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withValues(alpha:0.0)),
                ),
                icon: Container(
                  margin: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  child: Text(
                    '商户code',
                    style: TextStyle(
                      color: AppColor.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp.scale,
                    ),
                  ),
                ),
              ),
              autofocus: false,
            ),
          ),
        ],
      ),
    );
  }

  ///登陆按钮
  Widget _login() {
    return GestureDetector(
      onTap: () => controller.toLogin(),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
        height: 40.h,
        decoration: ShapeDecoration(
          color: const Color(0xFF3E65FF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        width: double.maxFinite,
        child: Text(
           '登录',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp.scale,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  ///环境选择
  Widget _setting() {
    return GestureDetector(
      onTap: () => controller.toSelect(),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        height: 40.h,
        decoration: ShapeDecoration(
          color: const Color(0xFF3E65FF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        width: double.maxFinite,
        child: Text(
          '环境选择',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp.scale,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TyLoginController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          appBar: Get.previousRoute.isNotEmpty?AppBar(
              backgroundColor: AppColor.backgroundColor,
          ):null,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _loginHeader(),
                  _loginInputBox(),
                  _login(),
                  _setting(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Get.delete<TyLoginController>();
    super.dispose();
  }
}
