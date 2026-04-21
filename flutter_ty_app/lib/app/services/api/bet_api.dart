import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/req/bet_req.dart';
import '../models/req/latest_market_req.dart';
import '../models/res/all_order_list_entity.dart';
import '../models/res/api_res.dart';
import '../models/req/bet_amount_req.dart';
import '../models/res/bet_amount_entity.dart';
import '../models/res/bet_result_entity.dart';
import '../models/res/cancel_pre_bet_order_entity.dart';
import '../models/res/cp_order_list_entity.dart';
import '../models/res/exist_match_result_entity.dart';
import '../models/res/get_cashout_max_amount_list_entity.dart';
import '../models/res/get_h5_order_list_entity.dart';
import '../models/res/get_h5_pre_bet_orderlist_entity.dart';

import '../models/res/get_order_cp_list_entry_entity.dart';

import '../models/res/get_match_limit_info_by_mids_entity.dart';
import '../models/res/get_pre_settle_order_detail_entity.dart';
import '../models/res/get_reserve_cashout_list_entity.dart';

import '../models/res/get_order_list_zr_entity.dart';

import '../models/res/last_market_entity.dart';
import '../models/res/order_pre_settle_entity.dart';
import '../models/res/order_status_entity.dart';
import '../models/res/query_market_info_by_match_id_and_play_id_entity.dart';
import '../models/res/query_market_max_min_pre_bet_money_entity.dart';
import '../models/res/round_video_entity.dart';
import '../models/res/update_pre_bet_odds_entity.dart';
import '../network/app_dio.dart';

part 'bet_api.g.dart';

/// 注单页面获取所有注单页面数据
@RestApi()
abstract class BetApi {
  factory BetApi(Dio dio, {String baseUrl}) = _BetApi;

  factory BetApi.instance() =>
      BetApi(AppDio.getInstance().dio, baseUrl: StringKV.baseUrl.get() ?? '');

  /// 获取额度接口合并
  /// 
  /// [betAmountReq] 请求参数
  @POST("/yewu13/v1/betOrder/queryBetAmount")
  Future<ApiRes<BetAmountEntity>> queryBetAmount(
      @Body() BetAmountReq betAmountReq);

  /// 获取最大值和最小值接口
  /// 
  /// [betAmountReq] 请求参数
  @POST("/yewu13/v1/betOrder/queryMarketMaxMinBetMoney")
  Future<ApiRes<List<BetAmountBetAmountInfo>>> queryMarketMaxMinBetMoney(
      @Body() BetAmountReq betAmountReq);

  /// 查询最新的盘口数据
  /// 
  /// [latestMarketReq] 请求参数
  @POST('/yewu13/v1/betOrder/queryLatestMarketInfo')
  Future<ApiRes<List<LastMarketEntity>>> queryLatestMarketInfo(
      @Body() LatestMarketReq latestMarketReq);

  /// 获取预约额度接口合并
  /// 
  /// [betAmountReq] 请求参数
  @POST("/yewu13/v1/betOrder/queryPreBetAmount")
  Future<ApiRes<BetAmountEntity>> queryPreBetAmount(
      @Body() BetAmountReq betAmountReq);

  /// 押注项提交接口
  /// 
  /// [betReq] 请求参数
  @POST("/yewu13/v1/betOrder/bet")
  Future<ApiRes<BetResultEntity>> bet(
      @Body() BetReq betReq);

  /// 查询注单状态
  /// 
  /// [orderNos] 注单号列表
  @GET("/yewu13/v1/betOrder/queryOrderStatus")
  Future<ApiRes<List<OrderStatusEntity>>> queryOrderStatus(
    @Query('orderNos') String orderNos,
  );

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
  @POST("/yewurecord/order/betRecord/getH5OrderListPB")
  Future<GetH5OrderListEntity> getH5OrderList(
    @Field('orderStatus') String? orderStatus,
    @Field('searchAfter') String? searchAfter, {
    @Field('timeType') int? timeType,
    @Field('beginTime') String? beginTime,
    @Field('endTime') String? endTime,
    @Field('page') int? page,
    @Field('size') int? size,
    @Field('orderBy') int? orderBy,
    @Field('outright') int? outright,
  });

  /// 已结注单-预约中-已失效 两个功能共用一个接口
  /// 
  /// [preOrderStatusList] 预约订单状态列表
  /// [searchAfter] 搜索标识
  /// [timeType] 时间类型
  /// [beginTime] 开始时间
  /// [endTime] 结束时间
  /// [page] 页码
  /// [size] 每页大小
  @POST("/yewurecord/order/betRecord/getH5PreBetOrderListPB")
  Future<GetH5PreBetOrderlistEntity> getH5PreBetOrderlist(
    @Field('preOrderStatusList') List<int>? preOrderStatusList,
    @Field('searchAfter') String? searchAfter, {
    @Field('timeType') int? timeType,
    @Field('beginTime') String? beginTime,
    @Field('endTime') String? endTime,
    @Field('page') int? page,
    @Field('size') int? size,
  });

  /// 已结注单
  /// 
  /// [orderStatus] 注单状态
  /// [searchAfter] 搜索标识
  /// [orderBy] 排序方式
  /// [timeType] 时间类型
  @POST("/yewurecord/order/betRecord/getH5OrderListPB")
  Future<GetH5OrderListEntity> getH5OrderListSettled(
    @Field('orderStatus') String? orderStatus,
    @Field('searchAfter') String? searchAfter,
    @Field('orderBy') int? orderBy,
    @Field('timeType') int? timeType,
  );

  /// 真人 已结注单 未结注单
  ///
  /// [endTime] 结束时间
  /// [startTime] 开始时间
  /// [settled] 是否已结算
  /// [timeType] 时间类型
  /// [page] 页码
  /// [size] 每页大小
  @POST("/yewu27/zr/order/v1/getOrderList")
  Future<GetOrderListZrEntity> getOrderListZrSettled(
    @Field('endTime') String? endTime,
    @Field('startTime') String? startTime,
    @Field('settled') int? settled,
    @Field('timeType') int? timeType,
    @Field('page') int? page,
    @Field('size') int? size,
  );

  /// 视频回放
  /// 
  /// [no] 请求参数
  @POST("/yewu27/zr/order/v1/getRoundsVideoPath")
  Future<RoundVideoEntity> getRoundsVideoPath(@Body() no);

  /// 未结注单-预约中-更改赔率
  /// 
  /// [marketType] 市场类型
  /// [odds] 赔率
  /// [orderNo] 订单号
  /// [originalOrderAmountTotal] 原始订单总金额
  @POST("/yewu13/order/betRecord/updatePreBetOdds")
  Future<UpdatePreBetOddsEntity> updatePreBetOdds(
      @Field('marketId') String? marketId,
      @Field('marketType') String? marketType,
      @Field('marketValue') String? marketValue,
      @Field('odds') int? odds,
      @Field('oddsType') String? oddsType,
      @Field('orderNo') String? orderNo,
      @Field('originalOrderAmountTotal') int? originalOrderAmountTotal,
      @Field('playId') String? playId,
      @Field('playOptionName') String? playOptionName,
      @Field('playOptionsId') String? playOptionsId,
      @Field('sportId') String? sportId,
      );



 ///marketId:""
 ///marketType:"EU"
 ///marketValue:"4/4.5"
 ///odds:177000
 ///oddsType:"Under"
 ///orderno:"5298641555775434"
 ///originalOrderAmountTotal:9100
 ///playId:"18"
 ///playOptionName:"小  4/4.5"
 ///playOptionsId:""


  ///queryPreBetAmount
  /// 未结注单-预约中-获取盘口列表  4455 需求新增
  @POST("/yewu13/v1/betOrder/queryMarketInfoByMatchIdAndPlayId")
  Future<QueryMarketInfoByMatchIdAndPlayIdEntity> queryMarketInfoByMatchIdAndPlayId(
      @Field('matchId') int? matchId,
      @Field('playId') int? playId);


  /// 未结注单-预约中-注单预约限额
  /// 
  /// [betAmountReq] 请求参数
  @POST("/yewu13/v1/betOrder/queryMarketMaxMinPreBetMoney")
  Future<QueryMarketMaxMinPreBetMoneyEntity> queryMarketMaxMinPreBetMoney(
      @Body() BetAmountReq betAmountReq);

  /// 未结注单-预约中-取消预约
  /// 
  /// [orderNo] 订单号
  @GET("/yewu13/v1/betOrder/cancelPreBetOrder")
  Future<CancelPreBetOrderEntity> cancelPreBetOrder(
    @Query('orderNo') int orderNo,
  );

  /// 未结注单-未结算-提前结算
  /// 
  /// [orderNo] 订单号
  @GET("/yewu13/order/betRecord/getCashoutMaxAmountList")
  Future<GetCashoutMaxAmountListEntity> getCashoutMaxAmountList(
    @Query('orderNo') String? orderNo,
  );

  /// 未结注单-未结算-提前结算-预约提前结算状态
  /// 
  /// [orderNo] 订单号
  @GET("/yewu13/v1/betOrder/getReserveCashoutList")
  Future<GetReserveCashoutListEntity> getReserveCashoutList(
    @Query('orderNo') String? orderNo,
  );

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
  @POST("/yewu13/v1/betOrder/saveReserveCashOut")
  Future<OrderPreSettleEntity> saveReserveCashOut(
    @Field('deviceType') int? deviceType,
    @Field('matchId') String? matchId,
    @Field('orderNo') String? orderNo,
    @Field('playId') int? playId,
    @Field('playOptionsId') String? playOptionsId,
    @Field('reserveAmount') double? reserveAmount,
    @Field('settleAmount') double? settleAmount,
    @Field('sportId') int? sportId,
  );

  /// 未结注单-未结算-提前结算-取消预约提前结算请求
  /// 
  /// [orderNo] 订单号
  @POST("/yewu13/v1/betOrder/cancelReserveCashoutOrder")
  Future<OrderPreSettleEntity> cancelReserveCashoutOrder(
    @Field('orderNo') String? orderNo,
  );

  /// 未结注单-未结算-提前结算
  /// 
  /// [deviceType] 设备类型
  /// [frontSettleAmount] 前置结算金额
  /// [orderNo] 订单号
  /// [settleAmount] 结算金额
  @POST("/yewu13/v1/betOrder/orderPreSettle")
  Future<OrderPreSettleEntity> orderPreSettle(
    @Field('deviceType') int? deviceType,
    @Field('frontSettleAmount') String? frontSettleAmount,
    @Field('orderNo') String? orderNo,
    @Field('settleAmount') double? settleAmount,
  );

  /// 获取真人，彩票，体育注单列表
  /// 
  /// [orderStatus] 订单状态
  /// [page] 页码
  /// [size] 每页大小
  /// [timeType] 时间类型
  /// [startTime] 开始时间
  /// [endTime] 结束时间
  @POST("/yewurecord/order/betRecord/getTYZRCPOrderList")
  Future<ApiRes<AllOrderListEntity>> getTYZRCPOrderList(
    @Field('orderStatus') int? orderStatus,
    @Field('page') int? page,
    @Field('size') int? size,
    @Field('timeType') int? timeType,
    @Field('startTime') String? startTime,
    @Field('endTime') String? endTime,
  );

  /// cp投注记录
  ///
  /// [chaseFlag] 追号标志
  /// [page] 页码
  /// [settled] 是否已结算
  /// [size] 每页大小
  /// [timeType] 时间类型
  /// [startTime] 开始时间
  /// [endTime] 结束时间
  @POST("/yewu28/cp/order/v2/getOrderList")
  Future<ApiRes<CpOrderListEntity>> getCpOrderList(
      @Field('chaseFlag') bool chaseFlag,
      @Field('page') int? page,
      @Field('settled') int settled, // 0未结 1已结
      @Field('size') int? size,
      @Field('timeType') int? timeType,
      @Field('startTime') String? startTime,
      @Field('endTime') String? endTime,
      );

  /// cp未结算记录记录
  /// 
  /// [chaseFlag] 追号标志
  /// [page] 页码
  /// [settled] 是否已结算
  /// [size] 每页大小
  /// [timeType] 时间类型
  /// [startTime] 开始时间
  /// [endTime] 结束时间
  @POST("/yewu28/cp/order/v1/getOrderList")
  Future<ApiRes<GetOrderCpListEntryEntity>> getCpOrderCpListData(
    @Field('chaseFlag') bool chaseFlag,
    @Field('page') int? page,
    @Field('settled') int settled, // 0未结 1已结
    @Field('size') int? size,
    @Field('timeType') int? timeType,
    @Field('startTime') String? startTime,
    @Field('endTime') String? endTime,
  );

  /// 追号记录
  /// 
  /// [chaseFlag] 追号标志
  /// [page] 页码
  /// [settled] 是否已结算
  /// [size] 每页大小
  /// [timeType] 时间类型
  /// [startTime] 开始时间
  /// [endTime] 结束时间
  @POST("/yewu28/cp/order/v1/getChaseOrderList")
  Future<ApiRes<CpOrderListEntity>> getChaseOrderList(
    @Field('chaseFlag') bool chaseFlag,
    @Field('page') int? page,
    @Field('settled') int settled, // 0未结 1已结
    @Field('size') int? size,
    @Field('timeType') int? timeType,
    @Field('startTime') String? startTime,
    @Field('endTime') String? endTime,
  );

  /// 未结注单-未结算-比赛时间和玩法比分
  /// 
  /// [body] 请求参数
  @POST("/yewu11/v1/w/getMatchLimitInfoByMidsNew")
  Future<GetMatchLimitInfoByMidsEntity> getMatchLimitInfoByMidsNew(
    @Body() body,
  );

  /// 已结注单-提前结算-提前兑现详情数据
  /// 
  /// [orderNo] 订单号
  @GET("/yewu13/order/betRecord/getPreSettleOrderDetail")
  Future<GetPreSettleOrderDetailEntity> getPreSettleOrderDetail(
    @Query('orderNo') String? orderNo,
  );

  /// 注单-查看当前赛事状态，未开赛，开赛中，已结束，
  ///
  /// [matchld] 赛事id
  /// [playOptionsld] 玩法id
  @GET("/yewu13/order/betRecord/existMatchResult")
  Future<ExistMatchResultEntity> existMatchResult(
    @Query('matchId') String matchId,
    @Query('playOptionsId') String playOptionsId,
  );
}