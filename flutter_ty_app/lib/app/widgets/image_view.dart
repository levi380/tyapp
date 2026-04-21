import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';

import '../global/custom_cache_manager.dart';
import '../utils/oss_util.dart';
import '../utils/utils.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-59bf5275-48ce-477a-831a-a111b6b78d68-dl 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  图片加载组件  】】】
    【【【 AUTO_PARAGRAPH_TITLE 图片加载组件  ImageView 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 图片加载组件  ImageView
    - ImageView
    ```
    /// 加载本体图片
    isLocalImage = true,

    /// 加载体育接口图片
    cdn = true,

    /// 加载电竞接口图片
    dj = true,

    /// 加载素材后台图片
    /// OssUtil.getServerPath(uri)  assets 地址路径处理
    ImageView(
      "assets/images/xsyd/beginners_guide_close.png",
      width: 30.w,
      height: 30.w,
      boxFit: BoxFit.fill,
    )
    ```
    】】】
 *
 */
class ImageView extends StatelessWidget {
  const ImageView(this._uri,
      {Key? key,
      this.width,

      ///是否是本地图片
      this.isLocalImage = false,
      this.height,
      this.cornerRadius,
      this.borderWidth,
      this.borderColor,
      this.boxFit,
      this.onTap,
      this.onTapDown,
      this.svgColor,
      this.color,
      this.cdn,
      this.dj,
      this.errorWidget})
      : super(key: key);
  final bool? isLocalImage;
  final String _uri;
  final double? width;
  final double? height;
  final double? cornerRadius;
  final double? borderWidth;
  final Color? borderColor;
  final VoidCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final BoxFit? boxFit;
  final Color? svgColor;
  final bool? cdn;
  final bool? dj;
  final Widget? errorWidget;

  // cdn = true 代表为 CDN 图片域名
  // dj = true 代表为 电竞图片域名
  /// If non-null, this color is blended with each image pixel using [colorBlendMode].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    try {
      if (_uri.isEmpty) {
        return SizedBox(
          width: width,
          height: width,
        );
      }
      return GestureDetector(
        onTap: onTap,
        onTapDown: onTapDown,
        child: !isLocalImage! ? _getNetWorkImage() : _getLocalImage(),
      );
    } catch (e) {
      return SizedBox(
        width: width,
      );
    }
  }

  Widget _getNetWorkImage() {
    String uri = _uri;
    if (uri.startsWith("assets")) {
      //   uri = uri.replaceFirst('assets', 'assets-2024-03-27-19-00');
      //uri = uri.replaceFirst('assets', 'assets-2024-04-05-12-00');
      //uri = 'https://assets-image.thewheresnik.com/public/upload/app/ty/$uri';
      uri = OssUtil.getServerPath(uri);
    }
    if (uri.endsWith('.svg')) {
      if (uri.startsWith('http')) {
        return FutureBuilder<File>(
          future: CustomCacheManager().getSingleFile(uri, key: uri),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return SvgPicture.memory(
                snapshot.data!.readAsBytesSync(),
                width: width,
                height: height,
                color: svgColor,
                fit: boxFit ?? BoxFit.contain,
              );
            } else {
              return errorWidget ??
                  Container(
                    width: width,
                    height: width,
                  );
              // DefaultCacheManager().downloadFile(uri,force: true);
              // return SvgPicture.network(
              //   uri,
              //   width: width,
              //   height: height,
              //   color: svgColor,
              //   fit: boxFit ?? BoxFit.contain,
              // );
            }
          },
        );
      } else {
        return SvgPicture.asset(
          uri,
          width: width,
          height: height,
          color: svgColor,
          fit: boxFit ?? BoxFit.contain,
        );
      }
    } else if (uri.startsWith("http") || cdn == true || dj == true) {
      String u = uri;
      if (cdn == true) {
        String cdnImg = StringKV.imgUrl.get() ?? "";

        if (!uri.startsWith('http')) {
          u = composeUrl(cdnImg, uri);
          // AppLogger.debug('cdnImg=======>$u');
        }
      } else if (dj == true) {
        String cdnImg = StringKV.eSportsImgDomain.get() ?? "";
        u = composeUrl(cdnImg, uri);
      }

      // 网络图片
      return ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius ?? 0),
        child: SizedBox(
          width: width,
          height: height ?? width,
          child: CachedNetworkImage(
            imageUrl: u,
            cacheKey: u,
            cacheManager: CustomCacheManager(),
            fit: boxFit ?? BoxFit.contain,
            errorListener: (value) {
              // AppLogger.debug("图片加载失败：$u");
            },
            color: color,
            // placeholder: (context, url) => const Center(
            //   child: CircularProgressIndicator(
            //     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            //   ),
            // ),
            placeholder: (context, url) =>
                errorWidget ?? Container(width: width, height: width),
            fadeOutDuration: const Duration(milliseconds: 0),
            fadeInDuration: const Duration(milliseconds: 0),

            ///不用加旧图缓存 不然首次图片加载失败的 新的图片加载不出来
            // useOldImageOnUrlChange: true,
            errorWidget: (context, url, error) =>
                errorWidget ?? Container(width: width, height: width),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  ///本地图片
  Widget _getLocalImage() {
    String uri = _uri;
    if (uri.endsWith('.svg')) {
      return SvgPicture.asset(
        uri,
        width: width,
        height: height,
        color: svgColor,
        fit: boxFit ?? BoxFit.fitWidth,
      );
    } else if (uri.startsWith("assets")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius ?? 0),
        child: Image.asset(
          uri,
          width: width,
          height: height,
          fit: boxFit ?? BoxFit.contain,
          color: color,
        ),
      );
    } else {
      return Container();
    }
  }
}
