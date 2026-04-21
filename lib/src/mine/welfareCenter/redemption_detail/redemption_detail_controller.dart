import 'package:filbet/http/entity/resp_redeem_record.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/mine/welfareCenter/models/tab_item_model.dart';
import 'package:get/get.dart';

class RedemptionDetailController extends GetXBaseController {
  RedeemRecordModel? model;

  final statusList = [
    TabItemModel(name: 'all_statuses'.tr, value: '0'),
    TabItemModel(name: '审核中'.tr, value: '2'),
    TabItemModel(name: '派发中'.tr, value: '4'),
    TabItemModel(name: '派发失败'.tr, value: '5'),
    TabItemModel(name: '派发成功'.tr, value: '6'),
    TabItemModel(name: '已拒绝'.tr, value: '7'),
  ];

  @override
  void onInit() {
    model = Get.arguments['model'];
    super.onInit();
  }

  String convertTypeName(int status) {
    return statusList.firstWhere((item) => item.value == '$status').name ?? '';
  }
}
