
import '../db/app_cache.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9236b86d-2f93-40b7-a267-6fcfe0acb8fe-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  图片地址  】】】
    【【【 AUTO_PARAGRAPH_TITLE 图片地址  OssUtil 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 图片地址  OssUtil
    - OssUtil
    】】】
 *
 */
abstract class OssUtil {
  /// 检查是否是本地图片
  static bool checkIsLocal(String uri) {
    return uri.startsWith("assets");
  }

  /// 获取本地图片路径
  // assets/images/common/logo/logo_Basketball.png
  // /images/common/logo/logo_Basketball.png
  static String getServerPath(String localPath) {
    //return getBaseUrl() + localPath.replaceFirst('assets', 'assets-2024-03-27-19-00');
    return getBaseUrl() + localPath.replaceFirst('assets', 'assets-2024-04-05-12-00');
  }

  static String getBaseUrl() {
    String? imgUrl = StringKV.jtStaticUrl.get();
    if (imgUrl == null || imgUrl.isEmpty) {
      // AppLogger.error("严重错误：AllDomain 未能提供 jtStaticUrl");
      return "https://assets-image.jganten.com" + "/public/upload/app/ty/"; // 仍保留一个硬编码，以防万一
    }
    return imgUrl + "/public/upload/app/ty/";
  }
}
