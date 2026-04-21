import 'package:get/get.dart';

/**
 * @Author swifter
 * @Date 2024/7/23 11:22
 */

class LocalUtil {
  static bool isZHCN() {
    bool res =
        Get.locale?.languageCode == 'zh' && Get.locale?.countryCode == 'CN';
    return res;
  }
}
