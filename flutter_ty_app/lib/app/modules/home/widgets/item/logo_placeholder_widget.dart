import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/placeholder_util.dart';

import '../../../../utils/lodash.dart';
import '../../../../utils/widget_utils.dart'; // 用于加载本地资源

class LogoPlaceholderWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final String base64Placeholder;

  final double cornerRadius; // 用于加载失败时显示的 base64 图片

  final dynamic dj;

  final dynamic cdn;

  // 构造函数，接收图片 URL、尺寸参数和 base64 占位图片
  const LogoPlaceholderWidget({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.base64Placeholder,
    this.cornerRadius = 0,
    this.dj = false,
    this.cdn = false
  }) : super(key: key);

  @override

  Widget build(BuildContext context) {
    if (imageUrl.isEmpty){
      return _buildBase64Image(base64Placeholder);
    }
    return ImageView(
        imageUrl,
      width: width,
      height: height,
      cornerRadius: cornerRadius,
      dj: dj,
      cdn: cdn,
      errorWidget: _buildBase64Image(base64Placeholder),
    );
  }

  // 将 base64 字符串转为 Image widget
  Widget _buildBase64Image(String base64String) {
    try {
      // 'placeholder_team.base64'
      String base64 =
      lodash.get(PlaceholderUtil.detaiPlaceholderConfig, base64String);
      // print(base64);
        return SizedBox(
            width: width,
            height: height,
            child: WidgetUtils.base64ImageWidget(baseUrl: base64));

    } catch (e) {
      return const CupertinoActivityIndicator().center;
    }
  }

}