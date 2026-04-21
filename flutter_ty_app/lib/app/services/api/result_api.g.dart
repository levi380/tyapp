// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _ResultApi implements ResultApi {
  _ResultApi(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  });

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<GetFilterMatchListEntity> getFilterMatchList(
    int type,
    String euid,
    String inputText,
    String? cuid,
    String device,
    String showem,
    String md,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'type': type,
      r'euid': euid,
      r'inputText': inputText,
      r'cuid': cuid,
      r'device': device,
      r'showem': showem,
      r'md': md,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetFilterMatchListEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/getFilterMatchList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetFilterMatchListEntity _value;
    try {
      _value = GetFilterMatchListEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetFilterMatchListAllEntity> getFilterMatchListAll(
    int type,
    String euid,
    String inputText,
    String? cuid,
    String device,
    String showem,
    String md,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'type': type,
      r'euid': euid,
      r'inputText': inputText,
      r'cuid': cuid,
      r'device': device,
      r'showem': showem,
      r'md': md,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetFilterMatchListAllEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/getFilterMatchList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetFilterMatchListAllEntity _value;
    try {
      _value = GetFilterMatchListAllEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetFilterMatchListNewDEntity> getFilterMatchListNew(
    int type,
    String euid,
    String inputText,
    String cuid,
    String device,
    String showem,
    String md,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'type': type,
      r'euid': euid,
      r'inputText': inputText,
      r'cuid': cuid,
      r'device': device,
      r'showem': showem,
      r'md': md,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetFilterMatchListNewDEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/getFilterMatchListNew',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetFilterMatchListNewDEntity _value;
    try {
      _value = GetFilterMatchListNewDEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> matcheResult(
    int category,
    String cuid,
    String device,
    String euid,
    String hpsFlag,
    String md,
    int showem,
    int sort,
    String tid,
    int type,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'category': category,
      'cuid': cuid,
      'device': device,
      'euid': euid,
      'hpsFlag': hpsFlag,
      'md': md,
      'showem': showem,
      'sort': sort,
      'tid': tid,
      'type': type,
    };
    final _options = _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matcheResultPB',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<MatchEntity>> _value;
    try {
      _value = ApiRes<List<MatchEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<dynamic>>> getMatchResult(
    int mcid,
    String mid,
    String cuid,
    String? isESport,
  ) async {
    final _extra = <String, dynamic>{
      'retry_retryable': true,
      'retry_code': '0401038',
    };
    final queryParameters = <String, dynamic>{
      r'mcid': mcid,
      r'mid': mid,
      r'cuid': cuid,
      r'isESport': isESport,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<List<dynamic>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchDetail/getMatchResult',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<dynamic>> _value;
    try {
      _value = ApiRes<List<dynamic>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<MatchEntity>> getResultMatchDetail(
    String mid,
    int type,
    String cuid,
    String isESport, {
    int? isNew,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'type': type,
      r'cuid': cuid,
      r'isESport': isESport,
      r'isNew': isNew,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiRes<MatchEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matchDetail/getResultMatchDetail',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<MatchEntity> _value;
    try {
      _value = ApiRes<MatchEntity>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiRes<List<MatchEntity>>> matcheHandpick(
    String cuid,
    String sportId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'cuid': cuid,
      'sportId': sportId,
    };
    final _options = _setStreamType<ApiRes<List<MatchEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/matcheHandpick',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiRes<List<MatchEntity>> _value;
    try {
      _value = ApiRes<List<MatchEntity>>.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<PlaybackVideoUrlEntity> playbackVideoUrl(
    String device,
    String eventCode,
    String mid,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'device': device,
      'eventCode': eventCode,
      'mid': mid,
    };
    final _options = _setStreamType<PlaybackVideoUrlEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/playbackVideoUrl',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late PlaybackVideoUrlEntity _value;
    try {
      _value = PlaybackVideoUrlEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AnalyzeLiveVideoLiveEventEntityEntity> liveEvents(
    String mid,
    String flag,
    String sportId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'flag': flag,
      r'sportId': sportId,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<AnalyzeLiveVideoLiveEventEntityEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/yewu11/v2/matchAnalysis/liveEvents',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AnalyzeLiveVideoLiveEventEntityEntity _value;
    try {
      _value = AnalyzeLiveVideoLiveEventEntityEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AnalyzeLiveVideoEventEntity> zoushiEvents(
    String device,
    String eventCode,
    String mid,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'device': device,
      'eventCode': eventCode,
      'mid': mid,
    };
    final _options = _setStreamType<AnalyzeLiveVideoEventEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v2/matchAnalysis/zoushiEvents',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AnalyzeLiveVideoEventEntity _value;
    try {
      _value = AnalyzeLiveVideoEventEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<MchampionMatchResultEntity> championMatchResult(
    int category,
    String cuid,
    String device,
    String endTime,
    int euid,
    int isVirtualSport,
    String md,
    int orderBy,
    int sort,
    int sportType,
    String startTime,
    int type,
    String tid,
  ) async {
    final _extra = <String, dynamic>{
      'throttle_able': true,
      'throttle_durtion': 1000,
    };
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'category': category,
      'cuid': cuid,
      'device': device,
      'endTime': endTime,
      'euid': euid,
      'isVirtualSport': isVirtualSport,
      'md': md,
      'orderBy': orderBy,
      'sort': sort,
      'sportType': sportType,
      'startTime': startTime,
      'type': type,
      'tid': tid,
    };
    final _options = _setStreamType<MchampionMatchResultEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/m/championMatchResult',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late MchampionMatchResultEntity _value;
    try {
      _value = MchampionMatchResultEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetH5OrderListEntity> resultGetH5OrderList(
    String matchId,
    int orderBy,
    String orderStatus,
    int timeType,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'matchId': matchId,
      'orderBy': orderBy,
      'orderStatus': orderStatus,
      'timeType': timeType,
    };
    final _options = _setStreamType<GetH5OrderListEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewurecord/order/betRecord/getH5OrderList',
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
  Future<VirtualMenusEntity> getVirtualMenus() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<VirtualMenusEntity>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/w/virtual/menus',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late VirtualMenusEntity _value;
    try {
      _value = VirtualMenusEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<QueryTournamentScoreResultEntity> getQueryTournamentScoreResult(
      dynamic body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = body;
    final _options = _setStreamType<QueryTournamentScoreResultEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v1/orderScoreResult/queryTournamentScoreResult',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late QueryTournamentScoreResultEntity _value;
    try {
      _value = QueryTournamentScoreResultEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<QueryLeagueTemplateListEntity> queryLeagueTemplateLis(
      String uid) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'uid': uid};
    final _options = _setStreamType<QueryLeagueTemplateListEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu12/user/queryLeagueTemplateList',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late QueryLeagueTemplateListEntity _value;
    try {
      _value = QueryLeagueTemplateListEntity.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetNoticeListByIdEntity> getNoticeListById(String uid) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'matchManageId': uid};
    final _options = _setStreamType<GetNoticeListByIdEntity>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/yewu11/v2/notice/getNoticeListById',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetNoticeListByIdEntity _value;
    try {
      _value = GetNoticeListByIdEntity.fromJson(_result.data!);
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
