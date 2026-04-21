import 'package:cached_network_image/cached_network_image.dart';
import 'package:filbet/utils/base_util.dart';
import 'package:filbet/widgets/cached_image/cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/api/api.dart';

class SKNetworkImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;
  final BorderRadius? radius;
  final bool expand;
  final bool needDecrypt;
  final Color? color;
  final ColorFilter? svgColorFilter;

  ///占位图:1:通用 2:游戏
  final int placeholderType;

  final Widget? customPlaceholder; //自定义placeholder
  final Widget? customErrorWidget; //自定义errorWidget

  const SKNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.expand = true,
    this.borderRadius = 0.0,
    this.radius,
    this.placeholderType = 1,
    this.color,
    this.svgColorFilter,
    this.needDecrypt = false,
    this.customPlaceholder,
    this.customErrorWidget,
  });

  @override
  State<StatefulWidget> createState() {
    return SKNetworkImageState();
  }
}

class SKNetworkImageState extends State<SKNetworkImage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _placeholder() {
    if (widget.customPlaceholder != null) {
      return widget.customPlaceholder!;
    }

    if (widget.placeholderType == 2) {
      return Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        color: widget.color ?? Colors.white,
        child: Image.asset(
          Assets.homeLogoPlaceholder,
          width: 40.r,
          height: 40.r,
          fit: widget.fit ?? BoxFit.contain,
        ),
      );
    }

    return Container(
      width: widget.width,
      height: widget.height,
      // color:color ??Color(0xffE0F2FF),
      alignment: Alignment.center,
      child: Image.asset(
        Assets.homeLogoPlaceholder,
        fit: widget.fit ?? BoxFit.contain,
      ),
    );
  }

  Widget _image() {
    final String url = widget.imageUrl.staticUrl(); //没域名的拼接域名
    if (!widget.needDecrypt) {
      return _customNetworkImage(url);
    }

    return _customNetworkImage(url);
  }

  String _buildFallbackUrl() {
    final String url = widget.imageUrl.staticUrl(); //没域名的拼接域名
    // 自动替换末尾文件名为 default.webp
    return url.replaceAll(RegExp(r'[^/]+\.webp$'), 'default.webp');
  }

  ///非svg网络图片
  Widget _customNetworkImage(String url) {
    return CustomCachedNetworkImage(
      needDecrypt: widget.needDecrypt,
      fit: BoxFit.fill,
      width: widget.width ?? (widget.expand == true ? double.infinity : null),
      height: widget.height ?? (widget.expand == true ? double.infinity : null),
      imageUrl: url,
      // color: color,
      placeholder: (context, url) {
        return _placeholder();
      },
      errorWidget: (_, __, ___) {
        if (widget.customErrorWidget != null) {
          return widget.customErrorWidget!;
        }

        if (widget.placeholderType == 2) {
          ///游戏图片失败
          return CachedNetworkImage(
            imageUrl: _buildFallbackUrl(),
            errorWidget: (context, Surl, error) => Container(
              width: widget.width,
              height: widget.height,
              color: widget.color ?? Colors.white,
              alignment: Alignment.center,
              child: Image.asset(
                Assets.homeLogoPlaceholder,
                width: 40.r,
                height: 40.r,
                fit: BoxFit.contain,
              ),
            ),
          );
        }
        return Container(
          width: widget.width,
          height: widget.height,
          // color:color ??Color(0xffE0F2FF),
          alignment: Alignment.center,
          child: Image.asset(
            Assets.homeLogoPlaceholder,
            fit: widget.fit ?? BoxFit.contain,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.radius ?? BorderRadius.circular(widget.borderRadius),
      child: _image(),
    );
  }
}
