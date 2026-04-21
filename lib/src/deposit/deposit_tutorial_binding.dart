import 'package:filbet/src/deposit/channel_model.dart';
import 'package:filbet/src/deposit/deposit_tutorial_controller.dart';
import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:get/get.dart';

class DepositTutorialBinding extends Bindings {
  @override
  void dependencies() {
    // 注入 WalletService（如果还没有注入）
    if (!Get.isRegistered<WalletService>()) {
      Get.lazyPut(() => WalletService());
    }
    
    // 从路由参数中获取数据
    final arguments = Get.arguments as Map<String, dynamic>?;
    
    List<ChannelModel> channelList = [];
    ChannelModel? selectedChannel;
    
    if (arguments != null) {
      channelList = (arguments['channelList'] as List<dynamic>?)
              ?.map((e) => e as ChannelModel)
              .toList() ??
          [];
      selectedChannel = arguments['selectedChannel'] as ChannelModel?;
    }
    
    Get.lazyPut<DepositTutorialController>(
      () => DepositTutorialController(
        channelList: channelList,
        selectedChannel: selectedChannel,
      ),
    );
  }
}

