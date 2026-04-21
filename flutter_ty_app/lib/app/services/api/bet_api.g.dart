// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _BetApi implements BetApi {
  _BetApi(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  });

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ApiRes<BetAmountEntity>> queryBetAmount(
      BetAmountReq betAmountReq) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(betAmountReq.toJson());
    final _options = _setStreamType<ApiRes<BetAmountEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/betOrder/queryBetAmount',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<BetAmountEntity> _value;
    try {
      _value = ApiRes<BetAmountEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<BetAmountBetAmountInfo>>> queryMarketMaxMinBetMoney(
      BetAmountReq betAmountReq) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(betAmountReq.toJson());
    final _options =
        _setStreamType<ApiRes<List<BetAmountBetAmountInfo>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/v1/betOrder/queryMarketMaxMinBetMoney',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<BetAmountBetAmountInfo>> _value;
    try {
      _value = ApiRes<List<BetAmountBetAmountInfo>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<LastMarketEntity>>> queryLatestMarketInfo(
      LatestMarketReq latestMarketReq) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(latestMarketReq.toJson());
    final _options = _setStreamType<ApiRes<List<LastMarketEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/betOrder/queryLatestMarketInfo',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<LastMarketEntity>> _value;
    try {
      _value = ApiRes<List<LastMarketEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<BetAmountEntity>> queryPreBetAmount(
      BetAmountReq betAmountReq) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(betAmountReq.toJson());
    final _options = _setStreamType<ApiRes<BetAmountEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/betOrder/queryPreBetAmount',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<BetAmountEntity> _value;
    try {
      _value = ApiRes<BetAmountEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<BetResultEntity>> bet(BetReq betReq) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(betReq.toJson());
    final _options = _setStreamType<ApiRes<BetResultEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/betOrder/bet',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<BetResultEntity> _value;
    try {
      _value = ApiRes<BetResultEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<OrderStatusEntity>>> queryOrderStatus(
      String orderNos) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'orderNos': orderNos};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<OrderStatusEntity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/betOrder/queryOrderStatus',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<OrderStatusEntity>> _value;
    try {
      _value = ApiRes<List<OrderStatusEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
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
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'orderStatus': orderStatus,
      'searchAfter': searchAfter,
      'timeType': timeType,
      'beginTime': beginTime,
      'endTime': endTime,
      'page': page,
      'size': size,
      'orderBy': orderBy,
      'outright': outright,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<GetH5OrderListEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewurecord/order/betRecord/getH5OrderListPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetH5OrderListEntity _value;
    try {
      _value = GetH5OrderListEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetH5PreBetOrderlistEntity> getH5PreBetOrderlist(
    List<int>? preOrderStatusList,
    String? searchAfter, {
    int? timeType,
    String? beginTime,
    String? endTime,
    int? page,
    int? size,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'preOrderStatusList': preOrderStatusList,
      'searchAfter': searchAfter,
      'timeType': timeType,
      'beginTime': beginTime,
      'endTime': endTime,
      'page': page,
      'size': size,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<GetH5PreBetOrderlistEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewurecord/order/betRecord/getH5PreBetOrderListPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetH5PreBetOrderlistEntity _value;
    try {
      _value = GetH5PreBetOrderlistEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetH5OrderListEntity> getH5OrderListSettled(
    String? orderStatus,
    String? searchAfter,
    int? orderBy,
    int? timeType,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'orderStatus': orderStatus,
      'searchAfter': searchAfter,
      'orderBy': orderBy,
      'timeType': timeType,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<GetH5OrderListEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewurecord/order/betRecord/getH5OrderListPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetH5OrderListEntity _value;
    try {
      _value = GetH5OrderListEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetOrderListZrEntity> getOrderListZrSettled(
    String? endTime,
    String? startTime,
    int? settled,
    int? timeType,
    int? page,
    int? size,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'endTime': endTime,
      'startTime': startTime,
      'settled': settled,
      'timeType': timeType,
      'page': page,
      'size': size,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<GetOrderListZrEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu27/zr/order/v1/getOrderList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetOrderListZrEntity _value;
    try {
      _value = GetOrderListZrEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<RoundVideoEntity> getRoundsVideoPath(dynamic no) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = no;
    final _options = _setStreamType<RoundVideoEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu27/zr/order/v1/getRoundsVideoPath',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late RoundVideoEntity _value;
    try {
      _value = RoundVideoEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UpdatePreBetOddsEntity> updatePreBetOdds(
    String? marketId,
    String? marketType,
    String? marketValue,
    int? odds,
    String? oddsType,
    String? orderNo,
    int? originalOrderAmountTotal,
    String? playId,
    String? playOptionName,
    String? playOptionsId,
    String? sportId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'marketId': marketId,
      'marketType': marketType,
      'marketValue': marketValue,
      'odds': odds,
      'oddsType': oddsType,
      'orderNo': orderNo,
      'originalOrderAmountTotal': originalOrderAmountTotal,
      'playId': playId,
      'playOptionName': playOptionName,
      'playOptionsId': playOptionsId,
      'sportId': sportId,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<UpdatePreBetOddsEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/order/betRecord/updatePreBetOdds',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late UpdatePreBetOddsEntity _value;
    try {
      _value = UpdatePreBetOddsEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<QueryMarketInfoByMatchIdAndPlayIdEntity>
      queryMarketInfoByMatchIdAndPlayId(
    int? matchId,
    int? playId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'matchId': matchId,
      'playId': playId,
    };
    _data.removeWhere((k, v) => v == null);
    final _options =
        _setStreamType<QueryMarketInfoByMatchIdAndPlayIdEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu13/v1/betOrder/queryMarketInfoByMatchIdAndPlayId',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late QueryMarketInfoByMatchIdAndPlayIdEntity _value;
    try {
      _value = QueryMarketInfoByMatchIdAndPlayIdEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<QueryMarketMaxMinPreBetMoneyEntity> queryMarketMaxMinPreBetMoney(
      BetAmountReq betAmountReq) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(betAmountReq.toJson());
    final _options = _setStreamType<QueryMarketMaxMinPreBetMoneyEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/betOrder/queryMarketMaxMinPreBetMoney',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late QueryMarketMaxMinPreBetMoneyEntity _value;
    try {
      _value = QueryMarketMaxMinPreBetMoneyEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<CancelPreBetOrderEntity> cancelPreBetOrder(int orderNo) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'orderNo': orderNo};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<CancelPreBetOrderEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/betOrder/cancelPreBetOrder',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late CancelPreBetOrderEntity _value;
    try {
      _value = CancelPreBetOrderEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetCashoutMaxAmountListEntity> getCashoutMaxAmountList(
      String? orderNo) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'orderNo': orderNo};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetCashoutMaxAmountListEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/order/betRecord/getCashoutMaxAmountList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetCashoutMaxAmountListEntity _value;
    try {
      _value = GetCashoutMaxAmountListEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetReserveCashoutListEntity> getReserveCashoutList(
      String? orderNo) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'orderNo': orderNo};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetReserveCashoutListEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/betOrder/getReserveCashoutList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetReserveCashoutListEntity _value;
    try {
      _value = GetReserveCashoutListEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<OrderPreSettleEntity> saveReserveCashOut(
    int? deviceType,
    String? matchId,
    String? orderNo,
    int? playId,
    String? playOptionsId,
    double? reserveAmount,
    double? settleAmount,
    int? sportId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'deviceType': deviceType,
      'matchId': matchId,
      'orderNo': orderNo,
      'playId': playId,
      'playOptionsId': playOptionsId,
      'reserveAmount': reserveAmount,
      'settleAmount': settleAmount,
      'sportId': sportId,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<OrderPreSettleEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/betOrder/saveReserveCashOut',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late OrderPreSettleEntity _value;
    try {
      _value = OrderPreSettleEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<OrderPreSettleEntity> cancelReserveCashoutOrder(
      String? orderNo) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {'orderNo': orderNo};
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<OrderPreSettleEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/betOrder/cancelReserveCashoutOrder',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late OrderPreSettleEntity _value;
    try {
      _value = OrderPreSettleEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<OrderPreSettleEntity> orderPreSettle(
    int? deviceType,
    String? frontSettleAmount,
    String? orderNo,
    double? settleAmount,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'deviceType': deviceType,
      'frontSettleAmount': frontSettleAmount,
      'orderNo': orderNo,
      'settleAmount': settleAmount,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<OrderPreSettleEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/v1/betOrder/orderPreSettle',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late OrderPreSettleEntity _value;
    try {
      _value = OrderPreSettleEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<AllOrderListEntity>> getTYZRCPOrderList(
    int? orderStatus,
    int? page,
    int? size,
    int? timeType,
    String? startTime,
    String? endTime,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'orderStatus': orderStatus,
      'page': page,
      'size': size,
      'timeType': timeType,
      'startTime': startTime,
      'endTime': endTime,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<AllOrderListEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewurecord/order/betRecord/getTYZRCPOrderList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<AllOrderListEntity> _value;
    try {
      _value = ApiRes<AllOrderListEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<CpOrderListEntity>> getCpOrderList(
    bool chaseFlag,
    int? page,
    int settled,
    int? size,
    int? timeType,
    String? startTime,
    String? endTime,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'chaseFlag': chaseFlag,
      'page': page,
      'settled': settled,
      'size': size,
      'timeType': timeType,
      'startTime': startTime,
      'endTime': endTime,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<CpOrderListEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu28/cp/order/v2/getOrderList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<CpOrderListEntity> _value;
    try {
      _value = ApiRes<CpOrderListEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<GetOrderCpListEntryEntity>> getCpOrderCpListData(
    bool chaseFlag,
    int? page,
    int settled,
    int? size,
    int? timeType,
    String? startTime,
    String? endTime,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'chaseFlag': chaseFlag,
      'page': page,
      'settled': settled,
      'size': size,
      'timeType': timeType,
      'startTime': startTime,
      'endTime': endTime,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<GetOrderCpListEntryEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu28/cp/order/v1/getOrderList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<GetOrderCpListEntryEntity> _value;
    try {
      _value = ApiRes<GetOrderCpListEntryEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<CpOrderListEntity>> getChaseOrderList(
    bool chaseFlag,
    int? page,
    int settled,
    int? size,
    int? timeType,
    String? startTime,
    String? endTime,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'chaseFlag': chaseFlag,
      'page': page,
      'settled': settled,
      'size': size,
      'timeType': timeType,
      'startTime': startTime,
      'endTime': endTime,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiRes<CpOrderListEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu28/cp/order/v1/getChaseOrderList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<CpOrderListEntity> _value;
    try {
      _value = ApiRes<CpOrderListEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetMatchLimitInfoByMidsEntity> getMatchLimitInfoByMidsNew(
      dynamic body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _options = _setStreamType<GetMatchLimitInfoByMidsEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/getMatchLimitInfoByMidsNew',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetMatchLimitInfoByMidsEntity _value;
    try {
      _value = GetMatchLimitInfoByMidsEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetPreSettleOrderDetailEntity> getPreSettleOrderDetail(
      String? orderNo) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'orderNo': orderNo};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetPreSettleOrderDetailEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/order/betRecord/getPreSettleOrderDetail',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetPreSettleOrderDetailEntity _value;
    try {
      _value = GetPreSettleOrderDetailEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ExistMatchResultEntity> existMatchResult(
    String matchId,
    String playOptionsId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'matchId': matchId,
      r'playOptionsId': playOptionsId,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ExistMatchResultEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu13/order/betRecord/existMatchResult',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ExistMatchResultEntity _value;
    try {
      _value = ExistMatchResultEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
