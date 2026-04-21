import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';

Uint8List imageDecode(Uint8List bytes, {required bool needDecrypt}) {
  if (!needDecrypt) {
    return bytes;
  }
  final KEY = utf8.encode('RZM15kr\$Oh=IxG#o');
  for (int i = 0; i < 100 && i < bytes.length; i++) {
    bytes[i] ^= KEY[i % KEY.length];
  }
  return bytes;
}
