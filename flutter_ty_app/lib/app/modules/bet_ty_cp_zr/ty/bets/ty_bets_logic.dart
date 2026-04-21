import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/ty_bets_state.dart';
import '../../../../routes/route_manager.dart';
import '../../../../services/api/bet_api.dart';
import '../../../../utils/bus/bus.dart';
import '../../../../utils/bus/event_enum.dart';
import '../../../../utils/sport.dart';
import '../../../unsettled_bets/utils/betsUtils.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'dart:core';

class TyBetsLogic extends GetxController {
  final TyBetsState state = TyBetsState();

  /*
  *构造方法传值
   */
  TyBetsLogic(int type){
    state.type = type;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /*
 *点击切换
  */
  setType(int type) {
   state.type = type;
    update();
  }
  /*
  用来跳转赛事详情的
   */
  getExistMatchResult(String matchId, String playOptionsId, int sportId,
      String time,
      {String dataSourceCode = ""}) async {
    ///vr体育6种，vr足球，vr篮球 vr赛狗，vr赛马，vr摩托车，vr泥地摩托车
    ///vr不支持跳转赛事详情
    if ([1001, 1004, 1009, 1010, 1011, 1002].contains(sportId)) {
      //  ToastUtils.show("vr赛事");
      return;
    }

    ///电子赛事也不支持跳转(预约中和已失效，没有电子赛事)
    if (dataSourceCode.isNotEmpty) {
      if (["RC", "C01", "OD"].contains(dataSourceCode)) {
        //  ToastUtils.show("电子赛事");
        return;
      }
    }

    ///来判断赛事，开赛有没超过15天，超过15天不允许跳转赛事详情
    if (BetsUtils.isOver15Days(time)) {
      // ToastUtils.show("当前赛事超过开赛15天");
      return;
    }

    ///获取赛事状态
    final res =
    await BetApi.instance().existMatchResult(matchId, playOptionsId);

    ///判断code == "0000000"就是成功拿到数据
    if (res.code == "0000000") {
      ///赛事没有结束才可以跳详情
      if (!res.data.matchEnd) {
        //确保当前界面存在
        if (isClosed) {
          return;
        }
        // 关闭当前界面
        Bus.getInstance().emit(EventType.tyCloseDialog);
        Get.back();

        ///跳转赛事详情
        RouteManager.goMatchDetail(
            mid: matchId,
            csid: sportId.toString(),
            isESports: [
              SportData.sportCsid_100,
              SportData.sportCsid_101,
              SportData.sportCsid_102,
              SportData.sportCsid_103,
              SportData.sportCsid_104,
              SportData.sportCsid_105,
            ].contains(sportId));
      }
    }
  }
}
