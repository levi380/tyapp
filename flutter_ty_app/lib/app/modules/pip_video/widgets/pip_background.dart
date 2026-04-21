import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../extension/widget_extensions.dart';
import '../../../utils/detail_csid_config.dart';
import '../../../utils/lodash.dart';
import '../../../utils/oss_util.dart';
import '../../../utils/widget_utils.dart';
import '../../login/login_head_import.dart';

/// 画中画（PIP）模式背景组件
/// 用于在画中画模式下显示比赛相关的背景图片
class PipBackground extends StatelessWidget {
  const PipBackground({super.key, required this.match});

  final MatchEntity match; // 比赛数据实体

  @override
  Widget build(BuildContext context) {

    // 获取比赛所属的运动类别ID
    String csid = match.csid;

    try {
      // 从配置中获取该运动类别的背景图片URL
      String bgUrl =
          lodash.get(DetailCsidConfig.detailCsidConfig, 'CSID_$csid.detail.B');
      // 从配置中获取该运动类别的Base64编码图片（如果有）
      String? base64 =
          lodash.get(DetailCsidConfig.detailCsidConfig, 'CSID_$csid.base64');

      // 如果没有base64图片，则使用网络图片
      if (base64 == null) {
        return Container(
          width: 1.sw, // 使用扩展方法设置屏幕宽度
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  // 通过OSS工具类获取完整的图片服务器路径
                  OssUtil.getServerPath(bgUrl),
                ),
                fit: BoxFit.cover // 图片填充方式：覆盖整个容器
                ),
          ),
        );
      } else {
        // 如果有base64图片，则使用base64图片
        return SizedBox(
            width: 1.sw,
            child: WidgetUtils.base64ImageWidget(
                baseUrl: base64) // 使用工具类解码base64图片
            );
      }
    } catch (e) {
      // 发生异常时显示加载指示器并居中
      return const CupertinoActivityIndicator().center;
    }
  }
}
