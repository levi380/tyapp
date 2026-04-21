

import 'dart:async';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/custom_cache_manager.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';
import 'package:dio/dio.dart';

/// 图片预加载任务的优先级
enum PreloadPriority {
  /// 最高优先级，尽快加载
  high,

  /// 中等优先级
  medium,

  /// 低优先级，可以在后台空闲时加载
  low,
}

/// 图片预加载任务模型
class _PreloadTask {
  final String url;
  /// 预加载优先级
  final PreloadPriority priority;
  final BuildContext context;

  _PreloadTask({
    required this.url,
    required this.priority,
    required this.context,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _PreloadTask &&
              runtimeType == other.runtimeType &&
              url == other.url;

  @override
  int get hashCode => url.hashCode;
}

/// 智能图片预加载工具类
///
/// 该类负责管理图片的异步预加载。
/// 它通过任务队列、优先级排序和并发限制来优化加载过程，
/// 确保图片在需要时能够快速显示，同时避免阻塞UI线程。
/// 图片下载操作在主线程异步执行，不使用隔离线程（Isolate），
/// 以避免与`Sqflite`等插件的底层冲突。
class SmartImagePreloader {
  SmartImagePreloader._();

  static final SmartImagePreloader instance = SmartImagePreloader._();

  /// 用于防止重复预加载的Set，比Map<List, bool>更高效。
  /// 存储的是解析后的最终URL。
  final Set<String> _preloadedUrls = <String>{};

  /// 待处理的预加载队列，可以根据优先级排序。
  final List<_PreloadTask> _preloadQueue = [];

  /// 预加载任务的并发数限制，防止网络或CPU过载。
  static const int _maxConcurrentPreloads = 3;

  /// 当前正在进行的预加载任务数。
  int _currentConcurrentPreloads = 0;

  /// 用于调度任务的Timer，避免短时间内大量触发`_processQueue`。
  Timer? _debounceTimer;
  static const Duration _debounceDuration = Duration(milliseconds: 100);

  /// 初始化方法。
  void init() {
    AppLogger.debug('SmartImagePreloader 已初始化。');
  }

  /// 纯粹的HTTP下载图片的函数。
  /// 此函数在主Isolate中异步运行，不使用隔离线程。
  /// 仅仅进行HTTP请求并返回字节数据。
  /// 参数为URL字符串，返回图片字节数组（Uint8List）。
  static Future<Uint8List?> _pureHttpDownloadAsync(String url) async {
    try {
      final dio = Dio(); // 在主Isolate中创建一个新的Dio实例。
      final response = await dio.get<List<int>>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          sendTimeout: const Duration(seconds: 10), // 连接超时时间
          receiveTimeout: const Duration(seconds: 30), // 接收超时时间
        ),
      );
      if (response.statusCode == 200 && response.data != null) {
        // AppLogger.debug('已异步下载图片文件: $url');
        return Uint8List.fromList(response.data!);
      }
      return null;
    } catch (e) {
      AppLogger.error('异步下载图片失败 $url: $e');
      return null;
    }
  }

  /// 添加一个预加载任务到队列。
  /// [urls] 待预加载的图片URL列表（可以是原始路径，会通过OssUtil解析）。
  /// [priority] 预加载任务的优先级。
  /// [context] 当前页面的BuildContext，用于检查组件是否已挂载。
  void addPreloadTask(List<String> urls, {
    required PreloadPriority priority,
    required BuildContext context,
  }) {

    for (final rawUrl in urls) {
      // 所有图片都通过OssUtil.getServerPath进行路径解析，确保是最终的网络URL。
      final String resolvedUrl = OssUtil.getServerPath(rawUrl);

      // 如果已经预加载过此URL，则跳过。
      if (_preloadedUrls.contains(resolvedUrl)) {
        continue;
      }

      _preloadQueue.add(_PreloadTask(
        url: resolvedUrl, // 存储解析后的URL。
        priority: priority,
        context: context,
      ));
      _preloadedUrls.add(resolvedUrl); // 标记为已添加到队列。

      // AppLogger.debug('已添加预加载任务: $resolvedUrl，优先级为 $priority');
    }

    // 重新排序队列 (高优先级在前)。
    _preloadQueue.sort((a, b) => b.priority.index.compareTo(a.priority.index));

    // 使用防抖来调度任务，避免短时间内大量触发`_processQueue`。
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, _processQueue);
  }

  /// 处理预加载队列。
  /// 当队列非空且并发任务数未达到上限时，持续处理任务。
  Future<void> _processQueue() async {
    while (_preloadQueue.isNotEmpty &&
        _currentConcurrentPreloads < _maxConcurrentPreloads) {
      final task = _preloadQueue.removeAt(0); // 取出最高优先级的任务。

      // 确保BuildContext仍然有效 (组件未被卸载)。
      if (!task.context.mounted) {
        AppLogger.debug(
            '预加载任务 ${task.url} 因BuildContext无效（组件未挂载）而跳过。');
        continue;
      }

      _currentConcurrentPreloads++;
      // AppLogger.debug('开始预加载: ${task
      //     .url}。当前并发任务数: $_currentConcurrentPreloads');

      final bool isSvg = task.url.endsWith('.svg'); // 根据文件后缀判断是否为SVG。

      // 【关键】直接在主Isolate中异步下载图片。
      _pureHttpDownloadAsync(task.url).then((
          Uint8List? bytes) async { // 接收下载的字节数据。
        if (bytes != null) {
          // 再次检查BuildContext mounted状态，防止在下载期间组件被卸载。
          if (!task.context.mounted) {
            // AppLogger.debug(
            //     '预加载任务 ${task.url} 在处理前因BuildContext无效而跳过。');
            return;
          }
          try {
            // 下载完成后，将字节数据传递给CustomCacheManager进行缓存和解码。
            // CustomCacheManager的所有平台通道操作都在主Isolate上执行。
            final cacheManager = CustomCacheManager();

            // 使用putFile方法将下载的字节写入缓存。
            // putFile内部通常会处理文件写入和可能的图片预解码。
            await cacheManager.putFile(task.url, bytes);

            if (isSvg) {
              // SVG仅下载并缓存，无需decodeImageFromList (SVG的解析通常在渲染时进行)。
              // AppLogger.debug('SVG文件 ${task.url} 已下载并缓存，无需解码。');
            } else {
              // 对于非SVG图片，putFile已经将文件写入缓存。
              // 为了确保图片在主线程被解码（减少初次渲染卡顿），我们可以显式调用一次。
              // 某些情况下，putFile内部可能已触发解码，此步可根据实际情况调整。
              await decodeImageFromList(bytes);
              // AppLogger.debug('已在主线程解码并缓存网络图片: ${task.url}');
            }
          } catch (e) {
            // AppLogger.error('在主线程处理图片失败 ${task.url}: $e');
          }
        }
      }).whenComplete(() {
        _currentConcurrentPreloads--; // 任务完成后，减少并发任务计数。
        _processQueue(); // 继续处理队列中的下一个任务。
      });
    }

    // 如果队列已空且所有并发任务都已完成。
    if (_preloadQueue.isEmpty && _currentConcurrentPreloads == 0) {
      AppLogger.debug('所有预加载任务已完成。');
      // 所有任务完成后，清空已加载记录，以便下次需要时可以重新加载。
      _preloadedUrls.clear();
    }
  }

  /// 销毁时取消所有任务和计时器。
  void dispose() {
    _debounceTimer?.cancel();
    _debounceTimer = null;
    _preloadQueue.clear();
    _preloadedUrls.clear();
    _currentConcurrentPreloads = 0;
    AppLogger.debug('SmartImagePreloader 已销毁，计时器已取消。');
  }
}