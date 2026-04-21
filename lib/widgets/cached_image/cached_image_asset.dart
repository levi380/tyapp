import 'package:flutter/material.dart';

class CachedImageAsset extends StatelessWidget {
  final String imagePath;
  final String? package;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CachedImageAsset({
    Key? key,
    required this.imagePath,
    this.package,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 对于本地资源，直接使用Image.asset，但添加缓存逻辑
    return Image.asset(
      imagePath,
      package: package,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      color: color,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ?? const Icon(Icons.error, size: 20),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: child,
        );
      },
    );
  }
}
