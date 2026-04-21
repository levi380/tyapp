import 'package:get/get.dart';
import '../controllers/match_detail_controller.dart';
class MatchDetailBinding extends Bindings {
  final String tag;

  MatchDetailBinding({required this.tag});

  @override
  void dependencies() {
    /// 赛事详情 通过binding 注入tag
    Get.lazyPut<MatchDetailController>(
      () => MatchDetailController(tag: tag),
      tag: tag,
    );
  }
}
