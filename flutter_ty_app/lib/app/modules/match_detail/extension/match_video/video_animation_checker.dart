
import 'dart:io';

/// 视频动画检查器
class VideoAnimationChecker {
  /// 检查URL是否可用
  static Future<bool> checkUrlAvailability(String url) async {
    var httpClient = HttpClient();
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      return response.statusCode == HttpStatus.ok;
    } catch (e) {
      return false;
    } finally {
      httpClient.close();
    }
  }
}