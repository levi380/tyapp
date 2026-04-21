import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';

class ZstdCodecUtil {
  ZstdCodecUtil._();

  static const _channel = MethodChannel('zstd_codec');

  static Future<Uint8List> decompress(Uint8List data) async {
    if (!Platform.isAndroid) {
      throw UnsupportedError('zstd only supported on Android');
    }

    final dynamic result =
    await _channel.invokeMethod('decompress', data);

    if (result is Uint8List) {
      return result;
    }

    throw Exception('zstd decompress failed');
  }
}
