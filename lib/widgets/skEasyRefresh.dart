import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

class EasyRefreshConfig {
  /// 默认 Header（支持多语言）
  static ClassicHeader defaultHeader() {
    return ClassicHeader(
      dragText: 'refresh_idle'.tr,
      armedText: 'refresh_can'.tr,
      readyText: 'refresh_loading'.tr,
      processingText: 'refresh_loading'.tr,
      processedText: 'refresh_done'.tr,
      failedText: 'refresh_failed'.tr,
      showMessage: false,
    );
  }

  /// 默认 Footer（支持多语言）
  static ClassicFooter defaultFooter() {
    return ClassicFooter(
      dragText: 'load_idle'.tr,
      armedText: 'load_can'.tr,
      readyText: 'load_loading'.tr,
      processingText: 'load_loading'.tr,
      processedText: 'load_done'.tr,
      failedText: 'load_failed'.tr,
      noMoreText: 'load_no_more'.tr,
      showMessage: false,
    );
  }

  /// 统一构建 EasyRefresh.builder
  static EasyRefresh build({
    Key? key,
    required Widget Function(BuildContext, ScrollPhysics) childBuilder,
    EasyRefreshController? controller,
    Future<void> Function()? onRefresh,
    Future<void> Function()? onLoad,
    bool enableRefresh = true,
    bool enableLoad = true,
    Header? header,
    Footer? footer,
  }) {
    return EasyRefresh.builder(
      key: key,
      controller: controller,
      onRefresh: enableRefresh ? onRefresh : null,
      onLoad: enableLoad ? onLoad : null,
      header: enableRefresh ? (header ?? defaultHeader()) : null,
      footer: enableLoad ? (footer ?? defaultFooter()) : null,
      childBuilder: childBuilder,
    );
  }
}