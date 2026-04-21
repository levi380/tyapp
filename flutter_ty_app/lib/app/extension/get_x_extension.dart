/**
 * @Author swifter
 * @Date 2024/2/4 18:23
 */
import 'package:get/get.dart';

extension GetxExtension on GetInterface {
  /// 返回到指定的路由
  void untilNamed(String routeName) {
    Get.until((route) => Get.currentRoute == routeName);
  }

  /// 替换controller的find方法，如果找不到则返回null
  T? findOrNull<T>({String? tag}) {
    try {
      if (Get.isRegistered<T>(tag: tag)) {
        return find<T>(tag: tag);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
