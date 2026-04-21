import 'package:filbet/themes/app_color.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/pop_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SKConfirmDialog {
  static PopUpView create({
    Key? key,
    required Widget content,
    String? title,
    Widget? confirmButton,
    VoidCallback? onConfirm,
    VoidCallback? onClose,
  }) {
    return PopUpView.withActionButton(
      key: key,
      title: title ?? 'tips'.tr,
      content: content,
      actionButton: confirmButton ?? _buildDefaultActionButton(onConfirm),
      onClose: onClose,
    );
  }

  static Widget _buildDefaultActionButton(VoidCallback? onConfirm) {
    return Builder(builder: (context) {
      return CommonActionButton.confirm(
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    });
  }

  static PopUpView text(
    BuildContext context,
    String text, {
    VoidCallback? onPressed,
    VoidCallback? onClose,
  }) {
    return SKConfirmDialog.create(
      content: Text(
        text,
        style: TextStyle(
          color: appColors.textMainColor,
          fontSize: 14.sp,
        ),
      ),
      confirmButton: CommonActionButton.confirm(true,
          onPressed: onPressed ??
              () {
                Navigator.of(context).pop();
              }),
      onClose: onClose,
    );
  }
}
