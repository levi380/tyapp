import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/mine/feedback/widgets/bottom_sheet_question_type.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/picture_selestor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class FeedbackController extends GetXBaseController {
  TextEditingController contentController = TextEditingController();
  final PictureSelectorController pictureController =
      PictureSelectorController();
  final imageCount = 0.obs;
  final textLength = 0.obs;
  final questionType = ''.obs;
  final enable = false.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
    updateImageCount();
    contentController.addListener(() {
      final text = contentController.text;
      if (text.length > 200) {
        contentController.value = TextEditingValue(
          text: text.substring(0, 200),
          selection: TextSelection.collapsed(offset: 200),
        );
      }
      textLength.value = contentController.text.length;
      checkEnable();
    });
  }

  void initData() {}

  void updateImageCount() {
    imageCount.value = pictureController.files.length;
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }

  void checkEnable() {
    enable.value = textLength > 0 && questionType.value.isNotEmpty;
  }

  void showQuestionTypeBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      builder: (c) {
        return BottomSheetQuestionType();
      },
    ).then((value) {
      if (value is String && value.isNotEmpty) {
        questionType.value = value;
        checkEnable();
      }
    });
  }

  void submit() async {
    if (questionType.value.isEmpty) {
      AppUtils.showToast('question_type_select'.tr);
      return;
    }
    if (contentController.text.isEmpty) {
      AppUtils.showToast('请输入问题描述');
      return;
    }
    if (contentController.text.length < 20 ||
        contentController.text.length > 200) {
      AppUtils.showToast('内容介于20~200字'.tr);
      return;
    }
    SmartDialog.showLoading();
    await Future.delayed(Duration(seconds: 1));
    SmartDialog.dismiss();
    AppUtils.showToast('提交成功');
    Get.back();
  }
}
