import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 部分提前兑现本地asset图片转为ui.Image 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能提供多种方式加载图像，包括通过 `ImageProvider`、文件路径和 `Uint8List`，支持异步操作。
    - 使用私有构造函数和静态实例实现单例模式，确保在整个应用中只有一个 `ImageLoader` 实例。
    - `ImageProvider provider`：用于获取图像的提供者。
    - `ImageConfiguration config`：图像配置，默认值为空。
    - **功能**：
    - 通过 `ImageProvider` 获取图像流，并返回一个 `Future<ui.Image>`，在图像加载完成后解析。
    - `String path`：图像文件的路径。
    - `int width` 和 `int height`：目标宽高。
    - **功能**：
    - 从指定路径读取图像文件并返回 `ui.Image`。
    - `Uint8List list`：图像的字节数组。
    - `int width` 和 `int height`：目标宽高。
    - **功能**：
    - 通过字节数组创建图像，并返回 `ui.Image`。
    】】】
 *
 */
class ImageLoader {
  ImageLoader._(); //私有化构造
  static final ImageLoader loader = ImageLoader._(); //单例模式

  //通过ImageProvider读取Image
  Future<ui.Image> loadImageByProvider(
      ImageProvider provider, {
        ImageConfiguration config = ImageConfiguration.empty,
      }) async {
    Completer<ui.Image> completer = Completer<ui.Image>(); //完成的回调
    late ImageStreamListener listener;
    ImageStream stream = provider.resolve(config); //获取图片流
    listener = ImageStreamListener((ImageInfo frame, bool sync) {
      //监听
      final ui.Image image = frame.image;
      completer.complete(image); //完成
      stream.removeListener(listener); //移除监听
    });
    stream.addListener(listener); //添加监听
    return completer.future; //返回
  }

  /// 通过 文件读取Image
  Future<ui.Image> loadImageByFile(
    String path, {
    required int width,
    required int height,
  }) async {
    var list = await File(path).readAsBytes();
    return loadImageByUint8List(list, width: width, height: height);
  }

  /// 通过[Uint8List]获取图片,默认宽高[width][height]
  Future<ui.Image> loadImageByUint8List(
    Uint8List list, {
    required int width,
    required int height,
  }) async {
    ui.Codec codec = await ui.instantiateImageCodec(list,
        targetWidth: width, targetHeight: height);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }
}
