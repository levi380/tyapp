import 'package:flutter_ty_app/app/services/api/bet_api.dart';

import '../../../services/models/res/all_order_list_entity.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/cp_order_list_entity.dart';
import '../../../services/models/res/get_cashout_max_amount_list_entity.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../services/models/res/get_order_list_zr_entity.dart';
import '../../../services/models/res/get_pre_settle_order_detail_entity.dart';
import '../../../services/models/res/get_reserve_cashout_list_entity.dart';
import '../../../services/models/res/order_pre_settle_entity.dart';

class BetRecordService {
  /// 彩票数据接口
  Future<ApiRes<CpOrderListEntity>> getCpOrderList(
      bool chaseFlag,
      int? page,
      int settled, // 0未结 1已结
      int? size,
      int? timeType,
      String? startTime,
      String? endTime,
      ) {
    return BetApi.instance().getCpOrderList(
        chaseFlag,
        page,
        settled,
        size,
        timeType,
        startTime,
        endTime
    );
  }

  /// 真人数据接口
  Future<GetOrderListZrEntity> getOrderListZrSettled(
      String? endTime,
      String? startTime,
      int? settled,
      int? timeType,
      int? page,
      int? size,
      ){
    return BetApi.instance().getOrderListZrSettled(
        endTime,
        startTime,
        settled,
        timeType,
        page,
        size
    );
  }

  /// 获取真人，彩票，体育注单列表
  ///
  /// [orderStatus] 订单状态
  /// [page] 页码
  /// [size] 每页大小
  /// [timeType] 时间类型
  /// [startTime] 开始时间
  /// [endTime] 结束时间
  Future<ApiRes<AllOrderListEntity>> getTYZRCPOrderList(
      int? orderStatus,
      int? page,
      int? size,
      int? timeType,
      String? startTime,
      String? endTime,
      ){
    return BetApi.instance().getTYZRCPOrderList(
        orderStatus,
        page,
        size,
        timeType,
        startTime,
        endTime
    );
  }

  /// 未结注单-未结算和（已结算）两个功能共用一个接口
  ///
  /// [orderStatus] 注单状态
  /// [searchAfter] 搜索标识
  /// [timeType] 时间类型
  /// [outright] 赛事类型
  /// [beginTime] 开始时间
  /// [endTime] 结束时间
  /// [page] 页码
  /// [orderBy] 排序 1投注时间,2 结算时间
  /// [size] 每页大小
  Future<GetH5OrderListEntity> getH5OrderList(
        String? orderStatus,
        String? searchAfter, {
          int? timeType,
          String? beginTime,
          String? endTime,
          int? page,
          int? size,
          int? orderBy,
          int? outright,
      }){
    return BetApi.instance().getH5OrderList(
        orderStatus,
        searchAfter,
        timeType: timeType,
        beginTime: beginTime,
        endTime: endTime,
        page: page,
        size: size,
        orderBy: orderBy,
        outright: outright
    );
  }

  /// 未结注单-未结算-提前结算
  ///
  /// [orderNo] 订单号
  Future<GetCashoutMaxAmountListEntity> getCashoutMaxAmountList(
      String? orderNo,
      ){
    return BetApi.instance().getCashoutMaxAmountList(
        orderNo
    );
  }

  /// 未结注单-未结算-提前结算
  ///
  /// [deviceType] 设备类型
  /// [frontSettleAmount] 前置结算金额
  /// [orderNo] 订单号
  /// [settleAmount] 结算金额
  Future<OrderPreSettleEntity> orderPreSettle(
      int? deviceType,
      String? frontSettleAmount,
      String? orderNo,
      double? settleAmount,
      ){
    return BetApi.instance().orderPreSettle(
        deviceType,
        frontSettleAmount,
        orderNo,
        settleAmount
    );
  }

  /// 未结注单-未结算-提前结算-取消预约提前结算请求
  ///
  /// [orderNo] 订单号
  Future<OrderPreSettleEntity> cancelReserveCashoutOrder(
      String? orderNo,
      ){
    return BetApi.instance().cancelReserveCashoutOrder(
        orderNo
    );
  }

  /// 未结注单-未结算-提前结算-预约提前结算金额请求
  ///
  /// [deviceType] 设备类型
  /// [matchId] 比赛ID
  /// [orderNo] 订单号
  /// [playId] 玩法ID
  /// [playOptionsId] 玩法选项ID
  /// [reserveAmount] 预约金额
  /// [settleAmount] 结算金额
  /// [sportId] 运动项目ID
  Future<OrderPreSettleEntity> saveReserveCashOut(
      int? deviceType,
      String? matchId,
      String? orderNo,
      int? playId,
      String? playOptionsId,
      double? reserveAmount,
      double? settleAmount,
      int? sportId,
      ){
    return BetApi.instance().saveReserveCashOut(
        deviceType,
        matchId,
        orderNo,
        playId,
        playOptionsId,
        reserveAmount,
        settleAmount,
        sportId
    );
  }

  /// 未结注单-未结算-提前结算-预约提前结算状态
  ///
  /// [orderNo] 订单号
  Future<GetReserveCashoutListEntity> getReserveCashoutList(
      String? orderNo,
      ){
    return BetApi.instance().getReserveCashoutList(
        orderNo
    );
  }

  /// 已结注单-提前结算-提前兑现详情数据
  ///
  /// [orderNo] 订单号
  Future<GetPreSettleOrderDetailEntity> getPreSettleOrderDetail(
      String? orderNo,
      ){
    return BetApi.instance().getPreSettleOrderDetail(
        orderNo
    );
  }
}