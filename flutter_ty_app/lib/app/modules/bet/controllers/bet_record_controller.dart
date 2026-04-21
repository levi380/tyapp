import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import '../../../../main.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/cp_order_list_entity.dart';
import '../../../services/models/res/get_order_list_zr_entity.dart';
import '../../home/models/refresh_status.dart';
import 'package:flutter_ty_app/app/widgets/date_picker/show_time_bottom.dart';
import 'dart:core';
import '../../../utils/oss_util.dart';
import '../../login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../unsettled_bets/widgets/slider/image_loader.dart';
import 'bet_all_logic.dart';
import 'bet_record_state.dart';
import 'bet_ty_logic.dart';
import '../service/bet_record_service.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 注单中心BetRecordController】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 处理注单类型切换逻辑
    】】】
 *
 */
class BetRecordController extends GetxController {
  final betAllLogic = BetAllLogic();
  final betTylogic = BetTyLogic();

  //TODO: Implement BetRecordController
  final BetRecordState state = BetRecordState();
  final BetRecordService service = BetRecordService();

  @override
  void onClose() {
    betTylogic.onClose();

    super.onClose();
  }


  @override
  void onInit() {
    ImageLoader.loader
        .loadImageByProvider(NetworkImage(
      OssUtil.getServerPath(
        Get.isDarkMode
            ? 'assets/images/bets/slider_icon_night.png'
            : 'assets/images/bets/slider_icon.png',
      ),
    ))
        .then((value) => state.sliderBlockImage = value);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    betTylogic.orderPreSettleObserve();
    fetchData();
  }

  static BetRecordController get to => Get.find();
  Future<void> fetchData() async {
    if (state.orderType == 3) {
      // 彩票
      fetchCpData();
    } else if (state.orderType == 1) {
      betTylogic.fetchData();
    } else if (state.orderType == 2) {
      fetchZrData();
    } else {
      betAllLogic.fetchData();
    }

  }

  /// 彩票数据接口
  Future<void> fetchCpData() async {
    ApiRes<CpOrderListEntity> res;
    try {
      res = await service.getCpOrderList(
          false,
          state.pageIndex,
          0, // 0 未结算 1已结算
          state.pageSize,
          state.timeType,
          state.startTime,
          state.endTime
      );
      state.cpDataList = [];
      if(res.code == "200"){
        state.cpDataList = res.data?.list??[];
        state.refreshStatus = state.cpDataList.isEmpty?RefreshStatus.loadNoData:RefreshStatus.loadSuccess;
      }else{
        state.errorMsg = res.msg??res.code;
        state.refreshStatus = RefreshStatus.loadFailed;
      }
    }catch (e) {
      AppLogger.debug('fetchData error: $e');
      state.cpDataList = [];
      state.errorMsg = LocaleKeys.common_no_network.tr;
      state.refreshStatus = RefreshStatus.loadFailed;
    }
    update();
  }

  /// 真人数据接口
  Future<void> fetchZrData() async {
    GetOrderListZrEntity res;
    try {
      res = await service.getOrderListZrSettled(
        state.endTime,
        state.startTime,
        0, // 0 未结算 1已结算
        state.timeType,
        state.pageIndex,
        state.pageSize,
      );
      state.zrDataList = [];
      if (res.code == "200") {
        state.zrDataList = res.data.list;
        state.refreshStatus = state.zrDataList.isEmpty
            ? RefreshStatus.loadNoData
            : RefreshStatus.loadSuccess;
      } else {
        state.errorMsg = res.msg;
        state.refreshStatus = RefreshStatus.loadFailed;
      }
    } catch (e) {
      AppLogger.debug('fetchData error: $e');
      state.zrDataList = [];
      state.errorMsg = LocaleKeys.common_no_network.tr;
      state.refreshStatus = RefreshStatus.loadFailed;
    }
    update();
  }

  void changeTimeType(int newTimeType){
    state.timeType = newTimeType;
    state.startTimeUi = "";
    state.endTimeUi = "";
    String tag = Get.locale!.toLanguageTag();
    if(isIPad==false){
      if(tag.contains('zh-CN') || tag.contains('zh-TW') || tag.contains('ko-KR')|| tag.contains('ko-KR')|| tag.contains('hi-IN')|| tag.contains('mn-MN')){
      }else{
        if(newTimeType==0){
          state.scrollController.jumpTo(0);
        }else if(newTimeType==1){
          state.scrollController.jumpTo(40);
        }else if(newTimeType==2){
          state.scrollController.jumpTo(100);
        }else if(newTimeType==3){
          state.scrollController.jumpTo(80);
        }else{
          state.scrollController.jumpTo(200);
        }
      }
    }


    update();
    if(state.timeType!=5) {
      fetchData();
    }
  }

  void changeExpanded({bool? exapnd,String? orderId}){
    if(orderId == null){
      state.isExapndedAll = exapnd??!state.isExapndedAll;
      state.expanedSet.clear();
    }else{
      if(state.isExapndedAll == exapnd){
        state.expanedSet.remove(orderId);
      }else{
        state.expanedSet.add(orderId);
      }
    }

    if (state.orderType == 3) {
      state.cpDataList.forEach((element) {
        element.isExpand = state.isExapndedAll;
      });
    } else if (state.orderType == 2) {
      state.zrDataList.forEach((element) {
        element.isExpand = state.isExapndedAll;
      });
    }

    update();
  }


  void changeMixExpanded(bool expand,String orderId){
    if(expand){
      state.mixExpanedSet.add(orderId);
    }else{
      state.mixExpanedSet.remove(orderId);
    }

    update();
  }


  changeOrderType(int value){
    state.orderType = value;
    state.expanedSet.clear();
    state.mixExpanedSet.clear();
    fetchData();
    update();
  }

  ///自定义时间控件
  void showTime(BuildContext context) {

    showTimeBottom.showModalBottom(
        context,
        onDateTimeChanged: (date) {
          ///开始时间
          state.startTimeUi = DateUtil.formatDateMs(date[0].millisecondsSinceEpoch,
              format: DateFormats.y_mo_d, )
              .toString();
          ///结束时间
          state.endTimeUi = DateUtil.formatDateMs(date[1].millisecondsSinceEpoch,
              format: DateFormats.y_mo_d, )
              .toString();
          ///开始时间
          state.startTime = date[0].millisecondsSinceEpoch.toString();
          ///如果结束时间是今天 那么取当前时间戳而不是当天的零点
          if (DateTime.now().difference(date[1]).inDays == 0) {
            state.endTime = DateTime.now().millisecondsSinceEpoch.toString();
          } else {
            state.endTime = date[1].millisecondsSinceEpoch.toString();
          }
          fetchData();
        });
  }
}
