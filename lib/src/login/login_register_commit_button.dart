import 'package:filbet/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 登录 / 注册页主操作按钮（背景图 + 不可点蒙层）
class LoginRegisterCommitButton extends StatelessWidget {
  const LoginRegisterCommitButton({
    super.key,
    required this.canTap,
    required this.onPressed,
    required this.label,
  });

  final bool canTap;
  final VoidCallback onPressed;
  final String label;

  static const Color disabledOverlayColor = Color(0x4D000000);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.r,
      child: GestureDetector(
        onTap: canTap ? onPressed : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.loginBgLoginButton),
                  fit: BoxFit.fill,
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (!canTap) const ColoredBox(color: disabledOverlayColor),
          ],
        ),
      ),
    );
  }
}
