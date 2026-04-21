import 'dart:async';
import 'dart:io';
import 'package:filbet/utils/app_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

typedef MediaPicked = void Function(File file);
typedef MultiMediaPicked = void Function(List<File> files);

class MediaPickerUtil {
  MediaPickerUtil._();

  static final ImagePicker _picker = ImagePicker();

  /// 最大缓存文件数，超过会自动删除最旧文件
  static const int _maxCacheFiles = 10;

  /// ---------------- 拍照 ----------------
  static Future<File?> takePhoto({
    int maxWidth = 1080,
    int maxHeight = 1920,
    int imageQuality = 80,
  }) async {
    if (!await _ensureCameraPermission()) return null;

    try {
      final xFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: imageQuality,
      );

      if (xFile == null) return null;

      return await _persistXFile(xFile, prefix: 'camera');
    } catch (_) {
      AppUtils.showToast('拍照失败');
      return null;
    }
  }

  /// ---------------- 拍视频 ----------------
  static Future<File?> takeVideo({
    Duration? maxDuration,
  }) async {
    if (!await _ensureCameraPermission()) return null;

    try {
      final xFile = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: maxDuration ?? const Duration(minutes: 2),
      );

      if (xFile == null) return null;
      return await _persistXFile(xFile, prefix: 'camera_video');
    } catch (_) {
      AppUtils.showToast('拍摄视频失败');
      return null;
    }
  }

  /// ---------------- 单选相册 ----------------
  static Future<File?> pickImage({
    int maxWidth = 1080,
    int maxHeight = 1920,
    int imageQuality = 80,
  }) async {
    if (!await _ensureGalleryPermission()) return null;

    try {
      final xFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: imageQuality,
      );

      if (xFile == null) return null;

      return await _persistXFile(xFile, prefix: 'gallery');
    } catch (_) {
      AppUtils.showToast('选择图片失败');
      return null;
    }
  }

  /// ---------------- 多选相册 ----------------
  static Future<List<File>> pickMultiImages({
    int maxWidth = 1080,
    int maxHeight = 1920,
    int imageQuality = 80,
    int? maxCount,
  }) async {
    if (!await _ensureGalleryPermission()) return [];

    try {
      final xFiles = await _picker.pickMultiImage(
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: imageQuality,
      );

      if (xFiles.isEmpty) return [];

      final limited = maxCount != null && xFiles.length > maxCount
          ? xFiles.sublist(0, maxCount)
          : xFiles;

      return await Future.wait(
        limited.map(
          (x) => _persistXFile(x, prefix: 'multi'),
        ),
      );
    } catch (_) {
      AppUtils.showToast('选择图片失败');
      return [];
    }
  }

  /// ---------------- 选择视频（相册） ----------------
  static Future<File?> pickVideo() async {
    if (!await _ensureGalleryPermission()) return null;

    try {
      final xFile = await _picker.pickVideo(
        source: ImageSource.gallery,
      );

      if (xFile == null) return null;

      return await _persistXFile(xFile, prefix: 'video');
    } catch (_) {
      AppUtils.showToast('选择视频失败');
      return null;
    }
  }

  /// ---------------- 内部权限方法 ----------------
  static Future<bool> _ensureCameraPermission() async {
    if (Platform.isIOS) {
      return true;
    }
    final status = await Permission.camera.status;
    if (status.isGranted || status.isLimited) return true;

    final result = await Permission.camera.request();
    if (result.isGranted || result.isLimited) return true;

    _toastPermissionDenied('相机', result);
    return false;
  }

  static Future<bool> _ensureGalleryPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    // Android：按系统版本选择权限
    final info = await DeviceInfoPlugin().androidInfo;
    if (info.version.sdkInt >= 33) {
      // Android 13+：优先走系统 Photo Picker（一般无需权限），但为兼容部分 ROM 可申请 photos
      final status = await Permission.photos.status;
      if (status.isGranted || status.isLimited) return true;
      final result = await Permission.photos.request();
      if (result.isGranted || result.isLimited) return true;
      _toastPermissionDenied('相册', result);
      return false;
    }

    // Android 12 及以下：使用 storage
    final status = await Permission.storage.status;
    if (status.isGranted || status.isLimited) return true;
    final result = await Permission.storage.request();
    if (result.isGranted || result.isLimited) return true;
    _toastPermissionDenied('相册', result);
    return false;
  }

  static void _toastPermissionDenied(String name, PermissionStatus status) {
    if (status.isPermanentlyDenied) {
      AppUtils.showToast('$name权限被永久拒绝，请在设置中开启权限');
    } else {
      AppUtils.showToast('$name权限被拒绝，请在设置中开启权限');
    }
  }

  /// 将 XFile 复制到 App 私有目录
  static Future<File> _persistXFile(
    XFile xFile, {
    required String prefix,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final ext = p.extension(xFile.path);
    final name = '${prefix}_${DateTime.now().millisecondsSinceEpoch}$ext';
    final target = File(p.join(dir.path, name));
    final saved = await File(xFile.path).copy(target.path);
    // 用上自动清理：避免缓存无限增长
    unawaited(_cleanOldCacheFiles(dir, prefix));
    return saved;
  }

  /// ---------------- 自动清理缓存 ----------------
  static Future<void> _cleanOldCacheFiles(Directory dir, String prefix) async {
    try {
      final files = dir
          .listSync()
          .whereType<File>()
          .where((f) => p.basename(f.path).startsWith(prefix))
          .toList();

      if (files.length <= _maxCacheFiles) return;

      // 按创建时间排序，最早的先删除
      files
          .sort((a, b) => a.statSync().changed.compareTo(b.statSync().changed));

      final removeCount = files.length - _maxCacheFiles;
      for (int i = 0; i < removeCount; i++) {
        try {
          files[i].deleteSync();
        } catch (_) {}
      }
    } catch (_) {}
  }
}
