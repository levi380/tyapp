import 'dart:io';
import 'dart:typed_data';

import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_ty_app/app/utils/webview_ios_http_auth.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class WebViewPageController extends GetXBaseController {
  static WebViewPageController get to => Get.find();

  WebViewController webViewController = WebViewController();

  Map argumentsData = {};

  RxBool loading = false.obs;

  @override
  void onInit() {
    if (Get.arguments is Map) {
      argumentsData = Get.arguments;
      debugPrint('$argumentsData');
    }

    loading.value = false;

    final NavigationDelegate nav = NavigationDelegate(
      onProgress: (progress) {
        if (progress > 80) {
          loading.value = true;
        }
      },
      onWebResourceError: (error) {
        loading.value = true;
        // AoneDialog.toastError('description:${error.description}');
      },
      onHttpAuthRequest: tyWebViewRejectHttpAuth,
    );
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black);

    if (Platform.isAndroid) {
      final androidController =
          webViewController.platform as AndroidWebViewController;
      // 设置文件选择器回调
      androidController.setOnShowFileSelector(_androidFilePicker);

      // 启用DOM存储和其他设置
    }

    final String content = '${argumentsData['url']}';
    tyWebViewBindNavigationAndLoadUnawaited(
      controller: webViewController,
      navigationDelegate: nav,
      loadRequestUri:
          content.startsWith('http') ? Uri.parse(content) : null,
      loadHtmlString: content.startsWith('http') ? null : content,
    );
    super.onInit();
  }

  /// ✅ Android 文件选择器
  Future<List<String>> _androidFilePicker(FileSelectorParams params) async {
    try {
      // 根据接受类型确定文件类型
      FileType fileType = FileType.any;
      List<String>? allowedExtensions;

      // 检查是否为图片选择
      if (params.acceptTypes != null && params.acceptTypes.isNotEmpty) {
        final acceptTypes =
            params.acceptTypes.map((e) => e.toLowerCase()).toList();
        if (acceptTypes.any((type) => type.contains('image'))) {
          fileType = FileType.image;
        } else if (acceptTypes.any((type) => type.contains('video'))) {
          fileType = FileType.video;
        } else if (acceptTypes.isNotEmpty) {
          // 提取文件扩展名（如 .jpg, .png 等）
          fileType = FileType.custom;
          allowedExtensions = acceptTypes
              .where((type) => type.startsWith('.'))
              .map((type) => type.substring(1))
              .toList();

          // 如果没有有效的扩展名，使用通用类型
          if (allowedExtensions.isEmpty) {
            fileType = FileType.any;
            allowedExtensions = null;
          }
        }
      }

      // 打开文件选择器
      final result = await FilePicker.platform.pickFiles(
        // allowMultiple: params.isMultiple,
        type: fileType,
        allowedExtensions: allowedExtensions,
      );

      if (result == null || result.files.isEmpty) {
        return [];
      }

      // 获取缓存目录
      final cacheDir = await getTemporaryDirectory();
      final List<String> uris = [];

      for (final file in result.files) {
        if (file.path == null) continue;

        try {
          final Uint8List bytes = File(file.path!).readAsBytesSync();
          final File cacheFile = File("${cacheDir.path}/${file.name}");
          await cacheFile.writeAsBytes(bytes, flush: true);

          uris.add(cacheFile.uri.toString());
          debugPrint("文件已选择: ${file.name}");
        } catch (e) {
          debugPrint("处理文件 ${file.name} 失败: $e");
        }
      }

      return uris;
    } catch (e) {
      debugPrint("文件选择失败: $e");
      return [];
    }
  }
  
}
