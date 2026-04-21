import 'package:filbet/api/api.dart';
import 'package:filbet/http/entity/resp_promo_tag.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:get/get.dart';

class ActivityController extends GetXBaseController {
  final RxList<ActivityTypeModel> typeList = RxList.empty();
  int? typeId;

  static ActivityController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    getPromoTypeData(isInit: true);
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///获取活动类型列表
  void getPromoTypeData({bool isInit = false}) async {
    if (isInit) {
      typeList.add(ActivityTypeModel(name: 'all_events'.tr));
    }
    await fetchHandler<List<ActivityTypeModel>>(
      _promoTypeList(),
      onSuccess: (response) async {
        response.sort((a, b) => (a.sort ?? 0).compareTo(b.sort ?? 0));
        typeList.value = [
          ActivityTypeModel(name: 'all_events'.tr),
          ...response
        ];
        typeList.refresh();
        //获取活动类型列表
        getPromoListData(type: typeId);
      },
      onError: toastError,
      loading: false,
    );
  }

  ///获取活动类型列表
  Future<List<ActivityTypeModel>> _promoTypeList() async {
    var response = await HttpClient.get(Api.promoTypeList);
    if (response.status == false) {
      throw response.error!;
    }
    var resp = RespPromoTag.fromJson(Map<String, dynamic>.from(response.data));
    return resp.d ?? [];
  }

  ///获取活动列表数据
  void getPromoListData({int? type}) async {
    await fetchHandler<List<ActivityModel>>(
      _promoList(type),
      onSuccess: (response) async {
        // 先按 sort 排序，sort 相同的情况下，按 updatedAt 排序
        response.removeWhere((item) => item.state == 4); //过滤已停用的活动
        response.sort((a, b) {
          final sortCompare = (a.sort ?? 0).compareTo(b.sort ?? 0);
          if (sortCompare != 0) {
            return sortCompare;
          }
          // sort 相同的情况下，按 updatedAt 排序（updatedAt 越大越靠前）
          final aUpdatedAt = a.updatedAt ?? 0;
          final bUpdatedAt = b.updatedAt ?? 0;
          return bUpdatedAt.compareTo(aUpdatedAt);
        });
        ActivityTypeModel? typeModel;
        if (type == null) {
          typeModel = typeList[0];
        } else {
          typeModel = typeList.firstWhereOrNull((e) => e.id == type);
        }
        typeModel?.activityList.clear();
        typeModel?.activityList.assignAll(response);
      },
      onError: toastError,
      loading: false,
    );
  }

  ///获取活动列表
  Future<List<ActivityModel>> _promoList(int? type) async {
    Map<String, dynamic> params = {};
    if (type != null) {
      params["tag_id"] = type;
    }

    var response = await HttpClient.get(Api.promoList, queryParameters: params);
    if (response.status == false) {
      throw response.error!;
    }
    List<dynamic> rawList = response.data ?? [];
    List<ActivityModel> list = rawList
        .map((e) => ActivityModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return list;
  }

  ///进入活动详情页
  void jumpToDetailPage(ActivityModel model) {
    //ty 4大转盘
    if (model.ty == 4) {
      Get.toNamed(Routes.ACTIVITY_DETAIL_TURNTABLE,
          arguments: {'model': model});
    } else if (model.ty == 1) {
      Get.toNamed(Routes.FIRST_DEPOSIT_ACTIVITY, arguments: {'model': model});
    } else if (model.ty == 3) {
      Get.toNamed(Routes.BETTING_FIRST_DEPOSIT, arguments: {'model': model});
    } else if (model.ty == 5) {
      Get.toNamed(Routes.MATCH_BETTING_ACT, arguments: {'model': model});
    } else {
      Get.toNamed(Routes.ACTIVITY_DETAIL, arguments: {'model': model});
    }
  }
}
