import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/tutorial/simulation_training/widgets/actual_combat_button_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/tutorial/simulation_training/widgets/question_1_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/tutorial/simulation_training/widgets/question_2_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/tutorial/simulation_training/widgets/simulation_title_widget.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../utils/change_skin_tone_color_util.dart';
import 'simulation_training_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 大小球模拟训练 页面视图 SimulationTrainingPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 大小球模拟训练 页面视图  SimulationTrainingPage
    - SimulationTrainingPage
    ```
    ///头部
    _title(),
    ///列表
    Expanded(
    child: SingleChildScrollView(
    child: _body(),
    ),
    )

    ///第一题
    Question1Widget(
    isDark: context.isDarkMode,
    question: controller.question1,
    select: controller.select,
    onSelect: (index) => controller.onSelect(index),
    nextQuestion: () => controller.nextQuestion(),
    ),

    ///第二题
    Question2Widget(
    isDark: context.isDarkMode,
    question: controller.question2,
    select: controller.select,
    onSelect: (index) => controller.onSelect(index),
    nextQuestion: () => controller.nextQuestion(),
    onBack: () => controller.onBack(),
    ),

    ///实战按钮
    _actualCombat(),
    ```
    】】】
 *
 */

class SimulationTrainingPage extends StatefulWidget {
  const SimulationTrainingPage({Key? key}) : super(key: key);

  @override
  State<SimulationTrainingPage> createState() => _SimulationTrainingPageState();
}

class _SimulationTrainingPageState extends State<SimulationTrainingPage> {
  final controller = Get.find<SimulationTrainingController>();
  final logic = Get.find<SimulationTrainingController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SimulationTrainingController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            color: context.isDarkMode ?  ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(noChange: true) : Color(0xFFF2F2F6),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  ///头部
                  _title(),
                  ///列表
                  Expanded(
                    child: SingleChildScrollView(
                      child: _body(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///头部
  Widget _title() {
    return SimulationTitleWidget(
      isDark: context.isDarkMode,
      title: LocaleKeys.app_h5_handicap_tutorial_answer_question.tr,
    );
  }

  ///列表
  Widget _body() {
    return Column(
      children: [
        ///第一题
        Question1Widget(
          isDark: context.isDarkMode,
          question: logic.question1,
          select: logic.select,
          onSelect: (index) => controller.onSelect(index),
          nextQuestion: () => controller.nextQuestion(),
        ),

        ///第二题
        Question2Widget(
          isDark: context.isDarkMode,
          question: logic.question2,
          select: logic.select,
          onSelect: (index) => controller.onSelect(index),
          nextQuestion: () => controller.nextQuestion(),
          onBack: () => controller.onBack(),
        ),

        ///实战按钮
        _actualCombat(),
      ],
    );
  }

  ///实战按钮
  Widget _actualCombat() {
    if (logic.select != 0) {
      return ActualCombatButtonWidget(
        isDark: context.isDarkMode,
        title: LocaleKeys.app_h5_handicap_tutorial_actual_combat.tr,
        onTap: () => controller.onBack(),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    Get.delete<SimulationTrainingController>();
    super.dispose();
  }
}
