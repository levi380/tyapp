import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/annual_report/annual_report_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/annual_report/widgets/report_10_widget.dart';
import 'package:flutter_ty_app/app/modules/annual_report/widgets/report_0_widget.dart';
import 'package:flutter_ty_app/app/modules/annual_report/widgets/report_1_widget.dart';
import 'package:flutter_ty_app/app/modules/annual_report/widgets/report_2_widget.dart';
import 'package:flutter_ty_app/app/modules/annual_report/widgets/report_6_widget.dart';
import 'package:flutter_ty_app/app/modules/annual_report/widgets/report_9_widget.dart';
import 'package:flutter_ty_app/app/modules/annual_report/widgets/report_no_data_widget.dart';
import 'package:flutter_ty_app/app/modules/annual_report/widgets/report_3_widget.dart';
import 'package:flutter_ty_app/app/modules/annual_report/widgets/report_4_widget.dart';
import 'package:flutter_ty_app/app/modules/annual_report/widgets/report_7_widget.dart';
import 'package:flutter_ty_app/app/modules/annual_report/widgets/report_8_widget.dart';
import 'package:flutter_ty_app/app/modules/annual_report/widgets/report_5_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/get_user_annual_report_template_entity.dart';
import 'package:get/get.dart';
import 'annual_report_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1509bbab-4a30-49cc-837f-3535741f55b4-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  年报】】】
    【【【 AUTO_PARAGRAPH_TITLE 年报 视图 AnnualReportPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 年报 视图 AnnualReportPage
    - AnnualReportPage
    ```
    Report0Widget(
    pandaAnimationController: controller.pandaAnimationController,
    upperSlipAnimation: controller.upperSlipAnimation,
    pandaIsVisible: controller.pandaIsVisible,
    nbAnimation: controller.nbAnimation,
    bgAnimation: controller.bgAnimation,
    onProductionReport: () => controller.onProductionReport(),
    animationController: controller.animationController,
    isPlaying: controller.isPlaying,
    pauseMusic: () => controller.pauseMusic(),
    playMusic: () => controller.playMusic(),
    onSaveToPhoto: () => controller.onSaveToPhoto(),
    )
    ```
    】】】
 *
 */
class AnnualReportPage extends StatefulWidget {
  const AnnualReportPage({Key? key}) : super(key: key);

  @override
  State<AnnualReportPage> createState() => _AnnualReportPageState();
}

class _AnnualReportPageState extends State<AnnualReportPage> {
  final AnnualReportController controller = Get.put(AnnualReportController());
  final logic = Get.find<AnnualReportController>().logic;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        Get.back();
        controller.initFillingPoint(16);
        if (didPop) return;
      },
      child: GetBuilder<AnnualReportController>(
        builder: (controller) {
          return RepaintBoundary(
            key: controller.globalKey,
            child: Scaffold(
              body: logic.noData  ? ReportNodataWidget(
                pandaAnimationController: controller.pandaAnimationController,
                upperSlipAnimation: controller.upperSlipAnimation,
                pandaIsVisible: logic.pandaIsVisible,
                animationController: controller.animationController,
                isPlaying: logic.isPlaying,
                pauseMusic: () => controller.pauseMusic(),
                playMusic: () => controller.playMusic(),
                onSaveToPhoto: () => controller.onSaveToPhoto(),
              ):PageView.builder(
                scrollDirection: Axis.vertical,
                controller: controller.pageController,
                onPageChanged: (int page) => controller.onPageChanged(page),
                itemCount: controller.reportPO.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Report0Widget(
                      pandaAnimationController:
                      controller.pandaAnimationController,
                      upperSlipAnimation: controller.upperSlipAnimation,
                      pandaIsVisible: logic.pandaIsVisible,
                      nbAnimation: controller.nbAnimation,
                      bgAnimation: controller.bgAnimation,
                      onProductionReport: () =>
                          controller.onProductionReport(),
                      animationController: controller.animationController,
                      isPlaying: logic.isPlaying,
                      pauseMusic: () => controller.pauseMusic(),
                      playMusic: () => controller.playMusic(),
                      onSaveToPhoto: () => controller.onSaveToPhoto(),
                    );
                  } else {
                    GetUserAnnualReportTemplateDataReportPO Template =
                    controller.reportPO[index];
                    if (Template.pageNo == 1) {
                      return Report1Widget(
                        Template: Template,
                        pandaAnimationController:
                        controller.pandaAnimationController,
                        upperSlipAnimation: controller.upperSlipAnimation,
                        isPlaying: logic.isPlaying,
                        pandaIsVisible: logic.pandaIsVisible,
                        animationController: controller.animationController,
                        pauseMusic: () => controller.pauseMusic(),
                        playMusic: () => controller.playMusic(),
                        onSaveToPhoto: () => controller.onSaveToPhoto(),
                      );
                    } else if (Template.pageNo == 2) {
                      return Report2Widget(
                        Template: Template,
                        pandaAnimationController:
                        controller.pandaAnimationController,
                        upperSlipAnimation: controller.upperSlipAnimation,
                        pandaIsVisible: logic.pandaIsVisible,
                        animationController: controller.animationController,
                        isPlaying: logic.isPlaying,
                        pauseMusic: () => controller.pauseMusic(),
                        playMusic: () => controller.playMusic(),
                        onSaveToPhoto: () => controller.onSaveToPhoto(),
                      );
                    } else if (Template.pageNo == 3) {
                      return Report3Widget(
                        Template: Template,
                        pandaAnimationController:
                        controller.pandaAnimationController,
                        upperSlipAnimation: controller.upperSlipAnimation,
                        pandaIsVisible: logic.pandaIsVisible,
                        animationController: controller.animationController,
                        isPlaying: logic.isPlaying,
                        pauseMusic: () => controller.pauseMusic(),
                        playMusic: () => controller.playMusic(),
                        onSaveToPhoto: () => controller.onSaveToPhoto(),
                      );
                    } else if (Template.pageNo == 4) {
                      return Report4Widget(
                        Template: Template,
                        pandaAnimationController:
                        controller.pandaAnimationController,
                        upperSlipAnimation: controller.upperSlipAnimation,
                        pandaIsVisible: logic.pandaIsVisible,
                        animationController: controller.animationController,
                        isPlaying: logic.isPlaying,
                        pauseMusic: () => controller.pauseMusic(),
                        playMusic: () => controller.playMusic(),
                        onSaveToPhoto: () => controller.onSaveToPhoto(),
                      );
                    } else if (Template.pageNo == 5) {
                      return Report5Widget(
                        Template: Template,
                        pandaAnimationController:
                        controller.pandaAnimationController,
                        upperSlipAnimation: controller.upperSlipAnimation,
                        pandaIsVisible: logic.pandaIsVisible,
                        animationController: controller.animationController,
                        isPlaying: logic.isPlaying,
                        pauseMusic: () => controller.pauseMusic(),
                        playMusic: () => controller.playMusic(),
                        onSaveToPhoto: () => controller.onSaveToPhoto(),
                      );
                    } else if (Template.pageNo == 6) {
                      return Report6Widget(
                        Template: Template,
                        pandaAnimationController:
                        controller.pandaAnimationController,
                        upperSlipAnimation: controller.upperSlipAnimation,
                        pandaIsVisible: logic.pandaIsVisible,
                        animationController: controller.animationController,
                        isPlaying: logic.isPlaying,
                        pauseMusic: () => controller.pauseMusic(),
                        playMusic: () => controller.playMusic(),
                        onSaveToPhoto: () => controller.onSaveToPhoto(),
                      );
                    } else if (Template.pageNo == 7) {
                      return Report7Widget(
                        Template: Template,
                        pandaAnimationController:
                        controller.pandaAnimationController,
                        upperSlipAnimation: controller.upperSlipAnimation,
                        pandaIsVisible: logic.pandaIsVisible,
                        animationController: controller.animationController,
                        isPlaying: logic.isPlaying,
                        pauseMusic: () => controller.pauseMusic(),
                        playMusic: () => controller.playMusic(),
                        onSaveToPhoto: () => controller.onSaveToPhoto(),
                      );
                    } else if (Template.pageNo == 8) {
                      return Report8Widget(
                        Template: Template,
                        pandaAnimationController:
                        controller.pandaAnimationController,
                        upperSlipAnimation: controller.upperSlipAnimation,
                        pandaIsVisible: logic.pandaIsVisible,
                        animationController: controller.animationController,
                        isPlaying: logic.isPlaying,
                        pauseMusic: () => controller.pauseMusic(),
                        playMusic: () => controller.playMusic(),
                        onSaveToPhoto: () => controller.onSaveToPhoto(),
                        resultList: getResultList(index),
                      );
                    } else if (Template.pageNo == 9) {
                      return Report9Widget(
                        Template: Template,
                        pandaAnimationController:
                        controller.pandaAnimationController,
                        upperSlipAnimation: controller.upperSlipAnimation,
                        pandaIsVisible: logic.pandaIsVisible,
                        animationController: controller.animationController,
                        isPlaying: logic.isPlaying,
                        pauseMusic: () => controller.pauseMusic(),
                        playMusic: () => controller.playMusic(),
                        onSaveToPhoto: () => controller.onSaveToPhoto(),
                        bgAnimation: controller.annualTitleAnimation,
                      );
                    } else if (Template.pageNo == 10) {
                      return Report10Widget(
                        Template: Template,
                        pandaAnimationController:
                        controller.pandaAnimationController,
                        upperSlipAnimation: controller.upperSlipAnimation,
                        pandaIsVisible: logic.pandaIsVisible,
                        animationController: controller.animationController,
                        isPlaying: logic.isPlaying,
                        pauseMusic: () => controller.pauseMusic(),
                        playMusic: () => controller.playMusic(),
                        onSaveToPhoto: () => controller.onSaveToPhoto(),
                        onWatchItAgain: () => controller.onWatchItAgain(),
                      );
                    }
                  }
                  return null;
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<AnnualReportController>();
    super.dispose();
  }

  getResultList(int index) {
    if (Get.locale!.toLanguageTag().contains('CN')) {
      return controller.reportPO[index].annualParamVO.paramContentZh.isEmpty
          ? null
          : controller.reportPO[index].annualParamVO.paramContentZh;
    } else if (Get.locale!.toLanguageTag().contains('TW')) {
      return controller.reportPO[index].annualParamVO.paramContentTw.isEmpty
          ? null
          : controller.reportPO[index].annualParamVO.paramContentTw;
    } else {
      return controller.reportPO[index].annualParamVO.paramContentEn.isEmpty
          ? null
          : controller.reportPO[index].annualParamVO.paramContentEn;
    }
  }
}
