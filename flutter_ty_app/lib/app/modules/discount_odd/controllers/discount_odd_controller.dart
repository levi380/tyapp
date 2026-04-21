import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/discount_odd/states/discount_odd_state.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 增值赔率】】】
    【【【 AUTO_PARAGRAPH_TITLE 增值赔率】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 增值赔率controller
    】】】
 *
 */
class DiscountOddController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static DiscountOddController get to => Get.put(DiscountOddController());
  DiscountOddState state = DiscountOddState();

  @override
  void onInit() {
    getData(isFrist: true);
    super.onInit();
    state.timer = Timer.periodic(Duration(seconds: 4), (time) {
      getData();
    });
    state.animationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    state.animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        state.animationController.reset();
      }
    });
  }

  @override
  void onClose() {
    state.animationController.dispose();
    state.timer?.cancel();
    super.onClose();
  }

/**
 * 获取网络数据
 */
  Future<void> getData({bool isFrist = false}) async {
    


    var res = await MatchApi.instance().getAllAddedOddsMatches(
        TYUserController.to.getUid(),
        TyHomeController.to.homeState.matchListReq.euid,

        ///球种id
        TyHomeController.to.homeState.matchtSet.safeFirst?.csid ?? '1',
        state.isHot.value?"1":"2");
    if (isFrist && state.needReload) {
      state.needReload = false;
      update();
    }

    // print("==========>res.data  (res.success ) ${(res.success )} state.isEmptyTimer ${state.isEmptyTimer}  data ${(ObjectUtil.isNotEmpty(res.data?.data))} data  ${res.data}");



    if (res.success ) {
      if(ObjectUtil.isNotEmpty(res.data?.data)){

        state.matchtDiscount.clear();
        state.matchtDiscount.addAll(res.data?.data ?? []);

        state.isEmptyTimer=0;
        state.matchtDiscountMerge.clear();
        List<MatchEntity> currentMatchList = [];
        for (int i = 0; i < state.matchtDiscount.length; i++) {
          MatchEntity matchEntity = state.matchtDiscount[i];
          if (matchEntity.tid == currentMatchList.safeFirst?.tid) {
            currentMatchList.add(matchEntity);
          } else {
            currentMatchList = [matchEntity];
            state.matchtDiscountMerge.add(currentMatchList);
          }
        }
        for (int i = 0; i < state.matchtDiscount.length; i++) {
          MatchEntity matchEntity = state.matchtDiscount[i];
          matchEntity.hps.forEach((MatchHps hl) {
            hl.hl.forEach((MatchHpsHl hpsHl) {
              hpsHl.ol.forEach((MatchHpsHlOl ol) {
                DataStoreController.to.updateOl(ol);
              });
            });
          });
        }
        if(isFrist) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ///下一帧执行
            Future.delayed(Duration(microseconds: 300),(){
              state.scrollController.animateTo(0, duration: Duration(microseconds: 400), curve: Curves.easeInOut);
            });
          });

        }
        update();

      }else{
        // 只请求  不刷新
        state.isEmptyTimer++;
        if(state.isEmptyTimer>2){
          update();
        }
      }
    }
  }

/**
 * 点击刷新图标
 */
  void iconRefresh() {
    state.animationController.forward();
    getData();
  }
}
