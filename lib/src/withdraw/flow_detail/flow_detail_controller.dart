import 'package:easy_refresh/easy_refresh.dart';
import 'package:filbet/http/entity/resp_flow_detail.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:get/get.dart';

class FlowDetailController extends GetXBaseController {
  final WalletService _walletService = WalletService();
  final pageSize = 20;
  final flowModels = <FlowModel>[].obs;
  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );
  bool isLoadingMore = false;
  bool hasNoMoreData = true;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    queryFlowDetail(null);
  }

  // 重置并加载数据
  Future<void> resetAndLoadData() async {
    await queryFlowDetail(null);
    easyRefreshController.finishRefresh();
    easyRefreshController.resetFooter();
  }

  // 加载更多数据
  void loadMoreData() async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    try {
      if (hasNoMoreData) return;
      await queryFlowDetail(flowModels.isNotEmpty ? flowModels.last.id : null);
      easyRefreshController.finishLoad(
        hasNoMoreData ? IndicatorResult.noMore : IndicatorResult.success,
      );
    } catch (_) {
      easyRefreshController.finishLoad(IndicatorResult.fail);
    } finally {
      isLoadingMore = false;
    }
  }

  Future queryFlowDetail(String? cur) async {
    var result = await _walletService.queryWithdrawTurnoverList(pageSize, cur);
    if (result != null) {
      if (cur == null) {
        flowModels.clear();
      }
      flowModels.addAll(result.d ?? []);
      flowModels.refresh();
      print("object123456 ${result.d?.length}");
      hasNoMoreData = (result.t ?? 0) < pageSize;
    }
  }
}
