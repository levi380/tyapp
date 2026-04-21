import 'package:get/get.dart';

import 'cache_store.dart';
import 'swr_config.dart';
import 'swr_manager.dart';

class SwrService extends GetxService {
  late SwrManager manager;

  static SwrService get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    final cache = MultiLevelCache([
      MemoryCacheStore(),
      HiveCacheStore(),
    ]);

    final options = SwrOptions(
      ttl: const Duration(minutes: 5),
      lifecycleAware: true,
      networkAware: true,
    );

    manager = SwrManager(defaultOptions: options, cache: cache);
  }
}
