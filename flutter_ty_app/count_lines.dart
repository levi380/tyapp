import 'dart:io';

void main() {
  ///只统计功能代码区域
  final directory = Directory('./lib/app/modules/');

  /// 递归查找所有 Dart 文件
  directory.listSync(recursive: true).forEach((fileEntity) {
    if (fileEntity is File && fileEntity.path.endsWith('.dart')) {
      final lines = fileEntity.readAsLinesSync().length;

      if (lines > 1200) {
        print(fileEntity.path.replaceAll('./', 'flutter_ty_app') +' has $lines lines');
      }
    }
  });
}