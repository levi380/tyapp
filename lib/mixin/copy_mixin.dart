import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

mixin CopyMixin {
  void copy(String? text) {
    if (text != null && text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text));
    }
  }

  void copyAndshowCopyOKDialog(String? text) {
    copy(text);
    AppUtils.showToast('copy_success'.tr);
  }

  void paste(TextEditingController controller) {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      if (value != null && value.text!.isNotEmpty) {
        controller.text = value.text!;
      }
    });
  }
}
